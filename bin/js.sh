#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# js
if [[ -d $lstatic/js ]]; then
  # concat the used js files in one temporary js file
  cat ./node_modules/jquery/dist/jquery.js ./node_modules/flexibility/flexibility.js $lstatic/$js/app.js > $lstatic/$js/site-orig.js

  # minify the js file to the used js file in website
  ./node_modules/.bin/uglifyjs $lstatic/$js/site-orig.js > $lstatic/$js/site.js

  # copy used js files
  cp $lstatic/$js/site.js $dest/$static/htdocs/$js/site.js
  cp ./node_modules/html5shiv/dist/html5shiv.min.js $dest/$static/htdocs/$js
  cp $lstatic/$js/modernizr.js $dest/$static/htdocs/$js
fi
