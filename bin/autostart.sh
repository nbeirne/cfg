#!/bin/bash

wallpaper='Lakeside_SunRise_1920x1080.jpg'
xinputd='SynPS/2 Synaptics TouchPad'
xtap='libinput Tapping Enabled'
compton_cmd='compton -r 10 -f -D 2 -G --inactive-dim 0.02'

#(sleep 1 && gnome-keyring-daemon --components=gpg,pkcs11,secrets,ssh) &
#(sleep 1 && gnome-settings-daemon) &

# most visible things first
(sleep 0 && ~/.xmonad/taffybar-wrapper.sh        ) &
(sleep 0 && wallpaper.sh $wallpaper              ) &

# settings and screen config
(sleep 1 && xrdb ~/.Xresources                   ) &
(sleep 1 && screens.sh                           ) &

# keybindings and mouse bindings. Can wait a bit longer.
(sleep 2 && xinput set-prop "$xinputd" "$xtap" 1 ) & # mouse tap-to-click
(sleep 2 && setxkbmap -option ctrl:nocaps        ) & # caps == ctrl

# need to start after taffybar
(sleep 3 && killall nm-applet; nm-applet         ) &

# not too important - used only for rofi.
(sleep 4 && killall compton; $compton_cmd        ) & 

# user apps
(sleep 5 && megasync                             ) &

