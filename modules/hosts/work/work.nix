{ inputs, self, ... }: {
  flake.nixosConfigurations.philip-WorkLaptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.work
    ];
  };
  flake.modules.nixos.work = { config, pkgs, ... }: {
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
    environment.systemPackages = with pkgs; [
      seahorse
      libsecret
    ];
    systemd.services.display-manager.serviceConfig.KeyringMode = "inherit";
    security.pam.services.sddm-autologin.rules = {
      auth = {
        systemd_loadkey = {
          order = config.security.pam.services.sddm-autologin.rules.auth."sddm-autologin-user".order + 10;
          control = "optional";
          modulePath = "${config.systemd.package}/lib/security/pam_systemd_loadkey.so";
        };
        gnome_keyring = {
          order = config.security.pam.services.sddm-autologin.rules.auth."sddm-autologin-user".order + 20;
          control = "optional";
          modulePath = "${pkgs.gnome-keyring}/lib/security/pam_gnome_keyring.so";
        };
      };
      session.gnome_keyring = {
        order = config.security.pam.services.sddm-autologin.rules.session.sddm.order + 10;
        control = "optional";
        modulePath = "${pkgs.gnome-keyring}/lib/security/pam_gnome_keyring.so";
        settings.auto_start = true;
      };
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
  flake.modules.homeManager.work = { ... }: {
    imports = with self.modules.homeManager; [
      general
      workApps
    ];
    wayland.windowManager.hyprland.extraLuaFiles."10-host" = ./hyprland.lua;
  };
}
