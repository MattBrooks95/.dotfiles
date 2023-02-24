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
    pkgs.git
    pkgs.nitrogen
    pkgs.xmobar
    pkgs.stack
    pkgs.haskell-language-server
    pkgs.niv
    pkgs.direnv
    pkgs.nodePackages."live-server"
    pkgs.nodePackages."typescript"
    pkgs.nodePackages."typescript-language-server"
    pkgs.flameshot
	pkgs.wally-cli
	pkgs.dmenu
	pkgs.tree
	pkgs.fd
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
  home.file."./.xmonad/xmonad.hs".source = ~/.dotfiles/xmonad/xmonad.hs;
  # I guess Xmonad wasn't reading the xdg file path, so I had to put the
  # config file at ./.xmonad/xmonad.hs
  #xdg.configFile.xmonad = {
  #  source = ~/.dotfiles/xmonad;
  #  recursive = true;
  #};
  xdg.configFile.xmobar = {
    source = ~/.dotfiles/xmobar;
    recursive = true;
  };
  xdg.configFile.alacritty = {
	  source = ~/.dotfiles/alacritty;
	  recursive = true;
  };

  home.file.".xprofile".source = ~/.dotfiles/.xprofile;
  home.file.".xinitrc".source = ~/.dotfiles/.xinitrc;

  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
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
  programs.bash = {
    enable = true;
	bashrcExtra = ''
	  . ~/.dotfiles/bash/.bashrc
	  eval "$(direnv hook bash)"
	'';
  };
  programs.git = {
    enable = true;
    userName = "MattBrooks95";
    userEmail = "28607360+MattBrooks95@users.noreply.github.com";
	extraConfig = {
		credential.helper = "${
			pkgs.git.override { withLibsecret = true; }
		}/bin/git-credential-libsecret";
		pull.rebase = false;
		core.editor = "nvim";
	};
  };
}
