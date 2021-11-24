#!/bin/bash

# Get current git branch when applicable:
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Set prompt:
COLOUR="\e[1m\e[34m"
export PS1="\[$COLOUR\]\u@\h [ \t ] \w\e[0m\$(parse_git_branch)\n"

