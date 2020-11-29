#!/usr/bin/env bash

# archery - Main Arch Linux installer script
#
# Copyright (c) 2020, Virgee LLC
#  Author: Ariel de Llano <arieldellano@virgee.com>

DIALOG=${DIALOG=dialog}
ROOT="/home/ariel/Development/github.com/arieldellano/archery/src"
MODULES="$ROOT/usr/lib/archery/modules"

. "$ROOT/usr/share/archery/locale/us/archery.resources.us.sh"
. "$ROOT/usr/lib/archery/lib.archery.sh"

main() {

    log "Starting Arch Linux installation"

    # Check if user is root otherwise displays an error message and exits.
    check_user_is_root

    # Wire-up signal handlers
    setup_signals

    # Execute modules
    execute_modules
}

main