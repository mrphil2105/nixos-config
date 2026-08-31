hl.config({
  input = {
    accel_profile = "flat",
  },
  general = {
    allow_tearing = true,
  },
  misc = {
    vrr = 3,
  },
})

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

hl.monitor({
  output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FO32U2P",
  mode = "3840x2160@240",
  position = "0x0",
  scale = 1.5,
  bitdepth = 10,
  cm = "srgb",
})

for workspace = 1, 10 do
  hl.workspace_rule({
    workspace = tostring(workspace),
    monitor = "HDMI-A-2",
  })
end

hl.on("hyprland.start", function()
  hl.exec_cmd("vesktop --ozone-platform=wayland --start-minimized & steam -silent &")
end)

hl.window_rule({
  name = "vesktop-workspace",
  match = { class = "vesktop" },
  workspace = 6,
})

hl.window_rule({
  name = "steam-workspace",
  match = { class = "steam" },
  workspace = 9,
})

hl.window_rule({
  name = "games",
  match = { class = "^(steam_app_\\d+|gamescope|cs2)$" },
  monitor = "DP-6",
  fullscreen = true,
  workspace = 10,
  content = "game",
})
