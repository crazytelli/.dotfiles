# Lines configured by zsh-newuser-install
autoload -U colors && colors	# Load colors
autoload -Uz compinit promptinit
compinit
promptinit
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

setopt autocd extendedglob
unsetopt beep
bindkey -v

HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
zstyle :compinstall filename '/home/victor/.zshrc'
zstyle ':completion:*' menu select


# Aliases
alias ip="ip -c=always"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
