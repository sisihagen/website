#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# css
if [[ -d "$lstatic/$css" ]]; then
  # scss to css and clean it with postcss
  sassc -t compressed -m $lstatic/scss/layout.scss | ./node_modules/.bin/postcss -u autoprefixer postcss-opacity postcss-flexibility > $lstatic/css/layout.css

  # copy files to sync directory
  cp $lstatic/css/layout.css $dest/$static/htdocs/$css
fi
