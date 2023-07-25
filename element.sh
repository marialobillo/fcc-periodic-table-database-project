#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"


if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

if [[ $1 =~ ^[1-9]=$ ]]
then
  info=$($PSQL "select 
  e.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius 
  from elements e 
  join properties p on e.atomic_number=p.atomic_number 
  join types t on t.type_id=p.type_id 
  where atomic_number = '$1'")
else
  info=$($PSQL "select 
  e.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius 
  from elements e 
  join properties p on e.atomic_number=p.atomic_number 
  join types t on t.type_id=p.type_id 
  where name = '$1' or symbol = '$1'")
fi

if [[ -z $info ]]
then
  echo -e "I could not find that element in the database."
  exit
fi

