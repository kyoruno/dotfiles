HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

autoload -Uz compinit promptinit
compinit
promptinit

prompt suse

typeset -U path PATH
path=(~/.local/bin $path)
export PATH

export EDITOR=vim
export GPG_TTY=$(tty)

alias ls='eza'
alias grep='grep --color=auto'
alias ssh='TERM=xterm-256color ssh'

# https://github.com/jarun/advcpmv
alias cp='advcp -g'
alias mv='advmv -g'

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

eval "$(zoxide init --cmd cd zsh)"
zstyle ':completion:*' rehash true
