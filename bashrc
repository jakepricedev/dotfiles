# *****************************************************************************
# .bashrc
# *****************************************************************************

# ==== Default ================================================================

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# ==== Custom =================================================================

# ++++ Base +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Disable XON/XOFF Flow Control:
# So you can remap Ctrl + S and Ctrl + Q
stty -ixon

# Bracketed paste https://serverfault.com/a/1021968:
bind 'set enable-bracketed-paste on'

# Set editor:
export VISUAL=vim
export EDITOR=$VISUAL

# Bash history:
HISTSIZE=100000
HISTFILESIZE=10000000
HISTTIMEFORMAT="%Y-%m-%d %T "

# Change ls directory colour:
LS_COLORS=$LS_COLORS:"di=0;94:" ; export LS_COLORS

# ++++ Aliases ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

alias src="source ~/.bashrc"
alias cp='cp --verbose'
alias mv='mv --verbose'
alias rm='rm --verbose'
alias ls="ls --color=always --group-directories-first"
alias rp="realpath"
alias python="python3"

# Force tmux to assume terminal supports 256 colours:
alias tmux='tmux -2'

# Open file in vim, in a tmux split:
alias edit="tmux split-window -h vim $@"

# Generate password:
alias genpwd="tr --complement --delete '[:alnum:]' < /dev/urandom \
    | fold --width=64 \
    | head --lines=1"

# ++++ Session "Intro" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Custom info to show on session launch:
HOSTNAME=$(hostname)
DISTRO=$(grep "PRETTY_NAME" /etc/os-release \
    | sed "s/PRETTY_NAME=\"//; s/\"//g")
IP_PUBLIC=$(dig @ns1-1.akamaitech.net ANY whoami.akamai.net +short)
echo -e "
Host:          $HOSTNAME
OS:            $DISTRO $DISTRO_RELEASE
Public IP:     $IP_PUBLIC
Date:          $(date +%A\ %d\ %B\ %Y) (Week $(date +%V))
"

# ++++ Prompt +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Get current git branch when applicable:
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Set prompt:
PURPLE="\e[38;5;105m"
export PS1="\[$PURPLE\]\u@\h [ \t ] \w\e[0m\$(parse_git_branch)\n"

# ++++ Other ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

