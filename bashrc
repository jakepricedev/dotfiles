# *****************************************************************************
# .bashrc
# *****************************************************************************

# ==== Default ================================================================

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# ==== Custom =================================================================

# ++++ What OS/Distro? ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    export DISTRO_IS=$(cat /etc/*-release | grep --regexp="^ID" | sed --regexp-extended 's/ID=//')
fi

# ++++ Path +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

export PATH=$HOME/.local/bin:$PATH

# ++++ Source +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

source $HOME/.code_root
source $HOME/.docs_root

# ++++ Base +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Disable XON/XOFF Flow Control:
# So you can remap Ctrl + S and Ctrl + Q
[[ $- == *i* ]] && stty -ixon

# Bracketed paste:
[[ $- == *i* ]] && bind 'set enable-bracketed-paste on'

# Only exit the shell on the 10th Ctrl-d:
set -o ignoreeof

# MacOS specifics:
if [[ "$OSTYPE" == "darwin"* ]]; then

    export BASH_SILENCE_DEPRECATION_WARNING=1

    export PATH=/usr/local/bin:$PATH
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
    export PATH="/Users/jprice/Library/Python/3.10/bin:$PATH"

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
    export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"
    export PATH="$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:$PATH"

    # Update PATH to include Python packages:
    export PATH="/Users/$USER/Library/Python/3.9/bin:$PATH"
fi

# Set editor:
if [[ "$DISTRO_IS" == "debian" ]]; then
    export VISUAL=vim
    export EDITOR=$VISUAL
elif [[ "$DISTRO_IS" == "fedora" ]]; then
    export VISUAL=vimx
    export EDITOR=$VISUAL
elif [[ "$OSTYPE" == "darwin"* ]]; then
    export VISUAL="vim"
    export EDITOR=$VISUAL
elif [[ "$OSTYPE" == "linux-android" ]]; then
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
alias cameras='bash $CODE_ROOT/bash-scripts/camera_mosaic.sh'
alias cp='cp --verbose'
alias edit="tmux split-window -h $EDITOR $@"
alias inbox="$VISUAL $DOCS_ROOT/log/content/inbox.md +$"
alias ll="ls -l"
alias log="cd $DOCS_ROOT/log/content && $VISUAL ."
alias log-cli="python3 $CODE_ROOT/log-cli/main.py"
alias ls="ls --color=always --group-directories-first"
if [[ "$HOSTNAME" == "elitebook" ]]; then
    alias malsoff="bash $CODE_ROOT/bash-scripts/monitors_arrange_laptop_screen_off.sh"
    alias malson="bash $CODE_ROOT/bash-scripts/monitors_arrange_laptop_screen_on.sh"
fi
alias mv='mv --verbose'
if [[ "$HOSTNAME" == "elitebook" ]]; then
    alias ms="/usr/local/bin/unison elitebook"
    alias msb="/usr/local/bin/unison elitebook -batch"
    alias my-sync="/usr/local/bin/unison elitebook"
elif [[ "$HOSTNAME" == "rpi-01" ]]; then
    alias my-sync="bash $CODE_ROOT/bash-scripts/unison_my_sync_rpi.sh"
fi
alias note="vim $DOCS_ROOT/log/content/inbox.md"
alias python="python3"
alias refresh-hosts="ssh-keygen -R 10.0.1.11 && ssh-keygen -R 10.0.1.12 && ssh-keygen -R 10.0.2.21 && ssh-keygen -R 10.0.2.31"
alias rm='rm --verbose'
alias rp="realpath"
alias src="source $HOME/.bashrc"
alias tf="terraform"
alias vim=$EDITOR

# Generate password:
alias genpwd="tr --delete --complement 'A-Za-z0-9' </dev/urandom | head --bytes 64; echo"

# ++++ Session "Intro" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

source $CODE_ROOT/dotfiles/supplementary/session_intro.sh

# ++++ Prompt +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

source $CODE_ROOT/dotfiles/supplementary/prompt.sh

# ++++ Other ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

source $CODE_ROOT/dotfiles/supplementary/fzf.sh
source $CODE_ROOT/dotfiles/supplementary/azure_cli_aliases.sh
source $CODE_ROOT/dotfiles/supplementary/github_cli_aliases.sh
