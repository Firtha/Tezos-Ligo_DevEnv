#include "../utils/XTGameModels.ligo"
#include "../utils/XTGameUtils.ligo"

function setRegisterContract(const register_addr : address; const s : storage) : storage is
  block {
    if Tezos.source = s.contract_owner
        then block {
            if s.binding_lock
                then failwith ("Error: Register contract already set, no updates allowed.")
            else block {
                s.register_contract := register_addr;
                s.binding_lock := True;
            }
        }
    else failwith ("Forbidden: You are not the contract's owner.");
  } with s

// Loto:
//  - An admin must create one (it will be in a waiting state)
//  - Users can join freely opened lotos
//  - An admin must close the loto at some point

// Roulette:
//  - Create one if the last one created is closed
//  - Joining users are automatically redirected in the right 'room'

// Blackjack:
//  - Solo player: automatic
function blackjackOpen(const bet : nat; const s : storage) : storage is
  block {
    isRegisteredUser(Tezos.source, s);

    const first_card : nat = randNat();

    const new_game: blackjack = record[
        state = True;
        player = Tezos.source;
        bet_value = bet;
        cards = list [11n];
    ];

    const current_id : nat = s.blackjacks.next_id;

    s.blackjacks.games[current_id] := new_game;
    s.blackjacks.next_id := current_id + 1n;
  } with s

function blackjackDrawCard(const game_id : nat; const s : storage) : storage is
  block {
    isRegisteredUser(Tezos.source, s);
    
    if not isGamePlayer(game_id, Tezos.source, s)
        then failwith ("Forbidden: You are not a the player of this game_id.")
    else skip;

    const next_card : nat = randNat();
    const larger_list : list (int) = 5 # my_list 
    
  } with s

type action is
| SetRegisterContract of address

function main (const p : action ; const s : storage) :
  (list(operation) * storage) is
  block { skip } with ((nil : list(operation)),
  case p of
  | SetRegisterContract(n) -> setRegisterContract(n, s)
  end)
