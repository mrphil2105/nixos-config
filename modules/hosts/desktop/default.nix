{ inputs, self, ... }: {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
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
        ./hardware.nix
        inputs.lanzaboote.nixosModules.lanzaboote
      ];
    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.loader.systemd-boot.consoleMode = "max";
    boot.lanzaboote.enable = true;
    boot.lanzaboote.pkiBundle = "/var/lib/sbctl";
    services.udev.packages = [ pkgs.wooting-udev-rules ];
    environment.systemPackages = [ pkgs.sbctl ];
    networking.hostName = "mrphil2105-NixDesktop";
    system.stateVersion = "25.05";
    home-manager.users.mrphil2105.home.stateVersion = "25.05";
  };
}
