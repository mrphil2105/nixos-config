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
	render = {
		direct_scanout = 2,
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
		monitor = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FO32U2P",
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

local game_rules = {
	{ class = "^(steam_app_\\d+|gamescope|cs2|tf_linux64)$" },
	{ xdg_tag = "proton-game" },
}

for i, rule in ipairs(game_rules) do
	hl.window_rule({
		name = "games-" .. i,
		match = rule,
		fullscreen = true,
		workspace = 10,
		content = "game",
		immediate = true,
	})
end
