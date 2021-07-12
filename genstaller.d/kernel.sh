#!/usr/bin/env bash
set -o errexit
source /tmp/settings.sh
[[ $(whoami) == 'root' ]] || exec sudo su -c $0 root

_EMERGE sys-kernel/gentoo-sources sys-kernel/genkernel sys-boot/grub

$_CHROOT /bin/bash << EOF
cd /usr/src/linux
genkernel all --no-compress-initrd --no-zfs
mount -o remount,rw /boot
grub-install --target=x86_64-efi --efi-directory=/dev/${DRIVE_NAME}1 --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
EOF

bash ./internal/execfile.sh software