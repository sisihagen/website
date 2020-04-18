#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# downloads
if [[ -d $sst/downloads ]]; then
  rsync -auq $sst/downloads/ $dst/downloads/
fi
