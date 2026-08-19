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
        general
        obsStudio
        gaming
        nvidia
      ]
      ++ [
        ./_hardware.nix
        inputs.lanzaboote.nixosModules.lanzaboote
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
    environment.systemPackages = [ pkgs.sbctl ];
    services.udev.packages = [ pkgs.wooting-udev-rules ];
    networking.hostName = "mrphil2105-NixDesktop";
    system.stateVersion = "25.05";
    home-manager.users.mrphil2105 = {
      imports = [
        self.modules.homeManager.desktop
      ];
      home.stateVersion = "25.05";
    };
  };
  flake.modules.homeManager.desktop = { lib, pkgs, ... }: {
    imports = with self.modules.homeManager; [
      general
      personalApps
      gaming
    ];
    home.packages = [
      pkgs.nvtopPackages.nvidia
    ];
    wayland.windowManager.hyprland.settings = {
      input.accel_profile = "flat";
      general.allow_tearing = true;
      misc.vrr = 3;
      monitor = [
        "desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FO32U2P, 3840x2160@240, 0x0, 1.5, bitdepth, 10, cm, srgb"
      ];
      workspace = map (i: "${toString i}, monitor:HDMI-A-2") (lib.range 1 10);
      exec-once = [
        "vesktop --ozone-platform=wayland --start-minimized & steam -silent &"
      ];
      windowrule = [
        "match:class vesktop, workspace 6"
        "match:class steam, workspace 9"
      ]
      ++ map (effect: "match:class ^(steam_app_\\d+|gamescope|cs2)$, ${effect}") [
        "monitor DP-6"
        "fullscreen on"
        "workspace 10"
        "content game"
      ];
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
    };
  };
}
