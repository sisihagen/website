---
title: "Легкий Мониторинг Сервера"
date: 2020-01-13
tags: "Компьютер"
shorttext: "Вы находите кактусы слишком перегруженными? Вы не хотите запускать PHP? Я представляю два простых инструмента, которые могли бы служить этой цели."
cover: "computer"
draft: false
lang: ru
---

Вы не находите, что кактусы вроде меня слишком загромождены? Найти PHP-нонсенс на сервере для одного инструмента? Тогда, возможно, вы установите Monit / SimpleMonitor. Простые инструменты без основных зависимостей и с простым веб-интерфейсом. Монит вызывает проблемы с проверками протоколам SMTP / представления, поэтому я установил также простой монитор.

Сначала мы установили и настроили инструмент [monit](https://mmonit.com/monit/ "Monit Barking at daemons").

#### Монит

```bash
pacman -S monit
```

Конфигурацию можно найти в файле /etc/monitrc, но рекомендуется создать каталог /etc/monit.d и хранить там свои собственные конфигурации и активировать соответствующий каталог в monitrc. 

```bash
mkdir /etc/monit.d
```

Давайте создадим предупреждающий материал:

```bash
set mailserver meinmailser.com port 587
        username "username" password "password"
using tlsv12

set mail-format {
   from: monit@pi
   subject: $SERVICE $EVENT at $DATE
   message: Monit $ACTION $SERVICE at $DATE on $HOST: $DESCRIPTION.
} 

set alert meinealtertmail
```

Конечно, вы должны приспособить это к своей ситуации. Далее, мы можем создать хосты. Я создал файл для каждого хоста.

```bash
check host myserver with address myserver
    if failed
        port 22
        protocol ssh
    then alert
    if failed
        port 587 and
        expect "^220.*"
        send   "HELO myserver\r\n"
        expect "^250.*"
        send   "QUIT\r\n"
        for 3 cycles
    then alert
    if failed
        port 993
        protocol imaps
    then alert
    if failed
        port 443
        protocol https
        status = 200
        content = "Silvio Siefke"
    then alert
    if failed
        port 80
        protocol http
        status = 301
    then alert    
```

Затем запустите monit, и вы сможете увидеть результат во встроенном веб-интерфейсе. Если вы используете такой сервер, как я, вы должны привязать веб-сервер к публичному ip в /etc/monitrc.

```bash
systemd enable --now monit
```

{{< image srcwebp="/static/img/content/2020/034.webp" srcalt="/static/img/content/2020/034.jpg" title="Monit at work" >}}

#### Простой Монитор

Теперь давайте установим [SimpleMonitor](https://jamesoff.github.io/simplemonitor/ "SimpleMonitor"). Установка и настройка проста, как и в случае с monit. Простому монитору нужны некоторые модули python и python версии 3. 

```bash
pacman -S python-colorlog python-pydbus python-paho-mqtt
```

Давайте клонируем РЕПО Github.

```bash
git clone https://github.com/jamesoff/simplemonitor.git
```

Простой монитор используйте два файла, файловый монитор.ini для настроек программы, мониторов.ini для настроек хостов, которые вы хотите отслеживать. Оба файла должны быть в одной папке, например monitor.py-да.

```bash
nano monitor.ini

[monitor]
interval=300

[reporting]
loggers=logfile
alerters=email

[logfile]
type=html
folder=/srv/http/sisi/monitor
filename=/srv/http/sisi/monitor/index.html
header=/srv/http/sisi/monitor/header.html
footer=/srv/http/sisi/monitor/footer.html

[email]
type=email
host=localhost
from=root
to=siefke
```

Для получения подробной информации о настройках загляните на сайт. Я использую только веб-интерфейс, но также вы можете использовать журнал, базу данных или их комбинацию. Вебинтерфейс я беру в своей папке nginx, поэтому я копирую также файл из каталога html в нем. Далее вы можете увидеть мои мониторы.ини.

```bash
nano monitors.ini

[ru-mail-ping]
type=host
host=ru-mail.silviosiefke.com
tolerance=2

[silviosiefke.ru]
type=http
url=https://silviosiefke.ru
allowed_codes=200

[ru-mail-dovecot]
type=tcp
host=ru-mail.silviosiefke.com
port=993

[ru-mail-smtp]
type=tcp
host=ru-mail.silviosiefke.com
port=25

[ru-mail-submission]
type=tcp
host=ru-mail.silviosiefke.com
port=587
```

Я использую скрипт, чтобы запустить инструмент.

```bash
cat /usr/local/bin/monitor.sh

#!/usr/bin/env bash

cd /usr/local/simplemonitor && exec /usr/bin/python3 monitor.py -q >> /var/log/simplemonitor.log
```

Для запуска системы я использую systemd.

```bash
cat /etc/systemd/system/monitor.service

[Unit]
Description=Monitoring my network
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/monitor.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

{{< image srcwebp="/static/img/content/2020/035.webp" srcalt="/static/img/content/2020/035.jpg" title="SimpleMonitor at Work" >}}
