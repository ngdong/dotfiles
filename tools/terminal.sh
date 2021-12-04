#!/bin/bash

# Export terminal profile
# dconf dump /org/gnome/terminal/legacy/profiles:/ > $PWD/configs/terminal.dconf

# Import terminal profile
dconf load /org/gnome/terminal/legacy/profiles:/ < $PWD/configs/terminal.dconf
