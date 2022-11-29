# FUNCTIONS
function get_micro_volume() {
	local s=$(amixer get Capture | grep "Front Left:" | tr -s ' ' | cut -d " " -f6)
	local len=$(expr length $s)
	echo ${s:1:$((len-2))}
}
function get_speakers_volume() {
	local s=$(amixer get Master | grep "Front Left: " | tr -s ' ' | cut -d " " -f6)
	#local s=$(amixer get Master | grep "Mono:" | tr -s ' ' | cut -d " " -f5)
	local len=$(expr length $s)
	echo ${s:1:$((len-2))}
}
function get_keyboard_layout() {
	local sd=$(xset -q | sed -rn 's/.*LED mask.*(.)[[:xdigit:]]{3}/\1/p')
	[[ $sd -eq 0 ]] && echo EN || echo RU
}
function get_battery() {
	upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage | tr -s " " | cut -d " " -f3
}
# CONFIG
DISPLAY_DATE=false
DISPLAY_SECONDS=false
DISPLAY_BATTERY=false
DISPLAY_USER=true
EMOJIS=true
#USTAT="Слава України "
# MAIN CODE
KLAYOUT=$(get_keyboard_layout)
SVOLUME=$(get_speakers_volume)
MVOLUME=$(get_micro_volume)
MEM=$(free -h | awk '/^Mem:/ { print $3 "/" $2 }')
$DISPLAY_BATTERY && BPERCENT=$(get_battery)
SSIGN="Speakers:"
MSIGN="Microphone:"
BSIGN="Battery:"
if $DISPLAY_SECONDS
then
	DATETIME=$(date +"%H:%M:%S")
else
	DATETIME=$(date +"%H:%M")
fi
if $EMOJIS
then
	SSIGN="🔊"
	MSIGN="🎙"
	BSIGN="⚡"
fi
$DISPLAY_BATTERY && PBATTERY="[ $BSIGN $BPERCENT ]"
$DISPLAY_DATE && {
	DATETIME+=" "
	DATETIME+=$(date +"%a %d.%m.%y")
}
$DISPLAY_USER && PUSER="[ $(whoami) ]"
DISPLAY_DATA="$USTAT[ $MEM ][ $DATETIME ][ $KLAYOUT ][ $SSIGN $SVOLUME ][ $MSIGN $MVOLUME ]${PBATTERY}${PUSER}"
xsetroot -name "$DISPLAY_DATA"
[[ -n $1 ]] && sleep $1
