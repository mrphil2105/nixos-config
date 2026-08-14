{ self, ... }: {
  flake.modules.nixos.personal = { ... }: {
    imports = with self.modules.nixos; [
      general
      obsStudio
    ];
    home-manager.users.mrphil2105.imports = with self.modules.homeManager; [
      general
      personal
    ];
  };
  flake.modules.homeManager.personal = { ... }: {
    imports = with self.modules.homeManager; [
      guiPrograms
      personalPrograms
      ssh
    ];
  };
}
