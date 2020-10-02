#!/usr/bin/env bash

# read in variables
source ./bin/variables.sh

if [[ -d $mdde/$year/$month ]]; then
    /usr/local/bin/quotes.sh $mdde/$year/$month/
fi

if [[ -d $mden/$year/$month ]]; then
  /usr/local/bin/quotes.sh $mden/$year/$month/
fi

if [[ -d $mdfr/$year/$month ]]; then
    /usr/local/bin/quotes.sh $mdfr/$year/$month/
fi

if [[ -d $mdru/$year/$month ]]; then
  /usr/local/bin/quotes.sh $mdru/$year/$month/
fi
