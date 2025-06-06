{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      #ensure that home manager and nixos are going to use the same packages
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake = {
      url = "github:MattBrooks95/neovim-flake?ref=nixpkgs-25.05";
    };
  };

  outputs = { self
    , nixpkgs
    , home-manager
    , neovim-flake
    , ... } @ inputs:
  let
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    lib = nixpkgs.lib;
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      lemur = lib.nixosSystem {#System76 lemur pro 11
        inherit system;
        #list of nix modules that build up the system configuration
        modules = [
          { _module.args = { inherit inputs; }; }
          ./configuration.nix
          home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.motoko = import ./motoko.nix "lemur";
              home-manager.backupFileExtension = "nix_home_manager_backup";
            }
        ];
      };
      antec = lib.nixosSystem {
        inherit system;
        #list of nix modules that build up the system configuration
        modules = [
          { _module.args = { inherit inputs; }; }
          ./antec_desktop_configuration.nix
          home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.motoko = import ./motoko.nix "antec";
              home-manager.backupFileExtension = "nix_home_manager_backup";
            }
        ];
      };
    };
  };
}
