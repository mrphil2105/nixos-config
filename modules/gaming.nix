{ ... }: {
  flake.modules.nixos.gaming = { pkgs, ... }: {
    programs = {
      steam = {
        enable = true;
        extraPackages = [ pkgs.hidapi ];
        extraCompatPackages = [
          pkgs.proton-ge-bin
          pkgs.nur.repos.vladexa.proton-cachyos
        ];
      };
      gamescope.enable = true;
    };
    services = {
      ananicy = {
        enable = true;
        package = pkgs.ananicy-cpp;
        rulesProvider = pkgs.ananicy-rules-cachyos;
      };
      udev.extraRules = ''
        # LAMZU Maya X - USB and HIDRAW Access (Dongle & Wired)
        SUBSYSTEM=="usb", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001e", MODE="0666", GROUP="input", TAG+="uaccess"
        SUBSYSTEM=="usb", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001c", MODE="0666", GROUP="input", TAG+="uaccess"
        KERNEL=="hidraw*", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001e", MODE="0666", GROUP="input", TAG+="uaccess"
        KERNEL=="hidraw*", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001c", MODE="0666", GROUP="input", TAG+="uaccess"
      '';
    };
  };
  flake.modules.homeManager.gaming = { pkgs, ... }: {
    home.packages = with pkgs; [
      prismlauncher
      satisfactorymodmanager
      wootility
    ];
    programs.mangohud = {
      enable = true;
      settings = {
        preset = "1,-1,0,2,3,4";
        font_size = 18;
        hud_no_margin = true;
      };
    };
  };
}
