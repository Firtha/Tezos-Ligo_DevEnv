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
vote_result : map(nat, string);
end

function createVote (const name : string ; const s : storage) : storage is
  block {
    // Handle vote ID
    const currVoteID : nat = s.nextVoteID;
    s.nextVoteID := s.nextVoteID + abs(1);

    // Add the vote ID to the vote_owners list
    const currSet : option(set(nat)) = s.vote_owners[Tezos.source];
    const newSet : set(nat) = case currSet of
    | None -> set [currVoteID]
    | Some(n) -> Set.add(currVoteID, n)
    end;
    s.vote_owners[Tezos.source] := newSet;

    // Define the new vote name
    const currName : option(string) = s.vote_names[currVoteID];
    const newName : string = case currName of
    | None -> name
    | Some(n) -> name
    end;
    s.vote_names[currVoteID] := newName;

    // Initiate the voters list for this vote ID
    //  vote_voters[vote-ID] will contain at max 11 elements, initiator + 10 voters
    const currVoteVoters : option(set(address)) = s.vote_voters[currVoteID];
    const newVoteVoters : set(address) = case currVoteVoters of
    | None -> set[Tezos.source]
    | Some(n) -> set[Tezos.source]
    end;
    s.vote_voters[currVoteID] := newVoteVoters;

    const currVoteYes : option(nat) = s.vote_yes[currVoteID];
    const newVoteYes : nat = case currVoteYes of
    | None -> abs(0)
    | Some(n) -> abs(0)
    end;
    s.vote_yes[currVoteID] := newVoteYes;

    const currVoteNo : option(nat) = s.vote_no[currVoteID];
    const newVoteNo : nat = case currVoteNo of
    | None -> abs(0)
    | Some(n) -> abs(0)
    end;
    s.vote_no[currVoteID] := newVoteNo;

    // Initiating the voting state
    const currVoteState : option(bool) = s.vote_states[currVoteID];
    const newVoteState : bool = case currVoteState of
    | None -> True
    | Some(n) -> True
    end;
    s.vote_states[currVoteID] := newVoteState;

    // Initiating the vote result
    const currVoteResult : option(string) = s.vote_result[currVoteID];
    const newVoteResult : string = case currVoteResult of
    | None -> "awaiting"
    | Some(n) -> "awaiting"
    end;
    s.vote_result[currVoteID] := newVoteResult;

  } with s


function takeVote (const params : vote_param ; const s : storage) : storage is
  block { 
    // Index and vote value check
    if params.vote_ID >= s.nextVoteID or ( params.vote_value =/= "yes" and params.vote_value =/= "no" )
      then failwith ("Wrong vote params (index or value (yes/no)).")
    else block{
      // Gathering current vote state
      const targetVoteState : option(bool) = s.vote_states[params.vote_ID];
      const voteState : bool = case targetVoteState of
      | None -> (failwith("Error during vote state gathering."):bool)
      | Some(n) -> n
      end;

      if voteState = False
        then failwith ("This Vote is closed.")
      else block {
        // Gathering current vote voters list
        const optVoteVoters : option(set(address)) = s.vote_voters[params.vote_ID];
        const currVoteVoters : set(address) = case optVoteVoters of
        | None -> (failwith("Error during voters gathering."):set(address))
        | Some(n) -> n
        end;

        // Already voted check
        if currVoteVoters contains Tezos.source
          then failwith("You have already voted on this.")
        else block {
          // Add voter to list
          s.vote_voters[params.vote_ID] := Set.add(Tezos.source, currVoteVoters);

          // Set useful vars
          var voteYes : nat := abs(0);
          var voteNo : nat := abs(0);
          if params.vote_value = "yes" then block {
            voteYes := abs(1);
          } else block {
            voteNo := abs(1);
          };

          const optVoteYes : option(nat) = s.vote_yes[params.vote_ID];
          const currVoteYes : nat = case optVoteYes of
          | None -> abs(0) + voteYes
          | Some(n) -> n + voteYes
          end;

          // Get current counts for yes and no votes
          const optVoteNo : option(nat) = s.vote_no[params.vote_ID];
          const currVoteNo : nat = case optVoteNo of
          | None -> abs(0) + voteNo
          | Some(n) -> n + voteNo
          end;
          
          // Vote count update only when needed
          if params.vote_value = "yes" then block {
            s.vote_yes[params.vote_ID] := currVoteYes;
          } else block {
            s.vote_no[params.vote_ID] := currVoteNo;
          };

          // CurrVoteVoters holds the 10 other voters
          //  10 : Administrator (at creation) + 9 previous voters (+ 1 current, reaching 11)
          if Set.size(currVoteVoters) = abs(10) then block {
            // If result is yes
            if currVoteYes > currVoteNo then block {
              const currVoteResult : option(string) = s.vote_result[params.vote_ID];
              const newVoteResult : string = case currVoteResult of
              | None -> "Yes"
              | Some(n) -> "Yes"
              end;
              s.vote_result[params.vote_ID] := newVoteResult;
            
            // If result is no
            } else if currVoteYes < currVoteNo then block {
              const currVoteResult : option(string) = s.vote_result[params.vote_ID];
              const newVoteResult : string = case currVoteResult of
              | None -> "No"
              | Some(n) -> "No"
              end;
              s.vote_result[params.vote_ID] := newVoteResult;
            
            // If result is equal (5 yes and 5 no)
            } else block {
              const currVoteResult : option(string) = s.vote_result[params.vote_ID];
              const newVoteResult : string = case currVoteResult of
              | None -> "noMajority"
              | Some(n) -> "noMajority"
              end;
              s.vote_result[params.vote_ID] := newVoteResult;
            };

            // Closing the vote
            const currVoteState : option(bool) = s.vote_states[params.vote_ID];
            const newVoteState : bool = case currVoteState of
            | None -> False
            | Some(n) -> False
            end;
            s.vote_states[params.vote_ID] := newVoteState;
          } else block { skip };
        };
      }
    }
  } with s


function main (const p : action ; const s : storage) :
  (list(operation) * storage) is
  block { skip } with ((nil : list(operation)),
  case p of
  | CreateVote(n) -> createVote(n, s)
  | TakingVote(n) -> takeVote(n, s)
  end)
