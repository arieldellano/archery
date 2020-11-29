#!/usr/bin/env bash

# lib.archery.module.keyboard - bootstrap modules for archery Arch Linux installer
#
# Copyright (c) 2020, Virgee LLC
#  Author: Ariel de Llano <arieldellano@virgee.com>

#
# bootstrap modules
init_modules() {
    log "Sourcing installer modules:"
    for module in $MODULES/*.[1-9]*; do
        MODULE_NAME=$(echo ${module} | sed 's/.*\.\(.*\)\.sh/\1/')
        . "${module}"
        log "   ... ${MODULE_NAME}"
    done

    log "Finished sourcing modules"
}

execute_modules() {

    declare -a modules
    modules=()

    for module in $MODULES/*.[1-9]*; do
        MODULE_NAME="$(echo ${module} | sed 's/.*\.\(.*\)\.sh/\1/')"
        ${MODULE_NAME}_get_module_description
        modules+=("$MODULE_NAME" "$MODULE_DESCRIPTION")
    done

    modules+=("exit" "$EXIT_INSTALLER")

    MODULE_NAME="keyboard"

    while true; do
        MODULE_NAME=$(dialog \
            --backtitle "$BACKTITLE" \
            --title " $MAIN_MENU_TITLE " \
            --default-item "$MODULE_NAME" \
            --menu "$MAIN_MENU_BODY" \
            $HEIGHT $WIDTH $CHOICE_HEIGHT \
        "${modules[@]}" 2>&1 >$TERMINAL)

        log "Selection option $MODULE_NAME"
        case $MODULE_NAME in
            exit)
                quit
            ;;
            *)
                ${MODULE_NAME}_module_main
            ;;
        esac
    done
}