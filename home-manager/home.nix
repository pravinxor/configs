{ pkgs, ... }:
{
	imports = [ ./shell.nix ./editor.nix ];
	home.packages = with pkgs; [
		pkgs.nerd-fonts.symbols-only
		ffmpeg

		nodejs uv

		# for claude-code 
		rustc rust-analyzer
		pyright 
		clang-tools
		vtsls
	];

	targets.darwin.linkApps.enable = false;
	targets.darwin.copyApps.enable = true;

	programs = {
		claude-code.enable = true;
		yt-dlp.enable = true;
		rtorrent.enable = true;
		aria2.enable = true;
		mpv = {
			enable = true;
			config = {
				vo = "gpu-next";
				hwdec = "auto";
				scale = "ewa_lanczos4sharpest";
				cache-pause = false;
				focus-on = "open";
			};
		};
		git = {
			enable = true;
			settings = {
				user = { name = "Pravin Ramana"; email = "pravin@pravinxor.dev"; };
			};
		};
		ssh = {
			enable = true;
			enableDefaultConfig = false;
			settings."*" = {
				AddKeysToAgent = true;
				UseKeyChain = true;
			};
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
