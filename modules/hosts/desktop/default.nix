{ inputs, self, ... }: {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.core
      self.modules.nixos.personal
      self.modules.nixos.desktop
      self.modules.nixos.gaming
    ];
  };
  flake.modules.nixos.desktop = { lib, pkgs, ... }: {
    imports = [
      inputs.lanzaboote.nixosModules.lanzaboote
      ./hardware.nix
      ./nvidia.nix
      ./gaming.nix
      ../../system
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
