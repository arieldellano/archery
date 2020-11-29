#!/usr/bin/env bash

# lib.archery.module.2.boot - boot module for archery Arch Linux installer
#
# Copyright (c) 2020, Virgee LLC
#  Author: Ariel de Llano <arieldellano@virgee.com>

BOOT_MODE="BIOS"
. "$ROOT/usr/share/archery/locale/us/archery.boot.resources.us.sh"

#
# module logger
boot_mod_log() {
    [ -n "$1" ] && log "[boot]: $1"
}

#
# If the command shows the directory without error, then the system is booted in UEFI mode.
verify_boot_mode() {
    boot_mod_log "Verifying boot mode"
    ls /sys/firmware/efi/efivars && BOOT_MODE="UEFI"
    boot_mod_log "Boot mode is ${BOOT_MODE}"

    update_boot_resources

    user_message_box "${user_msg_title_boot_verification}" "$user_msg_body_boot_verification"
    MODULE_NAME="network"
}

#
# module main function
boot_module_main() {
    boot_mod_log "Module started"
    verify_boot_mode
    boot_mod_log "Module ended"

    # Module exports
    export BOOT_MODE
}

#
# gets the module description
boot_get_module_description() {
    MODULE_DESCRIPTION="Verify the boot mode"
}