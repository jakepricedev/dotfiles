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
    export DISTRO_IS=$(cat /etc/*-release | grep --regexp="^\bID\b" | sed --regexp-extended 's/ID=//')
fi

# ++++ Path +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

export PATH=$HOME/.local/bin:$PATH

# ++++ Source +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

source $HOME/.code_root
if [[ "$IS_A_SERVER" == 0 ]]; then
    source $HOME/.docs_root
    source /home/jprice/.config/broot/launcher/bash/br
fi

# ++++ Base +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Disable XON/XOFF Flow Control:
# So you can remap Ctrl + S and Ctrl + Q
[[ $- == *i* ]] && stty -ixon

# Bracketed paste:
[[ $- == *i* ]] && bind 'set enable-bracketed-paste on'

# Only exit the shell on the 10th Ctrl-d:
set -o ignoreeof

# Adjust autocompletion behavior:
[[ $- == *i* ]] && bind 'set show-all-if-ambiguous on'
[[ $- == *i* ]] && bind 'TAB:menu-complete'
[[ $- == *i* ]] && bind '"\e[Z":menu-complete-backward' # shift-tab

# Source AWS command completion:
complete -C "/usr/local/bin/aws_completer" aws

# MacOS specifics:
if [[ "$OSTYPE" == "darwin"* ]]; then

    export BASH_SILENCE_DEPRECATION_WARNING=1

    export PATH=/usr/local/bin:$PATH
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
    export PATH="/Users/jprice/Library/Python/3.10/bin:$PATH"

    export HOMEBREW_NO_AUTO_UPDATE=1
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
if [[ "$IS_A_SERVER" == 1 ]]; then
    export VISUAL=vim
    export EDITOR=$VISUAL
elif [[ "$DISTRO_IS" == "fedora" ]]; then
    export VISUAL=vimx
    export EDITOR=$VISUAL
elif [[ "$DISTRO_IS" == "ubuntu" ]]; then
    export VISUAL=vim
    export EDITOR=$VISUAL
elif [[ "$DISTRO_IS" == "debian" ]]; then
    export VISUAL=vim
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
alias cp='cp --verbose'
alias edit="tmux split-window -h $EDITOR $@"
alias inbox="$VISUAL $DOCS_ROOT/log/content/inbox.md +$"
alias log="cd $DOCS_ROOT/log/content"
alias ll="ls -l"
alias ls="ls --color=always --group-directories-first"
if [[ "$HOSTNAME" == "elitebook" ]]; then
    alias malsoff="bash $CODE_ROOT/bash-scripts/monitors_arrange_laptop_screen_off.sh"
    alias malson="bash $CODE_ROOT/bash-scripts/monitors_arrange_laptop_screen_on.sh"
fi
alias mv='mv --verbose'
if [[ "$HOSTNAME" == "elitebook" ]]; then
    alias ms="docker run --rm --user 1000:1000 --env UNISONLOCALHOSTNAME=$HOSTNAME --volume /etc/timezone:/etc/timezone:ro --volume /etc/localtime:/etc/localtime:ro --volume /etc/passwd:/etc/passwd --volume $HOME/.unison:/home/$(whoami)/.unison --volume $HOME/.unison_sync_$HOSTNAME.log:/home/$(whoami)/.unison_sync_$HOSTNAME.log --volume $HOME/.ssh/host-01:/home/$(whoami)/.ssh/host-01 --volume $HOME/.ssh/known_hosts:/home/$(whoami)/.ssh/known_hosts --volume $HOME/my:/home/$(whoami)/my --interactive --tty jakepricedev/docker-unison:2.52.1-r0 $HOSTNAME"
    alias msb="docker run --rm --user 1000:1000 --env UNISONLOCALHOSTNAME=$HOSTNAME --volume /etc/timezone:/etc/timezone:ro --volume /etc/localtime:/etc/localtime:ro --volume /etc/passwd:/etc/passwd --volume $HOME/.unison:/home/$(whoami)/.unison --volume $HOME/.unison_sync_$HOSTNAME.log:/home/$(whoami)/.unison_sync_$HOSTNAME.log --volume $HOME/.ssh/host-01:/home/$(whoami)/.ssh/host-01 --volume $HOME/.ssh/known_hosts:/home/$(whoami)/.ssh/known_hosts --volume $HOME/my:/home/$(whoami)/my --interactive jakepricedev/docker-unison:2.52.1-r0 $HOSTNAME -batch"
elif [[ "$IS_A_SERVER" == 1 ]]; then
    alias ms="docker compose --project-directory $HOME/ppn/docker/compose/core/unison run --rm unison-$HOSTNAME $HOSTNAME"
    alias msb="docker compose --project-directory $HOME/ppn/docker/compose/core/unison run --rm unison-$HOSTNAME $HOSTNAME -batch"
fi
alias note="vim $DOCS_ROOT/log/content/inbox.md"
alias python="python3"
alias rm='rm --verbose'
alias rp="realpath"
alias src="source $HOME/.bashrc"
alias vim=$EDITOR

# Generate password:
alias genpwd="tr --delete --complement 'A-Za-z0-9' </dev/urandom | head --bytes 64; echo"

# ++++ Session "Intro" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

[[ $- == *i* ]] && source $CODE_ROOT/dotfiles/supplementary/session_intro.sh

# ++++ Prompt +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

source $CODE_ROOT/dotfiles/supplementary/prompt.sh

# ++++ Other ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

source $HOME/.custom
source $CODE_ROOT/dotfiles/supplementary/fzf.sh
if [[ "$IS_A_SERVER" == 0 ]]; then
    source $CODE_ROOT/log-cli/.log-cli-complete.bash
fi

