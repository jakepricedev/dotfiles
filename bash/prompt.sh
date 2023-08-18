#!/bin/bash

# Set prompt:
SERVER_COLOUR="\e[1m\e[38;5;9m"

export PS1="\[$SERVER_COLOUR\]\u@\h [ \t ] \w\e[0m\n$ "
