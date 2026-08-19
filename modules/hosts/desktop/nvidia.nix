{ ... }: {
  flake.modules.nixos.nvidia = { config, pkgs, ... }: {
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
    services = {
      xserver.videoDrivers = [ "nvidia" ];
      lact.enable = true;
    };
    programs = {
      gamescope.package = pkgs.gamescope.overrideAttrs (old: {
        # Fix blurry output
        NIX_CFLAGS_COMPILE = [ "-fno-fast-math" ];
        # Disable explicit sync because it does not work with Nvidia
        patches = old.patches ++ [ ./gamescope.patch ];
      });
      obs-studio.package = pkgs.obs-studio.override { cudaSupport = true; };
    };
  };
}
