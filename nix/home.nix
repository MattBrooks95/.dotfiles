{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "motoko";
  home.homeDirectory = "/home/motoko";

  home.packages = [
    pkgs.htop
    pkgs.ripgrep
    pkgs.tmux
    pkgs.alacritty
    pkgs.neovim
  ];

  # for neovim https://alexpearce.me/2021/07/managing-dotfiles-with-nix/
  xdg.configFile.nvim = {
    source = ~/.dotfiles/nvim;
    recursive = true;
  };
  xdg.configFile.tmux = {
    source = ~/.dotfiles/tmux;
	recursive = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "MattBrooks95";
    userEmail = "28607360+MattBrooks95@users.noreply.github.com";
	extraConfig = {
		credential.helper = "${
			pkgs.git.override { withLibsecret = true; }
		}/bin/git-credential-libsecret";
	};
  };
}
