#! /bin/bash
[ $# -eq 2 ] || exit 1

input=$1
output=$2

arrN=0

while read i ; do
	toAdd=$(echo $i | awk '{print NF}')
	arrN=$((arrN + ${toAdd}))	
done< <(hexdump ${input} | cut -d ' ' -f 2- | head -n -1)


echo uint32_t arrN = ${arrN}\; >> $output
echo uint16_t arr[${arrN}] = { >> $output

while read i ; do
	count=1
	while [ $count -le 8 ] ; do
		raw=$(echo $i | cut -d ' ' -f ${count})
		toDec=$(echo "obase=10; ibase=16; ${raw}" | bc)
		echo ${toDec}, >> $output
		count=$((count + 1))	
	done
	
done< <(hexdump $input | cut -d ' ' -f 2- | head -n -1)



echo } >> $output

