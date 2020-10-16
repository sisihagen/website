#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

case $1 in
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

    year)
      if [[ -z "$2" ]]; then
        # german content/de/blog/2020
        if [[ -d "$mdde" ]]; then
          mkdir $mdde/$year || exit
        fi

        # english content/en/blog/2020
        if [[ -d "$mden" ]]; then
          mkdir $mden/$year || exit
        fi

        # french content/fr/blog/2020
        if [[ -d "$mdfr" ]]; then
          mkdir $mdfr/$year || exit
        fi

        # french content/ru/blog/2020
        if [[ -d "$mdru" ]]; then
          mkdir $mdru/$year || exit
        fi
      fi
    ;;

    diff)
      # use ./bin/helper.sh diff
      # Directorys of contents

      # read out the filenames
      for file in $mdde/$year/$month/*; do
          f1="$mden/$year/$month/$( basename "$file" )"
          f2="$mdfr/$year/$month/$( basename "$file" )"
          f3="$mdru/$year/$month/$( basename "$file" )"

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
        clean_file $tmp
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
        sed -E -i 's/(^title: ).*/\1"'"$(egrep 'title:' $files | sed 's/title: //g; s/"//g' | trans -brief :en )"'"/' $files

        # set the right shorttext
        sed -E -i 's/(^shorttext: ).*/\1"'"$(egrep 'shorttext:' $files | sed 's/shorttext: //g; s/"//g' | trans -brief :en )"'"/' $files
      done

      # copy files when finished manipulation
      cp -v $tmp_dir/*.md $mden/$year/$month

      # clean the dir $tmp_dir
      clean_dir $tmp_dir

      # clean the source file $tmp
      clean_file $tmp
    ;;

    copy-fr)
      if [[ ! -f "$tmp" ]]; then
        ./bin/helper.sh diff > $tmp
      else
        clean_file $tmp
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
        sed -E -i 's/(^title: ).*/\1"'"$(egrep 'title:' $files | sed 's/title: //g; s/"//g' | trans -brief :fr )"'"/' $files

        # set the right shorttext
        sed -E -i 's/(^shorttext: ).*/\1"'"$(egrep 'shorttext:' $files | sed 's/shorttext: //g; s/"//g' | trans -brief :fr )"'"/' $files
      done

      # copy files when finished manipulation
      cp -v $tmp_dir/*.md $mdfr/$year/$month

      # clean the dir $tmp_dir
      clean_dir $tmp_dir

      # clean the source file $tmp
      clean_file $tmp
    ;;

    copy-ru)
      if [[ ! -f "$tmp" ]]; then
        ./bin/helper.sh diff > $tmp
      else
        clean_file $tmp
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
        sed -E -i 's/(^title: ).*/\1"'"$(egrep 'title:' $files | sed 's/title: //g; s/"//g' | trans -brief :ru )"'"/' $files

        # set the right shorttext
        sed -E -i 's/(^shorttext: ).*/\1"'"$(egrep 'shorttext:' $files | sed 's/shorttext: //g; s/"//g' | trans -brief :ru )"'"/' $files
      done

      # copy files when finished manipulation
      cp -v $tmp_dir/*.md $mdru/$year/$month

      # clean the dir $tmp_dir
      clean_dir $tmp_dir

      # clean the source file $tmp
      clean_file $tmp
    ;;

    remhref)
      sed -i -e 's/([^()]*)//g' "$2"
    ;;

    *)
        printf "month    > to create month folder in blog folder\n"
        printf "year     > to create year folder in blog folder\n"
        printf "diff     > to see which missing files give in blogs\n"
        printf "copy-en  > copy the german files to english folder\n"
        printf "copy-fr  > copy the english files to french folder\n"
        printf "copy-ru  > copy the english files to russian folder\n"
        printf "remhref  > delete links in markdown files\n"
    ;;
esac
