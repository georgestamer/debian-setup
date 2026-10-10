export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bira"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

export EDITOR=vim
alias ll='ls -lah'
alias gs='git status'
alias ..='cd ..'
alias update='sudo apt-get update && sudo apt-get upgrade -y'
