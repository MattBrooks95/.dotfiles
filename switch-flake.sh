#!/usr/bin/env bash
switchCommand="nixos-rebuild switch --flake .#"
echo "using \"$switchCommand\" to activate the nixos configuration built by the flake"
sudo $switchCommand
