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

hl.config({
		input = {
				kb_layout = us
				, kb_variant = ""
				, kb_model = ""
				, kb_options = ""
				, kb_rules = ""
				, follow_mouse = 1
				, sensitivity = 0 -- 0 = no modification, or range from -1 to 1
				, resolve_binds_by_sym = 1 -- TODO verify type, was an int with 1 being 'true, but LUA has booleans, so it could be a bool now
				, touchpad = {
						natural_scroll = false
				}
		}
})
