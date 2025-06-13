{ pkgs, ... }:

{
  programs = {
    chromium = {
      enable = true;
      dictionaries = [ pkgs.hunspellDictsChromium.en_US ];
      commandLineArgs = [ "--native-gpu-buffers" ];

      package = pkgs.brave;
    };

    thunderbird = {
      enable = true;
      profiles = { };
    };

    zathura = {
      enable = true;
      options = {
        "sandbox" = "strict";
        "selection-clipboard" = "clipboard";
      };
      mappings = { "<C-i>" = "recolor"; };
    };
  };
}
