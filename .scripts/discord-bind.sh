#!/usr/bin/env bash

# Workaround for OpenAsar logs being generated at home dir
# https://github.com/GooseMod/OpenAsar/issues/202
# export DISCORD_USER_DATA_DIR=$HOME/.config/discord

# Force XWayland because of flickering :(
# export ELECTRON_OZONE_PLATFORM_HINT=x11

###################################################################################

if ! ps aux | grep -v grep | grep vesktop > /dev/null; then 
    vesktop & sleep 2 # Launch if its not running
else
    json=$(hyprctl clients -j)
    discord_client=$(echo "$json" | jq '.[] | select(.class == "vesktop")')
    discord_wrkspc=$(echo "$discord_client" | jq -r '.workspace.name')

    # Most likely minimized to tray, this should bring it back
    if [ "$discord_client" == "" ]; then
        vesktop &
    fi

    # Move Disc back to its workspace if elsewhere
    if [ "$discord_wrkspc" != "special:discord" ]; then
        hyprctl dispatch movetoworkspacesilent "special:discord,class:^(vesktop)$"
    fi
fi

hyprctl dispatch togglespecialworkspace discord
