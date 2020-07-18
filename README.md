# silviosiefke.com / silviosiefke.de / silviosiefke.fr

Here you can see how I create my private website. I use the static site generator [Hugo](https://gohugo.io "The world’s fastest framework for building websites").

I use the following frameworks.

* [Normalize.css](https://github.com/necolas/normalize.css "A modern, HTML5-ready alternative to CSS resets") as CSS Reset
* [Jquery](http://jquery.com) as Javascript library for awesome tricks
* [Yarn](https://yarnpkg.com/) as package Manager for JS Librarys
* [PostCSS](http://postcss.org) for dealing with css files
* [Icomoon](https://icomoon.io) for svg Files
* [Minify](https://github.com/tdewolff/minify) to minify html files
* [htmltest](https://github.com/wjdp/htmltest) for test external links
* [linkchecker](http://wummel.github.io/linkchecker/) for test internal links
* [Glue](https://github.com/jorgebastida/glue) to create sprites.


If you want play with the page install [Hugo](https://gohugo.io "The world’s fastest framework for building websites"), [Git](https://www.git-scm.com/ "distributed VCS designed for speed and efficiency"), [yarn](https://yarnpkg.com/lang/en/ "FAST, RELIABLE, AND SECURE DEPENDENCY MANAGEMENT.") and [Nodejs](https://nodejs.org/en/) I use Arch and Gentoo so I not know how to install the stuff on other operating systems. 

```bash
pacman -S hugo git python-pygments yarn jpegoptim gifsicle parallel
emerge -av hugo git pygments yarn jpegoptim gifsicle libwebp optipng linkchecker parallel
pkg install gohugo py37-pygments yarn git jpegoptim gifsicle webp optipng minify parallel
```

To install minify on Arch and Gentoo you need to download the binary from the github repo. Extract and move minify to /usr/local/bin

```bash
wget https://github.com/tdewolff/minify/releases/download/v2.7.6/minify_2.7.6_linux_amd64.tar.gz
tar xf minify_2.7.6_linux_amd64.tar.gz
mv minify_2.7.6_linux_amd64/minify /usr/local/bin
rm -r minify*
```

To install linkchecker on Arch you can use AUR. For FreeBSD you need to download the package and use it from the folder or copy to your bin PATH.

I installed glue with pip in usermode. 

```bash
pip install glue --user
```

Now the basis is installed we can try to run the projects.

```bash
git clone https://github.com/sisihagen/website
cd website
yarn install
./bin/hugo.sh 
```
