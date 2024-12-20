#!/bin/bash

# Use fzf and rofi for interactive fuzzy search
selected_command=$(history | awk '{$1=""; print substr($0,2)}' | sort -u | fzf)

# If the user selects a command, run it
if [ -n "$selected_command" ]; then
    eval "$selected_command"
fi
