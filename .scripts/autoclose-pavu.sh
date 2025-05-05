#!/usr/bin/env bash

pavucontrol &
while :
do
    sleep 0.5
    window=$(hyprctl activewindow -j | jq -r '.class')
    if [[ "$window" != "org.pulseaudio.pavucontrol" ]]; then
        killall pavucontrol
        break
    fi
done
