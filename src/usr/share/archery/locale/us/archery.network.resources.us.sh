#!/usr/bin/env bash

# archery.network.resources.us - Network related English resources for archery Arch Linux installer
#
# Copyright (c) 2020, Virgee LLC
#  Author: Ariel de Llano <arieldellano@virgee.com>

update_network_resources() {
    SELECT_NETWORK_TYPE_TITLE="Select network type"
    SELECT_NETWORK_TYPE_BODY="How do you want to connect to the network?"

    NETWORK_TPYES=("wired" "Wired Network (Ethernet)" "wireless" "Wireless Network (Wi-Fi)")

    USR_MSG_TITLE_VERIFY_ETHERNET_CABLE="Better safe than sorry"
    USR_MSG_BODY_VERIFY_ETHERNET_CABLE="Before continuing, make sure the ethernet cable is securely connected to the \"$ETHERNET_ADAPTER\" ethernet adapter."

    SELECT_ETHERNET_ADAPTER_TITLE="Select ethernet adapter"
    SELECT_ETHERNET_ADAPTER_BODY="Choose the ethernet adapter you want to use to connect to the network"

    SELECT_WIRELESS_ADAPTER_TITLE="Select wireless adapter"
    SELECT_WIRELESS_ADAPTER_BODY="Choose the wireless adapter you want to use to connect to the network"

    USR_MSG_TITLE_WIRELESS_CONNECTION_SUCCESS="You are connected!"
    USR_MSG_BODY_WIRELESS_CONNECTION_SUCCESS="You are now connected to the network using your choosen wireless adapter \"$WIRELESS_ADAPTER\"."

    usr_msgbox_title_network_verification_failed=" Network connection verification failed "
    usr_msgbox_body_network_verification_failed="Network connection could not be verified."

    usr_msgbox_title_select_network_configuration=" Configure your network connection "
    usr_msgbox_body_select_network_configuration="How do you want to configure your ${NETWORK_TYPE} network connection?"

    network_configuration_dhcp_key="dhcp"
    network_configuration_dhcp_description="Get network configuration from a DHCP server"
    network_configuration_static_key="static"
    network_configuration_static_description="Set network configuration manually"
}

update_network_resources