# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./antec_desktop_hardware_configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  # set a lower, maximum # of derivation boot files on the boot partition
  # to prevent running out of space and becoming unable to nixos-rebuild
  boot.loader.systemd-boot.configurationLimit = 30;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "antec"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.motoko = {
    isNormalUser = true;
    description = "matt";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.pulseaudio = true;
  # TODO de-dupe, this can be shared across laptop and desktop
  # note that since this doesn't exist, and the waybar config would try to
  # access pulseaudio, this was stopping waybar from working
  hardware.pulseaudio.enable = true;

  # TODO dedup with Lemur config, I think every NixOs system I will have will want flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # TODO de-dupe with Lemur setup
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    firefox
    git
    docker-compose
    fcitx5
    zsa-udev-rules
    pavucontrol
    ncurses
    #neovim-flake <- did not work
    #neovim-flake.packages.default <- did not work
    #neovim-flake.defaultPackage <- did not work
    inputs.neovim-flake.packages.${system}.default
    #TODO I'm surprised this isn't in my laptop's nix config, yet pasting works there
    #install xclip, for copy and pasting to Neovim
    gtk4
    wofi
    dolphin
    wl-clipboard
  ] ++ import ./commonpackages.nix pkgs;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.steam.enable = true;

  programs.seahorse.enable = true;
  services.gnome.gnome-keyring = {
    enable = true;
  };

  services.displayManager.sddm =  {
    enable = true;
    wayland = {
      enable = true;
    };
    settings = {
      Wayland = {
        EnableHiDPI = "0";
      };
    };
  };

  programs.xwayland.enable = true;
  programs.waybar.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.xserver = {
    xkb.layout = "us";
  };
  # List services that you want to enable:
  # services.xserver = {
  #   enable = true;
  #   displayManager = {
  #     lightdm.enable = true;
  #   };
  #   windowManager.xmonad = {
  #     enable = true;
  #     enableContribAndExtras = true; #necessary for things like EZConfig
  #     config = builtins.readFile ./xmonad/xmonad.hs;
  #     enableConfiguredRecompile = true;
  #   };
  #   # Configure keymap in X11
  #   xkb = {
  #     layout = "us";
  #     variant = "";
  #   };
  # };

  # TODO de-duplicate between tower and laptop configs
  # udev rules for headsetcontrol
  services.udev.packages = with pkgs; [
    headsetcontrol
  ];
  services.pipewire = {
    enable = true;
  };

  hardware.opengl ={
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  # services.xserver.videoDrivers = ["nvidia"];
  # gpu
  #hardware.nvidia = {
  #  modesetting.enable = true;
  #  powerManagement.enable = true;
  #  open = false;
  #  nvidiaSettings = true;
  #  package = config.boot.kernelPackages.nvidiaPackages.stable;
  #};

  # TODO de-dupe with laptop configuration
  virtualisation = import ./containerconfiguration.nix;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
