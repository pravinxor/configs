{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fscrypt-experimental
  ];
  networking.firewall.enable = true;
  security = {
    polkit.enable = true;
    pam = {
      services = {
        swaylock = {};
      };
      enableFscrypt = true;
    };
  };
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    wireshark = {
      enable = false;
      usbmon.enable = true;
      package = pkgs.wireshark-qt;
    };
  };
  # users.users.pravin.extraGroups = [ "wireshark" ];
  services = {
    dbus.packages = [ pkgs.gcr ];
    cloudflare-warp.enable = false;
  };
  security.sudo.execWheelOnly = true;
}
