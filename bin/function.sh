#!/usr/bin/env bash

# for new.sh
function clean_dir()
{
  rm -r $1
}

# for new.sh
function clean_file()
{
  truncate -s 0 $1
}

# for new.sh
function copy_files()
{
  for i in "${source[@]}" ; do
    cp "$i" "$tmp_dir"
  done
}

# create md file header
function create_file()
{
  {
    echo "---"
    echo "title: \"$tmp_title\""
    echo "date: $date"
    echo "draft: false"
    echo "tags: \"$tag\""
    echo "shorttext:"
    echo "cover: \"$cover\""
    echo "lang: $lang"
    echo "---"
  } >> "$file"
}

# syncing
function sync()
{
  rsync -avq $1 $2
}

# html finished
function html()
{
  find "$1" -name "index.xml" -delete
  /usr/bin/minify --type=html --html-keep-document-tags --html-keep-end-tags --html-keep-quotes -r "$1" -o "$2"
  cp "$1"/robots.txt "$2"
}

# check png and convert them to jpg
function png()
{
  # read the png file in an array
  mapfile -t img < <(find ./static/static/img/"$1"/"${year}" -type f -name "*.png")

  # we run through the png files
  for i in "${img[@]}"; do
    # cat the extension
    filename=${i%.*}

    # optimzed pictures
    tinypng $filename.png

    # convert png to jpg
    convert $filename.png $filename.jpg

    # delete png
    rm -v $filename.png
  done
}

# difference between jpeg and webp
function images()
{
  # find jpg files
  find ./static/static/img/"$1"/"$year" -type f -name "*.jpg" | sort > ./jpg.txt

  # remove extension
  if [[ -f "./jpg.txt" ]]; then
    sed -i 's/.jpg//g' ./jpg.txt
  fi

  # find webp files
  find ./static/static/img/"$1"/"$year" -type f -name "*.webp" | sort > ./webp.txt

  # remove extension
  if [[ -f "webp.txt" ]]; then
    sed -i 's/.webp//g' ./webp.txt
  fi
}

# convert the missing webp from jpg
function alignthem()
{
  # convert jpg to webp
  if [[ -f "./diff.txt" ]]; then
    while read line; do
      tinypng -q $line.jpg
      cwebp -quiet $line.jpg -o $line.webp
    done < ./diff.txt
  fi

  # # clean the files
  if [[ -f "./jpg.txt" ]] || [[ -f "./webp.txt" ]] || [[ -f "./diff.txt" ]]; then
    rm ./jpg.txt ./webp.txt ./diff.txt
  fi
}

function sedpi()
{
  sed -i -e 's|brands-ovh|brands-raspi|g' ./public/local/index.html
  sed -i -e 's|www.ovh.com|www.raspberrypi.org|g' ./public/local/index.html
  sed -i -e 's|OVH - Innovation for Freedom|RASPBERRY PI FOUNDATION|g' ./public/local/index.html
}

function sedmirror_hetzner()
{
  sed -i -e 's|brands-ovh|brands-hetzner|g' $mirror/$finnland/$1/htdocs/index.html
  sed -i -e 's|brands-regru|brands-hetzner|g' $mirror/$finnland/$1/htdocs/index.html
  sed -i -e 's|www.ovh.com|www.hetzner.de|g' $mirror/$finnland/$1/htdocs/index.html
  sed -i -e 's|www.reg.ru|www.hetzner.de|g' $mirror/$finnland/$1/htdocs/index.html
  sed -i -e 's|Reg.ru the number one in Russia|Hetzner Online als ein führender Webhostinganbieter und erfahrener Rechenzentrumsbetreiber in Deutschland bietet professionelle Hostinglösungen zu fairen Preisen.|g' $mirror/$finnland/$1/htdocs/index.html
  sed -i -e 's|homearch|homedebian|g' $mirror/$finnland/$1/htdocs/index.html
  sed -i -e 's|www.arch.org|www.debian.org|g' $mirror/$finnland/$1/htdocs/index.html
  sed -i -e 's|Arch Linux|Debian - The Universal Operating System|g' $mirror/$finnland/$1/htdocs/index.html
  sed -i -e 's|OVH - Innovation for Freedom|Hetzner Online als ein führender Webhostinganbieter und erfahrener Rechenzentrumsbetreiber in Deutschland bietet professionelle Hostinglösungen zu fairen Preisen.|g' $mirror/$finnland/$1/htdocs/index.html
}

function sedmirror_oneprovider()
{
  sed -i -e 's|brands-ovh|brands-oneprovider|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|brands-regru|brands-oneprovider|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|www.ovh.com|www.oneprovider.com|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|www.reg.ru|www.oneprovider.com|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|OVH - Innovation for Freedom|With over 140 datacenter locations in the world, OneProvider is your one stop for dedicated server hosting solutions in the location of your choice.|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|Reg.ru the number one in Russia|With over 140 datacenter locations in the world, OneProvider is your one stop for dedicated server hosting solutions in the location of your choice.|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|homearch|homedebian|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|www.arch.org|www.debian.org|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|Arch Linux|Debian - The Universal Operating System|g' $mirror/$1/$2/htdocs/index.html
}
