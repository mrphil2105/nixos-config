{ self, ... }: {
  flake.modules.nixos.personal = { ... }: {
    home-manager.users.mrphil2105.imports = [
      self.modules.homeManager.core
      self.modules.homeManager.personal
    ];
  };
  flake.modules.homeManager.personal = { ... }: {
    programs.firefox.enable = true;
  };
}
