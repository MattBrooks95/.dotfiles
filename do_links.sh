#!/bin/bash
read -n 1 -s -r -p "will remove some files before setting up the sym links, also makes dir ~/.config/nvim. Press any key to continue"
#TODO can you do these in a loop somehow? need to learn how to bash script...
mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/init.vim ~/.config/nvim/

bashrcLocation="$HOME/.bashrc"
rm $bashrcLocation
ln -s ~/.dotfiles/bash/.bashrc $bashrcLocation

bashAliasesLocation="$HOME/.bash_aliases"
rm $bashAliasesLocation
ln -s ~/.dotfiles/bash/.bash_aliases $bashAliasesLocation
