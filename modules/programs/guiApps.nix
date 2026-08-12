{ self, ... }: {
  flake.modules.homeManager.guiApps = { pkgs, ... }: {
    imports = with self.modules.homeManager; [
      ghostty
      walker
    ];
    programs.firefox.enable = true;
    programs.vscode = {
      enable = true;
      profiles.default.extensions = [ pkgs.vscode-extensions.vscodevim.vim ];
    };
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
