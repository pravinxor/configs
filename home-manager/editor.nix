{ pkgs, inputs, ... }:
{
	imports = [ inputs.nixvim.homeModules.nixvim ];

	programs.nixvim = {
		enable = true; defaultEditor = true;
		viAlias = true; vimDiffAlias = true; vimAlias = true;
		nixpkgs.useGlobalPackages = true;
		enableMan = false;

		clipboard.providers.pbcopy.enable = true;
		colorschemes.melange = {
			enable = true;
		};

		dependencies.ripgrep.enable = true;

		performance.byteCompileLua = {
			enable = true;
			initLua = true;
			nvimRuntime = true;
			plugins = true;
		};

		opts = {
			clipboard = "unnamedplus";
			background = "light";
			number = true;
			relativenumber = true;
			shiftwidth = 4;
			tabstop = 4;
			expandtab = false;

			foldmethod = "expr"; foldexpr = "v:lua.vim.treesitter.foldexpr()"; foldlevel = 99;

			smartindent = true; autoindent = true;
			ignorecase = true; smartcase = true;
		};

		lsp.servers = {
			svelte.enable = true; tailwindcss.enable = true;
			wgsl_analyzer.enable = true;
			pyright.enable = true;
			vtsls.enable = true;
			clangd.enable = true;
			zls.enable = true;
			nixd.enable = true;
		};

		plugins = {
			lspconfig.enable = true;
			direnv.enable = true;
			blink-cmp.enable = true;
			treesitter = {
				enable = true;
				grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
					bash javascript python typescript
					c cpp wgsl zig
					html json svelte toml yaml nix
				];
				settings = {
					indent.enable = false;
					folding.enable = true;
					highlight = {
						additional_vim_regex_highlighting = false;
						enable = true;
					};
				};
			};
			treesitter-context.enable = true;
			web-devicons.enable = false;
			telescope = {
				enable = true;
				keymaps = {
					"<leader>f" = "find_files";
					"<leader>g" = "live_grep";
					"<leader>b" = "buffers";
					"<leader>h" = "help_tags";
				};
			};
		};
	};
}
