#!/usr/bin/bash
touch friends.txt
touch friendsList.txt
touch result.txt
while read i ; do
	while read j ; do
		while read p ; do
			 while read f ; do
			     echo $(basename ${p}) $(wc -l ${f}|awk '{print $1}') >> friends.txt
				 echo $(basename ${p}) >> friendsList.txt
			 done< <(find $p -type f)
		 done< <(find $j -type d -maxdepth 1 -mindepth 1)
	done< <(find $i -type d -maxdepth 1 -mindepth 1)
done< <(find $1 -type d  -maxdepth 1 -mindepth 1)

#while read i; do
	#   sz=0
	#   while read p; do
	#       if [ $i==$(echo ${p}|awk '{print $1}') ]; then
	#           sz=$((sz+$(echo ${p}|awk '{print $2}')))
	#       fi
	#    done< <(sort friends.txt)
	#    echo ${i} ${sz} >> result.txt
	#    sz=0
#done< <(sort friendsList.txt|uniq)


while read i ; do
	awk '{ if(${i}==${1}) {sum+=${2}} END {print ${i} sum}}' friends.txt >> result.txt
done < <(sort friendsList.txt | uniq)

sort -k 1,1 result.txt | head
