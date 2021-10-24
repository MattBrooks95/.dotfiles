#!/bin/bash
read -n 1 -s -r -p "This script may cause issues making links to directories that do not exist yet, like ~/.config/nvim. Install things first! Press any key to continue"
#TODO can you do these in a loop somehow? need to learn how to bash script...
ln -s ~/.dotfiles/init.vim ~/.config/nvim/
ln -s ~/.dotfiles/bash/.bashrc ~/.bashrc
ln -s ~/.dotfiles/bash/.bash_aliases ~/.bash_aliases
