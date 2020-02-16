---
title: "Encrypted USB Drive"
date: 2020-02-13
tags: "Computer"
shorttext: "There are files that should be protected from other people's eyes, even if you are on the move. I show how your USB Stick is encrypted."
cover: "computer"
draft: false
lang: en
---

I bought an Intenso 128 GB to store my private files on it. I am often on the road and therefore I have decided on a USB Drive and not an encrypted Notebook. 

I use Arch Linux, but the manual should run on any Linux System.

```bash
sudo pacman -S cryptsetup
```

Connect the USB Drive but do not mount it. We first delete the USB Stick securely, then the encrypted Container is created and then will be partition  created.

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

This means that the USB Drive is encrypted and requires the input of the Passphrase for integration. To mount the Drive I write a short Shell Script, with my File Managers it will not be worked user have write permission.

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

If you do not have sudo installed, you have to replace sudo with su -c, or do the whole thing as root.
