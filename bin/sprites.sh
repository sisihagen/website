#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

if [[ -d "$lstatic/img/brands" ]]; then
  echo "glue $glueopt"
fi
