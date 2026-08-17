{ inputs, ... }: {
  flake.modules.nixos.user =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];
      options.my.username = lib.mkOption {
        type = lib.types.str;
        default = "mrphil2105";
        description = "Username of the primary user";
      };
      config = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
        };
        programs.zsh = {
          enable = true;
          enableGlobalCompInit = false;
        };
        users.users.${config.my.username} = {
          shell = pkgs.zsh;
          isNormalUser = true;
          createHome = true;
          extraGroups = [
            "wheel"
            "networkmanager"
            "docker"
          ];
        };
      };
    };
}
