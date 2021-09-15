# Bash Dotfiles & Configuration Files

These files are _primarily used on MacOS_. As such there will be some minor differences that need to be accounted for if used on Linux.

## bashrc

### Information on PATH

I use Homebrew to upgrade Bash, and then install recent versions of many of the common Unix utilities to replace the defaults already installed on MacOS. 

To make sure these Homebrew versions are used instead of the default provided versions we have to update the `PATH`.

Homebrew links them into `/usr/local/bin` prefixed with `g`, so `ggrep` and so on, but I want to use them as defaults (without the prefixed `g`). As they're installed across a number of different directories it's easier to just update our current `PATH`.

Finding where everything is can be frustrating though, so I manually run the below `find` command, and paste the results into bashrc. I then format the lines to make sure they are not all in one big unreadable line.

```sh
find /usr/local -type d -follow -name gnubin -print 2>/dev/null | sort
```

I could of course automate this, but the reason I haven't is that it takes a fair bit of time when loading new Bash sessions, as it has to wait for `find` to complete. So, seeing as though the list will rarely change once the tools have been installed, doing it this way does the job just fine for me.

This is the how the section looks in the file:

```sh
HOMEBREW_PATH=$(brew --prefix)
export PATH="/Users/$(whoami)/Library/Python/3.9/bin:\
$HOMEBREW_PATH/var/homebrew/linked/libtool/libexec/gnubin:\
$HOMEBREW_PATH/var/homebrew/linked/coreutils/libexec/gnubin:\
$HOMEBREW_PATH/var/homebrew/linked/gnu-tar/libexec/gnubin:\
$HOMEBREW_PATH/var/homebrew/linked/grep/libexec/gnubin:\
$HOMEBREW_PATH/var/homebrew/linked/gnu-sed/libexec/gnubin:\
$HOMEBREW_PATH/var/homebrew/linked/gawk/libexec/gnubin:\
$HOMEBREW_PATH/var/homebrew/linked/make/libexec/gnubin:\
$HOMEBREW_PATH/var/homebrew/linked/findutils/libexec/gnubin:\
$HOMEBREW_PATH/opt/libtool/libexec/gnubin:\
$HOMEBREW_PATH/opt/coreutils/libexec/gnubin:\
$HOMEBREW_PATH/opt/gnu-tar/libexec/gnubin:\
$HOMEBREW_PATH/opt/grep/libexec/gnubin:\
$HOMEBREW_PATH/opt/gnu-sed/libexec/gnubin:\
$HOMEBREW_PATH/opt/gsed/libexec/gnubin:\
$HOMEBREW_PATH/opt/gawk/libexec/gnubin:\
$HOMEBREW_PATH/opt/make/libexec/gnubin:\
$HOMEBREW_PATH/opt/findutils/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/libtool/2.4.6_4/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/coreutils/8.32/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/gnu-tar/1.34/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/grep/3.7/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/gnu-sed/4.8/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/gawk/5.1.0/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/make/4.3/libexec/gnubin:\
$HOMEBREW_PATH/Cellar/findutils/4.8.0_1/libexec/gnubin:$PATH"
```

## Install Instructions

If you're bothered, then remove/backup your existing dotfiles.

```sh
mv $HOME/.bashrc $HOME/.bashrc_old
mv $HOME/.vimrc $HOME/.vimrc_old
mv $HOME/.tmux.conf $HOME/.tmux.conf.old
```

Then create symbolic links in the `home` directory that links to each dotfile.

```sh
ln -s $HOME/<path-to-repo>/dotfiles/bashrc $HOME/.bashrc
ln -s $HOME/<path-to-repo>/dotfiles/vimrc $HOME/.vimrc
ln -s $HOME/<path-to-repo>/dotfiles/tmux.conf $HOME/.tmux.conf
```

