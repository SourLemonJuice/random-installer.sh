#!/usr/bin/env bash

bin_name=test.bin

function RandomPath
{
    rand_line=$(echo $(($RANDOM % 2048 + 1)))
    find ~/.local/share/ -type d | sed -n ${rand_line}'{p;q}'
}

rand_path=$(RandomPath)

while true; do
    rand_path=$(RandomPath)
    if [[ ! -e "$rand_path/$bin_name" ]]; then
        break
    fi
done

echo "Evil file path at here: $rand_path/$bin_name"
# dd if=/dev/random of="${rand_path}"/test.bin bs=1M count=12 oflag=sync status=progress
