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
    haskell-language-server
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

  # for neovim https://alexpearce.me/2021/07/managing-dotfiles-with-nix/
  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };

  xdg.configFile.tmux = {
    source = ./tmux;
    recursive = true;
  };

  xdg.configFile."hypr/hyprland.conf" =
    let
      voyagerDevice = ''
      device {
        name = zsa-technology-labs-voyager
        kb_layout = us
        kb_variant =
      }
      '';
      options = {
        lemur = {
          defaultInputKeyboardVariant = "dvorak";
          additionalDevices = [
            voyagerDevice
            ''
            device {
              name = at-translated-set-2-keyboard
              kb_layout = us
              kb_variant = dvorak
            }
            ''
          ];
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

  xdg.configFile.waybar = {
    source = ./waybar;
    recursive = true;
  };

  xdg.configFile.wpaperd = {
    source = ./wpaperd;
    recursive = true;
  };

  #home.file."./.xmonad/xmonad.hs".source = ./xmonad/xmonad.hs;
  # I guess Xmonad wasn't reading the xdg file path, so I had to put the
  # config file at ./.xmonad/xmonad.hs
  #it also wasn't recompiling it so I had to force it to recompile with super+q
  #xdg.configFile.xmobar = {
  #  source = ./xmobar;
  #  recursive = true;
  #};

  #xdg.configFile.alacritty = {
  #  source = ./alacritty;
  #  recursive = true;
  #};

  xdg.configFile.kitty = {
    source = ./kitty;
    recursive = true;
  };

  # I think fcitx5 is working on my laptop because I ran the gui tool and did the configuration
  #I've tried copying those files into the ~/.config/fcitx5 folder using my nix
  #setup but the 'profile' file is overwritten by something when I signin to
  #the graphical environment
  #the 'settings' for the fcitx5 configuration doesn't work with home-manager, either =(
  xdg.configFile."fcitx5/config" = {
      source = ./fcitx5/config;
  };
  xdg.configFile."fcitx5/profile" = {
      source = ./fcitx5/profile;
      # not documented option that tells home manager that it's okay to overwrite the file. Fcitx5 'saves' ~/.config/fcitx5/profile
      # which overwrites the home manager symlink. Then, the next time the computer boots,
      # home manager will error because that file would be clobbered when home manager sets the link again
      # and even with backup files turned on, home manager would error when it tried to 'clobber' the backup file
      # https://github.com/fcitx/fcitx5/issues/948 here the creater says "we overwrite files, deal with it"
      # I wonder if they would accept a PR that added config option to have fcitx5 not do this
      force = true;
  };

  xdg.configFile.lazygit = {
    source    = ./lazygit;
    recursive = true;
  };

  home.file.".xprofile".source = ./.xprofile;
  home.file.".xinitrc".source = ./.xinitrc;

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
