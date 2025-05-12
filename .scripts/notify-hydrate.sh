#!/usr/bin/env bash

export XDG_RUNTIME_DIR=/run/user/1000
export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus

notify-send -i /dev/null "Time to hydrate! $(date '+%H:%M')"
paplay $HOME/.local/share/kyoruno/sounds/notif-click.mp3
