# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

#{ config, pkgs, neovim-flake, ...}: did not allow me to reference my neovim flake
{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  hardware.system76.kernel-modules.enable = true;
  hardware.system76.enableAll = true;
  hardware.bluetooth.enable = true;
  # so that we have sound
  hardware.pulseaudio.enable = true;

  #this seems to fix webgl performance and watching video streams perform much better
  #https://nixos.wiki/wiki/Accelerated_Video_Playback
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
       intel-media-driver
       vaapiIntel
       vaapiVdpau
       libvdpau-va-gl
    ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
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
  i18n.defaultLocale = "en_US.utf8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "dvorak";
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.motoko = {
    isNormalUser = true;
    description = "Matthew Brooks";
    extraGroups = [ "networkmanager" "wheel" "audio" "plugdev" "video" "docker" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # enable explicit pulseaudio support for applicable packages
  nixpkgs.config.pulseaudio = true;

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
    fcitx5
    zsa-udev-rules
    ntfs3g
    pavucontrol
    ncurses
    gtk2
    system76-keyboard-configurator #customize keys on lemur pro
    #neovim-flake <- did not work
    #neovim-flake.packages.default <- did not work
    #neovim-flake.defaultPackage <- did not work
    inputs.neovim-flake.packages.${system}.default
  ];

  programs.light.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
  #   enableSSHSupport = true;
  };

  # List services that you want to enable:
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm.enable = true;
    };
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true; #necessary for things like EZConfig
      config = builtins.readFile ../../xmonad/xmonad.hs;
      enableConfiguredRecompile = true;
    };
    libinput.enable = true;# will this fix the touchpad not working after reboot sometimes? -> no
  };
  # compositor
  services.picom.enable = true;

  services.gnome.gnome-keyring.enable = true;

  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
