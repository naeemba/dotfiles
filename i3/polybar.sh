killall -q polybar

# Wait for all Polybar instances to be terminated
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Get the list of connected monitors
# monitors=$(xrandr --listmonitors | awk '{print $4}')

# Launch Polybar on each monitor
# for monitor in $monitors; do
#     MONITOR=$monitor polybar --reload example &
# done

if type "xrandr"; then
  for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload top &
    MONITOR=$m polybar --reload bottom &
  done
else
  polybar --reload example &
fi

# Make Caps Lock a Control key
# setxkbmap -option ctrl:nocaps
exec --no-startup-id /usr/bin/setxkbmap -option "ctrl:nocaps"

# xrandr --output DP-0.2 --primary --mode 2560x1440 --pos 1920x0 --rotate left --output DP-0 --off --output DP-1 --mode 1920x1080 --pos 3360x931 --rotate normal --output HDMI-0 --off --output eDP-1-1 --mode 1920x1080 --pos 0x931 --rotate normal
