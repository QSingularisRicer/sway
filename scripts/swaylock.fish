#!/usr/bin/fish

set -l BG_LOCK_PATH     $HOME/.cache
set -l capture_image    $BG_LOCK_PATH/screen.jpg
set -l lock_image       $BG_LOCK_PATH/lock.png
set -q argv[1]; 
and set -l debug_mode

# Check if tools is installed
command -sq grim; or return 1
command -sq ffmpeg; or return 1

# Capture current screen
set -q debug_mode;      and printf 'Capture current screen\n'
test -e $capture_image; and rm -f $capture_image
grim -t jpeg $capture_image

# Make blur image
set -q debug_mode;      and printf 'Make blur image'
test -e $lock_image;    and rm -f $lock_image
ffmpeg -loglevel error -i $capture_image -vf "[in] gblur=sigma=10 [out]" $lock_image

# Execute swaylock
swaylock \
    --image "$lock_image" \
    --scaling fill \
    --font 'CodeNewRoman Nerd Font Mono' \
    --font-size 40 \
    --text-color ffffff \
    --key-hl-color e4c9af \
    --indicator-idle-visible \
    --indicator-radius 160 \
    --indicator-thickness 30 \
    --separator-color af9c7a \
    --ring-color af9c7a \
    --inside-color bdaeab \
    --ring-ver-color 7dc1c4 \
    --inside-ver-color a8cbcf \
    --ring-wrong-color f06292 \
    --inside-wrong-color e57373
