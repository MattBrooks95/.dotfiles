#!/bin/bash
read -n 1 -s -r -p "This script may cause issues making links to directories that do not exist yet, like ~/.config/nvim. Install things first! Press any key to continue"
#TODO can you do these in a loop somehow? need to learn how to bash script...
#TODO do you need to put in remove statements to remove what was already there?
ln -s ~/.dotfiles/init.vim ~/.config/nvim/

bashrcLocation="$HOME/.bashrc"
rm $bashrcLocation
ln -s ~/.dotfiles/bash/.bashrc ~/.bashrc

bashAliasesLocation="$HOME/.bash_aliases"
rm $bashAliasesLocation
ln -s ~/.dotfiles/bash/.bash_aliases ~/.bash_aliases
