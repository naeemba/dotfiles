# beamer.sh: sets Linux display for doing a presentation, 
#  for bumblebee configured on a laptop that has the HDMI
#  plugged on the NVidia board.
#
# Bruno Levy, Wed Jan 24 08:45:45 CET 2018
#
# Usage: 
#    beamer.sh widthxheight
#    (default is 1024x768)


# Note: output1 and output2 are hardcoded below,
#  change according to your configuration.
output1=eDP1
output2=VIRTUAL1

# Note: I think that the following command should have done
# the job, but it does not work. 
#    xrandr --output eDP1 --size 1024x768 --output VIRTUAL1 --size 1024x768 --same-as eDP1
# My guess: --size is not implemented with VIRTUAL devices.
# Thus I try to find a --mode that fits my needs in the list of supported modes.

wxh=$1

if [ -z "$wxh" ]; then
  wxh=1024x768
fi

# Test whether intel-virtual-output is running and start it.
ivo_process=`ps axu |grep 'intel-virtual-output' |egrep -v 'grep'`
if [ -z "$ivo_process" ]; then
   intel-virtual-output
   sleep 3
fi

# Mode names on the primary output are simply wxh (at least on
#  my configuration...)
output1_mode=$wxh

echo Using mode for $output1: $output1_mode

# Mode names on the virtual output are like: VIRTUAL1.ID-wxh
# Try to find one in the list that matches what we want.
output2_mode=`xrandr |grep $output2\\\. |grep $wxh |awk '{print $1}'`
# There can be several modes, take the first one.
output2_mode=`echo $output2_mode |awk '{print $1}'` 

echo Using mode for $output2: $output2_mode

# Showtime !
xrandr --output $output1 --mode $output1_mode --output $output2 --mode $output2_mode --same-as $output1
