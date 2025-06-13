{ config, pkgs, ... }: {
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    image = ./wallpaper.jpg;

    opacity.terminal = 0.925;

    fonts = with pkgs; {
      sizes = {
        desktop = 10.5;
        popups = 11;
        terminal = 11;
      };

      serif = {
        package = (iosevka-bin.override { variant = "Etoile"; });
        name = "Iosevka Etoile";
      };

      sansSerif = {
        package = (iosevka-bin.override { variant = "Aile"; });
        name = "Iosevka Aile";
      };

      monospace = {
        package = iosevka-bin;
        name = "Iosevka";
      };

      emoji = {
        package = noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    targets = {
      swaylock.enable = true;
      waybar.enable = false;
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Iosevka Aile" ];
      serif = [ "Iosevka Etoile" ];
      monospace = [ "Iosevka" ];
      emoji = [ "Noto Emoji" "Font Awesome" ];
    };
  };

  stylix.targets = {
    btop.enable = false;
    fish.enable = false;
    foot.enable = false;
    gtk.enable = false;
    helix.enable = false;
    kde.enable = false;
  };

  home.packages =
    [ (pkgs.iosevka-bin.override { variant = "SGr-IosevkaTerm"; }) ];

  gtk = {
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  programs = {
    btop.settings = {
      color_theme = "dracula";
      theme_background = false;
    };

    foot.settings = {
      main = {
        include = "${config.xdg.configHome}/home-manager/foot/dracula.ini";
        font = "IosevkaTerm:size=11";
      };
      colors.alpha = 0.95;
    };

    helix = {
      settings.theme = "dracula";
      themes.dracula = {
        inherits = "dracula";
        "ui.background" = { };
      };
    };
  };
}
