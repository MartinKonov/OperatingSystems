#!/bin/bash

max=0

while read i ; do
	cur=$(echo $i | grep '-' | wc -c)
	ifNegat=$(echo $i | sed "s/-//")
	if [ $cur -eq 0 ] ; then
		if [ $max -lt $ifNegat ] ; then
			max=$i
		fi
	else
		if [ $max -lt $ifNegat ] ; then
			max=$ifNegat
		fi
	fi
done < <(egrep "^(-|)[0-9]+$" test.txt)

echo $(egrep "^(-|)[0-9]+$" test.txt | egrep "$max" | sort | uniq)
	
