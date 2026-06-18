{ pkgs, ... }:
{
	imports = [ ./shell.nix ./editor.nix ];
	home.packages = with pkgs; [
		pkgs.nerd-fonts.symbols-only
		ffmpeg

		# dev
		scc
	];

	targets.darwin.linkApps.enable = false;
	targets.darwin.copyApps.enable = true;

	programs = {
		# dev
		ripgrep.enable = true;
		broot.enable = true;
		fd.enable = true;

		yt-dlp.enable = true;
		rtorrent.enable = true;
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
				init.defaultBranch = "master";
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

	home.file."Library/Preferences/clangd/config.yaml".source =
		(pkgs.formats.yaml { }).generate "clangd-config.yaml" {
			CompileFlags.Add = [
				"-isysroot"
				"${pkgs.apple-sdk}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
			];
		};

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
