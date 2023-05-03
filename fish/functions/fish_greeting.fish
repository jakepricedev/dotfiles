function fish_greeting
    set HOSTNAME (hostname)
    set DISTRO $(sw_vers -productName)
    set DISTRO_VERSION $(sw_vers -productVersion)
    set IP_PUBLIC (dig @ns1-1.akamaitech.net ANY whoami.akamai.net +short)

    echo "Host:          $HOSTNAME
OS:            $DISTRO $DISTRO_VERSION
Public IP:     $IP_PUBLIC
Date:          "(date +%A\ %d\ %B\ %Y) \(Week (date +%V)\)"
"
end

