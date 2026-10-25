{ ... }: {
  flake.modules.homeManager.personalApps = { pkgs, ... }: {
    home.packages = with pkgs; [
      brave-origin
      discord
      gimp3
      krita
      megasync
      signal-desktop
      solaar
      tor-browser
    ];
  };
}
