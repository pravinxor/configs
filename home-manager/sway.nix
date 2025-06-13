{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Fonts
    font-awesome
    noto-fonts-emoji
    noto-fonts-cjk-sans
    lmodern
    # noto-fonts

    helvetica-neue-lt-std

    # Sway packages
    swayidle
    swaybg
    playerctl
    brightnessctl
    wl-clipboard
    wlsunset

    # Screen capture
    grim
    slurp

    wlsunset

    adwaita-icon-theme
  ];

  services = {
    wlsunset = {
      enable = true;
      latitude = 33.019844;
      longitude = -96.698883;
    };
    swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
        {
          timeout = 500;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
        {
          event = "lock";
          command = "lock";
        }
      ];
    };

    mako = {
      enable = true;
      settings = {
        default-timeout = 5000; # measured in ms
      };
    };
  };

  programs = {
    swaylock = {
      enable = true;
      settings = {
        ignore-empty-password = true;
        indicator-caps-lock = true;
        show-failed-attempts = true;
      };
    };

    foot = {
      enable = true;
      settings = {
        main = { shell = "${pkgs.fish}/bin/fish"; };
        mouse = { hide-when-typing = "yes"; };
      };
    };

    fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "${pkgs.foot}/bin/footclient";
        };
        border = {
          radius = 0;
        };
      };
    };

    waybar = {
      enable = true;
      systemd.target = "sway-session.target";
      style = builtins.readFile ./waybar/style.css;
      settings = [{
        modules-left =
          [ "sway/workspaces" "battery" "cpu" "disk" "memory" "sway/window" ];
        modules-center = [ "clock" ];
        modules-right = [
          "network"
          "temperature"
          "wireplumber"
          "backlight"
          "tray"
          "idle_inhibitor"
          "custom/lock"
          "custom/suspend"
        ];
        "sway/window" = {
          format = "{}";
          max-length = 45;
          tooltip = false;
        };
        temperature = {
          format =
            "<span font_desc='Font Awesome 6 Free'>{icon}</span> {temperatureC}°C";
          format-icons = { default = [ "" "" "" "" "" ]; };
        };
        idle_inhibitor = {
          format = "<span font_desc='Font Awesome 6 Free'>{icon}</span>";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = { spacing = 10; };
        clock = { format = " {:%b %d %I:%M %p}"; };
        backlight = {
          format =
            "<span font_desc='Font Awesome 6 Free'>{icon}</span> {percent}%";
          format-icons = { default = [ "" "" "" ]; };
        };
        cpu = {
          format = "{usage}% ";
          states = { critical = 90; };
        };
        memory = {
          format =
            "{percentage}% <span font_desc='Font Awesome 6 Free'></span>";
          states = { critical = 85; };
        };
        disk = {
          interval = 60;
          format = "{percentage_used}% ";
          path = "/";
        };
        battery = {
          states = { critical = 15; };
          format =
            "{capacity}% <span font_desc='Font Awesome 6 Free'>{icon}</span>";
          format-charging = "{capacity}%  ";
          format-plugged = "{capacity}% ";
          tooltip = true;
          format-full =
            "Full <span font_desc='Font Awesome 6 Free'>{icon}</span>";
          format-icons = [ "" "" "" "" "" ];
          tooltip-format = " {time}";
        };
        network = {
          format-wifi = " {essid}";
          format-ethernet = " {ifname}: {ipaddr}/{cidr}";
          format-linked = " {ifname} (No IP)";
          format-disconnected = "  Disconnected";
          format-alt = " {bandwidthDownBytes}  {bandwidthUpBytes} ";
          tooltip-format = " {ifname}: {ipaddr}/{cidr}";
        };
        wireplumber = {
          format =
            "<span font_desc='Font Awesome 6 Free'>{icon}</span> {volume}%";
          format-bluetooth =
            "<span font_desc='Font Awesome 6 Free'>{icon}</span> {volume}%";
          format-bluetooth-muted = "  {volume}%";
          format-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
        };
        "custom/suspend" = {
          format = "";
          on-click = "${pkgs.systemd}/bin/systemctl suspend";
        };
      }];
    };
  };

  gtk.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    checkConfig =
      false; # Does not work (for now), due to bug when opening background image

    systemd.xdgAutostart = true;

    config = {
      startup = [{ command = "${pkgs.foot}/bin/foot --server"; }];

      gaps = {
        inner = 8;
        smartBorders = "on";
        smartGaps = true;
      };
      seat = { "*" = { "xcursor_theme" = "Adwaita"; }; };
      output = {
        "*" = {
          adaptive_sync = "on";
          allow_tearing = "yes";
          # render_bit_depth = "10"; # Causes issues with screen sharing
        };
        "Samsung Electric Company LC27T55 HCPNB03531" = {
          mode = "1920x1080@74.973Hz";
        };
        "Samsung Electric Company S34J55x H4LNC10122" = {
          mode = "3440x1440@75Hz";
        };
      };
      window = {
        border = 2;
        titlebar = false;
      };

      modifier = "Mod4";
      terminal = "${pkgs.foot}/bin/footclient";
      menu = "${pkgs.fuzzel}/bin/fuzzel";
      input = {
        "type:touchpad" = {
          accel_profile = "flat";
          dwt = "disabled";
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };
      keybindings =
        let modifier = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+0" = null;
          "${modifier}+Return" =
            "exec ${config.wayland.windowManager.sway.config.terminal}";
          "${modifier}+Shift+q" = "kill";
          "${modifier}+d" =
            "exec ${config.wayland.windowManager.sway.config.menu}";
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+e" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
          "Print" = ''exec grim -g "$(slurp)" - | wl-copy -t image/png'';
          "--locked ${modifier}+p" = "output $laptop toggle";
          "--locked XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          "--locked XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
          "--locked Shift+XF86MonBrightnessDown" = "exec brightnessctl set 1%-";
          "--locked Shift+XF86MonBrightnessUp" = "exec brightnessctl set 1%+";
          "--locked XF86KbdBrightnessUp" =
            "exec brightnessctl --device=asus::kbd_backlight set +1";

          "--locked XF86KbdBrightnessDown" =
            "exec brightnessctl --device=asus::kbd_backlight set 1-";
          "--locked XF86AudioMute" =
            "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "--locked XF86AudioLowerVolume" =
            "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.2";
          "--locked XF86AudioRaiseVolume" =
            "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.2";
          "--locked Shift+XF86AudioLowerVolume" =
            "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- -l 1.2";
          "--locked Shift+XF86AudioRaiseVolume" =
            "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ -l 1.2";
          "--locked XF86AudioPlay" = "exec playerctl play-pause";
          "--locked XF86AudioStop" = "exec playerctl stop";
          "--locked XF86AudioPrev" = "exec playerctl previous";
          "--locked XF86AudioNext" = "exec playerctl next";
        };
      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];
    };
    extraConfig = ''
      set $laptop "Thermotrex Corporation TL140ADXP02-0 Unknown"

      bindswitch --reload --locked lid:on output $laptop disable
      bindswitch --reload --locked lid:off output $laptop enable
    '';
  };
}
