hl.monitor({
		output     = "DP-1",
		, mode     = "1920x1080@144"
		, position = "0x0"
		, scale    = 1
})

h1.monitor({
		output      = "HDMI-A-1"
		, mode      = "1920x1080@60"
		, position  = "1920x-540"
		, scale     = 1
		, transform = 1
})

h1.device({
		name = "zsa-technology-labs-moonlander-mark-i"
		, kb_layout = "us"
		, kb_variant = ""
})
