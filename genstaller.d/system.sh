#!/usr/bin/env bash
set -o errexit
source /tmp/settings.sh
[[ $(whoami) == 'root' ]] || exec sudo su -c $0 root
ntpd -q -g
cd /mnt/gentoo
wget $_STAGE3_URI
tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner

cat > /mnt/gentoo/etc/portage/make.conf << EOF
COMMON_FLAGS="-march=native -O2 -pipe"
CFLAGS="${COMMON_FLAGS}"
CXXFLAGS="${COMMON_FLAGS}"
CHOST="x86_64-pc-linux-gnu"

MAKEOPTS="--jobs=${_CORES}"
EMERGE_DEFAULT_OPTS="--jobs=${_CORES}"
# Config the USE var to your own need
USE="offensive"
PORTDIR="/usr/portage"

GENTOO_MIRRORS="${DIST_MIRROR}"
EOF

cp -L /etc/resolv.conf /mnt/gentoo/etc/

if [[$PROFILE != *systemd]]; then
    mount --types proc /proc /mnt/gentoo/proc
    mount --rbind /sys /mnt/gentoo/sys
    mount --make-rslave /mnt/gentoo/sys
    mount --rbind /dev /mnt/gentoo/dev
    mount --make-rslave /mnt/gentoo/dev
elif [[$PROFILE == *systemd]]; then
    mount --types proc /proc /mnt/gentoo/proc
    mount --rbind /sys /mnt/gentoo/sys
    mount --rbind /dev /mnt/gentoo/dev
fi

$_CHROOT emerge-webrsync
$_CHROOT eselect news read all
$_CHROOT ln -sf /etc/portage/make.profile /var/db/repos/gentoo/profiles/${PROFILE}

bash ./internal/execfile.sh configuration
