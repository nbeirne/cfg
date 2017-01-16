#!/bin/bash

TERMINAL=urxvt

rofi -combi-modi window,drun,ssh \
     -show combi \
     -modi combi \
     -lines 5 \
     -width 100 \
     -padding 200 \
     -fullscreen -opacity '85' \
     -font 'Fira Mono 30' \
     -separator-style 'none'  \
     -terminal $TERMINAL \
     -ssh-terminal $TERMINAL

