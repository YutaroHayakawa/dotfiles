WS=~/Desktop/WorkSpace
export WS
alias cdw="cd ~/Desktop/WorkSpace"
alias ls="gls --color=auto"
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

export PYOPENCL_CTX='1'
export PATH=$PATH:/Users/YutaroHayakawa/Library/Haskell/bin
export SAUCE_USERNAME=ousia
export SAUCE_ACCESS_KEY=95ff82d0-1ff6-4ee5-a328-35c3731bb85a
export PATH=$PATH:/usr/local/mysql/bin/
