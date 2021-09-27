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
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Update PATH to use Homebrew installed tools:
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"

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
alias my-sync="bash ~/my/files/code/bash-scripts/unison_my_sync.sh"

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

# fzf fuzzy completion:
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
