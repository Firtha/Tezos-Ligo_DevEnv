#!/bin/bash

# Available accounts: 
#   Alice: tz1VSUr8wwNhLAzempoch5d6hLRiTh8Cjcjb
#   Bob: tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6

# Contract_owner: Alice
# Adding one admin: Bob
ligo dry-run --source="tz1VSUr8wwNhLAzempoch5d6hLRiTh8Cjcjb" XTGameUsers.ligo main 'AddAdmin(("tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6": address))' 'record[contract_owner=("tz1VSUr8wwNhLAzempoch5d6hLRiTh8Cjcjb":address); contract_balance=(abs(0):nat); admins=(set[]:set(nat)); gameUsers=(big_map[]:big_map(address, nat)); bans=(set[]:set(address)); games_contract=("tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6":address)]'

