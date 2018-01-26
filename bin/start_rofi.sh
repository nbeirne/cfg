#!/bin/bash

TERMINAL=urxvt

rofi -combi-modi window,drun,ssh \
     -show combi \
     -modi combi \
     -terminal $TERMINAL \
     -ssh-terminal $TERMINAL
     -separator-style 'none'  \
     #-font 'Fira Mono 30' \
     #-fullscreen -opacity '85' \
     #-lines 5 \
     #-width 100 \
     #-padding 200 \
