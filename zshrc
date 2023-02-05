# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export LANG=en_US.UTF-8
export EDITOR=nvim || export EDITOR=vi

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
setopt extended_history

# ls color scheme settings
export LSCOLORS
alias ls="ls --color=auto"
if [ -f ~/.dircolors ]; then
    if type dircolors > /dev/null 2>&1; then
        eval $(dircolors ~/.dircolors)
    elif type gdircolors > /dev/null 2>&1; then
        eval $(gdircolors ~/.dircolors)
    fi
fi

# PATHs
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:${KREW_ROOT:-$HOME/.krew}/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/sbin
export GOPATH=$HOME/go
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64

if command -v kubectl &> /dev/null; then
  alias kc="kubectl"
  alias ks="kubectl -n kube-system"
  alias sterns="stern -n kube-system"
  source <(kubectl completion zsh)
fi

if command -v helm &> /dev/null; then
  alias helms="helm -n kube-system"
	source <(helm completion zsh)
fi

if command -v gh &> /dev/null; then
	alias mypr="gh pr list -A YutaroHayakawa"
	alias myissue="gh issue list -a YutaroHayakawa"
	source <(gh completion -s zsh)
fi

alias cdw="cd ~/WorkSpace"
alias cdc="cd ~/go/src/github.com/cilium/cilium"
alias vim="nvim"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/yutaro/google-cloud-sdk/path.zsh.inc' ]; then . '/home/yutaro/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/yutaro/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/yutaro/google-cloud-sdk/completion.zsh.inc'; fi

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(direnv hook zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit load zdharma-continuum/history-search-multi-word
zinit load zsh-users/zsh-autosuggestions
zinit load romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
