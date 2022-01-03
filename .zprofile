#!/bin/zsh

# profile file. Runs on login. Environmental variables are set here.

eval "$(/opt/homebrew/bin/brew shellenv)"

stty stop undef         # Disable ctrl-s to freeze terminal.

# Adds `~/.local/bin` to $PATH
#export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':')"
path+="$HOME/.local/bin"

# vi mode
bindkey -v
# switch to normal mode with jj 
bindkey '^j' vi-cmd-mode # ?
# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1
# Edit line in vim with ctrl-e:
# autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line # ?

export EDITOR=nvim
# export TERMINAL="iterm2"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
# export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export NVM_DIR="$XDG_DATA_HOME"/nvm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
#export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
#export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
#export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export PYENV_ROOT="$HOME"/.pyenv

export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"


