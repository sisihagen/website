---
title: "Peer-to-Peer VPN with vpncloud"
date: 2020-06-07
draft: false
tags: "Computer"
shorttext: "Anyone who calls several servers his own may need a VPN network for Monitoring and so on. I am here, vpncloud."
cover: "computer"
lang: en
---

Those who call several servers their own and want to guarantee appropriate availability host them in geographically distributed data centers. The communication of the servers is difficult and often this internal Traffic takes place unencrypted.

Here [vpncloud as Peer-to-Peer VPN](https://github.com/dswd/vpncloud "Peer-to-Peer VPN") offers itself. In addition to a simple setup there are the following Highlights speak for vpncloud :

  - vpncloud connects the VPN network to its own Interface which can be freely configured with corresponding IP'S

  - vpncloud created a fully networked peer-to-peer VPN network. This means that vpncloud automatically connects the servers based on the IP addresses.

  - the VPN Tunnel is encrypted with AES-256

  - in the case of a connection loss vpncloud connects automatically again
  
  - [a very good Performance](https://vpncloud.ddswd.de/features/performance/ "Performance Measurements")

  - it's Open Source

  - it is easy to configure

  - it is stable, I have vpncloud on 9 servers in use, including the Rasspberry PI

#### Installation

First, you should install vpncloud on each server that belongs to the server cluster. There are ready-made packages for Debian-based distributions, under Arch (Arm, amd64) a corresponding package can be installed with aur.


```bash
wget https://github.com/dswd/vpncloud/releases/download/v1.3.0/vpncloud_1.3.0_amd64.deb
sudo dpkg -i vpncloud_1.3.0_amd64.deb
```

A Systemd Service will automatically installed.

#### Configuration

The configuration can be found in the directory /etc/vpncloud, a corresponding sample file is available. You copy it as a new file and can edit it accordingly.

```bash
sudo cp example.net.disabled mynet.net
sudo nano mynet.net
```

First we introduce the participants. This is done with peers.

```yaml
peers:
  - firstip:3210
  - secoundip:3210  
```

The Port can be adapted to your needs. You can also specify host names, or you can specify names in the /etc/hosts file.

###### Shared Key

The Shared Key is used for encryption, should be accordingly secure and be the same on all machines.

```yaml
shared_key: "nT4gAGSP!S9!2Rjb9%h*gdVN*8NszP"
```

###### Encryption

vpncloud uses ChaCha20 as its algorithm in the Default setting. For newer and faster CPU'S you should use AES-256 for better Performance.

```yaml
crypto: aes256
```

###### Interface

Finally, you should specify Ifdown / Ifup options, these commands are executed by vpncloud to boot and shut down the interface.

```yaml
ifup: "ifconfig $IFNAME 10.0.1.1/8 mtu 1400"
ifdown: "ifconfig $IFNAME down"
```

###### Let's run

As I said, a systemd service is installed which makes starting, stopping and automatic starting very easy. The following command is sufficient for automatic and immediate Start.

```bash
systemctl enable --now vpncloud@mynet 
```
Possible errors can be found with the status, or journalctl. The Hosts should be accessible via Ping. From now on, databases, Monitoring Tools and Co.can communicate with each other via encrypted Traffic.
