---
title: "Verschlüsselten USB Stick"
date: 2020-02-13
tags: "Computer"
shorttext: "Es gibt Dateien die vor fremden Augen geschützt sein sollen, auch wenn man unterwegs ist. Ich zeige wie Eurer USB Stick verschlüsselt wird."
cover: "computer"
draft: false
lang: de 
---

Ich habe mir einen Intenso 128 GB Stick gekauft um darauf meine privaten Dateien zu speichern. Ich bin öfters unterwegs und deshalb habe ich mich für ein USB Stick entschieden und nicht ein verschlüsseltes Notebook. 

Ich verwende Arch Linux, die Anleitung sollte aber auf jeden Linux System laufen. 

```bash
sudo pacman -S cryptsetup
```

Den USB Stick anschließen aber nicht einbinden. Wir löschen den USB Stick erst sicher, danach wird der verschlüsselte Container erstellt und danach eine Partion angelegt. 

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

Damit ist der Stick verschlüsselt und benötigt zum einbinden die Eingabe der Passphrase. Ich habe es nicht geschafft den Stick für User beschreibbar zu machen, aus diesen Grund habe ich ein Script geschrieben um das ganze über die Konsole zu erledigen.

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

Falls Ihr sudo nicht installiert habt, müsstet Ihr sudo mit su -c tauschen, oder das ganze gleich als root erleden.
