#!/bin/bash

# :::: fzf Stuff ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

# fzf fuzzy completion:
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash
elif [[ "$OSTYPE" == "darwin"* ]]; then
	[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash
elif [[ "$OSTYPE" == "linux-android" ]]; then
	source $PREFIX/share/fzf/completion.bash
fi

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

