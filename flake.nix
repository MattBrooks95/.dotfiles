{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      #ensure that home manager and nixos are going to use the same packages
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake = {
      url = "github:MattBrooks95/neovim-flake";
    };
  };

  outputs = { self, nixpkgs, home-manager, neovim-flake, ... } @ inputs:
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
    homeManagerConfigurations = {
    };
    nixosConfigurations = {
      lemur = lib.nixosSystem {#System76 lemur pro 11
        inherit system;
        #list of nix modules that build up the system configuration
        modules = [
          {
            _module.args = inputs;
          }
          ./nix/nixos/configuration.nix
        ];
      };
    };
  };
}
