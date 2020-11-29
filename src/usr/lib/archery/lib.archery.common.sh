#!/usr/bin/env bash

# lib.archery.common - common library for archery Arch Linux installer
#
# Copyright (c) 2020, Virgee LLC
#  Author: Ariel de Llano <arieldellano@virgee.com>

#
# No operation
nop() {
    sleep 1
}

#
# Reset terminal
reset_terminal() {
    tput reset # reset terminal
    nop
}

# Exit with failure
fail() {
    log "Installation failed to continue"
    exit 1
}

# User decided to quit
quit() {
    log "Installation aborted by user request"
    exit $1
}

# Confirm before quiting
confirm_quit() {
    $DIALOG --title "$usr_msgbox_title_confirm_quit" --clear \
    --yesno "$usr_msgbox_body_confirm_quit" 0 0

    case $? in
        0) quit ;;
        *) ;;
    esac
}

not_implemented() {
    user_message_box "$usr_msg_title_not_implemented" "$usr_msg_body_not_implemented"
}

#
# Test IPv4 connectivity
testIPv4() {
    if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
        true
    else
        false
    fi
}

