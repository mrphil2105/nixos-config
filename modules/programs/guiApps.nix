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
      mpv = {
        enable = true;
        config = {
          demuxer-max-bytes = "4GiB";
          demuxer-max-back-bytes = "512MiB";
        };
      };
    };
    home.packages = with pkgs; [
      bitwarden-desktop
      ferdium
      imv
      libreoffice-qt
      spotify
      vlc
      yubioath-flutter
      zathura
    ];
  };
}
