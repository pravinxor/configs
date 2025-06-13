{ pkgs, ... }:

{
  home.packages = with pkgs; [
    passExtensions.pass-otp
    (pass.withExtensions (ext: with ext; [ pass-otp ]))
    xorg.xauth
  ];

  programs = {
    ssh = {
      enable = true;
      matchBlocks."*" = {
        # forwardX11 = true;
      };
      addKeysToAgent = "yes";
      controlMaster = "auto";
      serverAliveInterval = 3;
    };

    git = {
      enable = true;
      userName = "Pravin Ramana";
      userEmail = "pravin@pravinxor.dev";
      signing = { 
        signByDefault = true;
        key = null;
      };
    };
  };
  
  services = {
    gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-tty;
    };
    gnome-keyring.enable = true;
  };
}
