#!/usr/bin/env bash
set -o errexit
source /tmp/00-settings.sh || true
[[ $(whoami) == 'root' ]] || exec sudo su -c $0 root

useradd -mG $USER_GROUPS $USER_NAME
echo $USER_NAME:$USER_PASSWORD | chpasswd
rm /stage3-*.tar.*
echo "have a nice time with your new gentoo install :)"
cd /
umount -l /mnt/gentoo/dev{/shm,/pts,} || true
umount -l /mnt/gentoo{/boot,/proc,} || true
read -p "Reboot now?[Y/n] Pressing enter will also select yes by default" -n 1 -r response
echo
response=${response,,} # tolower
 if [[ $response =~ ^(Y|y| ) ]] || [[ -z $response ]]; then
    reboot now
elif [[ $response =~ ^(N|n)]]; then
    echo "You pressed no; Exiting Gentoo Install Script, Bye!"
    exit 1 && return 1
else
    echo "Invalid Option"
    exit 1 && return 1
fi
    
