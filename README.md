# Dotfiles management with GNU/stow

## How to install the configuration files with stow

1. First, make sure to have stow installed:

`sudo pacman -Sy stow`

2. Navigate to the stow directory:

`cd ~/.dotfiles/default-stow`

3. To stow a specific config, such as the neovim:

`stow -vt ~ nvim`

4. To stow everything:

`stow -vt ~ *`

5. Finally: to remove the config for stowed programs:

`stow -vDt ~ *`



