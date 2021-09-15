# *****************************************************************************
# .bashrc
# *****************************************************************************

# ==== Custom =================================================================

# ++++ Base +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Enable Bash completion:
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

# Disable XON/XOFF Flow Control:
# So you can remap Ctrl + S and Ctrl + Q
stty -ixon

# Bracketed paste https://serverfault.com/a/1021968:
bind 'set enable-bracketed-paste on'

# Set editor:
export VISUAL=vim
export EDITOR=$VISUAL

# Add to MAN PATH:
MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"

# Update PATH to use Homebrew installed tools:
HOMEBREW_PATH=$(brew --prefix)
export PATH="/Users/$(whoami)/Library/Python/3.9/bin:\
$HOMEBREW_PATH/var/homebrew/linked/libtool/libexec/gnubin:\
$HOMEBREW_PATH/var/homebrew/linked/coreutils/libexec/gnubin:\
$HOMEBREW_PATH/var/homebrew/linked/gnu-tar/libexec/gnubin:\
$HOMEBREW_PATH/var/homebrew/linked/grep/libexec/gnubin:\
$HOMEBREW_PATH/var/homebrew/linked/gnu-sed/libexec/gnubin:\
$HOMEBREW_PATH/var/homebrew/linked/gawk/libexec/gnubin:\
$HOMEBREW_PATH/var/homebrew/linked/make/libexec/gnubin:\
$HOMEBREW_PATH/var/homebrew/linked/findutils/libexec/gnubin:\
$HOMEBREW_PATH/opt/libtool/libexec/gnubin:\
$HOMEBREW_PATH/opt/coreutils/libexec/gnubin:\
$HOMEBREW_PATH/opt/gnu-tar/libexec/gnubin:\
$HOMEBREW_PATH/opt/grep/libexec/gnubin:\
$HOMEBREW_PATH/opt/gnu-sed/libexec/gnubin:\
$HOMEBREW_PATH/opt/gsed/libexec/gnubin:\
$HOMEBREW_PATH/opt/gawk/libexec/gnubin:\
$HOMEBREW_PATH/opt/make/libexec/gnubin:\
$HOMEBREW_PATH/opt/findutils/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/libtool/2.4.6_4/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/coreutils/8.32/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/gnu-tar/1.34/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/grep/3.7/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/gnu-sed/4.8/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/gawk/5.1.0/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/make/4.3/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/findutils/4.8.0_1/libexec/gnubin:$PATH"

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
IP_PUBLIC=$(dig @ns1-1.akamaitech.net ANY whoami.akamai.net +short)
echo -e "
Host:          $HOSTNAME
OS:            $(sw_vers -productName) $(sw_vers -productVersion)
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

