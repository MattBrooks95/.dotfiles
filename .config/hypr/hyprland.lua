-- {
--   defaultInputKeyboardVariant ? ""
--   , additionalDevices ? []
--   , monitorsSetup ? "monitor=,preferred,auto,1"
-- }:
--''
-- # THIS FILE WAS CREATED BY hypr_config.nix
-- # You can add options to hypr_config.nix and then conditionally set configurations in this
-- # file. This is to be used with home manager.
-- 
-- # This is an example Hyprland config file.
-- # Refer to the wiki for more information.
-- # https://wiki.hyprland.org/Configuring/
-- 
-- # Please note not all available settings / options are set here.
-- # For a full list, see the wiki
-- 
-- # You can split this configuration into multiple files
-- # Create your files separately and then link them to this file like this:
-- # source = ~/.config/hypr/myColors.conf

function get_host()
		return io.popen("hostname")
end

-- import configurations that depend on the computer
local host = get_host()
if host == "lemur" then
		require("modules.lemur_laptop.lua")
elseif host == "antec" then
		require("modules.lemur_laptop.lua")
else
		print("hyrland.lua failed to determine configuration for machine host")
end


require("modules.cursor.lua")

-- multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioRaiseVolume" , hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume" , hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute"        , hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute"     , hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86MonBrightnessUp"  , hl.dsp.exec_cmd("brightnessctl s 10%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"))
-- music controls
hl.bind("XF86AudioNext" , hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPlay" , hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev" , hl.dsp.exec_cmd("playerctl previous"))

-- Set programs that you use
local terminal = "kitty"
local file_manager = "dolphin"
local menu = "wofi --show drun"
local browser = "firefox"

hl.on("hyprland.start", function()
		hl.exec_cmd("wpaperd")
		hl.exec_cmd("waybar")
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

-- cursor {
--   enable_hyprcursor = false
-- }


-- #####################
-- ### LOOK AND FEEL ###
-- #####################

-- general {
--     gaps_in = 5
--     gaps_out = 0
-- 
--     border_size = 2
-- 
--     # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
--     col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
--     col.inactive_border = rgba(595959aa)
-- 
--     # Set to true enable resizing windows by clicking and dragging on borders and gaps
--     resize_on_border = false
-- 
--     # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
--     allow_tearing = false
-- 
--     layout = dwindle
-- }


-- decoration {
--     rounding = 10
-- 
--     # Change transparency of focused and unfocused windows
--     active_opacity = 1.0
--     inactive_opacity = 1.0
-- 
--     #shadow {
--     #    enabled = true
--     #    range = 4
--     #    render_power = 3
--     #    color = rgba(1a1a1aee)
--     #}
-- 
--     # https://wiki.hyprland.org/Configuring/Variables/#blur
--     blur {
--         enabled = false
--         size = 3
--         passes = 1
-- 
--         vibrancy = 0.1696
--     }
-- }

hl.animation({ enabled = false })

# See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
dwindle {
    pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true # You probably want this
}

# See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
master {
    new_status = master
}

# https://wiki.hyprland.org/Configuring/Variables/#misc
misc {
    force_default_wallpaper = 0 # Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo = true # If true disables the random hyprland logo / anime girl background. :(
}


-- # https://wiki.hyprland.org/Configuring/Variables/#input
-- input {
--     kb_layout = us
--     kb_variant = ${defaultInputKeyboardVariant}
--     kb_model =
--     kb_options =
--     kb_rules =
-- 
--     follow_mouse = 1
-- 
--     sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

-- # to have the keybindings be based on symbol instead of key
-- # this way the voyager keybinds make sense when using it, and the laptop's keybinds
-- # make sense when using it
--     resolve_binds_by_sym = 1
-- 
--     touchpad {
--         natural_scroll = false
--     }
-- }



###################
### KEYBINDINGS ###
###################

# See https://wiki.hyprland.org/Configuring/Keywords/
local main_mod = "SUPER"
$mainMod = SUPER # Sets "Windows" key as main modifier

# keybind to lock the screen
bind = $mainMod, L, exec, hyprlock

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = SUPER_SHIFT, RETURN, exec, $terminal
bind = SUPER_SHIFT, C, killactive,
# TODO I can't seem to use this to switch my laptop keyboard variant back and forth between
# qwerty and dovrak. It's set to dvorak all the time for now
bind = $mainMod, G, exec, hyprctl switchxkblayout current next
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, $fileManager
bind = $mainMod, F, togglefloating,
bind = $mainMod, P, exec, $menu
bind = $mainMod, Q, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle
bind = SUPER_SHIFT, B, exec, $browser
bind = SUPER_SHIFT, R, exec, systemctl reboot

# Move focus with mainMod + arrow keys
bind = $mainMod, h, movefocus, l
bind = $mainMod, l, movefocus, r
bind = $mainMod, j, movefocus, d
bind = $mainMod, k, movefocus, u

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

-- Ignore maximize requests from apps. You'll probably like this.
-- windowrulev2 = suppressevent maximize, class:.*

-- Fix some dragging issues with XWayland
-- windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
