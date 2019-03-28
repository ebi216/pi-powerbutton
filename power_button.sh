#!/bin/bash


pin=3
interval=1
duration=5

echo $pin > /sys/class/gpio/export
echo 'in' > /sys/class/gpio/gpio${pin}/direction 

[[ -r /sys/class/gpio/gpio${pin}/value ]] || { logger -p user.info "[$0] Faild to setup gpio." ; exit 1 ; }

i=0
while [[ $i -lt $duration ]] ;do
	#echo "i=$i"
	[[ $(cat /sys/class/gpio/gpio${pin}/value) -eq 0 ]] && i=$((i+1)) || i=0
	sleep $interval
done

logger -p user.info "[$0] Power button pushed and shutdown now."
shutdown -h now
