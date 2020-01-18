---
title: "Surveillance Facile Du Serveur"
date: 2020-01-13
tags: "ordinateur"
shorttext: "Vous trouvez Cacti trop chargé? Tu ne veux pas lancer PHP? Je présente deux outils simples qui pourraient servir à cette fin."
cover: "computer"
draft: false
lang: fr
---

Tu trouves les cactus comme moi trop encombrés? Trouver des non-sens de PHP sur un serveur pour un seul outil? Alors peut-être que vous installerez Monit / SimpleMonitor. Des outils simples sans grandes dépendances et avec une interface web simple. Monit provoque des problèmes avec le SMTP / vérification de soumission, donc j'ai installé aussi simple moniteur.

Nous avons d'abord installé et configuré l'outil [monit](https://mmonit.com/monit/ "Monit Barking at daemons").

#### Monit

```bash
pacman -S monit
```

La configuration peut être trouvé dans le fichier /etc/monitrc, mais il est recommandé de créer le répertoire /etc/monit.d et stocker vos propres configurations et pour activer le répertoire correspondant dans la monitrc.

```bash
mkdir /etc/monit.d
```

Laissez-nous créer le truc d'alerte:

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

Bien sûr, vous devez l'adapter à votre Situation. Ensuite, nous pouvons créer les Hôtes. J'ai créé un fichier pour chaque Hôte.

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

Puis commencer à monit et vous pouvez voir le résultat dans l'interface web intégrée. Si vous utilisez un Serveur comme moi, vous devez lier le serveur web à l'adresse ip publique dans /etc/monitrc.

```bash
systemd enable --now monit
```

{{< image srcwebp="/static/img/content/2020/034.webp" srcalt="/static/img/content/2020/034.jpg" title="Monit at work" >}}

#### Simple Monitor

Maintenant, installons [SimpleMonitor](https://jamesoff.github.io/simplemonitor / "SimpleMonitor"). L'Installation et la configuration sont faciles comme avec monit. Simple Monitor a besoin de modules python et de la version 3 de python. 

```bash
pacman -S python-colorlog python-pydbus python-paho-mqtt
```

Clonons le Github Repo.

```bash
git clone https://github.com/jamesoff/simplemonitor.git
```

Simple moniteur utiliser deux fichiers, le moniteur de fichier.ini pour les paramètres du programme, les moniteurs.ini pour les paramètres des hôtes que vous voulez surveiller. Les deux fichiers doivent être dans le même dossier comme monitor.py.

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

Pour plus de détails sur les réglages, consultez le site web. Je n'utilise que la webinterface, mais vous pouvez également utiliser un journal, une base de données ou une combinaison de l'informatique. L'interface Web que je prends dans mon dossier nginx, donc je copie aussi le fichier à partir du répertoire html. Ensuite, vous pouvez voir mes moniteurs.ini.

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

J'utilise le script shell pour démarrer l'outil.

```bash
cat /usr/local/bin/monitor.sh

#!/usr/bin/env bash

cd /usr/local/simplemonitor && exec /usr/bin/python3 monitor.py -q >> /var/log/simplemonitor.log
```

Pour le démarrage du système j'utilise systemd. 

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
