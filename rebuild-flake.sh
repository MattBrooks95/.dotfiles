#!/usr/bin/env bash
rebuildCommand="nixos-rebuild build --flake .#"
echo "running '$rebuildCommand' to rebuild the flake. If the hostname is not set to match one of the host names in the flake.nix file, using .# will not work. you must use .#hostname"
sudo $rebuildCommand
