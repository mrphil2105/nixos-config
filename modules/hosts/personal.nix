{ self, ... }: {
  flake.modules.nixos.personal = { ... }: {
    imports = with self.modules.nixos; [
      core
      obsStudio
    ];
    home-manager.users.mrphil2105.imports = with self.modules.homeManager; [
      core
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
