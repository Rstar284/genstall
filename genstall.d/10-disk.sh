#!/usr/bin/env bash
set -o errexit
source /tmp/00-settings.sh
[[ $(whoami) == 'root' ]] || exec sudo su -c $0 root

sgdisk -n 1:0:$BOOT_SIZE -t 1:ef00 -c 1:"linux-boot" \
-n 2:0:$SWAP_SIZE -t 2:8200 -c 2:"swap"       \
-n 3:0:$ROOT_SIZE -t 3:8300 -c 3:"linux-root" \
-p /dev/$DRIVE_NAME

mkfs.$BOOT_FS /dev/${DRIVE_NAME}1
mkswap /dev/${DRIVE_NAME}2
swapon /dev/${DRIVE_NAME}2
mkfs.$ROOT_FS /dev/${DRIVE_NAME}3

mount /dev/sda4 /mnt/gentoo
mkdir /mnt/gentoo/boot
mount /dev/sda2 /mnt/gentoo/boot
