if status is-interactive

    # ++++ Defaults +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    set -x VISUAL vimx
    set -x EDITOR $VISUAL

    # ++++ Source +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    source $HOME/.code_root
    source $HOME/.docs_root
    source $CODE_ROOT/log-cli/.log-cli-complete.fish

    # ++++ Keybindings ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    # fzf key bindings:
    fzf_key_bindings

    # ++++ Setup atuin ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    atuin init fish | source

    # ++++ Aliases ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    alias bat "bat --theme ansi"
    alias cp='cp --verbose'
    alias edit "tmux split-window -h $EDITOR $argv"
    alias genpwd="tr --delete --complement 'A-Za-z0-9' </dev/urandom | head --bytes 64; echo"
    alias inbox "$VISUAL $DOCS_ROOT/log/content/inbox.md"
    alias log "cd $DOCS_ROOT/log/content"
    alias ll "ls -l"
    alias ls "ls --color=always --group-directories-first"
    alias malsoff "bash $CODE_ROOT/bash-scripts/monitors_arrange_laptop_screen_off.sh"
    alias malson "bash $CODE_ROOT/bash-scripts/monitors_arrange_laptop_screen_on.sh"
    alias mv='mv --verbose'
    alias ms "docker run --rm --user 1000:1000 --env UNISONLOCALHOSTNAME=$HOSTNAME --volume /etc/timezone:/etc/timezone:ro --volume /etc/localtime:/etc/localtime:ro --volume /etc/passwd:/etc/passwd --volume $HOME/.unison:/home/$(whoami)/.unison --volume $HOME/.unison_sync_$HOSTNAME.log:/home/$(whoami)/.unison_sync_$HOSTNAME.log --volume $HOME/.ssh/host-01:/home/$(whoami)/.ssh/host-01 --volume $HOME/.ssh/known_hosts:/home/$(whoami)/.ssh/known_hosts --volume $HOME/my:/home/$(whoami)/my --interactive --tty jakepricedev/docker-unison:2.52.1-r0 $HOSTNAME"
    alias msb "docker run --rm --user 1000:1000 --env UNISONLOCALHOSTNAME=$HOSTNAME --volume /etc/timezone:/etc/timezone:ro --volume /etc/localtime:/etc/localtime:ro --volume /etc/passwd:/etc/passwd --volume $HOME/.unison:/home/$(whoami)/.unison --volume $HOME/.unison_sync_$HOSTNAME.log:/home/$(whoami)/.unison_sync_$HOSTNAME.log --volume $HOME/.ssh/host-01:/home/$(whoami)/.ssh/host-01 --volume $HOME/.ssh/known_hosts:/home/$(whoami)/.ssh/known_hosts --volume $HOME/my:/home/$(whoami)/my --interactive jakepricedev/docker-unison:2.52.1-r0 $HOSTNAME -batch"
    alias note "vim $DOCS_ROOT/log/content/inbox.md"
    alias python "python3"
    alias rm='rm --verbose'
    alias rp "realpath"
    alias src "source $HOME/.config/fish/config.fish"
    alias vim=$EDITOR

end