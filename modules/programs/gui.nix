{ self, ... }: {
  flake.modules.homeManager.guiPrograms = { pkgs, ... }: {
    imports = [
      self.modules.homeManager.ghostty
    ];
    programs.firefox.enable = true;
    home.packages = with pkgs; [
      bitwarden-desktop
      ferdium
      imv
      libreoffice-qt-fresh
      mpv
      spotify
      vlc
      yubioath-flutter
      zathura
    ];
  };
}
