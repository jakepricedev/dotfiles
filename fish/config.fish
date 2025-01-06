if status is-interactive

    # ++++ Defaults +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    function fish_prompt
        set_color --bold FF9100; echo -n (whoami)@(hostname) [ (date '+%F %H:%M:%S') ] (prompt_pwd --full-length-dirs 999); set_color normal; set_color ffffff; echo (fish_git_prompt)
        set_color normal; echo "\$ "
    end

    set -x VISUAL vim
    set -x EDITOR $VISUAL
    
    # ++++ Homebrew +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    set -x PATH /usr/local/bin $PATH
    set -x PATH /opt/homebrew/bin $PATH
    set -x HOMEBREW_NO_AUTO_UPDATE 1
    set -x HOMEBREW_PREFIX (brew --prefix)

    # Update PATH to use Homebrew installed tools:
    set -x PATH $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin $PATH
    set -x PATH $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin $PATH
    set -x PATH $HOMEBREW_PREFIX/opt/grep/libexec/gnubin $PATH

    # ++++ Source +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    source $HOME/.code_root
    source $HOME/.docs_root
    source $HOME/.custom

    # ++++ Keybindings ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    # fzf key bindings:
    fzf_key_bindings

    # ++++ Setup atuin ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    atuin init fish --disable-up-arrow | source

    # Bind atuin additionally to Ctrl + K:
    bind \ck _atuin_search

    # ++++ Aliases ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    alias bat "bat --theme ansi"
    alias cdsc "cd $DOCS_ROOT/SIFT/content"
    alias cp 'cp --verbose'
    alias edit "tmux split-window -h $EDITOR $argv"
    alias genpwd "tr --delete --complement 'A-Za-z0-9' </dev/urandom | head --bytes 64; echo"
    alias inbox 'vim "+normal G" $DOCS_ROOT/SIFT/content/inbox.md'
    alias ll "ls -l"
    alias ls "ls --color=always --group-directories-first"
    alias mv 'mv --verbose'
    alias python "python3"
    alias rm 'rm --verbose'
    alias rg "rg --hidden"
    alias rp "realpath"
    alias src "source $HOME/.config/fish/config.fish"
    alias vim $EDITOR

end
