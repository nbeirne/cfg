#!/bin/bash
#
# Copyright (C) 2014 Sascha Teske <sascha.teske@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#              



INTERNAL="eDP1"
HDMI="HDMI1"
VGA="VGA1"

PRIMARY=$INTERNAL
SECONDARY=$VGA


PRIMARY=$VGA
SECONDARY=$INTERNAL
NUM_MONS=0

XRANDR="xrandr"
CMD="${XRANDR}"
declare -A VOUTS
eval VOUTS=$(${XRANDR}|awk 'BEGIN {printf("(")} /^\S.*connected/{printf("[%s]=%s ", $1, $2)} END{printf(")")}')
declare -A POS
#XPOS=0
#YPOS=0
#POS="${XPOS}x${YPOS}"
    
POS=([X]=0 [Y]=0)

find_mode() {
  echo $(${XRANDR} |grep ${1} -A1|awk '{FS="[ x]"} /^\s/{printf("WIDTH=%s\nHEIGHT=%s", $4,$5)}')
}

xrandr_params_for() {
  if [ "${2}" == 'connected' ]
  then

    if [ $1 == $HDMI ]
    then
        PRIMARY=$HDMI
        SECONDARY=$INTERNAL
        CMD="${CMD} --primary"
        echo "hdmi connected"
    elif [ $1 == $VGA ]
    then
       # PRIMARY=$INTERNAL
       # SECONDARY=$VGA
        echo "hdmi connected"
    fi

    eval $(find_mode ${1})  #sets ${WIDTH} and ${HEIGHT}
    MODE="${WIDTH}x${HEIGHT}"
    CMD="${CMD} --output ${1} --mode ${MODE} --pos ${POS[X]}x${POS[Y]}"
    POS[X]=$((${POS[X]}+${WIDTH}))


    let NUM_MONS=$NUM_MONS+1
    return 0
  else
    CMD="${CMD} --output ${1} --off"
    return 1
  fi
}

for VOUT in ${!VOUTS[*]}
do
  xrandr_params_for ${VOUT} ${VOUTS[${VOUT}]}
done
set -x
${CMD}
set +x

echo $NUM_MONS


# wallpaper.sh
