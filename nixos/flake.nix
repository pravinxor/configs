{
  description = "NixOS System configuration";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };
  outputs = { self, nixpkgs }: {
    nixosConfigurations.ampere = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./audio.nix
        ./games.nix
        ./hardware-configuration.nix
        ./locale.nix
        ./memory.nix
        ./networking.nix
        ./power.nix
        ./printing.nix
        ./security.nix
        ./user.nix
        ./video.nix
      ];
    };
  };
}
