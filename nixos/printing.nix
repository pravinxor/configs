{ pkgs, ... }:
{
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [ postscript-lexmark ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    system-config-printer.enable = true;
  };
}