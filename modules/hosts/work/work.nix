{ inputs, self, ... }: {
  flake.nixosConfigurations.philip-WorkLaptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.work
    ];
  };
  flake.modules.nixos.work = { ... }: {
    imports = [
      self.modules.nixos.general
      ./_hardware.nix
    ];
    my.username = "philip";
    networking.hostName = "philip-WorkLaptop";
    services = {
      power-profiles-daemon.enable = true;
      tailscale.enable = true;
      intune.enable = true;
      gnome.glib-networking.enable = true;
    };
    nixpkgs.overlays = [
      (final: prev: {
        microsoft-identity-broker = prev.microsoft-identity-broker.overrideAttrs (old: {
          nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ final.wrapGAppsHook3 ];
          buildInputs = (old.buildInputs or [ ]) ++ [ final.glib-networking ];
        });
      })
    ];
    system.stateVersion = "26.05";
    home-manager.users.philip = {
      imports = [
        self.modules.homeManager.work
      ];
      home.stateVersion = "26.05";
    };
  };
  flake.modules.homeManager.work = { lib, ... }: {
    imports = with self.modules.homeManager; [
      general
      workApps
    ];
    wayland.windowManager.hyprland.settings = {
      monitor = [
        "eDP-1, 1920x1200, 0x0, 1"
      ];
      workspace = map (i: "${toString i}, monitor:eDP-1") (lib.range 1 10);
      exec-once = [
        "slack --startup &"
      ];
      windowrule = [
        "match:class slack, workspace 6"
      ];
    };
  };
}
