


function main (const p : action ; const s : storage) :
  (list(operation) * storage) is
  block { skip } with ((nil : list(operation)),
  case p of
  | CreateVote(n) -> createVote(n, s)
  | TakingVote(n) -> takeVote(n, s)
  end)
