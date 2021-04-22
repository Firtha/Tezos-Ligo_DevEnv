// TODO: 'Real' random
function randNat(const max : nat; const min : nat) : nat is
  block {
      const to_update : nat = min + (11n mod max);
  } with to_update

// TODO: Connect with Register contract and check if existing
function isRegisteredUser(const user : address) : unit is
  block {
    const to_update: bool = True;

    const to_remove: address = user;
    if to_remove = Tezos.source
        then skip;
    else skip;

    if not to_update
        then failwith ("Forbidden: You are not a registered user.")
    else skip;
  } with unit

// TODO: Connect with Register contract and actually trigger payment
function triggerRegisterPayment(const conf : nat; const value : nat) : bool is
  block {
    if conf = 0n
        then skip   // 0: (Register contract): user_balance(Tezos.source) -- value --> contract_balance
    else skip;      // 1: (Register contract): contract_balance -- value --> user_balance(Tezos.source)

    const to_remove: nat = value;
    if to_remove = 1n
        then skip;
    else skip;
    const to_update : bool = True;
  } with to_update

function isBlackjackPlayer(const game : blackjack; const user : address) : unit is
  block {
    if game.player = user
        then block {
            if game.state = False
                then failwith ("Forbidden: This game ended and is now closed.");
            else skip;
        }
    else failwith ("Forbidden: You are not a player of this game.");
  } with unit

