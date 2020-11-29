#!/usr/bin/env bash

# lib.archery.module.1.keyboard - keyboard module for archery Arch Linux installer
#
# Copyright (c) 2020, Virgee LLC
#  Author: Ariel de Llano <arieldellano@virgee.com>

. "$ROOT/usr/share/archery/locale/us/archery.keyboard.resources.us.sh"

#
# module logger
kbd_mod_log() {
    [ -n "$1" ] && log "[keyboard]: $1"
}

#
# allow selection of any keymap
set_keyboard_layout_extra() {
    OTHER_KEYMAPS="$(localectl list-keymaps | sed 's/$/ -/g' | sort)"
    KEYMAP="$(dialog \
        --backtitle "$BACKTITLE" \
        --title " $SET_KEYBOARD_LAYOUT_TITLE " \
        --ok-button "$OK" \
        --cancel-button "$CANCEL" \
        --default-item "$KEYMAP" \
        --menu "$SET_KEYBOARD_LAYOUT_BODY" \
        $HEIGHT $WIDTH $CHOICE_HEIGHT \
    $OTHER_KEYMAPS 2>&1 >$TERMINAL)"
}

#
# Ask user for the default keyboard layout
set_keyboard_layout() {
    kbd_mod_log "Current layout set to \"$CURRENT_KEYMAP\""
    kbd_mod_log "Setting keyboard layout"

    while true; do
        KEYMAP = [ -n "$CURRENT_KEYMAP"] && KEYMAP="$CURRENT_KEYMAP" || KEYMAP="us"
        update_keyboard_resources

        j=1

        declare -a keymaps
        declare -a keymap_descriptions

        keymaps=("es" "uk" "us")
        keymap_descriptions=("Español" "English (United Kindom)" "English (United States)")

        declare -a keyboard_layout_options
        keyboard_layout_options=()

        for i in ${!keymaps[@]}; do
            keymap=${keymaps[$i]}
            keymap_description=${keymap_descriptions[$i]}
            keyboard_layout_options+=("$keymap" "$keymap_description")
            (( j++))
        done

        if [[ "$CURRENT_KEYMAP" != "es" && "$CURRENT_KEYMAP" != "uk" && "$CURRENT_KEYMAP" != "us" ]]; then
            keyboard_layout_options+=("$CURRENT_KEYMAP" "-")
        fi

        keyboard_layout_options+=("**" "$VIEW_MORE_KEYMAPS")

        KEYMAP="$(dialog \
            --backtitle "$BACKTITLE" \
            --title " $SET_KEYBOARD_LAYOUT_TITLE " \
            --ok-button "$OK" \
            --cancel-button "$CANCEL" \
            --default-item "$KEYMAP" \
            --menu "$SET_KEYBOARD_LAYOUT_BODY" \
            $HEIGHT $WIDTH $CHOICE_HEIGHT \
        "${keyboard_layout_options[@]}" 2>&1 >$TERMINAL)"

        case "$?" in
            0)

                case "$KEYMAP" in
                    es|uk|us)
                        kbd_mod_log "user selected a keyboard layout ($KEYMAP)"
                        break
                    ;;
                    *)
                        set_keyboard_layout_extra

                        if [ "$?" -eq 0 ]; then
                            kbd_mod_log "user selected a keyboard layout ($KEYMAP)"
                            break
                        fi
                    ;;
                esac
            ;;
            1)
                kbd_mod_log "user cancelled keyboard layout selection"
                break
            ;;
            255)
                kbd_mod_log "user escaped keyboard layout selection"
                break
            ;;
        esac
    done

    if [ -n "$KEYMAP" ]; then
        CURRENT_KEYMAP=$KEYMAP
        update_keyboard_resources

        kbd_mod_log  "executing: [localectl set-keymap $CURRENT_KEYMAP]"
        localectl set-keymap "$CURRENT_KEYMAP"

        kbd_mod_log  "executing: [loadkeys $CURRENT_KEYMAP]"
        loadkeys "$CURRENT_KEYMAP"

        kbd_mod_log  "Keyboard layout set to \"$CURRENT_KEYMAP\""
        user_message_box "$USR_MSG_TITLE_KEYMAP_SET" "$USR_MSG_BODY_KEYMAP_SET"

        MODULE_NAME="boot"
    fi
}

#
# module main function
keyboard_module_main() {
    kbd_mod_log "Module started"

    CURRENT_KEYMAP=$(localectl status | grep Keymap | sed 's/.*:\s\(.*\)$/\1/')
    set_keyboard_layout

    kbd_mod_log "Module ended"
}

#
# gets the module description
keyboard_get_module_description() {
    MODULE_DESCRIPTION="Set the keyboard layout"
}