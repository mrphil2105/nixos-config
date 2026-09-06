{ ... }: {
  flake.modules.homeManager.hyprland = { ... }: {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = null;
      portalPackage = null;
      configType = "lua";
      extraLuaFiles."00-common" = ./hyprland.lua;
    };
  };
}
