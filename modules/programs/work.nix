{ ... }: {
  flake.modules.homeManager.workPrograms = { pkgs, ... }: {
    programs.firefox.enable = true;
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
