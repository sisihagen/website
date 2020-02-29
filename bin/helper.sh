#!/usr/bin/env bash

case $1 in
    # help to find images without webp part
    webp)
      year=$(date +%Y)
      img_dir="./static/static/img/content"
      jpeg_file="jpg.txt"
      webp_file="webp.txt"
      diff_file="diff.txt"

      if [[ -d "$img_dir/$year" ]]; then

        cd "$img_dir/$year" || exit
        ls ./*.jpg > $jpeg_file
        ls ./*.webp > $webp_file
        sed -i 's/.jpg//g' $jpeg_file
        sed -i 's/.webp//g' $webp_file
        diff $jpeg_file $webp_file | awk '{print $2}' | sed '/^$/d' > $diff_file

        ### read the diff file for converting
        while IFS= read -r line; do
          cwebp -quiet "$line".jpg -o "$line".webp
        done < diff.txt

        ### clean the folder
        rm $jpeg_file $webp_file $diff_file

      fi
    ;;

    png)
      year=$(date +%Y)
      img_dir="./static/static/img/content"

      for img in "$img_dir"/"$year"/*.png; do
        optipng -quiet "$img";
      done

      for img in "$img_dir"/"$year"/*.png; do
          filename=${img%.*}
          convert "$filename.png" "$filename.jpg"
      done

      for img in "$img_dir"/"$year"/*.jpg; do
          filename=${img%.*}
          cwebp -quiet "$filename.jpg" -o "$filename.webp"
      done

      for img in "$img_dir"/"$year"/*.png; do
          rm "$img";
      done
    ;;

    month)
      if [[ -z "$2" ]]; then
        printf "use it like ./bin/helper.sh month language"
        exit 0
      fi

      # time
      year=$(date +%Y)

      # content
      month=(01 02 03 04 05 06 07 08 09 10 11 12)
      lang=$2

      if [[ ! -d "./content/$lang/blog/$year" ]]; then
        mkdir -p "./content/$lang/blog/$year/" || exit
        cd "./content/$lang/blog/$year" || exit
        mkdir "${month[@]}" || exit
        echo "Directory Structor is created"

      else
        cd "./content/$lang/blog/$year" || exit
        mkdir "${month[@]}" || exit
        echo "Directory Structor is created"
      fi
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

    copy-en)
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

      # set the right lang
      find ./content/en/blog/$year/$month/ -type f -exec sed -i 's/lang: de/lang: en/g' {} \;
    ;;

    copy-fr)
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

      # copy the files in french directory
      en="./content/en/blog"
      fr="./content/fr/blog"

      if [[ -f "$tmp" ]]; then
        sed -i 's|/fr/|/en/|g' $tmp
      fi

      # read in the source file
      readarray -t source < $tmp

      for i in "${source[@]}" ; do
        cp $i $fr/$year/$month/
      done

      # set the right lang
      find ./content/fr/blog/$year/$month/ -type f -exec sed -i 's/lang: en/lang: fr/g' {} \;
    ;;

    copy-ru)
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

      # copy the files in french directory
      en="./content/en/blog"
      ru="./content/ru/blog"

      if [[ -f "$tmp" ]]; then
        sed -i 's|/ru/|/en/|g' $tmp
      fi

      # read in the source file
      readarray -t source < $tmp

      for i in "${source[@]}" ; do
        cp $i $ru/$year/$month/
      done

      # set the right lang
      find ./content/ru/blog/$year/$month/ -type f -exec sed -i 's/lang: en/lang: ru/g' {} \;
    ;;

    *)
        printf "webp     > for converting jpg images to webp format\n"
        printf "png     > for converting png images to jpg|webp format\n"
        printf "month    > to create month folder in blog folder\n"
        printf "diff     > to see which missing files give in blogs\n"
        printf "copy-en  > copy the german files to english folder\n"
        printf "copy-fr  > copy the english files to french folder\n"
        printf "copy-ru  > copy the english files to russian folder\n"
    ;;
esac
