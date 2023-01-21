#!/usr/bin/bash

[ $# -ge 1 ] || exit 1


dir=$1


if [ $# -eq 1 ];then
		
	find 2>/dev/null ${dir} -xtype l

else
	
	answer=$(
	while read num name; do
			
		if [ ${num} -ge $2 ];then
			echo "${name}"				
		fi
	
	done < <(ls -l / | awk '{print $2, $9}' | sort -n)
)
	echo "${answer}"	
fi

