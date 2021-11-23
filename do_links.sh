#!/bin/bash
read -n 1 -s -r -p "will remove some files before setting up the sym links, also makes dir ~/.config/nvim. ./dwm/config.h will need to be copied to the dwm directory before doing make & make install. Press any key to continue"
#TODO can you do these in a loop somehow? need to learn how to bash script...
mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/.dotfiles/nvim/nvim_cmp_setup.lua ~/.config/nvim/nvim_cmp_setup.lua
ln -s ~/.dotfiles/nvim/nvim_telescope_setup.lua ~/.config/nvim/nvim_telescope_setup.lua

bashrcLocation="$HOME/.bashrc"
rm $bashrcLocation
ln -s ~/.dotfiles/bash/.bashrc $bashrcLocation

bashAliasesLocation="$HOME/.bash_aliases"
rm $bashAliasesLocation
ln -s ~/.dotfiles/bash/.bash_aliases $bashAliasesLocation

tmuxConfLocation="$HOME/.tmux.conf"
rm $tmuxConfLocation
ln -s ~/.dotfiles/tmux/.tmux.conf $tmuxConfLocation

dwmConfLocation="$HOME/source_builds/dwm/config.h"
rm $dwmConfLocation
ln -s ~/.dotfiles/dwm/config.h $dwmConfLocation
