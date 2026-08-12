{ self, ... }: {
  flake.modules.homeManager.cliApps = { pkgs, ... }: {
    imports = with self.modules.homeManager; [
      git
      yazi
      tmux
    ];
    programs.bat.enable = true;
    home.packages = with pkgs; [
      brightnessctl
      btop
      ffmpeg-full
      file
      gptfdisk
      htop
      iftop
      iotop
      jq
      libnotify
      net-tools
      npins
      ouch
      p7zip
      parted
      pciutils
      playerctl
      python3
      rclone
      ripgrep
      tldr
      tree
      unzip
      usbutils
      wiremix
      wl-clipboard
      zip
    ];
  };
}
