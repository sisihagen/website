#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# downloads
if [[ -d $lstatic/downloads ]]; then
  sync "$lstatic/$downloads/" "$dest/$static/htdocs/$downloads/"
fi
