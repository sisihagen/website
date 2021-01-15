#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# js
# check source exist
if [[ ! -f "$dest/$static/htdocs/$js/site.js" ]]; then
  # concat the used js files in one temporary js file
  cat ./node_modules/jquery/dist/jquery.js $lstatic/$js/app.js > $lstatic/$js/site-orig.js

  # minify the js file to the used js file in website
  ./node_modules/.bin/uglifyjs $lstatic/$js/site-orig.js > $lstatic/$js/site.js

  # copy used js files
  cp $lstatic/$js/site.js $dest/$static/htdocs/$js/site.js
  cp $lstatic/$js/modernizr.js $dest/$static/htdocs/$js

else
  # when exists check there was changes
  if [[ $(find "$lstatic/$js" -mtime -1 -type f 2>/dev/null ) ]] && [[ $(find "./node_modules/jquery" -mtime -1 -type f 2>/dev/null ) ]]; then
    # concat the used js files in one temporary js file
    cat ./node_modules/jquery/dist/jquery.js $lstatic/$js/app.js > $lstatic/$js/site-orig.js

    # minify the js file to the used js file in website
    ./node_modules/.bin/uglifyjs $lstatic/$js/site-orig.js > $lstatic/$js/site.js

    # copy used js files
    cp $lstatic/$js/site.js $dest/$static/htdocs/$js/site.js
    cp $lstatic/$js/modernizr.js $dest/$static/htdocs/$js
  fi

fi
