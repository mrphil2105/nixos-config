{ self, ... }: {
  flake.modules.homeManager.guiApps = { config, pkgs, ... }: {
    imports = with self.modules.homeManager; [
      ghostty
      walker
    ];
    programs = {
      firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
      };
      vscode = {
        enable = true;
        profiles.default.extensions = [ pkgs.vscode-extensions.vscodevim.vim ];
      };
    };
    home.packages = with pkgs; [
      bitwarden-desktop
      ferdium
      imv
      libreoffice-qt
      mpv
      spotify
      vlc
      yubioath-flutter
      zathura
    ];
  };
}
