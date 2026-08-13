{ ... }: {
  flake.modules.nixos.general = { pkgs, ... }: {
    services.xserver = {
      enable = false;
      xkb = {
        layout = "us";
        options = "eurosign:e,caps:escape";
      };
    };
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
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    console.useXkbConfig = true;
    programs.hyprland.enable = true;
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
      fontconfig.useEmbeddedBitmaps = true;
      fontconfig.defaultFonts = {
        monospace = [ "JetBrainsMono NF" ];
      };
    };
  };
}
