{ ... }:
{
	programs = {
		fzf.enable = true;
		zsh = {
			enable = true;
			enableVteIntegration = true;
			syntaxHighlighting.enable = true;
			setOptions = [ "vi" ];
			shellAliases = {
				ls = "ls --color=auto"; grep = "grep --color=auto";
			};
			initContent = ''
				if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
				  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
				fi
			'';
		};
	};
}

