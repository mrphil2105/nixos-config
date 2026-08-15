{ inputs, self, ... }: {
  flake.nixosConfigurations.mrphil2105-NixDesktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.desktop
    ];
  };
  flake.modules.nixos.desktop = { lib, pkgs, ... }: {
    imports =
      with self.modules.nixos;
      [
        personal
        gaming
        nvidia
      ]
      ++ [
        ./_hardware.nix
        inputs.lanzaboote.nixosModules.lanzaboote
        inputs.nur.modules.nixos.default
      ];
    boot = {
      loader.systemd-boot = {
        enable = lib.mkForce false;
        consoleMode = "max";
      };
      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };
    services.udev.packages = [ pkgs.wooting-udev-rules ];
    environment.systemPackages = [ pkgs.sbctl ];
    networking.hostName = "mrphil2105-NixDesktop";
    system.stateVersion = "25.05";
    home-manager.users.mrphil2105 = {
      imports = [
        self.modules.homeManager.desktop
      ];
      home.stateVersion = "25.05";
    };
  };
  flake.modules.homeManager.desktop = { pkgs, ... }: {
    home.packages = [
      pkgs.nvtopPackages.nvidia
    ];
    wayland.windowManager.hyprland.settings = {
      input.accel_profile = "flat";
      general.allow_tearing = true;
      misc.vrr = 3;
      monitor = [
        "HDMI-A-2, 3840x2160@240, 0x0, 1.5, bitdepth, 10, cm, srgb"
      ];
      workspace = [
        "1, monitor:DP-6"
        "2, monitor:DP-6"
        "3, monitor:DP-6"
        "4, monitor:DP-6"
        "5, monitor:DP-6"
        "6, monitor:DP-6"
        "7, monitor:DP-6"
        "8, monitor:DP-6"
        "9, monitor:DP-6"
        "10, monitor:DP-6"
        "11, monitor:HDMI-A-2"
        "12, monitor:HDMI-A-2"
        "13, monitor:HDMI-A-2"
        "14, monitor:HDMI-A-2"
        "15, monitor:HDMI-A-2"
      ];
      exec-once = [
        "vesktop --ozone-platform=wayland --start-minimized & steam -silent &"
      ];
      windowrule = [
        "match:class steam, workspace 9"
        "match:class ^(steam_app_\\d+|gamescope|cs2)$, monitor DP-6"
        "match:class ^(steam_app_\\d+|gamescope|cs2)$, fullscreen on"
        "match:class ^(steam_app_\\d+|gamescope|cs2)$, workspace 10"
        "match:class ^(steam_app_\\d+|gamescope|cs2)$, content game"
      ];
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
    };
  };
}
