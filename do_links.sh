#!/bin/bash
read -n 1 -s -r -p "This script may cause issues making links to directories that do not exist yet, like ~/.config/nvim. Install things first! Press any key to continue"
ln -s ~/.dotfiles/init.vim ~/.config/nvim/
