{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tree
  ];

  home.shell.enableFishIntegration = true;
  programs.fzf.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      fish_add_path ~/.local/bin
      alias mv='mv -v'
      alias cp='cp -v'
      alias rm='rm -v'
      alias chmod='chmod -v'
      alias nshell="NIXPKGS_ALLOW_UNFREE=1 nix-shell --command fish -p"
    '';
  };
}
