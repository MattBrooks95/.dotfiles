{ config, pkgs, ... }:{
  # services.gnome.gnome-keyring = {
  #   enable = true;
  # };
  programs.seahorse.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
