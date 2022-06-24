#!/bin/bash
while getopts i: flag
do
    case "${flag}" in
        i) index=${OPTARG}
    esac
done

if [ -z "$index" ]; then
  exit 0
fi

# Extract the window Id
window_id=`wmctrl -l | head -$index | tail +$index | cut -d' ' -f1`

if [ -z $window_id ]; then
    exit 1
fi

# Activate window by id
wmctrl -i -R $window_id

if [ $? -ne 0 ]; then
    exit 1
fi
