# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Custom oh-my-zsh plugin directory
ZSH_CUSTOM=$HOME/.zsh

# Example aliases
#
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/home/vagrant/.rbenv/shims:/home/vagrant/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin

export EDITOR="vim"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

bx() { if [[ $1 == "bp" ]]; then command shift && $HOME/.rbenv/shims/bundle exec bluepill --no-privileged "$@"; else command $HOME/.rbenv/shims/bundle exec "$@"; fi; }

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Autocorrect is more wrong than right
unsetopt correct_all

# I don't want fg to be the title of every window, thanks
DISABLE_AUTO_TITLE=true

# Let's try to make sure we're always using utf8
export LC_ALL="en_AU.UTF-8"
export LC_CTYPE="en_AU.UTF-8"

export JAVA_HOME=/usr/local/java/jdk1.7.0_21
export PATH=$PATH:$HOME/bin:$JAVA_HOME/bin
export PATH=$PATH:/opt/mysql/server-5.6/bin
export PATH=$PATH:/usr/local/go/bin

# added by travis gem
source /home/vagrant/.travis/travis.sh
