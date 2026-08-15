{ inputs, self, ... }: {
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
  ];
  flake.modules.nixos.core = { lib, pkgs, ... }: {
    imports = with self.modules.nixos; [
      system
      user
    ];
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    nixpkgs.config.allowUnfree = true;
    boot = {
      kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
    time.timeZone = "Europe/Copenhagen";
    i18n.defaultLocale = "en_DK.UTF-8";
    services.xserver = {
      enable = false;
      xkb = {
        layout = "us";
        options = "eurosign:e,caps:escape";
      };
    };
    console.useXkbConfig = true;
    networking.networkmanager.enable = true;
    environment.systemPackages = with pkgs; [
      vim
      git
    ];
  };
  flake.modules.homeManager.core = { ... }: {
    imports = with self.modules.homeManager; [
      cliApps
      tmux
      neovim
    ];
  };
}
