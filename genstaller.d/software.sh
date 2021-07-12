#!/usr/bin/env bash
set -o errexit
source /tmp/settings.sh
[[ $(whoami) == 'root' ]] || exec sudo su -c $0 root

_EMERGE $SOFTWARE

for D in $DAEMONS; do
	$_CHROOT rc-update add $D default
done

_EMERGE app-portage/gentoolkit
$_CHROOT emerge -uND --with-bdeps=y @world
$_CHROOT emerge --depclean
$_CHROOT revdep-rebuild
$_CHROOT rm -rf /var/tmp/portage/*
$_CHROOT rm -rf /usr/portage/distfiles/*

bash finalization.sh
