{ config, ... }: {
  programs = {
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
        proc_sorting = "cpu lazy";
        proc_tree = true;
        proc_filter_kernel = true;
        proc_aggregate = true;
        log_level = "off";
      };
    };

    rtorrent = {
      enable = true;
      extraConfig = ''
        session = ${config.xdg.configHome}/rtorrent;
        directory = ${config.home.homeDirectory}/Downloads;        
      '';
    };
  };
}
