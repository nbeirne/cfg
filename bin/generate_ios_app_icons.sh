#!/bin/bash

# Given a source image, create icons in all sizes needed for an iOS app icon.
# See <https://developer.apple.com/library/ios/qa/qa1686/_index.html> for details.
#
# First (required) argument is path to source file.
#
# Second (optional) argument is the prefix to be used for the output files.
# If not specified, defaults to "app_icon_".
# 
# Third (optional) argument is path to the GraphicsMagick gm executable.
# If not specified, defaults to /usr/local/bin/gm.
#

set -e

if [ -z "$1" ]; then
    echo "usage: make-ios-app-icons filename [output-file-prefix]"
    exit 1
fi

source_file=$1
output_file_prefix=AppIcon_

if [ ! -z "$2" ]
then
  output_file_prefix=$2
fi

generate_size() {
    size=$1
    scale=$2
    output_file_prefix="$3"
    output_file="$output_file_prefix$size@$scale.png"

    resolution=$(bc -l <<< "$size * $scale")
    convert "$source_file" -resize ${resolution}x${resolution}\! "$output_file"
}

# ????
generate_size 20 2  "${output_file_prefix}"
generate_size 20 3  "${output_file_prefix}"

# iPhone and iPad Settings
generate_size 29 2  "${output_file_prefix}"
generate_size 29 3  "${output_file_prefix}"

generate_size 38 2  "${output_file_prefix}"
generate_size 38 3  "${output_file_prefix}"
# iPhone and iPad Spotlight
#generate_size 40 1  "${output_file_prefix}40.png"
generate_size 40 2  "${output_file_prefix}"
generate_size 40 3  "${output_file_prefix}"

# iPhone home screen
generate_size 60 2  "${output_file_prefix}"
generate_size 60 3  "${output_file_prefix}"

generate_size 64 2  "${output_file_prefix}"
generate_size 64 3  "${output_file_prefix}"

generate_size 68 2  "${output_file_prefix}"

# iPad home screen
generate_size 76 2  "${output_file_prefix}"

# iPad Pro home screen
generate_size 83.5 2 "${output_file_prefix}"

# app store
generate_size 1024 1 "${output_file_prefix}"

# TODO: no apple watch. No macos. 

