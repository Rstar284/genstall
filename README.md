Genstall
========

Gentoo Linux Install Scripts

Usage: On Bare Metal
--------------------
**This will cause destructive file system changes**

Boot from a [Live CD](http://www.sysresccd.org/SystemRescueCd_Homepage) and run:

    curl -L https://api.github.com/repos/p8952/genstall/tarball > genstall.tar.gz
	tar xvf genstall.tar.gz
	cd p8952-genstall-xxxx
	bash install.sh


Usage: With Veewee & Vagrant
----------------------------

Install [Veewee](https://github.com/jedi4ever/veewee) and [Vagrant](http://www.vagrantup.com/) packages for your distribution:

    emerge -av app-emulation/vagrant
	gem install veewee --no-ri --no-rdoc

Clone and enter the repository:

    git clone https://github.com/p8952/genstall.git
	cd genstall

Build the base box using Veewee:

    veewee vbox build gentoo-amd64 --auto --nogui

Import the base box to Vagrant:

    vagrant box add gentoo-amd64 gentoo-amd64.box

Refer to [Vagrant's documentation](http://www.vagrantup.com/v2/) for further usage.
