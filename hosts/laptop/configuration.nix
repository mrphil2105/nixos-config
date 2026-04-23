{ ... }:
{
  imports = [
    ./hardware.nix
    ../../system
  ];
  networking.hostName = "mrphil2105-NixLaptop";
  services.power-profiles-daemon.enable = true;
  services.openvpn.servers.router.config = "config /home/mrphil2105/.openvpn/router.ovpn";
  services.openvpn.servers.router.autoStart = false;
  services.tailscale.enable = true;
  # https://kisonecat.com/blog/eduroam-openssl-wpa-supplicant/
  nixpkgs.config.packageOverrides = pkgs: {
    wpa_supplicant = pkgs.wpa_supplicant.overrideAttrs (attrs: {
      patches = attrs.patches ++ [ ./eduroam.patch ];
    });
  };
  system.stateVersion = "25.11";
}
