#!/bin/bash

# Available accounts: 
#   Alice: tz1VSUr8wwNhLAzempoch5d6hLRiTh8Cjcjb
#   Bob: tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6

# AddAdmin: VALID
# Contract_owner: Alice
# Adding one admin: Alice adds Bob
ligo dry-run --source="tz1VSUr8wwNhLAzempoch5d6hLRiTh8Cjcjb" XTGameUsers.ligo main 'AddAdmin(("tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6": address))' 'record[contract_owner=("tz1VSUr8wwNhLAzempoch5d6hLRiTh8Cjcjb":address); contract_balance=(abs(0):nat); admins=(set[]:set(nat)); gameUsers=(big_map[]:big_map(address, nat)); bans=(set[]:set(address)); games_contract=("tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6":address)]'

# AddAdmin: INVALID
# Contract_owner: Alice
# Adding one admin: Bob adds Bob
ligo dry-run --source="tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6" XTGameUsers.ligo main 'AddAdmin(("tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6": address))' 'record[contract_owner=("tz1VSUr8wwNhLAzempoch5d6hLRiTh8Cjcjb":address); contract_balance=(abs(0):nat); admins=(set[]:set(nat)); gameUsers=(big_map[]:big_map(address, nat)); bans=(set[]:set(address)); games_contract=("tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6":address)]'

# InjectFundAsUser: INVALID
# Contract_owner: Alice
# Injecting: Bob inject in his balance
ligo dry-run --source="tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6" XTGameUsers.ligo main 'InjectFundAsUser((abs(420):nat))' 'record[contract_owner=("tz1VSUr8wwNhLAzempoch5d6hLRiTh8Cjcjb":address); contract_balance=(abs(0):nat); admins=(set[]:set(nat)); gameUsers=(big_map[]:big_map(address, nat)); bans=(set[]:set(address)); games_contract=("tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6":address)]'

# RegisterUser: VALID
# Contract_owner: Alice
# Registering: Bob register himself
ligo dry-run --source="tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6" XTGameUsers.ligo main 'Register((abs(420):nat))' 'record[contract_owner=("tz1VSUr8wwNhLAzempoch5d6hLRiTh8Cjcjb":address); contract_balance=(abs(0):nat); admins=(set[]:set(nat)); gameUsers=(big_map[]:big_map(address, nat)); bans=(set[]:set(address)); games_contract=("tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6":address)]'

# InjectFundAsUser: VALID
# Contract_owner: Alice
# Injecting: Bob inject in his balance
ligo dry-run --source="tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6" XTGameUsers.ligo main 'InjectFundAsUser((abs(420):nat))' 'record[contract_owner=("tz1VSUr8wwNhLAzempoch5d6hLRiTh8Cjcjb":address); contract_balance=(abs(0):nat); admins=(set[]:set(nat)); gameUsers=(big_map[("tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6":address)->abs(420)]:big_map(address, nat)); bans=(set[]:set(address)); games_contract=("tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6":address)]'
