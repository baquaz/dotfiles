# Overview

Bare repo to store configuration files.

# Installation on new machine

### 1. Prerequisites Mac

#### Manual setup

* `git` command available at path: `user/bin/git`

* [Homebrew](https://brew.sh) - the missing package manager for macOS

* [NeoVim](https://neovim.io) - hyperextensible Vim-based text editor
    ```sh
    brew install neovim

* [Node](https://nodejs.org/en) - for neogit nvim plugin and any plugin using javascript
    ```sh
    brew install node
    ```
* [ripgrep](https://github.com/BurntSushi/ripgrep) - extended live-grep searching in neovim
    ```sh
    brew install ripgrep
    ```
* `chruby` and `ruby-install` for maintaining ruby gems
  and flexible switching between many Ruby versions
    ```sh
    brew install chruby ruby-install
    ```
    then you can install latest Ruby
    ```sh
    ruby-install ruby
    ```
* [Nerd Fonts](https://www.nerdfonts.com) - set of dev icons and symbols to display in terminal
    ```sh
    brew install font-meslo-lg-nerd-font --cask
    ```
* [Oh-My-Zsh](https://ohmyz.sh) - zsh config framework at path: `user/.oh-my-zsh`

* `zsh-autosuggestions` - zsh plugin for command autosuggestions
    ```sh
    brew install zsh-autosuggestions
    ```
* `zsh-syntax-highlighting` - zsh plugin for highlighting valid/invalid commands
    ```sh
    brew install zsh-syntax-highlighting
    ```
* [Oh-My-Posh](https://ohmyposh.dev) - beautify the prompt and additional status look
  ```sh 
  brew install jandedobbeleer/oh-my-posh/oh-my-posh
  ```
  
#### Automatic setup

  - Installs everything listed above using the [gist script](https://gist.github.com/baquaz/510b8a702c79d00d7c9bf2a297381da1).

    Use command:
    ```bash
    curl -Lks https://gist.githubusercontent.com/baquaz/\
    510b8a702c79d00d7c9bf2a297381da1/raw/47f240bb6ebe97d969c053fd9a18c10b950ae7c6/\
    mac-setup-init.sh | /bin/sh
    ```
    
<br>

### 2. Automatic dotfiles [gist script](https://gist.github.com/baquaz/296cb06e075ee9d715dd2058a44fb686)

Installs repo and moves all pre-existing files into `.config-backup` folder

Use command: 
```bash
curl -Lks https://gist.githubusercontent.com/baquaz/\
296cb06e075ee9d715dd2058a44fb686/raw/c1cee0a0a83869a403c069b3a44fe51b6ad0bece/\
dotfiles-install.sh | /bin/zsh
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
