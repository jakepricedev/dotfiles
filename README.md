# Dotfiles

## Install Instructions

If you're bothered, then remove/backup your existing dotfiles.

```sh
mv $HOME/.bashrc $HOME/.bashrc_old
mv $HOME/.vimrc $HOME/.vimrc_old
mv $HOME/.tmux.conf $HOME/.tmux.conf.old
```

Create `~/.code_root` and `~/.docs_root` to specify the directory path to which you store your code and documents (some aliases or functions I use rely on these). 

```sh
echo "export CODE_ROOT=<filepath-to-code>" > ~/.code_root
echo "export DOCS_ROOT=<filepath-to-documents>" > ~/.docs_root
```

Then create symbolic links in the `home` directory that links to each dotfile.

```sh
ln -s $HOME/<path-to-repo>/dotfiles/bashrc $HOME/.bashrc
ln -s $HOME/<path-to-repo>/dotfiles/vimrc $HOME/.vimrc
ln -s $HOME/<path-to-repo>/dotfiles/tmux.conf $HOME/.tmux.conf
```

## Private Functionality

There may be some things such as work specific code, or other functionality you just don't want to commit to source control for whatever reason. A file called `.custom` is sourced to allow you to keep some stuff private.

Create the `.custom` file and copy or symlink it into `$HOME`.

