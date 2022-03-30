#!/bin/bash

# Custom info to show on session launch:
HOSTNAME=$(hostname)
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    DISTRO=$(grep "^NAME" /etc/*-release \
        | sed "s/NAME=//; s/\"//g")
    DISTRO_VERSION=$(grep "VERSION_ID" /etc/*-release \
        | sed "s/^VERSION_ID=//; s/\"//g")
elif [[ "$OSTYPE" == "darwin"* ]]; then
    DISTRO=$(sw_vers -productName)
    DISTRO_VERSION=$(sw_vers -productVersion)
elif [[ "$OSTYPE" == "linux-android" ]]; then
    DISTRO=$(echo "Termux")
    DISTRO_VERSION=$TERMUX_VERSION
fi

IP_PUBLIC=$(dig @ns1-1.akamaitech.net ANY whoami.akamai.net +short)
echo -e "Host:          $HOSTNAME
OS:            $DISTRO $DISTRO_VERSION
Public IP:     $IP_PUBLIC
Date:          $(date +%A\ %d\ %B\ %Y) (Week $(date +%V))
"

