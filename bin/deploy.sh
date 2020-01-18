#!/usr/bin/env bash

workdir=public/dest
de=silviosiefke.de/htdocs
en=silviosiefke.com/htdocs
fr=silviosiefke.fr/htdocs
ru=silviosiefke.ru/htdocs
st=static.silviosiefke.com/htdocs

case "$1" in
    de)
        rsync -auq --delete $workdir/$de/ web:/var/www/silviosiefke.de/htdocs/
    ;;

    fr)
        rsync -auq --delete $workdir/$fr/ web:/var/www/silviosiefke.fr/htdocs/
    ;;

    en)
        rsync -auq --delete $workdir/$en/ web:/var/www/silviosiefke.com/htdocs/
    ;;

    ru)
        rsync -auq --delete $workdir/$ru/ ru-web:/var/www/silviosiefke.ru/htdocs/
    ;;

    st)
        rsync -auq --delete $workdir/$st/ web:/var/www/static.silviosiefke.com/htdocs/
        rsync -auq --delete $workdir/$st/ ru-web:/var/www/static.silviosiefke.com/htdocs/
    ;;

    *)
        rsync -auq --delete --exclude "sisi-plancher.com" --exclude "log" --exclude "silviosiefke.ru" --exclude "scss" $workdir/ web:/var/www/
        rsync -auq --delete --exclude "sisi-plancher.com" --exclude "log" --exclude "scss" --exclude "silviosiefke.de" --exclude "silviosiefke.fr" --exclude "silviosiefke.com" $workdir/ ru-web:/var/www/
    ;;
esac
