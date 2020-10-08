#!/usr/bin/env bash
# you append to the command the language, categories and the title
# the script build a file and create the head content of it
# the script also generate a english based filename

# read in variables
source ./bin/variables.sh

# function
source ./bin/function.sh

case $1 in
  de)
    if test -n "$lang"; then
      # check tag is in array
      if [[ ${categories[*]} =~ $cover ]]; then

        # translation tag > categories
        if [[ $cover =~ "computer" ]]; then
          tag="Computer"

        elif [[ $cover =~ "media" ]]; then
          tag="Medien"

        elif [[ $cover =~ "repression" ]]; then
          tag="Staat"


        elif [[ $cover =~ "society" ]]; then
          tag="Gesellschaft"
        fi

        # check the folder structure is right
        if [[ -d "$content_dir" ]]; then

          # create the content and fill up the file
          create_file

          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        else

          # create the folder of content
          mkdir -p "$content_dir"

          # create the content and fill up the file
          create_file

          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        fi
      else
        echo "Enter a valid tag name ..."
      fi
    fi
  ;;

  en)
    if test -n "$lang"; then
      # check tag is in array
      if [[ ${categories[*]} =~ $cover ]]; then

        # translation tag > categories
        if [[ $cover =~ "computer" ]]; then
          tag="Computer"

        elif [[ $cover =~ "media" ]]; then
          tag="Media"

        elif [[ $cover =~ "repression" ]]; then
          tag="State"

        elif [[ $cover =~ "society" ]]; then
          tag="Society"
        fi

        # check the folder structure is right
        if [[ -d "$content_dir" ]]; then

          # create the content and fill up the file
          create_file

          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        else

          # create the folder of content
          mkdir -p "$content_dir"

          # create the content and fill up the file
          create_file

          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        fi
      else
        echo "Enter a valid tag name ..."
      fi
    fi
  ;;

  fr)
    if test -n "$lang"; then
      # check tag is in array
      if [[ ${categories[*]} =~ $cover ]]; then

        # translation tag > categories
        if [[ $cover =~ "computer" ]]; then
          tag="Ordinateur"

        elif [[ $cover =~ "media" ]]; then
          tag="Journalisme"

        elif [[ $cover =~ "repression" ]]; then
          tag="Politique"

        elif [[ $cover =~ "society" ]]; then
          tag="Société"
        fi

        # check the folder structure is right
        if [[ -d "$content_dir" ]]; then

          # create the content and fill up the file
          create_file

          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        else

          # create the folder of content
          mkdir -p "$content_dir"

          # create the content and fill up the file
          create_file

          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        fi
      else
        echo "Enter a valid tag name ..."
      fi
    fi
  ;;

  ru)

    if test -n "$lang"; then
      # check tag is in array
      if [[ ${categories[*]} =~ $cover ]]; then

        # translation tag > categories
        if [[ $cover =~ "computer" ]]; then
          tag="Компьютер"

        elif [[ $cover =~ "media" ]]; then
          tag="СМИ"

        elif [[ $cover =~ "repression" ]]; then
          tag="штат"

        elif [[ $cover =~ "society" ]]; then
          tag="Общество"
        fi

        # check the folder structure is right
        if [[ -d "$content_dir" ]]; then

          # create the content and fill up the file
          create_file

          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        else

          # create the folder of content
          mkdir -p "$content_dir"

          # create the content and fill up the file
          create_file


          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        fi
      else
        echo "Enter a valid tag name ..."
      fi
    fi
  ;;

  info)
    echo "To work with this script you need append the follow stuff"
    echo "./bin/new.sh lang cover title"
    echo "./bin/news.sh en society 'This is a title'"
    echo "cover: computer, media, repression, society"
  ;;
esac
