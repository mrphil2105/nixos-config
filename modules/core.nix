{ inputs, self, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
  ];
  flake.modules.nixos.core = { ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    nixpkgs.config.allowUnfree = true;
    programs.zsh = {
      enable = true;
      enableGlobalCompInit = false;
    };
    programs.nix-ld.enable = true;
    programs.fuse.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.envfs.enable = true;
    services.udisks2.enable = true;
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
  flake.modules.homeManager.core = { ... }: {
    imports = [
      self.modules.homeManager.cliPrograms
      self.modules.homeManager.neovim
    ];
  };
}
