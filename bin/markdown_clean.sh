#!/usr/bin/env bash

# read in variables
source ./bin/variables.sh

if [[ -d $mdde/$year/$month ]]; then
    /usr/local/bin/quotes.sh $mdde/$year/$month/
fi