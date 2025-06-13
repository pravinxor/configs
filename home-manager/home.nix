{ pkgs, ... }: {

  home.username = "pravin";
  home.homeDirectory = "/home/pravin";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    dconf
    rtorrent
    ffmpeg
    sshfs
    jq
    nvtopPackages.full
    zip
    unzip

    radare2
    binwalk
    nmap
    whois


    claude-code
    glow
    signal-desktop
    python3
    parallel
    qflipper
    socat
  ];

  programs = {
    direnv = {
      enable = true;
      silent = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };

  home.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  programs.home-manager.enable = true;
}

