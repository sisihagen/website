---
title: "VPN Peer-to-Peer avec vpncloud"
date: 2020-06-07
draft: false
tags: "Ordinateur"
shorttext: "Quiconque appelle son propre serveur sur plusieurs serveurs peut avoir besoin d'un réseau VPN pour la surveillance, etc. Je suis ici, vpncloud."
cover: "computer"
lang: fr
---

Ceux qui appellent plusieurs serveurs les leurs et veulent garantir une disponibilité appropriée les hébergent dans des centres de données répartis géographiquement. La communication des serveurs est difficile et souvent ce trafic interne a lieu en clair.

Ici [vpncloud comme VPN Peer-to-Peer](https://github.com/dswd/vpncloud "Peer-to-Peer VPN") s'offre. En plus d'une configuration simple il y a les faits saillants suivants parler pour vpncloud :

  - vpncloud connecte le réseau VPN à sa propre Interface qui peut être configurée librement avec les adresses IP correspondantes

  - vpncloud a créé un réseau VPN peer-to-peer entièrement en réseau. Cela signifie que vpncloud connecte automatiquement les serveurs en fonction des adresses IP.

  - le Tunnel VPN est crypté avec AES-256

  - dans le cas d'une perte de connexion vpncloud se connecte automatiquement à nouveau

  - [une très bonne Performance](https://vpncloud.ddswd.de/features/performance/ "Performance Measurements")

  - il est Open Source

  - il est facile à configurer

  - il est stable, j'ai vpncloud sur 9 serveurs en cours d'utilisation, y compris le Rasspberry PI

#### Installation

Tout d'abord, vous devez installer vpncloud sur chaque serveur appartenant au cluster de serveurs. Il existe des paquets prêts à L'emploi pour les distributions basées sur Debian, sous Arch (Arm, amd64) un paquet correspondant peut être installé avec aur.


```bash
wget https://github.com/dswd/vpncloud/releases/download/v1.3.0/vpncloud_1.3.0_amd64.deb
sudo dpkg -i vpncloud_1.3.0_amd64.deb
```

Un service Systemd sera automatiquement installé.

#### Configuration

La configuration se trouve dans le répertoire / etc / vpncloud, un exemple de fichier correspondant est disponible. Vous le copier dans un nouveau fichier et pouvez le modifier en conséquence.

```bash
sudo cp example.net.disabled mynet.net
sudo nano mynet.net
```

Nous présentons d'abord les participants. Ceci est fait avec des pairs.

```yaml
peers:
  - firstip:3210
  - secoundip:3210  
```

Le Port peut être adapté à vos besoins. Vous pouvez également spécifier des noms d'hôte, ou vous pouvez spécifier des noms dans le fichier /etc/hosts.

###### Clé Partagée

La clé partagée est utilisée pour le chiffrement, doit être en conséquence sécurisée et être la même sur toutes les machines.

```yaml
shared_key: "nT4gAGSP!S9!2Rjb9%h*gdVN*8NszP"
```

###### Cryptage

vpncloud utilise ChaCha20 comme algorithme dans le paramètre par défaut. Pour les processeurs plus récents et plus rapides, vous devez utiliser AES-256 pour de meilleures performances.

```yaml
crypto: aes256
```

###### Interface

Enfin, vous devez spécifier les options Ifdown / Ifup, ces commandes sont exécutées par vpncloud pour démarrer et arrêter l'interface.

```yaml
ifup: "ifconfig $IFNAME 10.0.1.1/8 mtu 1400"
ifdown: "ifconfig $IFNAME down"
```

###### Passons à l'exécution de

Comme je l'ai dit, un service systemd est installé ce qui rend le démarrage, l'arrêt et le démarrage automatique très faciles. La commande suivante est suffisante pour automatique et Démarrage immédiat.

```bash
systemctl enable --now vpncloud@mynet 
```

Les erreurs possibles peuvent être trouvées avec le statut, ou journalctl. Les hôtes doivent être accessibles via Ping. A partir de Maintenant, bases de données, Outils De Suivi et Co.peut communiquer entre eux via le trafic crypté.
