{ ... }: {
  flake.modules.homeManager.personalApps = { pkgs, ... }: {
    programs.firefox.enable = true;
    home.packages = with pkgs; [
      brave-origin
      gimp3
      krita
      megasync
      signal-desktop
      solaar
      tor-browser
      vesktop
    ];
  };
}
