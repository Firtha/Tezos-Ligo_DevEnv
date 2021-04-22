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
    isRegisteredUser(Tezos.source);

    const first_card : nat = randNat(1n, 13n);

    const new_game: blackjack = record[
        state = True;
        player = Tezos.source;
        bet_value = bet;
        cards = list [first_card];
        cards_value = first_card;
    ];

    const current_id : nat = s.blackjacks.next_id;

    s.blackjacks.games[current_id] := new_game;
    s.blackjacks.next_id := current_id + 1n;
  } with s

function blackjackDrawCard(const game_id : nat; const s : storage) : storage is
  block {
    isRegisteredUser(Tezos.source);
    
    const supposed_target_game : option (blackjack) = Big_map.find_opt ((game_id : nat), s.blackjacks.games);
    const target_game : blackjack = case supposed_target_game of
    | None -> failwith ("Error: Retrieving this game's datas caused an error.")
    | Some(n) -> n
    end;

    isBlackjackPlayer(target_game, Tezos.source);

    const next_card : nat = randNat(1n, 13n);
    const card_list : list(nat) = target_game.cards;
    target_game.cards := next_card # card_list;
    const new_cards_value : nat = target_game.cards_value + next_card;
    target_game.cards_value := new_cards_value;

    if new_cards_value = 21n
        then block {
            // WINNER
            const reward_value : nat = target_game.bet_value * 3n;
            if triggerRegisterPayment(1n, reward_value)
                then skip
            else skip;          // TODO: Plan something in case the payment have gone wrong
        }
    else if new_cards_value > 21n
        then block {
            // LOSER
            if triggerRegisterPayment(0n, target_game.bet_value)
                then skip
            else skip;          // TODO: Plan something in case the payment have gone wrong
        }
    else skip;
  } with s

type action is
| SetRegisterContract of address

function main (const p : action ; const s : storage) :
  (list(operation) * storage) is
  block { skip } with ((nil : list(operation)),
  case p of
  | SetRegisterContract(n) -> setRegisterContract(n, s)
  end)
