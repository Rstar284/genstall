Genstall
========

Gentoo Linux Install Scripts

Usage: On Bare Metal
--------------------
**This will cause destructive file system changes**

Boot from a [Live CD](http://www.sysresccd.org/SystemRescueCd_Homepage) and run:

	curl -L https://api.github.com/repos/rstar284/genstall/tarball > genstall.tar.gz
	tar xvf genstall.tar.gz
	cd rstar284-genstall-*
	bash install.sh

Configuration
-------------

Without any user defined configuration genstall will attempt to install a basic
Gentoo system as per the [Gentoo
Handbook](http://www.gentoo.org/doc/en/handbook/).

Additional settings can be configured in genstall.d/00-settings.sh, such as
enabling LVM, installing custom software (Puppet, Chef, ect), and setting
metadata (hostname, root password, network settings).

Variables in genstall.d/00-settings.sh prefixed with _ are internal variables
and should not be changed.

Variable                 |Value
--------                 |-----
DIST\_MIRROR             | [Portage Distfile Mirror(s)](http://www.gentoo.org/main/en/mirrors2.xml)
SYNC\_MIRROR             | [Portage Rsync Mirror(s)](http://www.gentoo.org/main/en/mirrors-rsync.xml)
BOOT\_SIZE               | Size of the boot partition, eg: +256M
SWAP\_SIZE               | Size of the swap partition, eg: +1G
ROOT\_SIZE               | Size of the root partition, eg: +48G
BOOT\_FS                 | The file system of the boot partition, eg: fat
ROOT\_FS                 | The file system of the root partition, eg: ext4
DRIVE\_NAME		 | The drive name to be used, eg: vda
TIMEZONE                 | The system's timezone, eg: Europe/London
HOSTNAME                 | The system's hostname, eg: gentoo-linux
PASSWORD                 | The system's root password
SOFTWARE                 | Applications to be installed, eg: syslog, cron and sudo
DAEMONS                  | Daemons to be added to the default runlevel, eg: sshd
USER\_NAME		 | The user name for the user to be created
USER\_PASSWORD		 | The password for the user to be created
USER\_GROUPS		 | The groups to be added to the user which will be created

Have fun with my script :)
