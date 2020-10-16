#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# fonts
if [[ -d $lstatic/fonts ]]; then
  sync "$lstatic/$fonts/" "$dest/$static/htdocs/$fonts/"
fi
