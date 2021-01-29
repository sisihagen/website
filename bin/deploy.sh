#!/usr/bin/env bash
# The mirrors will be feed over rsync Daemon on host france.

# variables
source ./bin/variables.sh

case "$1" in
  de)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_de.txt' $dest/ finnland:/var/www/
  ;;

  en)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_en.txt' $dest/ naw:/var/www/
  ;;

  fr)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_fr.txt' $dest/ france:/var/www/
  ;;

  ru)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_ru.txt' $dest/ ru-web:/var/www/
  ;;

  st)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_st.txt' $dest/$static/htdocs/ finnland:/var/www/$static/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_st.txt' $dest/$static/htdocs/ naw:/var/www/$static/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_st.txt' $dest/$static/htdocs/ france:/var/www/$static/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_st.txt' $dest/$static/htdocs/ ru-web:/var/www/$static/htdocs/
  ;;
  *)
    # Russian
    rsync -auq --delete --exclude-from='./resources/rsync_ex_ru.txt' --exclude-from='./resources/rsync_ex_st.txt' $dest/ ru-web:/var/www/

    # English
    rsync -auq --delete --exclude-from='./resources/rsync_ex_en.txt' --exclude-from='./resources/rsync_ex_st.txt' $dest/ naw:/var/www/

    # French
    rsync -auq --delete --exclude-from='./resources/rsync_ex_fr.txt' --exclude-from='./resources/rsync_ex_st.txt' $dest/ france:/var/www/

    # German
    rsync -auq --delete --exclude-from='./resources/rsync_ex_de.txt' --exclude-from='./resources/rsync_ex_st.txt' $dest/ finnland:/var/www/
  ;;
esac
