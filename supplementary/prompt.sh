#!/bin/bash

# Get current git branch when applicable:
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Set prompt:
FEDORA_COLOUR="\e[1m\e[38;5;75m"
UBUNTU_COLOUR="\e[1m\e[38;5;202m"
DEBIAN_COLOUR="\e[1m\e[38;5;198m"
MACOS_COLOUR="\e[1m\e[38;5;208m"
TERMUX_COLOUR="\e[1m\e[92m"

if [[ "$DISTRO_IS" == "fedora" ]]; then
    export PS1="\[$FEDORA_COLOUR\]\u@\h [ \t ] \w\e[0m\$(parse_git_branch)\n$ "
elif [[ "$DISTRO" == "Ubuntu" ]]; then
    export PS1="\[$UBUNTU_COLOUR\]\u@\h [ \t ] \w\e[0m\$(parse_git_branch)\n$ "
elif [[ "$DISTRO_IS" == "debian" ]]; then
    export PS1="\[$DEBIAN_COLOUR\]\u@\h [ \t ] \w\e[0m\$(parse_git_branch)\n$ "
elif [[ "$OSTYPE" == "darwin"* ]]; then
    export PS1="\[$MACOS_COLOUR\]\u@\h [ \t ] \w\e[0m\$(parse_git_branch)\n$ "
elif [[ "$OSTYPE" == "linux-android" ]]; then
    export PS1="\[$TERMUX_COLOUR\]\u@\h [ \t ] \w\e[0m\$(parse_git_branch)\n$ "
fi

