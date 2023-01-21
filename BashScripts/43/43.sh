#!/bin/bash
[ $# -gt 0 ]  || exit 0
for i in $@; do
	 [ $(cat $i|head -n 1|grep -c "SOA") -gt 0 ] || exit 1
	count=0
	data=$(date -I|sed "s/-//g" )
	if [ $(cat $i|head -n 1|grep -c "(" ) -eq 0 ];then
		currdata=$(awk '{print $7}' $i)
		if [ ${data} -gt $(awk '{print $7}' $i |rev|cut -c 3-|rev) ];then
			sed -i "s/${currdata}/${data}00/" $i
		else
		    toReplace=$((currdata+1))
		    sed -i "s/${currdata}/${toReplace}/" $i
		fi
	else
	    currdata=$(grep "; serial" $i|cut -d ";" -f 1|tr -d " ")
		if [  ${data} -gt $(echo ${currdata} | rev | cut -c 3- | rev) ]; then
			sed -i "s/${currdata}/${data}00/" $i
		else
		      toReplace=$((currdata+1))
			  sed -i "s/${currdata}/${toReplace}/" $i
	
		fi
	fi
done
