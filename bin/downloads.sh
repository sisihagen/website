#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# downloads
if [[ $(find "$lstatic/scss" -mtime -1 -type f 2>/dev/null ) ]]; then
  if [[ -d "$lstatic/downloads" ]]; then
    sync "$lstatic/$downloads/" "$dest/$static/htdocs/$downloads/"
  fi
fi
