---
title: "Зашифрованный USB-накопитель"
date: 2020-02-13
tags: "Компьютер"
shorttext: "Есть файлы, которые следует защищать от чужих глаз, даже если вы находитесь в движении. Я покажу, как зашифрована ваша флешка."
cover: "computer"
draft: false
lang: ru
---

Я купил Intenso 128 ГБ, чтобы хранить на нем свои личные файлы. Я часто бываю в дороге, и поэтому я решил использовать USB-накопитель, а не зашифрованный ноутбук. 

Я использую Arch Linux, но руководство должно работать на любой системе Linux.

```bash
sudo pacman -S cryptsetup
```

Подключите USB-накопитель, но не монтируйте его. Сначала мы надежно удаляем флешку, затем создается зашифрованный контейнер, а затем будет создан раздел.

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

Это означает, что USB-накопитель зашифрован и требует ввода парольной фразы для интеграции. Для монтирования диска я пишу короткий скрипт оболочки, с моими файловыми менеджерами он не будет работать пользователь имеет разрешение на запись.

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

Если у вас не установлен sudo, вы должны заменить sudo на su-c или сделать все это как root.
