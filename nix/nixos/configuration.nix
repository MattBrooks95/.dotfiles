# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

#{ config, pkgs, neovim-flake, ...}: did not allow me to reference my neovim flake
{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./sound_configuration.nix
      ./input_method_settings.nix
    ];

  hardware.system76.enableAll = true;

  # turn off because it conflicts with system76's stuff
  services.power-profiles-daemon.enable = false;

  hardware.bluetooth.enable = true;

  #this seems to fix webgl performance and watching video streams perform much better
  #https://nixos.wiki/wiki/Accelerated_Video_Playback
  #hardware.opengl = {
  #  enable = true;
  #  extraPackages = with pkgs; [
  #     intel-media-driver
  #     vaapiIntel
  #     vaapiVdpau
  #     libvdpau-va-gl
  #  ];
  #};
# because I have a 12th gen intel processor with integrated graphics
# https://tech-docs.system76.com/models/lemp11/README.html
# https://nixos.wiki/wiki/Accelerated_Video_Playback
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  # set a lower, maximum # of derivation boot files on the boot partition
  # to prevent running out of space and becoming unable to nixos-rebuild
  boot.loader.systemd-boot.configurationLimit = 30;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  #I needed this kernel for things on my lemur pro to work properly
  #when I bought it in around July 2022. 6.0 was a short lived kernel
  #which has already reached EOL so I need to go to 6.1
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # nix-shell -p pciutils --run "lspci | grep VGA" will tell you what
  # graphics devices are availabile, and according to
  # https://nixos.wiki/wiki/Intel_Graphics, X Server may fail on this
  # generation intel chip, so we have to tell it to use the device we found
  # from the lspci command (in this case, the ID was 46a8)
  # of course, this didn't work =(
  #boot.kernelParams = [ "i915.force_probe=46a8" ];

  boot.supportedFilesystems = [ "ntfs" ];

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "lemur"; # Define your hostname.
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

  # Configure console keymap
  console.keyMap = "dvorak";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.motoko = {
    isNormalUser = true;
    description = "Matthew Brooks";
    extraGroups = [ "networkmanager" "wheel" "audio" "plugdev" "video" "docker" "adbusers"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    firefox
    git
    docker-compose
    ntfs3g
    pavucontrol
    ncurses
    pinentry-tty
    wl-clipboard
    brightnessctl
    #system76-keyboard-configurator #customize keys on lemur pro
    inputs.neovim-flake.packages.${system}.default
    gtk4
    wofi
  ] ++ (with kdePackages; [
    dolphin
  ]) ++ import ./commonpackages.nix pkgs;

  environment.sessionVariables = {
    EDITOR = "vim";
  };

  # let's try brightnessctl instead, hyprland uses that with the
  # default config. I was using 'light' with my 'xmonad' setup on
  # my lemur pro 11
  programs.light.enable = false;

  programs.adb.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
  };

  services.displayManager.sddm = {
    enable = true;
    settings = {
      Wayland = {
        EnableHiDPI = "0";
      };
    };
  };
  services.displayManager.sddm.wayland.enable = true;
  programs.xwayland.enable = true;
  programs.waybar.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "dvorak";
  };
  fonts.packages = import ./fonts.nix pkgs;

  # List services that you want to enable:
  #services.xserver = {
  #  enable = true;
  #  displayManager = {
  #    lightdm.enable = true;
  #  };
  #  windowManager.xmonad = {
  #    enable = true;
  #    enableContribAndExtras = true; #necessary for things like EZConfig
  #    config = builtins.readFile ./xmonad/xmonad.hs;
  #    enableConfiguredRecompile = true;
  #  };

  #  # Configure keymap in X11
  #  xkb = {
  #    layout = "us";
  #    variant = "dvorak";
  #  };
  #};
  # will this fix the touchpad not working after reboot sometimes? -> no
  # issue seemed to be fixed by some linux version update along the way
  services.libinput.enable = true;
  # compositor
  # services.picom.enable = true;

  services.gnome.gnome-keyring.enable = true;

  # udev rules for headsetcontrol
  services.udev.packages = with pkgs; [
    headsetcontrol
    android-udev-rules
  ];
  services.udev.extraRules = let zsaRules = builtins.readFile ./zsa_udev.txt; in
    ''
    ${zsaRules}
    '';

  virtualisation = import ./containerconfiguration.nix;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

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
  system.stateVersion = "22.05"; # Did you read the comment?
}
