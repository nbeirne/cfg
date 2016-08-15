#!/bin/bash

scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png

. $HOME/.config/base16-env/base16-env.sh

i3lock -p default -I 10 -d -e -i /tmp/screen.png -D 0.7 \
  --color-border $base0E \
  --color-bg $base01 \
  --color-verify $base0D \
  --color-wrong $base08 \
  --color-icon $base04 \
# i3lock -e -u -n -i /tmp/screen.png 
