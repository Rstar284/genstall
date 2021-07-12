#!/usr/bin/env bash
set -o errexit
[[ $(whoami) == 'root' ]] || exec sudo su -c $0 root


cat > /tmp/settings.sh << "EOF"
#Variables that can be edited to configure the installation
DIST_MIRROR="http://mirror.bytemark.co.uk/gentoo/"
SYNC_MIRROR="rsync://mirror.bytemark.co.uk/gentoo-portage"

BOOT_SIZE="+256MB"
SWAP_SIZE="+1G"
ROOT_SIZE="+48G"

BOOT_FS="fat -F32"
ROOT_FS="ext4"
DRIVE_NAME="vda"

TIMEZONE="UTC"
HOSTNAME="gentoo-linux"
PASSWORD="gentoo"
USER_NAME="rstar284"
USER_PASSWORD="yourpasswordhere"
USER_GROUPS="users,wheel,audio,portage,cdrom"

SOFTWARE="app-admin/syslog-ng sys-process/cronie app-admin/sudo"
DAEMONS="syslog-ng cronie sshd"

# Internal Variables, DO NOT TOUCH
_CORES=$(($(nproc) + 1))
_LATEST_STAGE3=$(curl -s $DIST_MIRROR/releases/amd64/autobuilds/latest-stage3-amd64.txt | tail -1 | awk '{print $1}')
_STAGE3_URI="$DIST_MIRROR/releases/amd64/autobuilds/$_LATEST_STAGE3"
_CHROOT="chroot /mnt/gentoo /bin/bash"
function _EMERGE() {
	set +e
	$_CHROOT emerge --pretend "$@"
	if [[ $? == 1 ]]; then
		$_CHROOT emerge --autounmask-write "$@"
		$_CHROOT etc-update --automode -5
	fi
	$_CHROOT emerge "$@"
	set -e
}

EOF
bash ./internal/execfile.sh disk
