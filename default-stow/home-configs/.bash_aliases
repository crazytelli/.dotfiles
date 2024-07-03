########### Meus Aliases #############
#
# add the following line to .bashrc
#
# . ~/.bash_aliases
# 
# and then run `source ~/.bashrc`

# Source .bash_aliases if it exists
#[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

alias ls="ls -hN --color=auto --group-directories-first"
alias grep="grep --color=auto"

# copy move and remove commands
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -Iv"
alias mkd="mkdir -pv"

# pacman aliases
alias pacq='pacman -Q | grep'
alias pacs='pacman -Ss '

# files and configs shortcuts
alias stow="stow -vt ~"
alias sxiv="nsxiv"
alias cq="${EDITOR} $HOME/.config/qtile/config.py"
alias dots="clear && cd $HOME/.dotfiles/default-stow && ls"

# (cat ~/.cache/wal/sequences &)
