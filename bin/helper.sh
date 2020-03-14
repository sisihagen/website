#!/usr/bin/env bash

# variables
year=$(date +%Y)
month=$(date +%m)
img_dir='./static/static/img/content'
jpeg_file='jpg.txt'
webp_file='webp.txt'
diff_file='diff.txt'
de='./content/de/blog'
en='./content/en/blog'
fr='./content/fr/blog'
ru='./content/ru/blog'
tmp='/tmp/source.txt'
tmp_dir='/tmp/md'

# function
function clean_dir()
{
  if [[ "$(ls -A $tmp_dir)" ]]; then
    rm $tmp_dir/*.md
  fi
}

function clean_file()
{
  if [[ -s "$tmp" ]]; then
    truncate -s 0 $tmp
  fi
}

function copy_files()
{
  for i in "${source[@]}" ; do
    cp "$i" "$tmp_dir"
  done
}

case $1 in
    # help to find images without webp part
    webp)

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
      if [[ ! -f "$tmp" ]]; then
        ./bin/helper.sh diff > $tmp
      else
        clean_file
        ./bin/helper.sh diff > $tmp
      fi

      if [[ -f "$tmp" ]]; then
        sed -i 's|/en/|/de/|g' $tmp
      fi

      if [[ ! -d "$tmp_dir" ]]; then
          mkdir $tmp_dir
      fi

      # read in the source file
      readarray -t source < $tmp

      # markdown files will be copied to $tmp_dir
      copy_files

      # manipulate the files in $tmp_dir
      for files in $tmp_dir/*.md ; do
        # set the right lang settings
        sed -i 's/lang: de/lang: en/g' $files

        # set the right tags
        sed -i 's/tags: "Gesellschaft"/tags: "Society"/g' $files
        sed -i 's/tags: "Medien"/tags: "Media"/g' $files
        sed -i 's/tags: "Staat"/tags: "State"/g' $files

        # set the right title
        sed -E -i 's/(^title: ).*/\1"'"$(egrep 'title:' $files | sed 's/title: //g; s/"//g' | trans -brief -e bing :en )"'"/' $files

        # set the right shorttext
        sed -E -i 's/(^shorttext: ).*/\1"'"$(egrep 'shorttext:' $files | sed 's/shorttext: //g; s/"//g' | trans -brief -e bing :en )"'"/' $files
      done

      # copy files when finished manipulation
      cp -v $tmp_dir/*.md $en/$year/$month

      # clean the dir $tmp_dir
      clean_dir

      # clean the source file $tmp
      clean_file
    ;;

    copy-fr)
      if [[ ! -f "$tmp" ]]; then
        ./bin/helper.sh diff > $tmp
      else
        clean_file
        ./bin/helper.sh diff > $tmp
      fi

      if [[ -f "$tmp" ]]; then
        sed -i 's|/fr/|/en/|g' $tmp
      fi

      if [[ ! -d "$tmp_dir" ]]; then
          mkdir $tmp_dir
      fi

      # read in the source file
      readarray -t source < $tmp

      # markdown files will be copied to $tmp_dir
      copy_files

      # manipulate the files in $tmp_dir
      for files in $tmp_dir/*.md ; do
        # set the right lang settings
        sed -i 's/lang: en/lang: fr/g' $files

        # set the right tags
        sed -i 's/tags: "Society"/tags: "Société"/g' $files
        sed -i 's/tags: "Media"/tags: "Journalisme"/g' $files
        sed -i 's/tags: "State"/tags: "Politique"/g' $files
        sed -i 's/tags: "Computer"/tags: "Ordinateur"/g' $files

        # set the right title
        sed -E -i 's/(^title: ).*/\1"'"$(egrep 'title:' $files | sed 's/title: //g; s/"//g' | trans -brief -e bing :fr )"'"/' $files

        # set the right shorttext
        sed -E -i 's/(^shorttext: ).*/\1"'"$(egrep 'shorttext:' $files | sed 's/shorttext: //g; s/"//g' | trans -brief -e bing :fr )"'"/' $files
      done

      # copy files when finished manipulation
      cp -v $tmp_dir/*.md $fr/$year/$month

      # clean the dir $tmp_dir
      clean_dir

      # clean the source file $tmp
      clean_file
    ;;

    copy-ru)
      if [[ ! -f "$tmp" ]]; then
        ./bin/helper.sh diff > $tmp
      else
        clean_file
        ./bin/helper.sh diff > $tmp
      fi

      if [[ -f "$tmp" ]]; then
        sed -i 's|/ru/|/en/|g' $tmp
      fi

      if [[ ! -d "$tmp_dir" ]]; then
          mkdir $tmp_dir
      fi

      # read in the source file
      readarray -t source < $tmp

      # markdown files will be copied to $tmp_dir
      copy_files

      # manipulate the files in $tmp_dir
      for files in $tmp_dir/*.md ; do
        # set the right lang settings
        sed -i 's/lang: en/lang: ru/g' $files

        # set the right tags
        sed -i 's/tags: "Society"/tags: "Общество"/g' $files
        sed -i 's/tags: "Media"/tags: "СМИ"/g' $files
        sed -i 's/tags: "State"/tags: "штат"/g' $files
        sed -i 's/tags: "Computer"/tags: "Компьютер"/g' $files

        # set the right title
        sed -E -i 's/(^title: ).*/\1"'"$(egrep 'title:' $files | sed 's/title: //g; s/"//g' | trans -brief -e bing :ru )"'"/' $files

        # set the right shorttext
        sed -E -i 's/(^shorttext: ).*/\1"'"$(egrep 'shorttext:' $files | sed 's/shorttext: //g; s/"//g' | trans -brief -e bing :ru )"'"/' $files
      done

      # copy files when finished manipulation
      cp -v $tmp_dir/*.md $ru/$year/$month

      # clean the dir $tmp_dir
      clean_dir

      # clean the source file $tmp
      clean_file
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
