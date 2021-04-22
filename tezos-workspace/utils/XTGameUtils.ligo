// TODO
function randNat(const max : nat; const min : nat) : nat is
  block {
      const val : nat = 11n;
  } with val

// TODO
function isRegisteredUser(const user : address; const s : storage) : unit is
  block {
    const isUser: bool = True;

    if not isUser
        then failwith ("Forbidden: You are not a registered user.")
    else skip;
  } with unit

function isGamePlayer(const game_id : nat; const user : address; const s : storage) : bool is
  block {
    const isPlayer: bool = True;
  } with isPlayer

