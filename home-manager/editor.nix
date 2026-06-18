{ pkgs, inputs, ... }:
{
	imports = [ inputs.nixvim.homeModules.nixvim ];

	programs.nixvim = {
		enable = true; defaultEditor = true;
		viAlias = true; vimAlias = true;
		nixpkgs.useGlobalPackages = true;
		enableMan = false;
		
		colorschemes.melange.enable = true;
		clipboard.providers.pbcopy.enable = true;

		opts = {
			clipboard = "unnamedplus";
			background = "light";
			shiftwidth = 4;
			tabstop = 4;

			foldmethod = "expr"; foldexpr = "v:lua.vim.lsp.foldexpr()"; foldlevel = 99;

			number = true; relativenumber = true;

			smartindent = true; autoindent = true;
			ignorecase = true; smartcase = true;
		};

		lsp = {
			servers = {
				svelte.enable = true; tailwindcss.enable = true; vtsls.enable = true;
				ocamllsp.enable = true;
				ty.enable = true; ruff.enable = true;
				clangd.enable = true;
				nixd.enable = true;
			};
		};

		plugins = {
			lspconfig.enable = true;
			direnv.enable = true;
			treesitter = {
				enable = true;
				grammarPackages = with pkgs.vimPlugins.nvim-treesitter-parsers; [
					bash javascript python typescript ocaml
					c cpp
					html json svelte toml yaml nix
				];
				settings = {
					indent.enable = true;
					highlight = {
						additional_vim_regex_highlighting = false;
						enable = true;
					};
				};
			};
		};
	};
}
