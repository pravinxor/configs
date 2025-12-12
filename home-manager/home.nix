{ pkgs, ... }:
{
	imports = [ ./editor.nix ./shell.nix ];
	home.packages = with pkgs; [
		git
		ffmpeg
	];
	
	programs = {
		mpv = {
			enable = true;
			config = {
				hwdec = "auto";
			};
		};
		yt-dlp = {
			enable = true;
		};
		gemini-cli = {
			enable = true;
			settings = {
				vimMode = true;
				preferredEditor = "nvim";
				theme = "Xcode";
			};
		};
		git = {
			enable = true;
			settings = {
				user = { name = "Pravin Ramana"; email = "pravin@pravinxor.dev"; };
			};
		};
		ssh = {
			enable = true; enableDefaultConfig = false;
			matchBlocks."*" = { addKeysToAgent = "yes"; extraOptions.UseKeychain = "yes"; };
		};
	};
	xdg.configFile."nixpkgs/config.nix".text = "{ allowUnfree = true; }";
		
	home = {
		shell.enableZshIntegration = true;
		username = "pravin"; homeDirectory = "/Users/pravin";
		stateVersion = "25.05";
	};
	nix.gc = { automatic = true; persistent = true; };

  	nixpkgs.config = {
		allowUnfree = true;
	};
  	programs.home-manager.enable = true;
}
