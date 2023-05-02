function fish_greeting
    set HOSTNAME (hostname)
    set DISTRO (grep --no-filename "^NAME" /etc/*-release | sed "s/NAME=//; s/\"//g")
    set DISTRO_VERSION (grep --no-filename "VERSION_ID" /etc/*-release | sed "s/^VERSION_ID=//; s/\"//g")
    set IP_PUBLIC (dig @ns1-1.akamaitech.net ANY whoami.akamai.net +short)

    echo "Host:          $HOSTNAME
OS:            $DISTRO $DISTRO_VERSION
Public IP:     $IP_PUBLIC
Date:          "(date +%A\ %d\ %B\ %Y) \(Week (date +%V)\)"
"
end

