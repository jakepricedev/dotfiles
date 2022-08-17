#!/bin/bash

# :::: fzf Stuff ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

# fzf fuzzy completion:
if [[ "$DISTRO_IS" == "fedora" ]]; then
	[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash
    export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude ".git"'

elif [[ "$DISTRO_IS" == "debian" ]]; then
	[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
    export FZF_DEFAULT_COMMAND='fdfind --hidden --follow --exclude ".git"'

elif [[ "$OSTYPE" == "darwin"* ]]; then

    # Completion & Bindings:
    PATH_COMPLETION=$HOMEBREW_PREFIX/opt/fzf/shell/completion.bash
    PATH_BINDINGS=$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.bash
	[ -f $PATH_COMPLETION ] && source $PATH_COMPLETION
	[ -f $PATH_BINDINGS ] && source $PATH_BINDINGS

    # Default fzf command:
    export FZF_DEFAULT_COMMAND='fd \
        --hidden \
        --follow \
        --exclude "*.DS_Store" \
        --exclude "*.ansible" \
        --exclude "*.azure" \
        --exclude "*.cache" \
        --exclude "*.git" \
        --exclude "*antenv" \
        --exclude "*Google Drive" \
        --exclude "*Library" \
        --exclude "*lib" \
        --exclude "*venv" \
        --exclude "*.pyc"'

elif [[ "$OSTYPE" == "linux-android" ]]; then
	source $PREFIX/share/fzf/completion.bash
    export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude ".git"'
fi

# Override default fzf commands:
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND=$FZF_DEFAULT_COMMAND

_fzf_compgen_path() {
  $FZF_DEFAULT_COMMAND "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

