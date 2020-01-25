#!/usr/bin/env bash

if [[ -d './static/static/img/sprites' ]]; then
  cp -r ./static/static/img/brands ./static/static/img/sprites
  rm ./static/static/img/sprites/brands/*.webp
  find ./static/static/img/sprites/brands/ -name '*.png' -exec mogrify -resize 68\> {} \;
  ~/.local/bin/glue -q -c -p 20 -s ./static/static/img/sprites/brands -o ./static/static/img/brands --scss ./static/static/scss/_includes
fi

if [[ -f './static/static/scss/_includes/brands.scss' ]]; then
  mv  ./static/static/scss/_includes/brands.scss ./static/static/scss/_includes/_sprite.scss
  sed -i 's|../../img/brands/brands.png|/static/img/brands/brands.png|g' ./static/static/scss/_includes/_sprite.scss
fi

if [[ -f './static/static/img/sprites/brands.png' ]]; then
  optipng -quiet ./static/static/img/brands/brands.png
  cwebp -quiet ./static/static/img/brands/brands.png -o ./static/static/img/brands/brands.webp
fi
