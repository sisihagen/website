---
title: "Clé cryptée"
date: 2020-02-13
tags: "Ordinateur"
shorttext: "Il y a des fichiers qui devraient être protégés contre les yeux des autres, même si vous êtes en déplacement. Je montre comment votre clé USB est cryptée."
cover: "computer"
draft: false
lang: fr
---

J'ai acheté un Intenso 128 GB pour stocker mes fichiers privés dessus. Je suis souvent sur la route et j'ai donc décidé d'une clé USB et non d'un ordinateur portable crypté. 

J'utilise Arch Linux, mais le manuel devrait fonctionner sur N'importe quel système Linux.

```bash
sudo pacman -S cryptsetup
```

Connectez le lecteur USB mais ne le montez pas. Nous supprimons d'abord la clé USB en toute sécurité, puis le conteneur crypté est créé, puis sera partition créée.

```bash
$ sudo dd if=/dev/urandom of=/dev/sdb bs=4096
$ sudo shred -v /dev/sdb
$ sudo cryptsetup -v --cipher aes-xts-plain64 --key-size 512 --hash sha512 --iter-time 5000 --use-random --verify-passphrase luksFormat /dev/sdb
$ sudo cryptsetup open --type luks /dev/sdb crypt
$ sudo mkfs.btrfs /dev/mapper/crypt
$ sudo mkdir /mnt/dmCrypt
$ sudo mount -t btrfs /dev/mapper/crypt /mnt/dmCrypt
$ sudo chmod a=rwx /mnt/dmCrypt
```

Cela signifie que le lecteur USB est crypté et nécessite l'entrée de la phrase secrète pour l'intégration. Pour monter le lecteur, j'écris un Script Shell court, avec mes gestionnaires de fichiers, il ne sera pas travaillé utilisateur ont l'autorisation d'écriture.

```bash
$ cat /usr/local/bin/mount_crypt.sh
#!/usr/bin/env bash

case $1 in
  mount )
    sudo cryptsetup open --type luks /dev/sdb crypt
    sudo mount -t ext4 /dev/mapper/crypt /mnt/crypt
    sudo chmod a+rwxt /mnt/crypt
  ;;

  umount)
    sudo umount /mnt/crypt
    sudo cryptsetup luksClose crypt
  ;;

  *)
    echo "for mounting the drive use mount_crypt.sh mount"
    echo "for umount the drive use mount_crypt.sh umount "
  ;;
esac
```

Si vous n'avez pas sudo installé, vous devez remplacer sudo par su-C, ou faire le tout en tant que root.
