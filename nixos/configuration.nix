# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./games.nix
    ./hardware-configuration.nix
    ./locale.nix
    ./memory.nix
    ./networking.nix
    ./power.nix
    ./printing.nix
    ./security.nix
    ./user.nix
    ./video.nix
  ];

  services.fwupd.enable = true;

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      configurationLimit = 3;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware = {
    enableAllFirmware = true;
    keyboard.qmk.enable = true;
    flipperzero.enable = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };

  programs.nix-ld.enable = true;

  nix = {
    daemonIOSchedClass = "idle";
    daemonCPUSchedPolicy = "idle";

    optimise = {
      automatic = true;
      persistent = true;
    };
    gc = {
      automatic = true;
      persistent = true;
    };

    settings = {
      sandbox = "relaxed";
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];

      keep-outputs = true;
      keep-derivations = true;
    };
  };

  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
