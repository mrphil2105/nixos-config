hl.monitor({
	output = "eDP-1",
	mode = "1920x1200",
	position = "0x0",
	scale = 1,
})

for workspace = 1, 10 do
	hl.workspace_rule({
		workspace = tostring(workspace),
		monitor = "eDP-1",
	})
end

hl.on("hyprland.start", function()
	hl.exec_cmd("discord --start-minimized &")
end)

hl.window_rule({
	name = "discord-workspace",
	match = { class = "discord" },
	workspace = 6,
})
