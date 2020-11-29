#!/usr/bin/env bash

# lib.archery.common - security library for archery Arch Linux installer
#
# Copyright (c) 2020, Virgee LLC
#  Author: Ariel de Llano <arieldellano@virgee.com>

#
# Check if user is root otherwise displays an error message and exits.
check_user_is_root() {
    log " - checking root privileges..."
    if [ "$(id -u)" -ne 0 ]; then
        user_message_box "$usr_msgbox_title_noroot" "$usr_msgbox_body_noroot"
        reset_terminal
        exit 1
    fi
}
