# CONFIG
WALLPAPER=$HOME/wallpaper/dark-spaceship-muted.png
STARTUP_SOUND=$HOME/Загрузки/POWERON.mp3
WAIT_TIME=0.7
SOUND_PLAYER=mpv
SET_BAR=true
# MAIN CODE
if command -v feh && [[ -f $WALLPAPER ]]
then
	feh --bg-fill $WALLPAPER
fi &
if command -v $SOUND_PLAYER && [[ -f $STARTUP_SOUND ]]
then
	$SOUND_PLAYER $STARTUP_SOUND
fi &
while $SET_BAR
do
	bash /usr/bin/dwm-files/set_bar.sh $WAIT_TIME
done &
twmnd &
#picom -b --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffnes 500 --corner-radius 15 &
xcompmgr &
dwm
