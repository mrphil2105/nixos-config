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
    networking.hostName = "mrphil2105-NixLaptop";
    services = {
      power-profiles-daemon.enable = true;
      openvpn.servers.router = {
        config = "config /home/mrphil2105/.openvpn/router.ovpn";
        autoStart = false;
      };
      tailscale.enable = true;
    };
    system.stateVersion = "25.11";
    home-manager.users.mrphil2105 = {
      imports = [
        self.modules.homeManager.work
      ];
      home.stateVersion = "25.11";
    };
  };
  flake.modules.homeManager.work = { lib, ... }: {
    imports = [
      self.modules.homeManager.general
    ];
    wayland.windowManager.hyprland.settings = {
      monitor = [
        "eDP-1, 1920x1200, 0x0, 1"
      ];
      workspace = map (i: "${toString i}, monitor:eDP-1") (lib.range 1 10);
    };
    programs.zsh.shellAliases = {
      startvpn = "sudo systemctl start openvpn-router.service";
      stopvpn = "sudo systemctl stop openvpn-router.service";
    };
  };
}
