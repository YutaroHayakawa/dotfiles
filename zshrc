export LANG=ja_JP.UTF-8
export EDITOR=vim || export EDITOR=vi

PROMPT="%F{154}%n@%m #%f "
RPROMPT="%F{154}%d%f" 

export LSCOLORS

alias ls="ls --color=auto"

if [ -f ~/.dircolors ]; then
    if type dircolors > /dev/null 2>&1; then
        eval $(dircolors ~/.dircolors)
    elif type gdircolors > /dev/null 2>&1; then
        eval $(gdircolors ~/.dircolors)
    fi
fi
