{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pravin = {
    isNormalUser = true;
    description = "pravin";
    extraGroups = [ "wheel" ];
  };
  xdg.portal = {
  	enable = true;
  	wlr.enable = true;
    xdgOpenUsePortal = true;

    configPackages = [ pkgs.xdg-desktop-portal-wlr ];
  };
}
