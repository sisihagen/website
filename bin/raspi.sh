#!/usr/bin/env bash

if [[ -d './public/local' ]]; then
  cp -r ./public/build/de/* ./public/local
  find ./public/local -type f -name "*.html" -exec sed -i -e 's/silviosiefke.de/home.silviosiefke.com/g' {} \;
  rsync -auq --exclude "scss" ./static/static/ pi:/srv/http/home.silviosiefke.com/static/
  sed -i -e 's/ovh.png/raspi.png/g' ./public/local/index.html
  sed -i -e 's/ovh.webp/raspi.webp/g' ./public/local/index.html
  sed -i -e 's/www.ovh.com/www.raspberrypi.org/g' ./public/local/index.html
  sed -i -e 's/OVH - Innovation for Freedom/RASPBERRY PI FOUNDATION/g' ./public/local/index.html
  rsync -auq public/local/ pi:/srv/http/home.silviosiefke.com/
else
  mkdir ./public/local
  cp -r ./public/build/de/* ./public/local
  find ./public/local -type f -name "*.html" -exec sed -i -e 's/silviosiefke.de/home.silviosiefke.com/g' {} \;
  rsync -auq --exclude "scss" ./static/static/ pi:/srv/http/home.silviosiefke.com/static/
  sed -i -e 's/ovh.png/raspi.png/g' ./public/local/index.html
  sed -i -e 's/ovh.webp/raspi.webp/g' ./public/local/index.html
  sed -i -e 's/www.ovh.com/www.raspberrypi.org/g' ./public/local/index.html
  sed -i -e 's/OVH - Innovation for Freedom/RASPBERRY PI FOUNDATION/g' ./public/local/index.html
  rsync -auq public/local/ pi:/srv/http/home.silviosiefke.com/
fi

exit 0
