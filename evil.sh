#!/usr/bin/env bash

# generate a random file path dose not exist
# parameter $1 is the file name e.g. /random/path/$1
#
# return 1 is error; 0 is OK
function RandomPath
{
    local rand_line=$(echo $(($RANDOM % 1024 * 18 + 1)))
    local rand_path=$(find ~/.local/share/ -type d | sed -n ${rand_line}'{p;q}')

    while true; do
        if [[ ! -e "$rand_path/$1" ]]; then
            break
        fi
    done

    echo "$rand_path"
}

# default file name
bin_name="Evil_Installer_Test_File_8868f8c0-f08a-432c-8a6e-9bddc2b5ea35.bin"
# default file size
# the bs= of dd used in this script is 1M(means 1 MiB)
bin_size="16"

# default mode is general
case "$1" in
dry-run)
    rand_path="$(RandomPath "$bin_name")"

    echo "Evil file path at here: $rand_path/$bin_name"
    ;;
general)
    rand_path="$(RandomPath "$bin_name")"

    echo "Evil file path at here: $rand_path/$bin_name"
    dd if=/dev/random of="$rand_path/$bin_name" bs=1M count="${bin_size}" oflag=sync status=progress
    ;;
evil)
    for i in {1..12}; do
        bin_name="$(uuidgen).bin"
        rand_path="$(RandomPath "$bin_name")"
        bin_size=""$(($RANDOM % 512 + 64))

        if [[ "$2" == "confirm" ]]; then
            # dd if=/dev/random of="$rand_path/$bin_name" bs=1M count="${bin_size}" oflag=sync
            :
        else
            echo "[dry-run] File; number: $i; size: $bin_size * 1MiB; path: $rand_path/$bin_name"
        fi
    done
    ;;
*)
    echo "Mode invalid"
    ;;
esac
