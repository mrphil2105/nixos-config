{ ... }: {
  flake.modules.homeManager.workApps = { pkgs, ... }: {
    home.packages = with pkgs; [
      _1password-gui
      bruno
      chromium
      dbeaver-bin
      slack
      teams-for-linux
      zoom-us
    ];
  };
}
