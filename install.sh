#!/bin/sh

instdir="/usr/local/opensplash"
apachedir="/usr/local/etc/apache"

	# Do we have root permissions?
	amiroot=`id -nu`
	if [ "$amiroot" != "root" ]; then
	echo "You must be root to install OpenSplash"; echo
	exit 67 # non-root exit error
	fi

	# Are we successfully running ipfw?
	echo "Checking ipfw..."
	if which ipfw >/dev/null 2>&1; then
	ipfw=$(ipfw show >/dev/null && echo $?)
		if [ "$ipfw" = "0" ]; then
		echo "ipfw enabled... yes"; echo
		continue;
		else
		echo "Error: ipfw not enabled, refer to documentation..."
		exit 1
		fi
	fi

	# Continue with installation
	echo " Enter installation directory path for the executable and htdocs..."
	echo " It is recommended that you leave the default value, otherwise"
	echo " you would have to re-edit several configuration files:"
	echo -n " [$instdir] "
	read input
	instdir=${input:-$instdir}

	echo " Specify where Apache configuration files are located:"
	echo -n " [$apachedir] "
	read input
	apachedir=${input:-$apachedir}

	echo
	echo "Copying Apache files..."
	cp -p opensplash.conf $apachedir

	echo
	echo "Installing start-up script..."
	cat rc.sh | sed -e "s:instdir=.*:instdir=\"$instdir\":g" -e \
	"s:apachedir=.*:apachedir=\"$apachedir\":g" >/usr/local/etc/rc.d/opensplash.sh
	chmod 754 /usr/local/etc/rc.d/opensplash.sh

	echo
	echo "Copying executables and htdocs..."
	mkdir -p $instdir
	cp -p opensplash $instdir
	cp -rp htdocs $instdir

	echo
	echo "Copying configuration file..."
	cp -p splash.cfg $instdir

	echo
	echo "Installation complete..."
	echo "See README file for instructions!"
	echo

