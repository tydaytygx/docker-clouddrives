#!/bin/bash
export DISPLAY=:1
service dbus status
set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

export LANG=zh_CN.UTF-8

export WINEPREFIX=/config/.wine

VIRT_DESK_RESOLUTION="1920x1080"

exec /usr/bin/wine explorer /desktop=shell,"$VIRT_DESK_RESOLUTION" explorer.exe
#exec /config/lutris-GE-Proton8-26-x86_64/bin/wine  /config/.wine/drive_c/windows/system32
#exec /usr/bin/wine  /config/.wine/drive_c/windows/system32
