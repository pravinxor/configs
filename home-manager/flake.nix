{
	description = "Home Manager configuration of pravin";

	inputs = {
		nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?ref=nixos-unstable&shallow=1";
    	home-manager = { url = "git+https://github.com/nix-community/home-manager?shallow=1"; inputs.nixpkgs.follows = "nixpkgs"; };
    	nixvim = { url = "git+https://github.com/nix-community/nixvim?shallow=1"; inputs.nixpkgs.follows = "nixpkgs"; };
	};

  	outputs = { nixpkgs, home-manager, ... }@inputs:
		let
			system = "aarch64-darwin";
			pkgs = import nixpkgs {
				inherit system;
				config = {
				  allowUnfree = true;
				  allowUnsupportedSystem = true;
				};
			};
		in
    {
    	homeConfigurations."pravin" = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			# Pass 'inputs' to all sub-modules (home.nix, editor.nix, etc.)
			extraSpecialArgs = { inherit inputs; };
			modules = [ ./home.nix ];
    	};
	};
}
