{ inputs, self, ... }: {
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
  ];
  flake.modules.nixos.system = { ... }: {
    hardware = {
      bluetooth.enable = true;
      logitech.wireless.enable = true;
    };
    services = {
      pipewire = {
        enable = true;
        pulse.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
      };
      pcscd.enable = true;
      gnome.gnome-keyring.enable = true;
      envfs.enable = true;
      udisks2.enable = true;
    };
    programs = {
      nix-ld.enable = true;
      fuse.enable = true;
      gnupg.agent.enable = true;
    };
    virtualisation.docker.enable = true;
  };
  flake.modules.homeManager.core = { ... }: {
    imports = with self.modules.homeManager; [
      cliPrograms
      neovim
    ];
  };
}
