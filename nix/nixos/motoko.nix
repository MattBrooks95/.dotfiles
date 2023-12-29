{ config, pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "motoko";
  home.homeDirectory = "/home/motoko";

  home.packages = with pkgs; [
    htop
    ripgrep
    tmux
    alacritty
    git
    nitrogen
    xmobar
    stack
    haskell-language-server
    niv
    direnv
    nodePackages."live-server"
    nodePackages."typescript"
    nodePackages."typescript-language-server"
    flameshot
    wally-cli
    dmenu
    tree
    fd
  ];

  # for neovim https://alexpearce.me/2021/07/managing-dotfiles-with-nix/
  xdg.configFile.nvim = {
    source = ../../nvim;
    recursive = true;
  };
  xdg.configFile.tmux = {
    source = ../../tmux;
    recursive = true;
  };
  home.file."./.xmonad/xmonad.hs".source = ../../xmonad/xmonad.hs;
  # I guess Xmonad wasn't reading the xdg file path, so I had to put the
  # config file at ./.xmonad/xmonad.hs
  #it also wasn't recompiling it so I had to force it to recompile with super+q
  xdg.configFile.xmobar = {
    source = ../../xmobar;
    recursive = true;
  };
  xdg.configFile.alacritty = {
    source = ../../alacritty;
    recursive = true;
  };

  home.file.".xprofile".source = ../../.xprofile;
  home.file.".xinitrc".source = ../../.xinitrc;

  home.file.".bashrc".text = import ../bash.nix;
  home.file.".bash_profile".text = import ../bash_profile.nix;
  home.file.".bash_aliases".text = import ../bash_aliases.nix;

  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      #fcitx5.engines = with pkgs.fcitx-engines; [ mozc ];
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
