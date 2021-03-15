sh ./monitors.sh

killall -q polybar

# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload bottom &
    MONITOR=$m polybar --reload top &
done

# xrandr --output DP-0.2 --primary --mode 2560x1440 --pos 1920x0 --rotate left --output DP-0 --off --output DP-1 --mode 1920x1080 --pos 3360x931 --rotate normal --output HDMI-0 --off --output eDP-1-1 --mode 1920x1080 --pos 0x931 --rotate normal
