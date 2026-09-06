local terminal = "ghostty"
local file_manager = "ghostty --title=Yazi -e yazi"
local audio_mixer = "ghostty --title=wiremix -e wiremix --tab output"
local menu = "walker"
local browser = "firefox"
local lock_screen = "hyprlock"
local main_mod = "SUPER"

hl.config({
	general = {
		layout = "master",
		gaps_in = 2,
		gaps_out = 4,
		border_size = 1,
		col = {
			active_border = {
				colors = { "rgba(007799ee)", "rgba(007744ee)" },
				angle = 45,
			},
			inactive_border = "rgba(595959aa)",
		},
	},
	decoration = {
		rounding = 4,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = false,
		},
	},
	xwayland = {
		force_zero_scaling = true,
	},
	animations = {
		enabled = false,
	},
	dwindle = {
		preserve_split = true,
	},
	input = {
		kb_layout = "us,dk",
		kb_options = "caps:escape,grp:win_space_toggle",
	},
	misc = {
		force_default_wallpaper = 1,
		enable_anr_dialog = false,
	},
})

hl.env("XCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_SIZE", "32")

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprctl setcursor capitaine-cursors 32")
	hl.exec_cmd("ghostty --title='Ghostty Primary' -e tmux &")
	hl.exec_cmd("waybar & ferdium & firefox &")
end)

hl.bind(main_mod .. " + C", hl.dsp.window.close())
hl.bind(main_mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))

hl.bind(main_mod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(main_mod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. " + A", hl.dsp.exec_cmd(audio_mixer))
hl.bind(main_mod .. " + Escape", hl.dsp.exec_cmd(lock_screen))

hl.bind(main_mod .. " + S", hl.dsp.layout("swapwithmaster"))
hl.bind(main_mod .. " + N", hl.dsp.layout("cyclenext"))
hl.bind(main_mod .. " + P", hl.dsp.layout("cycleprev"))
hl.bind(main_mod .. " + SHIFT + N", hl.dsp.layout("swapnext"))
hl.bind(main_mod .. " + SHIFT + P", hl.dsp.layout("swapprev"))
hl.bind(main_mod .. " + S", hl.dsp.layout("togglesplit"))

hl.bind(main_mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(main_mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(main_mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(main_mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(main_mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

local extra_workspace_keys = {
	T = 11,
	Y = 12,
	U = 13,
	I = 14,
	O = 15,
}

for key, workspace in pairs(extra_workspace_keys) do
	hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
	hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(main_mod .. " + W", hl.dsp.workspace.toggle_special("magic"))
hl.bind(main_mod .. " + SHIFT + W", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output --clipboard-only"))
hl.bind(main_mod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only"))
hl.bind(main_mod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind("CONTROL + PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(main_mod .. " + CONTROL + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(main_mod .. " + SHIFT + CONTROL + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

hl.bind(main_mod .. " + CONTROL + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(main_mod .. " + CONTROL + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(main_mod .. " + CONTROL + K", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(main_mod .. " + CONTROL + J", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })

hl.bind(main_mod .. " + mouse:272", hl.dsp.window.resize(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.drag(), { mouse = true })

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("hyprlock"), { locked = true })
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd('hyprctl keyword monitor "eDP-1, disable"'), { locked = true })
hl.bind(
	"switch:off:Lid Switch",
	hl.dsp.exec_cmd('hyprctl keyword monitor "eDP-1, 1920x1200, 0x0, 1"'),
	{ locked = true }
)

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

local workspace_rules = {
	{ match = { title = "Ghostty Primary" }, workspace = 1 },
	{ match = { class = "firefox" }, workspace = 3 },
	{ match = { title = "Yazi" }, workspace = 4 },
	{ match = { class = "Ferdium" }, workspace = 5 },
	{ match = { class = "Spotify" }, workspace = 7 },
	{ match = { class = "bitwarden" }, workspace = 7 },
}

for i, rule in ipairs(workspace_rules) do
	hl.window_rule({
		name = "default-workspace-" .. i,
		match = rule.match,
		workspace = rule.workspace,
	})
end
