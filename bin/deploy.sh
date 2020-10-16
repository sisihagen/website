#!/usr/bin/env bash

# variables
source ./bin/variables.sh

case "$1" in
    *)
        # France
        rsync -auq --delete --exclude "sisi-plancher.com" --exclude "debt.silviosiefke.com" --exclude "mailconfig.sisi-systems.ovh" --exclude "status.sisi-systems.ovh" --exclude "log" --exclude "silviosiefke.ru" $dest/ france:/var/www/

        # Russia
        rsync -auq --delete --exclude "sisi-plancher.com" --exclude "log" --exclude "silviosiefke.de" --exclude "silviosiefke.fr" --exclude "silviosiefke.com" $dest/ ru-web:/var/www/

        # Raspberry Pi Local
        rsync -auq --delete $pi/ pi:/srv/http/home.silviosiefke.com/

        # Finnland
        rsync -avq --delete --exclude "log" $mirror/$finnland/ finnland:/var/www/

        # South Africa
        rsync -avq --delete --exclude "log" $mirror/$jburg/ jburg:/var/www/

        # Japan
        rsync -avq --delete --exclude "log" $mirror/$jpy/ jpy:/var/www/
    ;;
esac
