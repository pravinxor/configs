{ config, pkgs, ... }:
{
	programs = {
		fzf.enable = true;
		direnv =  {
			enable = true; nix-direnv.enable = true; enableZshIntegration = true; silent = true;
			package = (pkgs.direnv.overrideAttrs (oldAttrs: { doCheck = false; }));
		};
		zsh = {
			enable = true;
			enableVteIntegration = true;
			syntaxHighlighting.enable = true;
			setOptions = [ "vi" ];
			shellAliases = {
				ls = "ls --color=auto"; grep = "grep --color=auto"; diff = "diff --color=auto";
				hm-switch = "nix flake update --flake ${config.xdg.configHome}/home-manager && home-manager switch";
			};
			sessionVariables = { COLORTERM = 1; };
			initContent = ''
				if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
				  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
				fi
			'';
		};
	};
}

