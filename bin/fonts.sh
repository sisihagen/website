#!/usr/bin/env bash

#variables
source ./bin/variables.sh

# fonts
if [[ -d $sst/fonts ]]; then
  cp $sst/fonts/* $dst/fonts/
fi
