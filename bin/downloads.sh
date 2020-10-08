#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# downloads
if [[ -d $sst/downloads ]]; then
  cp -r $sst/downloads/* $dst/downloads/
fi
