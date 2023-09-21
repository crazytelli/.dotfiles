########### Meus Aliases #############
#
# add the following line to .bashrc
#
# . ~/.bash_aliases
# 
# and then run `source ~/.bashrc`

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
alias batstat="cat /sys/class/power_supply/BAT1/status"
alias vpn="wg-quick up archlinux-BR-21"

# alias cfi="${EDITOR} $HOME/.config/i3/config"
# alias cfp="${EDITOR} $HOME/.config/polybar/config"
# alias cdp="cd $HOME/.config/polybar"
# alias cfn="${EDITOR} $HOME/.config/nvim/init.vim"
# alias cdn="cd $HOME/.config/nvim/ && ls"

# (cat ~/.cache/wal/sequences &)
