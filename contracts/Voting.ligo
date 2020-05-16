type vote_param is record
vote_ID : nat;
vote_value : string;
end

type action is
| CreateVote of string
| TakingVote of vote_param

type storage is record
contract_owner : address;

vote_owners : map(address, set(nat));

nextVoteID : nat;
vote_names : map(nat, string);
vote_voters : map(nat, set(address));
vote_yes : map(nat, nat);
vote_no : map(nat, nat);
vote_states : map(nat, bool);
end

function takeVote (const params : vote_param ; const s : storage) : storage is
  block { 
    if params.vote_ID >= s.nextVoteID
      then failwith ("Wrong vote index.")
    else block{
      const targetVoteState : option(bool) = s.vote_states[params.vote_ID];
      const voteState : bool = case targetVoteState of
      | None -> False
      | Some(n) -> True
      end;
    }
  } with s

function createVote (const name : string ; const s : storage) storage is
  block {
    const newVoteID : nat = s.nextVoteID;
    s.nextVoteID := s.nextVoteID + 1;

    // Construction du nouveau vote avec les différents mappings

  } with s


function main (const p : action ; const s : storage) :
  (list(operation) * storage) is
  block { skip } with ((nil : list(operation)),
  case p of
  | TakingVote(n) -> takeVote(n, s)
  end)
