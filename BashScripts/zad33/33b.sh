#/bin/bash

maxSum=0
maxSumNum=0
while read i ; do
	ifNegat=$(echo $i | sed "s/-//")
	sum=0
	while [ $ifNegat -gt 0 ] ; do
		sum=$(($ifNegat%10 + $sum))
		ifNegat=$((ifNegat/10))
	done
	
	if [ $maxSum -lt $sum ] ; then
		maxSum=$sum
		maxSumNum=$i
	fi
    if [ $maxSumNum -gt $i ] && [ $sum -eq $maxSum ] ; then
        maxSumNum=$i
	fi 

done < <(egrep "^(-|)[0-9]+$" test.txt | sort | uniq)


echo $maxSumNum

