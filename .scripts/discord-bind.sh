#!/usr/bin/env bash

if ! pidof Discord > /dev/null; then 
    discord & sleep 1 # Launch if its not running
else
    json=$(hyprctl clients -j)
    discord_client=$(echo "$json" | jq '.[] | select(.class == "discord")')
    discord_wrkspc=$(echo "$discord_client" | jq -r '.workspace.name')

    # Most likely minimized to tray, this should bring it back
    if [ "$discord_client" == "" ]; then
        discord &
    fi

    # Move Disc back to its workspace if elsewhere
    if [ "$discord_wrkspc" != "special:discord" ]; then
        hyprctl dispatch movetoworkspacesilent "special:discord,class:^(discord)$"
    fi
fi

hyprctl dispatch togglespecialworkspace discord
