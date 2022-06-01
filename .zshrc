# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$XDG_DATA_HOME"/oh-my-zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'
ZSH_THEME="powerlevel10k/powerlevel10k"
HIST_STAMPS="yyyy-mm-dd"

alias h='history'
alias f="lf -config ${XDG_CACHE_HOME:-$HOME/.cache}/lf/lfcd"
alias py='python'
alias ipy='ipython'
alias e=$EDITOR

# todo
export TODOTXT_DEFAULT_ACTION=ls
alias t='todo.sh'

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    fzf
)

source $ZSH/oh-my-zsh.sh

# pyenv
eval "$(pyenv init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

export NVM_DIR="$XDG_DATA_HOME"/nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

bindkey -s '^o' 'lfcd\n'  # zsh

# if type rg &> /dev/null; then
#     export FZF_DEFAULT_COMMAND='rg --files --hidden'
# fi

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# History
HISTFILE="$HOME/.history"
export HISTSIZE=100000           # 
export SAVEHIST=$HISTSIZE
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write history with timestamps
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not on shell exit.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
