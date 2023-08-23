#!/bin/sh

if lsof /dev/video0 >/dev/null 2>&1; then
    camera="%{F#f38ba8}    "
else
	camera="%{F#a6e3a1}    "
fi

if pacmd list-sources 2>&1 | grep -q RUNNING; then
    mic="%{F#f38ba8} "
else
	mic="%{F#a6e3a1} "
fi

echo "$camera$mic"
