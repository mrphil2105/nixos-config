hl.monitor({
	output = "eDP-1",
	mode = "1920x1200",
	position = "0x0",
	scale = 1,
})

hl.monitor({
	output = "desc:Dell Inc. DELL S2722DC 7C9MHD3",
	mode = "2560x1440",
	position = "-1600x-1440",
	scale = 1,
})

hl.monitor({
	output = "desc:Dell Inc. DELL S2725DC 2XNKPC4",
	mode = "2560x1440",
	position = "960x-1440",
	scale = 1,
})

hl.monitor({
	output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FO32U2P",
	mode = "3840x2160",
	position = "-320x-1440",
	scale = 1.5,
})

local function bindWorkspaces(first, last, monitor)
	for workspace = first, last do
		hl.workspace_rule({
			workspace = tostring(workspace),
			monitor = monitor,
		})
	end
end

bindWorkspaces(1, 10, "eDP-1")
bindWorkspaces(11, 13, "desc:Dell Inc. DELL S2722DC 7C9MHD3")
bindWorkspaces(14, 15, "desc:Dell Inc. DELL S2725DC 2XNKPC4")
bindWorkspaces(11, 15, "desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FO32U2P")

hl.on("hyprland.start", function()
	hl.exec_cmd("slack --startup &")
end)

hl.window_rule({
	name = "slack-workspace",
	match = { class = "slack" },
	workspace = 6,
})
