#! /usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

case $1 in
  de)

    if [[ -d "$mdde" ]]; then
      for file in $mdde/$year/$month/*.md; do
        langid < "$file"
      done
    fi

  ;;

  en)

    if [[ -d "$mden" ]]; then
      for file in $mden/$year/$month/*.md; do
        langid < "$file"
      done
    fi

  ;;

  fr)

    if [[ -d "$mdfr" ]]; then
      for file in $mdfr/$year/$month/*.md; do
        langid < "$file"
      done
    fi

  ;;

  ru)

    if [[ -d "$mdru" ]]; then
      for file in $mdru/$year/$month/*.md; do
        langid < "$file"
      done
    fi

  ;;
esac
