# Overview

Bare repo to store configuration files.

# Installation on new machine

#### Prerequisites
- git available at path: `user/bin/git`

#### Automatic script 

- installs repo and moves all pre-existing files into `.config-backup` folder

Use command: 
```bash
curl -Lks https://gist.githubusercontent.com/baquaz/\
296cb06e075ee9d715dd2058a44fb686/raw/281b7847f14fcda0ee8de6f3e3d90643c5866389\
/dotfiles-install.sh | /bin/zsh
```
**Done!**

<br>

From now on you can use bare repo almost the same way as normal git repo.

Just use special alias `config` instead of `git` command for the repo.

Define the alias in the current shell scope:
```bash
alias config='/usr/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME'
```
Example usage:
```bash
config status
config add .vimrc
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push
```

## References

https://www.atlassian.com/git/tutorials/dotfiles

https://www.youtube.com/watch?v=tBoLDpTWVOM
