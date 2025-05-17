#!/usr/bin/env bash

LOCKFILE="/tmp/hide-waybar.lock"

bar_off() {
    if [ -f "$LOCKFILE" ]; then
        echo "Lockfile found"
        return
    fi

    touch "$LOCKFILE"
    killall -SIGUSR1 waybar
}

bar_on() {
    if [ ! -f "$LOCKFILE" ]; then
        echo "Lockfile not found"
        return
    fi

    rm -f "$LOCKFILE"
    killall -SIGUSR1 waybar
}

case "$1" in
    off)
        bar_off
        ;;
    on)
        bar_on
        ;;
    *)
        echo "Usage: $0 {on|off}"
        exit 1
        ;;
esac
