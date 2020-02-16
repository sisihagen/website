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
      # use ./bin/helper.sh diff
      # Directorys of contents
      de="./content/de/blog"
      en="./content/en/blog"
      fr="./content/fr/blog"
      ru="./content/ru/blog"
      year=$(date +"%Y")
      month=$(date +"%m")

      # read out the filenames
      for file in $de/$year/$month/*; do
          f1="$en/$year/$month/$( basename "$file" )"
          f2="$fr/$year/$month/$( basename "$file" )"
          f3="$ru/$year/$month/$( basename "$file" )"

          #compare name in english tree
          if [ ! -e "$f1" ]; then
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

    copy)
      tmp='/tmp/source.txt'
      year=$(date +"%Y")
      month=$(date +"%m")


      # create a files which contains all articles which be not in english
      if [[ -f "$tmp" ]]; then
        truncate -s 0 "$tmp"
        ./bin/helper.sh diff > $tmp
      else
        ./bin/helper.sh diff > $tmp
      fi

      # delete article files which not need to translate
      if [[ -f "$tmp" ]]; then
        if [[ $(grep "the-unbearable-russia-frees-auschwitz" $tmp) ]]; then
          sed -i '/the-unbearable-russia-frees-auschwitz/d' $tmp
        fi
      fi

      # copy the files in english directory
      de="./content/de/blog"
      en="./content/en/blog"

      if [[ -f "$tmp" ]]; then
        sed -i 's|/en/|/de/|g' $tmp
      fi

      # read in the source file
      readarray -t source < $tmp

      for i in "${source[@]}" ; do
        cp -v $i $en/$year/$month/
      done
    ;;

    *)
        printf "webp  > for converting jpg images to webp format\n"
        printf "month > to create month folder in blog folder\n"
        printf "diff  > to see which missing files give in blogs\n"
        printf "copy  > copy the german files to english folder\n"
    ;;
esac
