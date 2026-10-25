hostname:{ config, pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "motoko";
  home.homeDirectory = "/home/motoko";

  home.packages = with pkgs; [
    htop
    ripgrep
    tmux
    kitty
    git
    xmobar
    niv
    direnv
    nodePackages."typescript"
    nodePackages."typescript-language-server"
    flameshot
    dmenu
    tree
    fd
    cockatrice
    runelite
    obs-studio
    # for ZSA keyboard configuration
    wally-cli
    keymapp
    # copy into X clipboard from terminal
    #xclip
    pass
    # [configurable wallpaper cycler](https://github.com/danyspin97/wpaperd)
    wpaperd
    # command line utility for piping json data into other commands
    jq
    # https://github.com/ful1e5/Bibata_Cursor
    bibata-cursors
    lazygit
  ];

  xdg.configFile."hypr/hyprland.conf" =
    let
      options = {
        lemur = {
          startFcitx5 = true;
        };
        antec = {
          defaultInputKeyboardVariant = "";
          additionalDevices = [
            voyagerDevice
          ];
          startFcitx5 = true;
          monitorsSetup = ''
          monitor=DP-1, 1920x1080@144, 0x0, 1
          monitor=HDMI-A-1, 1920x1080@60,1920x-540, 1, transform, 1
          '';
        };
      };
    in
      {
        text = import ./hypr/hypr_config.nix options."${hostname}";
        recursive = false;
      };

  home.file.".xprofile".source = ./.xprofile;
  home.file.".xinitrc".source = ./.xinitrc;
  home.file.".npmrc".text = ''
ignore-scripts=true
min-release-age=14
  '';

  home.file.".bashrc".source = ./bash/.bashrc;
  home.file.".bash_profile".source = ./bash/.bash_profile;
  home.file.".bash_aliases".source = ./bash/.bash_aliases;

  # https://github.com/ful1e5/Bibata_Cursor
  home.file."${config.xdg.dataHome}/icons" = {
    source = "${pkgs.bibata-cursors}/share/icons/";
    recursive = true;
  };

# Following https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
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
    settings = {
      user = {
        name = "MattBrooks95";
        email = "28607360+MattBrooks95@users.noreply.github.com";
      };
      credential.helper = "${
        pkgs.git.override { withLibsecret = true; }
      }/bin/git-credential-libsecret";
      pull.rebase = false;
      core.editor = "nvim";
    };
  };
}
