#!/bin/sh
vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
mute=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo " (muted)" || echo "")
echo "${vol}%${mute}"
