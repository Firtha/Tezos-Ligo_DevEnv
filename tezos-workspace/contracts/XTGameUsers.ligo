//#include "../utils/XTGameTypes.ligo"

// TODO :
// - Allows admins to retrieve only the amount of money they have injected 
//      o Add a timestamp so admin can retrieve injected money after a waiting time (with some interests ?)
//
// OPTIONAL :
// - Real management of money (contract's balance (Tezos.balance) and users inject/retrieve)

type storage is record
    contract_owner : address;
    contract_balance : nat;
    admins : set(address);
    gameUsers : big_map(address, nat);
    bans : set(address);

    games_contract : address;
end

// UTILS
//
function getUserBalance(const s : storage) : nat is block {
    const supposed_balance : option (nat) = Big_map.find_opt ((Tezos.source : address), s.gameUsers);
    const actual_balance : nat = case supposed_balance of
    | None -> 0n
    | Some(n) -> n
    end;
} with actual_balance

function checkAdminAccess(const s : storage): unit is block {
    if not (Tezos.source = s.contract_owner)
        then block {
            if not (s.admins contains Tezos.source)
                then failwith ("Forbidden: You are not admin.");
            else skip;
        }
    else skip;
} with unit
//
// UTILS


// OPERATIONS
//
function setGamesContract(const games_addr : address; const s : storage) : storage is
  block {
    if Tezos.source = s.contract_owner
        then s.games_contract := games_addr;
    else failwith ("Forbidden: You are not the contract's owner.");
  } with s

function addAdmin (const user : address ; const s : storage) : storage is
  block {
    checkAdminAccess(s);
    if not (s.admins contains user)
        then s.admins := Set.add(user, s.admins);
    else failwith ("Warning: This user is already an admin.");
  } with s

function rmAdmin (const user : address ; const s : storage) : storage is
  block {
    checkAdminAccess(s);

    if s.admins contains user
        then s.admins := Set.remove(user, s.admins);
    else failwith ("Warning: This user is not an admin.");
  } with s

function banUser (const user : address ; const s : storage) : storage is
  block {
    checkAdminAccess(s);

    if not (s.bans contains user)
        then s.bans := Set.add(user, s.bans);
    else failwith ("Warning: This user is already banned.");
  } with s

function unbanUser (const user : address ; const s : storage) : storage is
  block {
    checkAdminAccess(s);

    if s.bans contains user
        then s.bans := Set.remove(user, s.bans);
    else failwith ("Warning: This user has not been banned.");
  } with s

function injectFund (const value : nat ; const s : storage) : storage is
  block {
    checkAdminAccess(s);

    s.contract_balance := s.contract_balance + value;
  } with s

function retrieveFund (const value : nat ; const s : storage) : storage is
  block {
    checkAdminAccess(s);

    if s.contract_balance >= value 
        then s.contract_balance := abs(s.contract_balance - value);
    else failwith ("Warning: Insufficient contract balance.");
  } with s

function registerUser (const value : nat ; const s : storage) : storage is
  block {
    if Big_map.mem ((Tezos.source : address), s.gameUsers)
        then failwith ("Warning: You are already registered.");
    else skip;

    s.gameUsers[Tezos.source] := value;
  } with s

function injectFundAsUser (const value : nat ; const s : storage) : storage is
  block {
    if not Big_map.mem ((Tezos.source : address), s.gameUsers)
        then failwith ("Warning: You are already registered.");
    else skip;

    s.gameUsers[Tezos.source] := getUserBalance(s) + value;
  } with s

function retrieveFundAsUser (const value : nat ; const s : storage) : storage is
  block {
    if not Big_map.mem ((Tezos.source : address), s.gameUsers)
        then failwith ("Warning: You are already registered.");
    else skip;

    const my_balance : nat = getUserBalance(s);
    if my_balance <= value
        then failwith ("Error: Insufficient fund.");
    else block{
        s.gameUsers[Tezos.source] := abs(my_balance - value);
    };
  } with s
//
// OPERATIONS


type action is
| AddAdmin of address
| RmAdmin of address
| BanUser of address
| UnbanUser of address
| InjectFund of nat
| RetrieveFund of nat
| Register of nat
| InjectFundAsUser of nat
| RetrieveFundAsUser of nat

function main (const p : action ; const s : storage) :
  (list(operation) * storage) is
  block { skip } with ((nil : list(operation)),
  case p of
  // Administration of XTGameUsers
  | AddAdmin(n) -> addAdmin(n, s)
  | RmAdmin(n) -> rmAdmin(n, s)
  | BanUser(n) -> banUser(n, s)
  | UnbanUser(n) -> unbanUser(n, s)
  | InjectFund(n) -> injectFund(n, s)
  | RetrieveFund(n) -> retrieveFund(n, s)
  // Classic use of XTGameUsers
  | Register(n) -> registerUser(n, s)
  | InjectFundAsUser(n) -> injectFundAsUser(n, s)
  | RetrieveFundAsUser(n) -> retrieveFundAsUser(n, s)
  end)
