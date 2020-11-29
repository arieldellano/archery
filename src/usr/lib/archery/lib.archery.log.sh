#!/usr/bin/env bash

# lib.archery.log - logging library for archery Arch Linux installer
#
# Copyright (c) 2020, Virgee LLC
#  Author: Ariel de Llano <arieldellano@virgee.com>

LOG_FILE="$HOME/archery.installation.log"

#
# Log message to log file (see LOG_FILE)
log() {
    [ -n "$1" ] && echo -e "[$(date)]: $1" >> "${LOG_FILE}"
}

# Library exports
export LOG_FILE

#
# Initialize log system
init_log() {
    echo "" > "${LOG_FILE}"

    # # if log file exists, make a backup and create a new one
    # if [ -n "${LOG_FILE}" ]; then
    #     cp ${LOG_FILE} "${LOG_FILE}.bak"
    #     rm ${LOG_FILE}
    # fi
}

init_log