import XMonad
import XMonad.Util.EZConfig

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.EwmhDesktops
--import XMonad.Util.SpawnOnce (
--    spawnOnce
--  )

-- overwrite parts of the default config, and specify keybindings/remappings
myConfig = def
  { modMask = mod4Mask -- specify super key as mod key
  , terminal = "alacritty"
  }
  `additionalKeysP`
  [ ("M-S-b", spawn "firefox")
  , ("M-l", spawn "dm-tool lock") -- lock the screen with Super + L
  , ("M-p", spawn "dmenu_run")--dmenu to run programs
  , ("<XF86MonBrightnessUp>", spawn "brightnessctl set +10%") --brightness up
  , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 10%-") --brightness down
  , ("<XF86_AudioRaiseVolume>", spawn "amixer set Master 2%+")
  , ("<XF86_AudioLowerVolume>", spawn "amixer set Master 2%-")
  , ("<XF86_AudioMute>", spawn "amixer set Master toggle")
  ]

-- use function composition to wire together xmonad and xmobar, then pass in the configuration
main = xmonad . ewmhFullscreen . ewmh . xmobarProp $ myConfig
