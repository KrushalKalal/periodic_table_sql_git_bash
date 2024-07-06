#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"
if [[ $1 ]]
then
  if [[ $1 =~ ^[1-9]+$ ]]
  then
    ELEMENT=$($PSQL "SELECT atomic_number,atomic_mass,melting_point_celsius,boiling_point_celsius,symbol,name,type FROM properties JOIN elements USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$1")
  else
     ELEMENT=$($PSQL "SELECT atomic_number,atomic_mass,melting_point_celsius,boiling_point_celsius,symbol,name,type FROM properties JOIN elements USING(atomic_number) JOIN types USING(type_id) WHERE name = '$1' or symbol = '$1'")
  fi
  if [[ -z $ELEMENT ]]
  then
    echo "I could not find that element in the database."
    else
     echo $ELEMENT | while IFS=" |" read ATOMIC_NUMBER ATOMIC_MASS MELT BOIL SYMBOL NAME TYPE
     do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      done
  fi
  else
  echo "Please provide an element as an argument."
fi


