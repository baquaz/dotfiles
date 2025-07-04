
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# History
HISTSIZE=5000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
# erase any duplicates in hist file
HISTDUP=erase
# append any commands to history file rather than overriding
setopt appendhistory
# share command history across all zsh sessions
setopt sharehistory
# start command with space to prevent from saving it in history
setopt hist_ignore_space
# ignore duplicates
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
 git
 bundler
 colored-man-pages
 brew
 macos
 #fastlane
 zsh-autosuggestions
 zsh-syntax-highlighting
 web-search
)

source $ZSH/oh-my-zsh.sh
# Chruby scripts
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Oh-My-Posh
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  initialCommand=""
  case $ITERM_PROFILE in

    "Config NVIM")
      initialCommand="| nvim ~/.config/nvim"
      ;;
    "Notes NVIM")
      initialCommand="| nvim notes"
      ;;

  esac

  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/myown.toml) $initialCommand"
  #eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/example.toml)"
fi


# Alias config
alias config='/usr/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME'

# PATHS

# TMUX custom config path
export TMUX_CONF=~/.config/tmux/tmux.conf

# Visual Studio Code (code)
vscode="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Homebrew
brewopt=$(brew --prefix)/opt

# SwiftLint
homebrewbin="$brewopt/homebrew/bin"

# Ruby
ruby="$HOME/.rubies/ruby-3.3.3"
# Ruby Gems
rubygems="$ruby/bin"

export PATH="$ruby:$rubygems:$homebrewbin:$PATH:$brewopt:$vscode"

# GPG
export GPG_TTY=$(tty)

