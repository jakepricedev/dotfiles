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

