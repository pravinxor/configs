{ pkgs, ... }:

{
  programs = {
    helix = {
      enable = true;
      defaultEditor = true;

      extraPackages = with pkgs; [
        bash-language-server
        nixd
        nixfmt
        clang-tools
        superhtml
        vscode-langservers-extracted
        typescript-language-server
        rust-analyzer
        ruff
        svelte-language-server
        ty
        jdt-language-server
        gopls
        tinymist
        typst-fmt
        marksman
        markdown-oxide
        yaml-language-server
        zls
      ];

      settings = {
        editor = {
          line-number = "relative";
          color-modes = true;
          bufferline = "multiple";
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          indent-guides.render = true;
          soft-wrap.enable = true;
          completion-replace = true;
          lsp = { display-progress-messages = true; };
        };
      };

      languages = {
        language = [
          {
            name = "python";
            language-servers = [ "ruff" "ty" ];
          }
          {
            name = "nix";
            formatter = { command = "${pkgs.nixfmt}/bin/nixfmt"; };
          }
        ];
        language-server = {
          ty = {
            command = "${pkgs.ty}/bin/ty";
            args = [ "server" ];
          };
        };
      };
    };
  };
}
