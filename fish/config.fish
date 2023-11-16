if status is-interactive

    # ++++ Defaults +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    set -gx HOSTNAME (hostname)

    function fish_prompt
        set_color --bold 5fafff; echo -n (whoami)@(hostname) [ (date '+%F %H:%M:%S') ] (prompt_pwd --full-length-dirs 999); set_color normal; set_color ffffff; echo (fish_git_prompt)
        set_color normal; echo "\$ "
    end

    set -x VISUAL vimx
    set -x EDITOR $VISUAL
    set -x SIFT_PATH ~/my/files/documents/SIFT

    # ++++ Source +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    source $HOME/.code_root
    source $HOME/.docs_root
    source $DOCS_ROOT/SIFT/cli/sift-completions.fish

    # ++++ Keybindings ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    # fzf key bindings:
    fzf_key_bindings

    # ++++ Setup atuin ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    atuin init fish --disable-up-arrow | source

    # Bind atuin additionally to Ctrl + K:
    bind \ck _atuin_search

    # ++++ Aliases ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    alias bat "bat --theme ansi"
    alias cp 'cp --verbose'
    alias edit "tmux split-window -h $EDITOR $argv"
    alias genpwd "tr --delete --complement 'A-Za-z0-9' </dev/urandom | head --bytes 64; echo"
    alias inbox "$VISUAL $DOCS_ROOT/SIFT/content/inbox.md"
    alias ll "ls -l"
    alias ls "ls --color=always --group-directories-first"
    alias malsoff "bash $CODE_ROOT/bash-scripts/monitors_arrange_laptop_screen_off.sh"
    alias malson "bash $CODE_ROOT/bash-scripts/monitors_arrange_laptop_screen_on.sh"
    alias ms "docker run --rm --user 1000:1000 --env UNISONLOCALHOSTNAME=$HOSTNAME --volume /etc/timezone:/etc/timezone:ro --volume /etc/localtime:/etc/localtime:ro --volume /etc/passwd:/etc/passwd --volume $HOME/.unison:/home/$(whoami)/.unison --volume $HOME/.unison_sync_$HOSTNAME.log:/home/$(whoami)/.unison_sync_$HOSTNAME.log --volume $HOME/.ssh/host-01:/home/$(whoami)/.ssh/host-01 --volume $HOME/.ssh/known_hosts:/home/$(whoami)/.ssh/known_hosts --volume $HOME/my:/home/$(whoami)/my --interactive --tty jakepricedev/docker-unison:2.52.1-r0 $HOSTNAME"
    alias msb "docker run --rm --user 1000:1000 --env UNISONLOCALHOSTNAME=$HOSTNAME --volume /etc/timezone:/etc/timezone:ro --volume /etc/localtime:/etc/localtime:ro --volume /etc/passwd:/etc/passwd --volume $HOME/.unison:/home/$(whoami)/.unison --volume $HOME/.unison_sync_$HOSTNAME.log:/home/$(whoami)/.unison_sync_$HOSTNAME.log --volume $HOME/.ssh/host-01:/home/$(whoami)/.ssh/host-01 --volume $HOME/.ssh/known_hosts:/home/$(whoami)/.ssh/known_hosts --volume $HOME/my:/home/$(whoami)/my --interactive jakepricedev/docker-unison:2.52.1-r0 $HOSTNAME -batch"
    alias mv 'mv --verbose'
    alias python "python3"
    alias rm 'rm --verbose'
    alias rg "rg --hidden"
    alias rp "realpath"
    alias smartdns_activate "bash $CODE_ROOT/bash-scripts/activate_smartdns.sh"
    alias smartdns_disable "bash $CODE_ROOT/bash-scripts/disable_smartdns.sh"
    alias src "source $HOME/.config/fish/config.fish"
    alias vim $EDITOR

end
