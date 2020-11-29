#!/usr/bin/env bash

# archery.resources.us - Global English resources for archery Arch Linux installer
#
# Copyright (c) 2020, Virgee LLC
#  Author: Ariel de Llano <arieldellano@virgee.com>

# Globals
LANG="en_US.UTF-8"
BACKTITLE="Archery - The Arch Linux Installer"
TERMINAL="$(tty)"
HEIGHT=0
WIDTH=0
CHOICE_HEIGHT=0

# Main menu
MAIN_MENU_TITLE="Main Menu"
MAIN_MENU_BODY="Choose a module:"
EXIT_INSTALLER="Exit installer"

# user message box labels
OK="Ok"
CANCEL="Cancel"
usr_msgbox_default_title=" Installation message "


# abort
usr_msgbox_title_abort=" Installation aborted "
usr_msgbox_body_abort="The installation was aborted (ctrl+c) and your system was not completely installed.\n\nReview the installation log (~/archery.installation.log) for more information."

# confirm quit
usr_msgbox_title_confirm_quit=" Confirm "
usr_msgbox_body_confirm_quit="Please confirm you want to exit the installer"

# no root
usr_msgbox_title_noroot=" Script invocation error "
usr_msgbox_body_noroot="$0 can't continue as it requires root privileges.\n\nPlease use:\n\n    sudo $0"

# not implemented
usr_msg_title_not_implemented=" Oops! "
usr_msg_body_not_implemented="Seems like this option isn't ready yet."

. "$ROOT/usr/share/archery/locale/us/archery.network.resources.us.sh"

