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
  flake.modules.homeManager.desktop = { pkgs, ... }: {
    imports = with self.modules.homeManager; [
      general
      personalApps
      gaming
    ];
    home.packages = [
      pkgs.nvtopPackages.nvidia
    ];
    wayland.windowManager.hyprland.extraLuaFiles."10-host" = ./hyprland.lua;
  };
}
