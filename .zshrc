# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/ian/.zshrc'
autoload -U colors && colors
autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zhist
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify correctall
bindkey -e
# End of lines configured by zsh-newuser-install
export PS1="$fg_bold[green]%n$fg[white]@%M$fg_no_bold[white]:[$fg[yellow]%~$fg[white]]%# "
zstyle ':completion:*:descriptions' format '%U%B%d%b%u' 