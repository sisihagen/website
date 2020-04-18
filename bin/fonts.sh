#!/usr/bin/env bash

#variables
source ./bin/variables.sh

# fonts
if [[ -d $sst/fonts ]]; then
  rsync -auq $sst/fonts/ $dst/fonts/
fi
