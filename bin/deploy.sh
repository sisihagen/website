#!/usr/bin/env bash
# The mirrors will be feed over rsync Daemon on host france.

# variables
source ./bin/variables.sh

case "$1" in
  de)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_de.txt' $dest/$de/htdocs/ aweb:/var/www/$de/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_de.txt' $dest/$de/htdocs/ brazil:/var/www/$de/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_de.txt' $dest/$de/htdocs/ france:/var/www/$de/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_de.txt' $dest/$de/htdocs/ naw:/var/www/$de/htdocs/
  ;;

  en)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_en.txt' $dest/$en/htdocs/ aweb:/var/www/$en/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_en.txt' $dest/$en/htdocs/ brazil:/var/www/$en/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_en.txt' $dest/$en/htdocs/ france:/var/www/$en/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_en.txt' $dest/$en/htdocs/ naw:/var/www/$en/htdocs/
  ;;

  fr)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_fr.txt' $dest/$fr/htdocs/ aweb:/var/www/$fr/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_fr.txt' $dest/$fr/htdocs/ brazil:/var/www/$fr/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_fr.txt' $dest/$fr/htdocs/ france:/var/www/$fr/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_fr.txt' $dest/$fr/htdocs/ naw:/var/www/$fr/htdocs/
  ;;

  ru)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_ru.txt' $dest/$ru/htdocs/ aweb:/var/www/$ru/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_ru.txt' $dest/$ru/htdocs/ brazil:/var/www/$ru/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_ru.txt' $dest/$ru/htdocs/ ru-web:/var/www/$ru/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_ru.txt' $dest/$ru/htdocs/ naw:/var/www/$ru/htdocs/
  ;;

  st)
    rsync -auq --delete --exclude-from='./resources/rsync_ex_st.txt' $dest/$static/htdocs/ aweb:/var/www/$static/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_st.txt' $dest/$static/htdocs/ brazil:/var/www/$static/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_st.txt' $dest/$static/htdocs/ france:/var/www/$static/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_st.txt' $dest/$static/htdocs/ naw:/var/www/$static/htdocs/
    rsync -auq --delete --exclude-from='./resources/rsync_ex_st.txt' $dest/$static/htdocs/ ru-web:/var/www/$static/htdocs/
  ;;
  *)
    # Europe
    rsync -auq --delete --exclude-from='./resources/rsync_ex_de_dest.txt' $dest/ france:/var/www/

    # regu.ru
    rsync -auq --delete --exclude-from='./resources/rsync_ex_ru.txt' $dest/ ru-web:/var/www/

    # North America
    rsync -auq --delete --exclude "log" $mirror/na/ naw:/var/www/

    # South America
    rsync -auq --delete --exclude "log" $mirror/sa/ brazil:/var/www/

    # Asia
    rsync -auq --delete --exclude "log" $mirror/asia/ aweb:/var/www/

    # Africa
    #rsync -auq --delete --exclude "log" $mirror/africa/ jburg:/var/www/

    # Raspberry Pi Local
    rsync -auq --delete $pi/ pi:/srv/http/home.silviosiefke.com/
  ;;
esac
