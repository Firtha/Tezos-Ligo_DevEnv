// variant defining pseudo multi-entrypoint actions
type action is
| Increment of int
| Decrement of int
| Reset of unit

type storage is record 
counter : int;
owner : address
end

function add (const a : int ; const b : int) : int is
  block { skip } with a + b

function subtract (const a : int ; const b : int) : int is
  block { skip } with a - b

function reset (const s : storage) : int is
  block { 
    if Tezos.source =/= s.owner 
    then failwith ("Access denied.")
    else skip
  } with 0

// real entrypoint that re-routes the flow based
// on the action provided
function main (const p : action ; const s : storage) :
  (list(operation) * storage) is
  block {  
  const newCounter : int = case p of
    | Increment(n) -> add(s.counter, n)
    | Decrement(n) -> subtract(s.counter, n)
    | Reset -> reset(s)
  end;

  s.counter := newCounter
  } with ((nil : list(operation)), s)