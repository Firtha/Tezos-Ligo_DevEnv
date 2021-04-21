#include "XTGameTypes.ligo"

type action is
| Register of nat
| InjectFund of nat
| RetrieveFund of nat

type storage is record
contract_owner : address;
admins : set(address);
XTGameUsers : map(address, nat);
end

// Register an user and set his balance
function registerUser (const value : nat ; const s : storage) : storage is
  block {

  } with s

function injectFund (const value : nat ; const s : storage) : storage is
  block {

  } with s

function retrieveFund (const value : nat ; const s : storage) : storage is
  block {

  } with s


function main (const p : action ; const s : storage) :
  (list(operation) * storage) is
  block { skip } with ((nil : list(operation)),
  case p of
  | Register(n) -> registerUser(n, s)
  | InjectFund(n) -> injectFund(n, s)
  | RetrieveFund(n) -> retrieveFund(n, s)
  end)
