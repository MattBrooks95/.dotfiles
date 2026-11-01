-- This is an example Hyprland config file.
-- Refer to the wiki for more information.
-- https://wiki.hyprland.org/Configuring/
-- 
-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

function get_host()
		local handle = io.popen("hostname")
		return handle:read("*a"):gsub("%s+", "")
end

-- import configurations that depend on the computer
local host = get_host()
print(host)
if host == "lemur" then
		require("modules.lemur_laptop")
elseif host == "antec" then
		require("modules.antec_desktop")
else
		print("hyrland.lua failed to determine configuration for machine host")
end

-- Set programs that you use
local TERMINAL     = "kitty"
local FILE_MANAGER = "dolphin"
local MENU         = "wofi --show drun"
local BROWSER      = "firefox"

hl.on("hyprland.start", function()
		hl.exec_cmd("wpaperd")
		-- hl.exec_cmd("waybar") -- right now, I'm still on NixOS and my nix settings enable waybar automatically. Calling this here causes two waybars to show up.
		-- launch fcitx5 in daemon mode https://nixos.wiki/wiki/Fcitx5
		hl.exec_cmd("fcitx5 -d -r")
		-- reload fcitx5 config https://nixos.wiki/wiki/Fcitx5
		hl.exec_cmd("fcitx5-remote -r")
end)

hl.window_rule({
		name = "fcitx5"
		, match = {
				title = "fcitx"
		}
		, pseudo = true
})

-- # See https://wiki.hyprland.org/Configuring/Environment-variables/

hl.env("XCURSOR_SIZE"   , "24")
hl.env("XCURSOR_THEME"  , "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")

-- #####################
-- ### LOOK AND FEEL ###
-- #####################
-- https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.lua

hl.config({
		general = {
				gaps_in = 3
				, gaps_out = 2
				, border_size = 3
				, allow_tearing = false
				, layout = "dwindle" -- should I try 'master'? I need keybindings to switch between more layouts.
				, resize_on_border = false
		}
		, decoration = {
				rounding = 0
				, active_opacity = 1.0
				, inactive_opacity = 1.0
				-- , shadow = {
				-- 		enabled = true
				-- 		, range = 4
				-- 		, render_power = 3
				-- 		, color = 0xee1a1a1a
				-- }
		}
		-- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
		, dwindle = {
				-- pseudotile = true -- Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below -> this table entry doesn't seem to exist anymore
				preserve_split = true -- You probably want this
		}
		-- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
		, master = {
				new_status = "master"
		}
		-- https://wiki.hyprland.org/Configuring/Variables/#misc
		, misc = {
				force_default_wallpaper = 0 -- Set to 0 or 1 to disable the anime mascot wallpapers
				, disable_hyprland_logo = true -- If true disables the random hyprland logo / anime girl background. :(
		}
		, animations = {
				enabled = false
		}
})

-- hl.animation({ enabled = false })

-- ###################
-- ### KEYBINDINGS ###
-- ###################

-- See https://wiki.hyprland.org/Configuring/Keywords/
local MAIN_MOD = "SUPER" -- Sets "Windows" key as main modifier
local SUPER_SHIFT = MAIN_MOD .. " + SHIFT"

-- keybind to lock the screen
hl.bind(MAIN_MOD .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
-- TODO use table.concat for joining strings instead of manually adding '+'
hl.bind(SUPER_SHIFT .. " + RETURN", hl.dsp.exec_cmd(TERMINAL))
hl.bind(SUPER_SHIFT .. " + C", hl.dsp.window.close())
-- TODO I can't seem to use this to switch my laptop keyboard variant back and forth between
-- qwerty and dovrak. It's set to dvorak all the time for now
hl.bind(MAIN_MOD .. " + G", hl.dsp.exec_cmd("hyprctl switchxkblayout current next"))
hl.bind(MAIN_MOD .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(MAIN_MOD .. " + E", hl.dsp.exec_cmd(FILE_MANAGER))
hl.bind(MAIN_MOD .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(MAIN_MOD .. " + P", hl.dsp.exec_cmd(MENU))
hl.bind(MAIN_MOD .. " + Q", hl.dsp.window.pseudo())
hl.bind(MAIN_MOD .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(SUPER_SHIFT .. " + B", hl.dsp.exec_cmd(BROWSER))
hl.bind(SUPER_SHIFT .. " + R", hl.dsp.exec_cmd("systemctl reboot"))

-- Move focus with mainMod + arrow keys
hl.bind(MAIN_MOD .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(MAIN_MOD .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(MAIN_MOD .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(MAIN_MOD .. " + k", hl.dsp.focus({ direction = "up" }))

for i = 1, 10 do
		local key = i % 10 -- 10 maps to key 0
		-- Switch workspaces with mainMod + [0-9]
		hl.bind(MAIN_MOD .. " + " .. key, hl.dsp.focus({ workspace = i }))
		-- Move active window to a workspace with mainMod + SHIFT + [0-9]
		hl.bind(MAIN_MOD .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(MAIN_MOD .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(MAIN_MOD .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(MAIN_MOD .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(MAIN_MOD .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume" , hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+") , { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume" , hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+") , { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume" , hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") , { locked = true, repeating = true })
hl.bind("XF86AudioMute"        , hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") , { locked = true, repeating = true })
hl.bind("XF86AudioMicMute"     , hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") , { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp"  , hl.dsp.exec_cmd("brightnessctl s 10%+") , { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-") , { locked = true, repeating = true })
-- music controls
hl.bind("XF86AudioNext" , hl.dsp.exec_cmd("playerctl next")      , { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay" , hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev" , hl.dsp.exec_cmd("playerctl previous")  , { locked = true })

-- Ignore maximize requests from apps. You'll probably like this.
local suppress_maximize_rule = hl.window_rule({
		name             = "suppress-maximize-events"
		, match          = { class = ".*" }
		, suppress_event = "maximize"
})

suppress_maximize_rule:set_enabled(true)

-- Fix some dragging issues with XWayland
hl.window_rule({
		name = "fix-xwayland-drags"
		, match = {
				class      = "^$"
				, title      = "^$"
				, xwayland   = true
				, float      = true
				, fullscreen = false
				, pin        = false
		}
		, no_focus = true
})
