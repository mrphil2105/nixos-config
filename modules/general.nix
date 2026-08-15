{ self, ... }: {
  flake.modules.nixos.general = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      core
      hyprland
    ];
    services.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      autoLogin = {
        enable = true;
        user = "mrphil2105";
      };
      defaultSession = "hyprland";
    };
    programs.dconf.enable = true;
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        _0xpropo
        jetbrains-mono
        nerd-fonts.jetbrains-mono
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];
      fontconfig.defaultFonts.monospace = [ "JetBrainsMono NF" ];
    };
  };
  flake.modules.homeManager.general = { pkgs, ... }: {
    imports = with self.modules.homeManager; [
      core
      hyprland
      guiPrograms
    ];
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 32;
    };
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    };
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
