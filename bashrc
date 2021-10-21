# *****************************************************************************
# .bashrc
# *****************************************************************************

# ==== Default ================================================================

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# ==== Custom =================================================================

# ++++ Base +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Disable XON/XOFF Flow Control:
# So you can remap Ctrl + S and Ctrl + Q
stty -ixon

# Bracketed paste:
bind 'set enable-bracketed-paste on'

# Homebrew specifics:
if [[ "$OSTYPE" == "darwin"* ]]; then

    HOMEBREW_PREFIX="$(brew --prefix)"
    
    # Enable bash completion:
    if type brew &>/dev/null; then
      if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
      else
        for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
          [[ -r "$COMPLETION" ]] && source "$COMPLETION"
        done
      fi
    fi

    # Update PATH to use Homebrew installed tools:
    export PATH="$HOMEBREW_PREFIX/opt/homebrew/bin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"

    # Update PATH to include Python packages:
    export PATH="/Users/$USER/Library/Python/3.9/bin:$PATH"
fi

# Set editor:
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    export VISUAL=vimx
    export EDITOR=$VISUAL
elif [[ "$OSTYPE" == "darwin"* ]]; then
    export VISUAL=vim
    export EDITOR=$VISUAL
fi

# Bash history:
HISTSIZE=100000
HISTFILESIZE=10000000
HISTTIMEFORMAT="%Y-%m-%d %T "

# Change ls directory colour:
LS_COLORS=$LS_COLORS:"di=0;94:" ; export LS_COLORS

# ++++ Aliases ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

alias bat="bat --theme ansi"
alias cp='cp --verbose'
alias edit="tmux split-window -h $EDITOR $@"
alias ls="ls --color=always --group-directories-first"
alias mv='mv --verbose'
alias my-sync="bash ~/my/files/code/bash-scripts/unison_my_sync.sh"
alias python="python3"
alias rm='rm --verbose'
alias rp="realpath"
alias src="source ~/.bashrc"
alias vim=$EDITOR

# Generate password:
alias genpwd="tr --complement --delete '[:alnum:]' < /dev/urandom \
    | fold --width=64 \
    | head --lines=1"

# ++++ Session "Intro" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Custom info to show on session launch:
HOSTNAME=$(hostname)
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    DISTRO=$(grep "^NAME" /etc/os-release \
        | sed "s/NAME=//")
    DISTRO_VERSION=$(grep "VERSION_ID" /etc/os-release \
        | sed "s/VERSION_ID=//g")
elif [[ "$OSTYPE" == "darwin"* ]]; then
    DISTRO=$(sw_vers -productName)
    DISTRO_VERSION=$(sw_vers -productVersion)
fi

IP_PUBLIC=$(dig @ns1-1.akamaitech.net ANY whoami.akamai.net +short)
echo -e "
Host:          $HOSTNAME
OS:            $DISTRO $DISTRO_VERSION
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

# :::: fzf Stuff ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

# fzf fuzzy completion:
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Override default fzf commands:
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude ".git"'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND=$FZF_DEFAULT_COMMAND

_fzf_compgen_path() {
  $FZF_DEFAULT_COMMAND "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

