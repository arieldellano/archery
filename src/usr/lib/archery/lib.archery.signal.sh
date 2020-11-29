#!/usr/bin/env bash

# lib.archery.signal - signal handling library for archery Arch Linux installer
#
# Copyright (c) 2020, Virgee LLC
#  Author: Ariel de Llano <arieldellano@virgee.com>

#
# SIGINT handler
#
# Abort installer
abort() {
    user_message_box "${usr_msgbox_title_abort}" "${usr_msgbox_body_abort}"
    log "Installation aborted by user request"
    quit 1
}

#
# Clean up installation
cleanup() {
    log " - cleaning up..."
    reset_terminal

    log "Arch Linux installation completed!"
}

#
# Wire-up signal handlers
setup_signals() {
    log " - setting up signal handlers..."
    trap abort SIGINT
    trap cleanup EXIT
}