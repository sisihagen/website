---
title: "Peer-to-Peer VPN mit vpncloud"
date: 2020-06-07
draft: false
tags: "Computer"
shorttext: "Wer mehrere Server sein eigenen nennt benötigt eventuell für Monitoring und so weiter ein VPN Netzwerk. Ich stelle hier vpncloud vor."
cover: "computer"
lang: de
---

Wer mehrere Server sein eigenen nennt und entsprechende Verfügbarkeit garantieren möchte hostet diese in geographisch verteilten Rechenzentren. Die Kommunikation der Server gestaltet sich schwierig und nicht selten findet dieser interne Traffic unverschlüsselt statt. 

Hier bietet sich [vpncloud als Peer-to-Peer VPN](https://github.com/dswd/vpncloud "Peer-to-Peer VPN") an. Neben einer einfachen Einrichtung sind es folgende Highlights die für vpncloud sprechen:

  - vpncloud bindet das VPN Netzwerk an ein eigenes Interface das mit entsprechenden IP's frei konfiguriert werden kann

  - vpncloud erstellt ein vollständig vernetztes peer-to-peer VPN Netzwerk. Das bedeutet das vpncloud automatisch anhand der IP Adressen die Server verbindet.
  
  - der VPN Tunnel ist mit AES-256 verschlüsselt
  
  - bei einen Verbindungsverlust verbindet sich vpncloud selbstständig wieder
  
  - [eine sehr gute Performance](https://vpncloud.ddswd.de/features/performance/ "Performance Measurements")

  - es ist ein OpenSource Projekt
  
  - es ist einfach zu konfigurieren
  
  - es ist stabil, ich habe vpncloud auf 9 Servern im Einsatz einschließlich den Rasspberry PI

#### Installation

Als erstes solltest du auf jeden Server vpncloud installieren der zum Server Cluster gehören soll. Es gibt fertige Pakete für Debian basierte Distributionen, unter Arch (Arm, amd64) kann ein entsprechendes Paket mit AUR installiert werden.


```bash
wget https://github.com/dswd/vpncloud/releases/download/v1.3.0/vpncloud_1.3.0_amd64.deb
sudo dpkg -i vpncloud_1.3.0_amd64.deb
```

Es wird automatisch ein Systemd Service installiert. 

#### Konfiguration

Die Konfiguration findet sich im Verzeichniss /etc/vpncloud, eine entsprechende Beispieldatei ist vorhanden. Diese kopiert Ihr als neue Datei und könnt diese entsprechende bearbeiten. 

```bash
sudo cp example.net.disabled mynet.net
sudo nano mynet.net
```

Als erstes machen wir die Teilnehmer bekannt. Das wird mit peers erledigt. 

```yaml
peers:
  - ersteip:3210
  - zweiteip:3210  
```

Der Port kann man an seine Bedürfnisse anpassen. Du kannst auch Hostnamen angeben, oder entsprechend Namen in der Datei /etc/hosts angeben. 

###### Shared Key

Der Shared Key dient der Verschlüsselung, sollte entsprechend sicher sein und auf allen Maschinen der gleiche sein. 

```yaml
shared_key: "nT4gAGSP!S9!2Rjb9%h*gdVN*8NszP"
```

###### Encryption

vpncloud nutzt in der Default Einstellung ChaCha20 als Algorithmus. Für neuere und schnelle CPU's solltet Ihr für die bessere Performance AES-256 nutzen.

```yaml
crypto: aes256
```

###### Schnittstelle

Als letztes solltet Ihr ifdown / ifup Optionen angeben, diese Befehle führt vpncloud aus um die Schnittstelle hoch- und runterzufahren. 

```yaml
ifup: "ifconfig $IFNAME 10.0.1.1/8 mtu 1400"
ifdown: "ifconfig $IFNAME down"
```

###### Let's run

Wie gesagt es wird ein systemd service installiert der das starten, stoppen und automatische Starten sehr einfach gestaltet. Es reicht der folgende Befehl zum automatischen und sofortigen Start. 

```bash
systemctl enable --now vpncloud@mynet 
```

Eventuelle Fehler findet man mit dem Status, oder eben journalctl. Die Hosts sollten per Ping erreichbar sein. Ab jetzt können Datenbanken, Monitoring Tools und Co. über einen verschlüsselten Traffic miteinander kommunizieren. 
