#! /bin/bash

[ $# -eq 3 ] || exit 1

pwds=$1
config=$2
dir=$3


while read i ; do
	fileName=$(echo $i | cut -d '/' -f 2| cut -d '.' -f 1)
	count=0
	isDS=0
	isValid=1
	firstError=0
	while read j ; do
		firstChar=$(echo ${j} | cut -c 1)
		asci=$(printf '%d' "'${firstChar}")
		#echo $j
		if [ "${asci}" -eq 0 ]; then
			count=$((count + 1))
			continue
		fi
		#echo ${firstChar}
		if [ ${isDS} -eq 1 ] ; then
			if [ ${asci} -ne 123 ] ; then
				if [ ${firstError} -eq 0 ] ; then
					echo Error in ${fileName}.cfg
					echo 23red
					firstError=1
				fi
				echo Line ${count}: ${j}
				isValid=0
			fi
			isDS=0
		fi

		if [ ${asci} -eq 35 ] ; then
			isDS=1	
		elif [ ${asci} -eq 123 ] ; then
			validBr=$(echo $j | grep "^{ .* };" | wc -c)
			if [ ${validBr} -eq 0 ] ; then
				if [ ${firstError} -eq 0 ]; then
					echo Error in ${fileName}.cfg
					firstError=1
				fi
				isValid=0
				echo Line ${count}: ${j}
			fi
		else
			if [ ${firstError} -eq 0 ]; then
				echo Error in ${fileName}.cfg
				firstError=1
			fi
		#echo $isDS
			#echo 51red
			isValid=0
			echo Line ${count}: ${j}
		fi
		count=$((count + 1))

	done< <(cat $i)

	if [ ${isValid} -eq 1 ]; then
		cat ${i} >> ${config}
		
		exists=$(grep "${fileName}" ${pwds} | wc -c)
		if [ ${exists} -eq 0 ] ; then
			password=$(pwgen 16 1)
			echo ${fileName}:${password} >> ${pwds}
			echo ${fileName} ${password}
		fi
		
	fi
done< <(find ${dir} -type f -name "*.cfg")
