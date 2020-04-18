#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# create folder
mkdir -p $dde $den $dfr $dru

if [[ ! -d $dst ]]; then
  mkdir -p $dst/{css,downloads,fonts,img,js}
fi
