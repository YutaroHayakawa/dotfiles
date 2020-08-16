export EDITOR=vim || export EDITOR=vi

autoload -U compinit
compinit

# Specify history file name
export HISTFILE=${HOME}/.zsh_history
# Histories will be stored on memory
export HISTSIZE=1000
# Histories will be stored in history file
export SAVEHIST=100000
# Ignore historie's duplicate
setopt hist_ignore_dups
# Remember start and exit
setopt EXTENDED_HISTORY

PROMPT="%F{5}%n@%m $%f "
RPROMPT="%F{5}%d%f" 

export LSCOLORS

alias ls="ls --color=auto"
if [ -f ~/.dircolors ]; then
    if type dircolors > /dev/null 2>&1; then
        eval $(dircolors ~/.dircolors)
    elif type gdircolors > /dev/null 2>&1; then
        eval $(gdircolors ~/.dircolors)
    fi
fi

export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
