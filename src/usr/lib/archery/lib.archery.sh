#!/usr/bin/env bash

# lib.archery - bootstrap archery libraries
#
# Copyright (c) 2020, Virgee LLC
#  Author: Ariel de Llano <arieldellano@virgee.com>

. "$ROOT/usr/lib/archery/lib.archery.common.sh"
. "$ROOT/usr/lib/archery/lib.archery.log.sh"
. "$ROOT/usr/lib/archery/lib.archery.signal.sh"
. "$ROOT/usr/lib/archery/lib.archery.dialog.sh"
. "$ROOT/usr/lib/archery/lib.archery.security.sh"
. "$ROOT/usr/lib/archery/modules/lib.archery.module.sh"

init() {
    init_modules
}

init