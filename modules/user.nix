{ inputs, ... }: {
  flake.modules.nixos.user = { pkgs, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
    programs.zsh = {
      enable = true;
      enableGlobalCompInit = false;
    };
    users.users.mrphil2105 = {
      shell = pkgs.zsh;
      isNormalUser = true;
      createHome = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "libvirtd"
      ];
    };
  };
}
