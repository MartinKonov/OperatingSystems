#!/usr/bin/bash

[ $# -eq 2 ] || exit 1

txtFile=$2
dir=$1

#[ $(ls -A $dir) ] || exit 2

touch $dir/dict.txt
touch helper.txt

number=0
while read i ; do
	        echo "$i;$number" >> $dir/dict.txt
			touch $dir/$number.txt
			number=$(( number + 1))
		done < <(awk -F ':' '{print $1}' $txtFile | awk '{print $1 " " $2}' | sort | uniq)


index=0

while read i  || [ $index -lt $number ]; do
	grep "$i" $txtFile | awk -F ':' '{print $2}' >> $dir/$index.txt
	index=$((index + 1))
done < <(awk -F ';' '{print $1}' $dir/dict.txt)

