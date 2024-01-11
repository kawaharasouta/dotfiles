date_formatted=$(date "+%Y/%m/%d %H:%M:%S")

energy_full=$(cat /sys/class/power_supply/BAT0/energy_full)
energy_now=$(cat /sys/class/power_supply/BAT0/energy_now)

#energy_percentage=$(echo "scale=2; $ENERGY_NOW / $ENERGY_FULL * 100;" | bc | sed 's/\([0-9].\)\.../\1/g')
energy_percentage=$(echo | awk -v N1=$energy_now -v N2=$energy_full '{print N1 / N2 * 100}' | sed 's/\..*//g')

energy_status=$(cat /sys/class/power_supply/BAT0/status)

echo " 🐧 $energy_percentage%⚡$energy_status 🐧 $date_formatted "
