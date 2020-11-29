#!/usr/bin/env bash

# lib.archery.dialog - dialog library for archery Arch Linux installer
#
# Copyright (c) 2020, Virgee LLC
#  Author: Ariel de Llano <arieldellano@virgee.com>


#
# Displays a dialog with a message and optional title to the user
#
# $1 - message title if body was supplied as $2; otherwise, message body
# $2 - message body (if message title is set)
user_message_box() {
    if [ -z "$2" ]; then
        msg_body="$1"
        msg_title="${usr_msgbox_default_title}"
    else
        msg_title="$1"
        msg_body="$2"
    fi

    HEIGHT=0
    WIDTH=0

    dialog \
           --title " $msg_title " \
           --msgbox "$msg_body" \
           $HEIGHT $WIDTH
}
