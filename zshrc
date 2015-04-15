export LANG=ja_JP.UTF-8

PROMPT="%F{154}%#%f "
RPROMPT="%F{154}%d%f" 

export LSCOLORS

if [ -f ~/.dircolors ]; then
    if type dircolors > /dev/null 2>&1; then
        eval $(dircolors ~/.dircolors)
    elif type gdircolors > /dev/null 2>&1; then
        eval $(gdircolors ~/.dircolors)
    fi
fi
