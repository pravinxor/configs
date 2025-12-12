{ pkgs, inputs, ... }:
{
	imports = [ inputs.nixvim.homeModules.nixvim ];

	programs.nixvim = {
		enable = true; defaultEditor = true; 
		viAlias = true; vimAlias = true;
		enableMan = false;

		clipboard.providers.pbcopy.enable = true;
		colorschemes.one.enable = true;
		
		keymaps = [{
			action = ":NvimTreeToggle<cr>";
			key = "<leader>e";
		}];

		performance = {
			byteCompileLua = {
			enable = true;
			initLua = true;
			nvimRuntime = true;
			plugins = true;
			};
			combinePlugins.enable = true;
		};

		opts = {
			background = "light";
			number = true; 
			relativenumber = true;
			shiftwidth = 4; 
			tabstop = 4;
		};

		lsp.servers = {
			svelte.enable = true; tailwindcss.enable = true;
			pyright.enable = true; vtsls.enable = true;
			clangd.enable = true; zls.enable = true;
			nixd.enable = true;
		};

		plugins = {
			lspconfig.enable = true;
			treesitter = {
				enable = true;
				grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
					bash javascript python typescript
					c cpp rust wgsl zig
					html json svelte toml yaml nix
				];
				settings = {
				indent.enable = true;
					highlight = { additional_vim_regex_highlighting = false; enable = true; };
				};
			};
			nvim-tree = {
				enable = true;
				settings = {
					renderer.icons.show = {
						file = false;
						folder = false; 
						folder_arrow = false;
						git = false;
						modified = false;
						diagnostics = false;
					};
					diagnostics.enable = true;
				};
			};
			web-devicons.enable = true;
		};
	};
}
