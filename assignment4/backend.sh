#!/bin/sh


while :
do
	START=$(date +%s)
	perl ./ass4.pl
	END=$(date +%s)

	script_time=$(($END-$START))
	sleep_by=$((5 - $script_time))
	echo "==========="
	echo "Script Run time: $script_time"
	echo "==========="
	
	sleep $sleep_by
done
