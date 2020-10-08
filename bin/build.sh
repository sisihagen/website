#!/usr/bin/env bash

# read in variables
source ./bin/variables.sh

case "$1" in
  git)
    git add . && git commit -m "Articles and fixes for week $weeknumber" &&  git push && git push github
  ;;

  version)
    npm version patch
  ;;

  *)

    # clean
    ./bin/clean.sh

    # folder
    ./bin/folder.sh

    # markdown clean
    ./bin/markdown_clean.sh

    # hugo build
    ./bin/hugo.sh hugobuild || exit

    # html
    ./bin/html.sh

    # assets
    ./bin/css.sh &
    ./bin/downloads.sh &
    ./bin/fonts.sh &
    ./bin/images.sh &
    ./bin/js.sh &
    wait

    # deploy
    ./bin/deploy.sh

    # raspi
    ./bin/raspi.sh
  ;;
esac
