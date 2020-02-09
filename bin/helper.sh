#!/usr/bin/env bash

case $1 in
    # help to find images without webp part
    webp)
      if [[ -z "$2" ]]; then
        printf "use it like ./bin/helper.sh webp static/static/img/content/2019/*.jpg\n"
        exit 0
      fi

      for file in $2
      do
        if [[ -e ${file%%jpg}webp ]]; then
          echo "all perfect"
        else
          echo "${file%%jpg}miss"
        fi
      done
    ;;

    month)
      # check user input is right
      if [[ -z "$2" ]]; then
        printf "use it like ./bin/helper.sh month and the year you want split\n"
        exit 0
      fi

      month=(01 02 03 04 05 06 07 08 09 10 11 12)
      cd "$2" || exit
      mkdir "${month[@]}"
    ;;

    diff)
      # use ./bin/helper.sh compare 2020/02
      # Directorys of contents
      de="./content/de/blog"
      en="./content/en/blog"
      fr="./content/fr/blog"
      ru="./content/ru/blog"

      # check user input is right and not empty
      if [[ -z "$2" ]]; then
        printf "use it like ./bin/helper.sh diff and then the year and month folder\n"
        exit 0
      fi

      # read out the filenames
      for file in $de/$2/*; do
          f1="$en/$2/$( basename "$file" )"
          f2="$fr/$2/$( basename "$file" )"
          f3="$ru/$2/$( basename "$file" )"

          #compare name in english tree
          if [ ! -e "$f2" ]; then
              printf '%s\n' "$f1"

          #compare name in french tree
          elif [[ ! -e "$f2" ]]; then
              printf '%s\n' "$f2"

          #compare name in russian tree
          elif [[ ! -e "$f3" ]]; then
              printf '%s\n' "$f3"
          fi
      done
    ;;

    *)
        printf "webp  > for converting jpg images to webp format\n"
        printf "month > to create month folder in blog folder\n"
        printf "diff  > to see which missing files give in blogs\n"
    ;;
esac
