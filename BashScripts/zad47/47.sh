#! /bin/bash

[ $# -eq 1 ] || exit 1

reg="^[A-Z0-9]{1,4}$"

[ $1~=${reg} ] || exit 2

status=$(grep "$1" ./wakeup | awk '{print $3}' | tr -d "\t" | tr -d " " | cut -c 2-)

sed -i "s/\t/==/g" ./wakeup
sed -i "s/ /_/g" ./wakeup
sed -i "s/\*/+/g" ./wakeup
line=$(grep "$1" ./wakeup)
toSwap=""
if [ ${status} == "enabled" ]; then
	toSwap=$(echo ${line} | sed "s/${status}/disabled/")
elif [ ${status} == "disabled" ]; then
	toSwap=$(echo ${line} | sed "s/${status}/enabled/")
else
	exit 3
fi

sed -i "s/${line}/${toSwap}/" ./wakeup
sed -i "s/==/\t/g" ./wakeup
sed -i "s/_/ /g" ./wakeup
sed -i "s/+/\*/g" ./wakeup
