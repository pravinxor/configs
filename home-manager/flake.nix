{
  description = "Home Manager configuration of pravin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, stylix, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations."pravin" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          stylix.homeModules.stylix
        
          ./home.nix
          ./audio.nix
          ./browser.nix
          ./extra.nix
          ./helix.nix
          ./personal.nix
          ./security.nix
          ./shell.nix
          ./style.nix
          ./sway.nix
          ./video.nix
        ];
      };
    };
}
