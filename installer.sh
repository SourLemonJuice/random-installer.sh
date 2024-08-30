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
# log path
# use to record evil mode's file path
evil_log_path="$HOME/.evil_installer_file_path_list.txt"

# default mode is general
case "$1" in
help | --help | -h)
    echo "Usage: installer.sh [help | --help | -h] <MODE> [<args>]"
    echo "MODE list: general [confirm]; evil [confirm];"
    echo "If the MODE has no 'confirm' argument, it means dry-run"
    ;;
general)
    rand_path="$(RandomPath "$bin_name")"

    if [[ "$2" == "confirm" ]]; then
        echo "Evil file path at here: $rand_path/$bin_name"
        dd if=/dev/random of="$rand_path/$bin_name" bs=1M count="${bin_size}" oflag=sync status=progress
    else
        echo "[dry-run] File; size: $bin_size * 1MiB; path: $rand_path/$bin_name"
    fi
    ;;
evil)
    if [[ -f "$evil_log_path" ]]; then
        echo "The evil mode log file already existed:"
        echo "$evil_log_path"
        exit 1
    fi

    for i in {1..12}; do
        bin_name="$(uuidgen).bin"
        rand_path="$(RandomPath "$bin_name")"
        bin_size=""$(($RANDOM % 512 + 64))

        if [[ "$2" == "confirm" ]]; then
            echo "$rand_path/$bin_name" >> $evil_log_path
            dd if=/dev/random of="$rand_path/$bin_name" bs=1M count="${bin_size}" oflag=sync
        else
            echo "[dry-run] File; number: $i; size: $bin_size * 1MiB; path: $rand_path/$bin_name"
        fi
    done
    ;;
*)
    echo "Mode invalid"
    ;;
esac
