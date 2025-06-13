{ ... }:

{
  networking = {
    useNetworkd = true;
    networkmanager.enable = false;
    wireless = {
      fallbackToWPA2 = false;
      iwd = { enable = true; };
    };
    hostName = "ampere";

    # wireguard.enable = true;
  };

  systemd.network = {
    enable = true;
    wait-online.enable = false;

    networks = {
      "40-wired" = {
        matchConfig = { Type = "ether"; };
        networkConfig = { DHCP = "yes"; };
      };
      "50-wireless" = {
        matchConfig = { Type = "wlan"; };
        networkConfig = { DHCP = "yes"; };
      };
    };
  };

  services.resolved = {
    enable = true;
    # domains = [ "~." ];

    # dnsovertls = "opportunistic";
    # dnssec = "allow-downgrade";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
