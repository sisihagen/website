#!/usr/bin/env bash
# The mirrors will be feed over rsync Daemon on host france.

# variables
source ./bin/variables.sh

case "$1" in
  de)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_de.txt' $dest/$de/htdocs/ france:/var/www/$de/htdocs/
  ;;

  en)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_en.txt' $dest/$en/htdocs/ france:/var/www/$en/htdocs/
  ;;

  fr)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_fr.txt' $dest/$fr/htdocs/ france:/var/www/$fr/htdocs/
  ;;

  en)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_ru.txt' $dest/$ru/htdocs/ france:/var/www/$ru/htdocs/
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
