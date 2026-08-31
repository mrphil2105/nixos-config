{ inputs, self, ... }: {
  flake.nixosConfigurations.mrphil2105-NixLaptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.laptop
    ];
  };
  flake.modules.nixos.laptop = { ... }: {
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
    };
    system.stateVersion = "25.11";
    home-manager.users.mrphil2105 = {
      imports = [
        self.modules.homeManager.laptop
      ];
      home.stateVersion = "25.11";
    };
  };
  flake.modules.homeManager.laptop = { ... }: {
    imports = with self.modules.homeManager; [
      general
      personalApps
    ];
    wayland.windowManager.hyprland.extraLuaFiles."10-host" = ./hyprland.lua;
    programs.zsh.shellAliases = {
      startvpn = "sudo systemctl start openvpn-router.service";
      stopvpn = "sudo systemctl stop openvpn-router.service";
    };
  };
}
