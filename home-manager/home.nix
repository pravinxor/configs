{ pkgs, ... }:
{
	imports = [ ./editor.nix ./shell.nix ];
	home.packages = with pkgs; [
		git
		yt-dlp
		ffmpeg
		aria2
		mpv
	];
	
	programs = {
		ssh = {
			enable = true; enableDefaultConfig = false;
			matchBlocks."*" = {
				addKeysToAgent = "yes";
				extraOptions.UseKeychain = "yes";
			};
		};

		direnv =  { enable = true; nix-direnv.enable = true; enableZshIntegration = true; };
	};
	xdg.configFile."nixpkgs/config.nix".text = ''
		{
			allowUnfree = true;
		}
	'';	
		
	home = {
		shell.enableZshIntegration = true;
		username = "pravin"; homeDirectory = "/Users/pravin";
		stateVersion = "25.05";
	};

  	nixpkgs.config.allowUnfree = true;
  	programs.home-manager.enable = true;
}
