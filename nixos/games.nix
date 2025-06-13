{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    extest.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  hardware = {
    steam-hardware.enable = true;
    xone.enable = true;
  };
}
