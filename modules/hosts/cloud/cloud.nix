{ inputs, self, ... }: {
  flake.homeConfigurations."philip@cloud-computer-philip" =
    inputs.home-manager.lib.homeManagerConfiguration
      {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          self.modules.homeManager.cloud
        ];
      };
  flake.modules.homeManager.cloud = { ... }: {
    imports = [
      self.modules.homeManager.core
    ];
    nixpkgs.config.allowUnfree = true;
    programs = {
      home-manager.enable = true;
      zsh.shellAliases.hms = "home-manager switch --flake ~/.nix";
    };
    home = {
      username = "philip";
      homeDirectory = "/home/philip";
      stateVersion = "25.11";
    };
  };
}
