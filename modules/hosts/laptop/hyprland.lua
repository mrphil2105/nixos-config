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
	hl.exec_cmd("vesktop --ozone-platform=wayland --start-minimized &")
end)

hl.window_rule({
	name = "vesktop-workspace",
	match = { class = "vesktop" },
	workspace = 6,
})
