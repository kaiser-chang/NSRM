#!/bin/bash
TARGET=ifconfig.me
if [ "$1" != "" ] ; then
    TARGET=$1
fi

echo "curl ${TARGET}"

curl $TARGET