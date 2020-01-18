---
title: "Easy Server Monitoring"
date: 2020-01-13
tags: "Computer"
shorttext: "You find Cacti too overloaded? You don't want to run PHP? I present two simple Tools that could serve the purpose."
cover: "computer"
draft: false
lang: en 
---

Do you find Cacti like me too cluttered? Find PHP nonsense on a Server for a single Tool? Then maybe you will install Monit / SimpleMonitor. Simple Tools without major dependencies and with a simple web interface. Monit causes problems with the SMTP / Submission Checks, so I installed also Simple Monitor.

First we installed and configure the [monit](https://mmonit.com/monit/ "Monit Barking at daemons") tool. 

#### Monit

```bash
pacman -S monit
```

The configuration can be found in the file /etc/monitrc, but it is recommended to create the directory /etc/monit.d and store your own configurations there and to activate the corresponding directory in the monitrc. 

```bash
mkdir /etc/monit.d
```

Let us create the alert stuff:

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

Of course, you have to adapt this to your Situation. Next, we can create the Hosts. I created a file for each Host.

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

Then start monit and you can see the result in the built-in web interface. If you use a Server like me, you have to bind the web server to the public ip in  /etc/monitrc.

```bash
systemd enable --now monit
```

{{< image srcwebp="/static/img/content/2020/034.webp" srcalt="/static/img/content/2020/034.jpg" title="Monit at work" >}}

#### Simple Monitor

Now let us installed [SimpleMonitor](https://jamesoff.github.io/simplemonitor/ "SimpleMonitor"). Installation and configuration is easy like with monit. Simple Monitor need some python modules and python version 3. 

```bash
pacman -S python-colorlog python-pydbus python-paho-mqtt
```

Let us clone the Github Repo.

```bash
git clone https://github.com/jamesoff/simplemonitor.git
```

Simple Monitor use two files, the file monitor.ini for the program settings, monitors.ini for the hosts settings which you want to monitor. Both files should be in the same folder like monitor.py.

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

For Settings details take a look on the website. I use only the webinterface but also you can use a log, a database or a combination of it. The webinterface I take in my nginx folder, so I copy also the file from html directory in it. Next you can see my monitors.ini.

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

I use shell script to start the tool.  

```bash
cat /usr/local/bin/monitor.sh

#!/usr/bin/env bash

cd /usr/local/simplemonitor && exec /usr/bin/python3 monitor.py -q >> /var/log/simplemonitor.log
```

For system start I use systemd. 

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
