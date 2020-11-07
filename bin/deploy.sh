#!/usr/bin/env bash
# The mirrors will be feed over rsync Daemon on host france.

# variables
source ./bin/variables.sh

case "$1" in
  de)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_de.txt' $dest/$de/htdocs/ france:/var/www/$de/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_de.txt' $dest/$de/htdocs/ finnland:/var/www/$de/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_de.txt' $dest/$de/htdocs/ jpy:/var/www/$de/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_de.txt' $dest/$de/htdocs/ jburg:/var/www/$de/htdocs/
  ;;

  en)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_en.txt' $dest/$en/htdocs/ france:/var/www/$en/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_en.txt' $dest/$en/htdocs/ finnland:/var/www/$en/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_en.txt' $dest/$en/htdocs/ jpy:/var/www/$en/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_en.txt' $dest/$en/htdocs/ jburg:/var/www/$en/htdocs/
  ;;

  fr)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_fr.txt' $dest/$fr/htdocs/ france:/var/www/$fr/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_fr.txt' $dest/$fr/htdocs/ finnland:/var/www/$fr/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_fr.txt' $dest/$fr/htdocs/ jpy:/var/www/$fr/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_fr.txt' $dest/$fr/htdocs/ jburg:/var/www/$fr/htdocs/
  ;;

  ru)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_ru.txt' $dest/$ru/htdocs/ ru-web:/var/www/$ru/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_ru.txt' $dest/$ru/htdocs/ finnland:/var/www/$ru/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_ru.txt' $dest/$ru/htdocs/ jpy:/var/www/$ru/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_ru.txt' $dest/$ru/htdocs/ jburg:/var/www/$ru/htdocs/
  ;;

  st)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_st.txt' $dest/$static/htdocs/ france:/var/www/$static/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_st.txt' $dest/$static/htdocs/ ru-web:/var/www/$static/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_st.txt' $dest/$static/htdocs/ finnland:/var/www/$static/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_st.txt' $dest/$static/htdocs/ jpy:/var/www/$static/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_st.txt' $dest/$static/htdocs/ jburg:/var/www/$static/htdocs/
  ;;
  *)
    # France
    rsync -auq --delete --exclude-from='./resources/rsync_ex_de_dest.txt' $dest/ france:/var/www/

    # regu.ru
    rsync -auq --delete --exclude-from='./resources/rsync_ex_ru.txt' $dest/ ru-web:/var/www/

    # finnland
    rsync -auq --delete $mirror/finnland/ finnland:/var/www/

    # jpy
    rsync -auq --delete $mirror/jpy/ jpy:/var/www/

    # jburg
    rsync -auq --delete $mirror/jburg/ jburg:/var/www/

    # Raspberry Pi Local
    rsync -auq --delete $pi/ pi:/srv/http/home.silviosiefke.com/
  ;;
esac
