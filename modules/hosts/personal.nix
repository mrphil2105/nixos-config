{ self, ... }: {
  flake.modules.nixos.personal = { ... }: {
    imports = with self.modules.nixos; [
      general
      obsStudio
    ];
    home-manager.users.mrphil2105.imports = [
      self.modules.homeManager.personal
    ];
  };
  flake.modules.homeManager.personal = { ... }: {
    imports = with self.modules.homeManager; [
      general
      personalPrograms
      ssh
    ];
  };
}
