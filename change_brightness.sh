#!/usr/bin/bash
current=$(xrandr --verbose | grep Brightness | awk '{ print $2; }')
[[ $1 == "plus" ]] && op="+" || op="-"
result=$(bc -l <<< "scale=1; $current ${op} 0.1")
[[ $result != ".10" ]] && [[ $result != "1.1" ]] && xrandr --output LVDS-1 --brightness $result
