type loto is record
    state: bool;
    players_bet: big_map(address, nat);
    nb_players: nat;
    total_balance: nat;
end

type lotos_list is record
    games: list(loto);
    val_min: nat;
    val_max: nat;
    bet_min: nat;
    bet_max: nat;
end

type blackjack is record
    state: bool;
    player: address;
    bet_value: nat;
    cards: list(nat);
end

type blackjacks_list is record
    games: map(nat, blackjack);
    next_id: nat;
    target_cards_value: nat;
end

type caster is record
    state: bool;
    nb_players: nat;
    players_bet: map(address, nat);
    total_balance: nat;
end

type casters_list is record
    games: map(nat, caster);
    next_id: nat;
    join_limit: nat;
    bet_min: nat;
    bet_max: nat;
end

type storage is record
    contract_owner : address;
    register_contract : address;
    binding_lock: bool;

    lotos: lotos_list;
    blackjacks: blackjacks_list;
    casters: casters_list;
end