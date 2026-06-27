{ ... }:
{
  imports = [
    ./boot.nix
    ./display.nix
    ./networking.nix
    ./locale.nix
    ./sound.nix
    ./auth.nix
    ./users.nix
    ./virtualisation.nix
    ./packages.nix
    ./fonts.nix
    ./obs-studio.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;
  programs.zsh.enable = true;
  programs.zsh.enableGlobalCompInit = false;
  programs.nix-ld.enable = true;
  programs.fuse.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.envfs.enable = true;
  services.udisks2.enable = true;
}
