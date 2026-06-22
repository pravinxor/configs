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
        performance.byteCompileLua = {
            enable = true;
            luaLib = true;
            nvimRuntime = true;
            plugins = true;
        };

        autoCmd = [
            {
                command = "GuessIndent";
                event = [ "BufEnter" ];
            }
        ];

        opts = {
            clipboard = "unnamedplus";
            background = "light";
            foldmethod = "expr"; foldexpr = "v:lua.vim.lsp.foldexpr()"; foldlevel = 99;

            number = true; relativenumber = true;

            cindent = true;
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
            blink-cmp = {
                enable = true;
                settings = {
                    signature.enabled = true;
                    sources.default = [ "lsp" "path" ];
                };
            };
            direnv.enable = true;
            guess-indent = {
                enable = true;
                callSetup = true;
            };
            treesitter = {
                enable = true;
                grammarPackages = with pkgs.vimPlugins.nvim-treesitter-parsers; [
                    bash javascript python typescript ocaml make
                    c cpp
                    html json svelte toml yaml nix
                ];
                highlight.enable = true;
                indent.enable = true;
            };
        };
    };
}
