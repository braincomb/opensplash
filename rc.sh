#!/bin/sh

instdir="/usr/local/opensplash"
apachedir="/usr/local/etc/apache"

case "$1" in
        start)
		httpd=`which httpd`
                if [ -x $instdir/opensplash ]; then
                        $instdir/opensplash &
			$httpd -f $apachedir/opensplash.conf
			echo -n ' opensplash '
                fi
                ;;
        stop)
		pid=`cat /var/run/opensplash.pid`
		apachepid=`cat /var/run/apache-opensplash.pid`
		kill -15 $pid
		kill -15 $apachepid
		echo -n ' opensplash stopped '
		;;
        *)
                echo
                echo "Usage: `basename $0` { start | stop }"
                echo
                exit 64
                ;;
esac


