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
    echo "geo:"
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
  /usr/bin/minify --type=html --html-keep-document-tags --html-keep-end-tags --html-keep-quotes -r -o "$1" *
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

function sedmirror_vultr()
{
  sed -i -e 's|brands-arch|brands-freebsd|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|brands-arch|brands-debian|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|brands-nginx|brands-caddy|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|brands-ovh|brands-vultr|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|brands-regru|brands-vultr|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|www.ovh.com|www.vultr.com/?ref=8742952|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|www.reg.ru|www.vultr.com/?ref=8742952|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|www.archlinux.org|www.freebsd.org|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|www.nginx.org|www.caddyserver.com|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|Arch Linux|The FreeBSD Project|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|Nginx Webserver|Caddy Webserver|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|OVH - Innovation for Freedom|SSD VPS Servers, Cloud Servers and Cloud Hosting by Vultr|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|OVH - Innovation for Freedom|Reg.ru the number one in Russia|g' $mirror/$1/$2/htdocs/index.html
}

function sedmirror_hostafrica()
{
  sed -i -e 's|brands-ovh|brands-cloudza|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|brands-arch|brands-debian|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|brands-nginx|brands-caddy|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|www.ovh.com|cloud.co.za|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|www.nginx.org|www.caddyserver.com|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|www.archlinux.org|www.debiam.org|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|Arch Linux|Debian - The universal operating system|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|OVH - Innovation for Freedom|Cloud Servers - Windows or Linux from South Africa|g' $mirror/$1/$2/htdocs/index.html
  sed -i -e 's|Nginx Webserver|Caddy Webserver|g' $mirror/$1/$2/htdocs/index.html
}

function deletejs()
{
  sed -i 's|<script async src="/static/js/site.js"></script>||g' $1
}
