# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="tjkirch"

# Custom oh-my-zsh plugin directory
ZSH_CUSTOM=$HOME/.zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git bundler)

source $ZSH/oh-my-zsh.sh

# Where are we?
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='osx'
fi

bindkey '^R' history-incremental-search-backward

alias c="clear"

export GOPATH=$HOME/go

export PATH=$HOME/.rbenv/shims:$HOME/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/vagrant_ruby/bin:$PATH

export PATH=$PATH:$HOME/bin:$JAVA_HOME/bin
export PATH=$PATH:$HOME/adt/sdk/platform-tools
export PATH=$PATH:/opt/mysql/server-5.6/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin
export PATH="$PATH:$HOME/elixir/elixir/bin"

if [[ "$platform" == "osx" ]]; then
  alias ctags="`brew --prefix`/bin/ctags"
  export PATH="/Applications/Postgres.app/Contents/MacOS/bin:${PATH}"
  export JAVA_HOME=$(/usr/libexec/java_home)
fi

if [[ "$platform" == "linux" ]]; then
  export JAVA_HOME=/usr/local/java/jdk1.7.0_21
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export EDITOR="vim"

# Autocorrect is more wrong than right
unsetopt correct_all

# I don't want fg to be the title of every window, thanks
DISABLE_AUTO_TITLE=true

# Let's try to make sure we're always using utf8
export LC_ALL="en_AU.UTF-8"
export LC_CTYPE="en_AU.UTF-8"

# added by travis gem
#source /home/vagrant/.travis/travis.sh

eval "$(rbenv init -)"
