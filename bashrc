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
MANPATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"
export MANPAGER="sh -c 'col -bx | bat --theme ansi --language man --plain'"

# Update PATH to use Homebrew installed tools:
export PATH="$HOMEBREW_PREFIX/opt/homebrew/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"

# Bash history:
HISTSIZE=100000
HISTFILESIZE=10000000
HISTTIMEFORMAT="%Y-%m-%d %T "

# Change ls directory colour:
LS_COLORS=$LS_COLORS:"di=0;94:" ; export LS_COLORS

# ++++ Aliases ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

alias bat="bat --theme ansi"
alias cp='cp --verbose'
alias edit="tmux split-window -h vim $@"
alias logvim="mvim ~/my/files/documents/log/content"
alias ls="ls --color=always --group-directories-first"
alias mv='mv --verbose'
alias my-sync="bash ~/my/files/code/bash-scripts/unison_my_sync.sh"
alias python="python3"
alias rm='rm --verbose'
alias rp="realpath"
alias src="source ~/.bashrc"

# Force tmux to assume terminal supports 256 colours:
alias tmux='tmux -2'

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
