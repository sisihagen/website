#!/usr/bin/env bash

if [[ -d './public/local' ]]; then
  cp -r ./public/build/de/* ./public/local
  find ./public/local -type f -name "*.html" -exec sed -i -e 's/silviosiefke.de/home.silviosiefke.com/g' {} \;
  rsync -avuzq --exclude "scss" ./static/static/ pi:/usr/share/nginx/html/static/
  sed -i -e 's/ovh.png/raspi.png/g' ./public/local/index.html
  sed -i -e 's/ovh.webp/raspi.webp/g' ./public/local/index.html
  sed -i -e 's/www.ovh.com/www.raspberrypi.org/g' ./public/local/index.html
  sed -i -e 's/OVH - Innovation for Freedom/RASPBERRY PI FOUNDATION/g' ./public/local/index.html
  rsync -avuzq public/local/ pi:/usr/share/nginx/html/
else
  mkdir ./public/local
  cp -r ./public/build/de/* ./public/local
  find ./public/local -type f -name "*.html" -exec sed -i -e 's/silviosiefke.de/home.silviosiefke.com/g' {} \;
  rsync -avuzq --exclude "scss" ./static/static/ pi:/usr/share/nginx/html/static/
  sed -i -e 's/ovh.png/raspi.png/g' ./public/local/index.html
  sed -i -e 's/ovh.webp/raspi.webp/g' ./public/local/index.html
  sed -i -e 's/www.ovh.com/www.raspberrypi.org/g' ./public/local/index.html
  sed -i -e 's/OVH - Innovation for Freedom/RASPBERRY PI FOUNDATION/g' ./public/local/index.html
  rsync -avuzq ./public/local/ pi:/usr/share/nginx/html/
fi

exit 0
