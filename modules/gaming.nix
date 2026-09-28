{ ... }: {
  flake.modules.nixos.gaming = { config, pkgs, ... }: {
    programs = {
      steam = {
        enable = true;
        protontricks.enable = true;
        extraPackages = with pkgs; [
          hidapi
        ];
        extraCompatPackages = [
          pkgs.proton-ge-bin
          pkgs.nur.repos.vladexa.proton-cachyos
        ];
      };
      gamescope.enable = true;
      gamemode.enable = true;
    };
    environment.systemPackages = with pkgs; [
      wineWow64Packages.stable
      winetricks
    ];
    users.users.${config.my.username}.extraGroups = [ "gamemode" ];
    services.udev.extraRules = ''
      # LAMZU Maya X - USB and HIDRAW Access (Dongle & Wired)
      SUBSYSTEM=="usb", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001e", MODE="0666", GROUP="input", TAG+="uaccess"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001c", MODE="0666", GROUP="input", TAG+="uaccess"
      KERNEL=="hidraw*", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001e", MODE="0666", GROUP="input", TAG+="uaccess"
      KERNEL=="hidraw*", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001c", MODE="0666", GROUP="input", TAG+="uaccess"
    '';
  };
  flake.modules.homeManager.gaming = { pkgs, ... }: {
    home.packages = with pkgs; [
      prismlauncher
      satisfactorymodmanager
      wootility
    ];
    home.file.".local/lib/libgamemode.so".source = "${pkgs.gamemode.lib}/lib/libgamemode.so";
    programs.mangohud = {
      enable = true;
      settings = {
        preset = "0,1,-1,4";
        font_size = 18;
        hud_no_margin = true;
      };
    };
  };
}
