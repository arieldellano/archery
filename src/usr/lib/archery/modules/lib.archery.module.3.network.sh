#!/usr/bin/env bash

# lib.archery.module.3.network - network module for archery Arch Linux installer
#
# Copyright (c) 2020, Virgee LLC
#  Author: Ariel de Llano <arieldellano@virgee.com>

NETWORK_VERIFIED=false

#
# module logger
network_mod_log() {
    [ -n "$1" ] && log "[network]$2: $1"
}

#
# Select wired or wireless network
select_network_type() {
    network_mod_log "Selecting network type (wired or wireless)"

    NETWORK_TYPE="wired"

    while true; do
        NETWORK_TYPE="$(dialog \
            --backtitle "$BACKTITLE" \
            --title " $SELECT_NETWORK_TYPE_TITLE " \
            --ok-button "$OK" \
            --cancel-button "$CANCEL" \
            --default-item "$NETWORK_TYPE" \
            --menu "$SELECT_NETWORK_TYPE_BODY" \
            $HEIGHT $WIDTH $CHOICE_HEIGHT \
        "${NETWORK_TPYES[@]}" 2>&1 >$TERMINAL)"

        case "$?" in
            0)
                network_mod_log "Network type set to \"${NETWORK_TYPE}\""
                update_network_resources

                case $NETWORK_TYPE in
                    wired)
                        select_wired_adapter
                    ;;
                    wireless)
                        select_wireless_adapter
                    ;;
                esac

                if [[ -n "$ETHERNET_ADAPTER" || -n "$WIRELESS_ADAPTER" ]]; then
                    break
                fi

            ;;
            1)
                network_mod_log "user cancelled network type selection"
                break
            ;;
            255)
                network_mod_log "user escaped network type selection"
                break
            ;;
        esac
    done
}

select_wired_adapter() {
    # pick network adapter
    ETHERNET_ADAPTER=
    ETHERNET_ADAPTERS=$(ip link | awk -F': ' '$0 !~ "lo|vir|wl|^[^0-9]"{print $2;getline}' | sed 's/$/ -/g' | sort)

    ETHERNET_ADAPTER="$(dialog \
        --backtitle "$BACKTITLE" \
        --title " $SELECT_ETHERNET_ADAPTER_TITLE " \
        --ok-button "$OK" \
        --cancel-button "$CANCEL" \
        --default-item "$ETHERNET_ADAPTER" \
        --menu "$SELECT_ETHERNET_ADAPTER_BODY" \
        $HEIGHT $WIDTH $CHOICE_HEIGHT \
    $ETHERNET_ADAPTERS 2>&1 >$TERMINAL)"

    case "$?" in
        0)
            network_mod_log "User selected an ethernet adapter ($ETHERNET_ADAPTER)" "[$NETWORK_TYPE]"
            network_mod_log "Asking user to verify the ethernet cable is connected" "[$NETWORK_TYPE]"

            update_network_resources

            user_message_box "$USR_MSG_TITLE_VERIFY_ETHERNET_CABLE" "$USR_MSG_BODY_VERIFY_ETHERNET_CABLE"
        ;;
        1)
            network_mod_log "user cancelled ethernet adapter selection"
        ;;
        255)
            network_mod_log "user escaped ethernet adapter selection"
        ;;
    esac
}

select_wireless_adapter() {
    # pick network adapter
    WIRELESS_ADAPTER=
    # TODO: write script to get wireless adapters only
    WIRELESS_ADAPTERS=$(ip link |  | sed 's/$/ -/g' | sort)

    WIRELESS_ADAPTER="$(dialog \
        --backtitle "$BACKTITLE" \
        --title " $SELECT_WIRELESS_ADAPTER_TITLE " \
        --ok-button "$OK" \
        --cancel-button "$CANCEL" \
        --default-item "$WIRELESS_ADAPTER" \
        --menu "$SELECT_WIRELESS_ADAPTER_BODY" \
        $HEIGHT $WIDTH $CHOICE_HEIGHT \
    $WIRELESS_ADAPTERS 2>&1 >$TERMINAL)"

    network_mod_log "User selected a wireless adapter ($WIRELESS_ADAPTER)" "[$NETWORK_TYPE]"

    # case "$?" in
    #     0)
    #         network_mod_log "User selected a wireless adapter ($WIRELESS_ADAPTER)" "[$NETWORK_TYPE]"
    #         update_network_resources

    #         # make sure the wireless card is not blocked with rfkill.
    #         # authenticate to the wireless network using iwctl.
    #         #

    #         user_message_box "$USR_MSG_TITLE_VERIFY_ETHERNET_CABLE" "$USR_MSG_BODY_VERIFY_ETHERNET_CABLE"
    #     ;;
    #     1)
    #         network_mod_log "user cancelled ethernet adapter selection"
    #     ;;
    #     255)
    #         network_mod_log "user escaped ethernet adapter selection"
    #     ;;
    # esac
}

# # Configure your network connection
# configure_network_connection() {
#     network_mod_log "Configuring network connection" "[$NETWORK_TYPE]"

#     network_configuration="$(dialog --title "${usr_msgbox_title_select_network_configuration}" --ok-button "${OK}" --menu "${usr_msgbox_body_select_network_configuration}" 0 0 0 "$network_configuration_dhcp_key" "$network_configuration_dhcp_description" "$network_configuration_static_key" "$network_configuration_static_description" 3>&1 1>&2 2>&3)"
#     not_implemented
#     # DHCP: dynamic IP address and DNS server assignment (provided by systemd-networkd and systemd-resolved) should work out of the box for wired and wireless network interfaces.
#     # Static IP address: follow Network configuration#Static IP address.
# }

# verify_network_connection() {
#     network_mod_log "Verifying network connection" "[$network_type]"
#     if [ testIPv4 ]; then
#         NETWORK_VERIFIED=true
#         network_mod_log "Network connection verification succeeded" "[$network_type]"
#     else
#         NETWORK_VERIFIED=false
#         network_mod_log "Network connection verification failed" "[$network_type]"
#         user_message_box "$usr_msgbox_title_network_verification_failed" "$usr_msgbox_body_network_verification_failed"
#         fail
#     fi
# }

#
# module main function
network_module_main() {
    network_mod_log "Module started"

    select_network_type

    network_mod_log "Network verified: ${NETWORK_VERIFIED}"
    network_mod_log "Module ended"
}

#
# gets the module description
network_get_module_description() {
    MODULE_DESCRIPTION="Connect to the internet"
}