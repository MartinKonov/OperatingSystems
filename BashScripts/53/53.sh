#! /bin/bash

[ $# -eq 2 ] || exit 1
[ -d $1 ] || exit 2
[[ $2 =~ ^[0-9]{1,2} ]] || exit 3

DIR=$1
PERCENTAGE=$2

yearly=""
monthly=""
weekly=""
daily=""
for i in $(find $DIR -name "*.tar.xz" | sort -d "-" |); do
        formated=$(basename -s .tar.xz $i)
        dateTimeInSec=$(date $(echo $formated | cut -d "-" -f 3) +"%s")
        hostname=$(echo $formated | cut -d "-" -f 1)
        area=$(echo $formated | cut -d "-" -f 2)
        objName="${hostname}-${area}"

        todaysDate=$(date +"%s")
        difference=$(($todaysDate - $dateTimeInSec))
        diffInDays=$(($difference / 86400))
        if [ $diffInDays -ge 365 ];then
                yearly="$yearly $i"
        elif [ $diffInDays -ge 30 ] && [ $diffInDays -le 364 ]; then
                monthly="$monthly $i"
        elif [ $diffInDays -ge 7 ] && [ $diffInDays -le 29 ]; then
                weekly="$weekly $i"
        else
                daily="$daily $i"
        fi
done


while read i ; do
   rm $i
done< <(find -L ${DIR} -type l)

while [ $(df ${DIR} | tail -n 1 | awk '{print $5}' | cut -c1) -gt ${PERCENTAGE} ]; do
	
	if [ ${yearly} != "" ]; then
	
		todel=$(echo ${yearly} | cut -d ' ' -f 1)
		rm ${todel}
		yearly=$(echo ${yearly} | sed "s/${todel}//" | tr -s ' ')
    
	elif [ ${monthly} != "" ]; then

         todel=$(echo ${monthly} | cut -d ' ' -f 1)
         rm ${todel}
         monthly=$(echo ${monthly} | sed "s/${todel}//" | tr -s ' ')
    
	elif [ ${weekly} != "" ]; then
      
	 	todel=$(echo ${weekly} | cut -d ' ' -f 1)
         rm ${todel}
         weekly=$(echo ${weekly} | sed "s/${todel}//")
    
	 elif [ ${daily} != "" ]; then
     
	 	 todel=$(echo ${daily} | cut -d ' ' -f 1)
         rm ${todel}
         daily=$(echo ${daily} | sed "s/${todel}//")
	
	fi

done
