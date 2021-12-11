#!/bin/bash
read -n 1 -s -r -p "will remove some files before setting up the sym links, also makes dir ~/.config/nvim. ./dwm/config.h will need to be copied to the dwm directory before doing make & make install. Press any key to continue"
ln -s ~/.dotfiles/nvim ~/.config/nvim

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

xprofileLocation="$HOME/.xprofile"
rm $xprofileLocation
ln -s ~/.dotfiles/.xprofile $xprofileLocation
