#!/bin/bash
DOMAIN=scadev.ipaas.samsung.com
OPT=
if [ "$1" != "" ] ; then
    DOMAIN=$1
fi
if [ "$2" != "" ] ; then
	OPT="$2"
fi
if [ "$3" != "" ] ; then
    OPT="$OPT $3"
fi
if [ "$4" != "" ] ; then
    OPT="$OPT $4"
fi
if [ "$5" != "" ] ; then
    OPT="$OPT $5"
fi
if [ "$6" != "" ] ; then
    OPT="$OPT $6"
fi
if [ "$7" != "" ] ; then
    OPT="$OPT $7"
fi
if [ "$8" != "" ] ; then
    OPT="$OPT $8"
fi
if [ "$9" != "" ] ; then
    OPT="$OPT $9"
fi

echo "traceroute ${OPT} ${DOMAIN}"

traceroute $OPT $DOMAIN