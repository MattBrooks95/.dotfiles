{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    neovim-flake = {
      url = "github:MattBrooks95/neovim-flake/neovim-0.12";
    };
  };

  outputs = { self
    , nixpkgs
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
        ];
      };
      antec = lib.nixosSystem {
        inherit system;
        #list of nix modules that build up the system configuration
        modules = [
          { _module.args = { inherit inputs; }; }
          ./antec_desktop_configuration.nix
        ];
      };
    };
  };
}
