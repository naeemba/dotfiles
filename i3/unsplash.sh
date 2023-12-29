#!/bin/sh
# unspla.sh - Set your i3 background image to a random unsplash image
# Created by Collin McKinley (collinm.xyz)

# Settings
# RUN_AS_DAEMON=0                           # Run unspla.sh as a daemon if 1, if 0 unspla.sh will set the image then exit
# BACKGROUND_RES="5560x1920"                # Set the size of unsplash images to pull
# PARAMETERS="fruit"                  # Set any other parametes to pull in images. add a comma between parameters ( nature, backgrounds)
# BACKGROUND_COMMAND="feh --bg-fill --no-xinerama"       # The command that will be used to set the background, default is feh.  Image will be supplied after the command.
# IMAGE_SAVE_DIR="/tmp/unsplash/photo.jpg"  # Directory to save the images to
# IMAGE_FORMAT=".jpg"
# IMAGE_DIR="/tmp/unsplash/"

#Do not change unless you need to
# UNSPLASH_URL="https://source.unsplash.com/random/$BACKGROUND_RES/?$PARAMETERS"
# https://source.unsplash.com/random/2560x1440/?fruit

# Daemon Settings (only modify if you are using unspla.sh as a daemon)
# UPDATE_INTERVAL=86400                     # How long to wait before changing the picture (seconds)


# mkdir -p /tmp/unsplash
# MONITORS=$(polybar --list-monitors | cut -d":" -f1)

# if type "xrandr"; then
#   for monitor in $(polybar --list-monitors | cut -d":" -f1); do 
# 	  RESOLUTION=$(polybar --list-monitors | grep $monitor | awk '{print $2}' | cut -f1 -d"+")
# 	  IMAGE="/tmp/unsplash/$monitor$IMAGE_FORMAT"
# 	  UNSPLASH="https://source.unsplash.com/random/${RESOLUTION}/?${PARAMETERS}"
# 	  echo $UNSPLASH $UNSPLASH_URL
# 	  proxychains -q wget --quiet $UNSPLASH -4 -O $IMAGE
# 	  # $BACKGROUND_COMMAND $IMAGE
#   done
# else
# if [ $RUN_AS_DAEMON = 1 ]
# then
#   printf "Launching into background"
#   while :
#   do
#     proxychains -q wget --quiet $UNSPLASH_URL -4 -O $IMAGE_SAVE_DIR
#     $BACKGROUND_COMMAND $IMAGE_SAVE_DIR
#     sleep $UPDATE_INTERVAL
#   done &
# else
#     proxychains -q wget --quiet $UNSPLASH_URL -4 -O $IMAGE_SAVE_DIR
#     $BACKGROUND_COMMAND $IMAGE_SAVE_DIR
# fi

feh --bg-fill --no-fehbg ~/Pictures/1.jpg ~/Pictures/1.jpg ~/Pictures/1.jpg 

sleep 1

setxkbmap -option
setxkbmap -option "ctrl:nocaps"
