---
title: "Einfaches Server Monitoring"
date: 2020-01-13
tags: "Computer"
shorttext: "Ihr findet Cacti zu überladen? Ihr wollt nicht PHP laufen lassen? Ich stelle euch zwei einfache Tools vor die den Zweck erfüllen könnten."
cover: "computer"
draft: false
lang: de 
---

Findet Ihr Cacti wie ich zu überladen? Findet Ihr PHP unsinnig auf einen Server für ein einziges Tool? Dann werden Ihr vielleicht Monit / SimpleMonitor installieren. Einfache Tools ohne großen Abhängigkeiten und einfachen Webinterface. Monit macht Probleme mit den SMTP / Submission Checks, deswegen habe ich noch Simple Monitor installiert. 

Als erstes installieren und konfigurieren wir [monit](https://mmonit.com/monit/ "Monit Barking at daemons"). 

#### Monit

```bash
pacman -S monit
```

Die Konfiguration findet Ihr in der Datei /etc/monitrc, es bietet sich aber an das Verzeichnis /etc/monit.d zu erstellen und die eigenen Konfigurationen dort abzulegen und entsprechendes Verzeichnis in der monitrc zu aktivieren. 

```bash
mkdir /etc/monit.d
```

Wir erstellen als erstes die alert Spezifikationen:

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

Ihr müsst das natürlich an eure Situation anpassen. Als nächstes können wir die Hosts anlegen. Ich habe für jeden Host eine Datei angelegt. Ihr könnt es auch in eine Datei schreiben. 

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

Danach monit starten und das Ergebniss seht Ihr dann im eingebauten Webinterface. Solltet Ihr wie ich einen Server nutzen müsst Ihr in der /etc/monitrc den Webserver auf die public ip binden. 

```bash
systemd enable --now monit
```

{{< image srcwebp="/static/img/content/2020/034.webp" srcalt="/static/img/content/2020/034.jpg" title="Monit at work" >}}

#### Simple Monitor

Jetzt wollen wir uns zum Vergleich [SimpleMonitor](https://jamesoff.github.io/simplemonitor/ "SimpleMonitor") anschauen. Installation und Konfiguration ist ähnlich einfach. Das Programm benötigt ein paar Python Module und Python 3. 

```bash
pacman -S python-colorlog python-pydbus python-paho-mqtt
```

Als nächstes müssen wir das Github Verzeichniss klonen. 

```bash
git clone https://github.com/jamesoff/simplemonitor.git
```

SimpleMonitor nutzt zwei Dateien, die Einstellungen zum Programm sucht es in der Datei monitor.ini, die Einstellungen zu den Hosts in der monitors.ini. Beide Dateien müssen im selben Verzeichniss liegen. 

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

Die Einstellungen sind auf der Website gut erklärt. Ich brauche kein Logfile, SimpleMonitor soll eine Website erstellen. Die HTML Dateien im Unterverzeichniss html sollten in den entsprechenden Ordner kopiert werden die Ihr beim [logfile] angegeben habt. Ihr könnt diese auch entsprechend anpassen. 

Als nächstes die Datei monitors.ini und die Konfiguration der Hosts die überprüft werden sollen. 

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

Ich starte SimpleMonitor über ein Shell Script. 

```bash
cat /usr/local/bin/monitor.sh

#!/usr/bin/env bash

cd /usr/local/simplemonitor && exec /usr/bin/python3 monitor.py -q >> /var/log/simplemonitor.log
```

Dazu habe ich ein systemd Service erstellt. 

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
