{ ... }:
{
  flake.nixosModules.gaming = { pkgs, ... }: {
    programs.steam = {
      enable = true;
      extraPackages = [ pkgs.hidapi ];
      extraCompatPackages = [
        pkgs.proton-ge-bin
        pkgs.nur.repos.vladexa.proton-cachyos
      ];
    };
    programs.gamescope.enable = true;
    programs.gamescope.package = pkgs.gamescope.overrideAttrs (old: {
      # Fix blurry output
      NIX_CFLAGS_COMPILE = [ "-fno-fast-math" ];
      # Disable explicit sync because it does not work with Nvidia
      patches = old.patches ++ [ ./gamescope.patch ];
    });
    services.ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };
    services.udev.extraRules = ''
      # LAMZU Maya X - USB and HIDRAW Access (Dongle & Wired)
      SUBSYSTEM=="usb", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001e", MODE="0666", GROUP="input", TAG+="uaccess"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001c", MODE="0666", GROUP="input", TAG+="uaccess"
      KERNEL=="hidraw*", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001e", MODE="0666", GROUP="input", TAG+="uaccess"
      KERNEL=="hidraw*", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001c", MODE="0666", GROUP="input", TAG+="uaccess"
    '';
  };
}
