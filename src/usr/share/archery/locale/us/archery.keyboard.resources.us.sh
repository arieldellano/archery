#!/usr/bin/env bash

# archery.keyboard.resources.us - Keyboard related English resources for archery Arch Linux installer
#
# Copyright (c) 2020, Virgee LLC
#  Author: Ariel de Llano <arieldellano@virgee.com>

update_keyboard_resources() {
    VIEW_MORE_KEYMAPS="More layouts"
    SET_KEYBOARD_LAYOUT_TITLE="Set keyboard layout"
    SET_KEYBOARD_LAYOUT_BODY="Select your keyboard layout (the currently selected layout is \"$CURRENT_KEYMAP\"): \n\nIf unsure leave default"

    USR_MSG_TITLE_KEYMAP_SET="Keyboard Layout Set"
    USR_MSG_BODY_KEYMAP_SET="The keyboard layout was set to \"$CURRENT_KEYMAP\""
}

update_keyboard_resources