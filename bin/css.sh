#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# css
if [[ -d $sst/css ]]; then
  # scss to css file and fix it with postcss
  sassc -t compressed $sst/scss/layout.scss | ./node_modules/.bin/postcss --no-map -u autoprefixer postcss-opacity postcss-flexibility > $sst/css/layout.css

  # copy files to sync directory
  rsync -auq $sst/css/ $dst/css/
fi
