hl.device({
		name         = "at-translated-set-2-keyboard"
		, kb_layout  = "us"
		, kb_variant = "dvorak"
})

-- https://wiki.hyprland.org/Configuring/Variables/#input
hl.config({
		input = {
				kb_layout = us
				, kb_variant = "dvorak"
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

hl.monitor({
		output     = "eDP-1"
		, mode     = "1920x1080@60"
		, position = "0x0"
		, scale    = 1
		, disabled = false
})
