#!/usr/bin/env python3

import os
import json
import argparse
import subprocess
from pathlib import Path

LOCKFILE = Path(os.getenv("XDG_RUNTIME_DIR", "/tmp")) / "hypr-hide-clients"

parser = argparse.ArgumentParser(description="hide active clients by changing opacity")
parser.add_argument('--toggle', dest='toggle', action='store_true', help="toggle current windows")
parser.set_defaults(toggle=None)

args = parser.parse_args()

def hide_clients(state: bool):
    """Set window transparency states based on toggle"""
    clients = subprocess.check_output(["hyprctl", "clients", "-j"])
    clients = json.loads(clients)

    state_str = "1" if state else "0"
    dim = "0.9" if state else "0"

    subprocess.run(["hyprctl", "keyword", "decoration:blur:enabled", state_str], check=True)
    subprocess.run(["hyprctl", "keyword", "decoration:dim_special", dim], check=True)

    for window in clients:
        subprocess.run(["hyprctl", "dispatch", "setprop", f'address:{window["address"]}', "alphainactive", state_str, "lock"], check=True)
        subprocess.run(["hyprctl", "dispatch", "setprop", f'address:{window["address"]}', "alpha", state_str, "lock"], check=True)

def main():
    """Main function"""
    if args.toggle:
        if LOCKFILE.exists():
            hide_clients(False)
            LOCKFILE.unlink()
        else:
            hide_clients(True)
            LOCKFILE.touch()
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
