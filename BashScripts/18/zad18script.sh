#!/usr/bin/bash
read first
read second
rows= find /home/students/s45804/vimFiles/sbornik/zad18/files -type f | wc -l
helper= find /home/students/s45804/vimFiles/sbornik/zad18/files -type f
mkdir a b c

for i in /home/students/s45804/vimFiles/sbornik/zad18/files/*
do
	cat $i | wc -l
	
	if [[ "$(cat $i | wc -l)" -lt "$first" ]];
	 then
		#mv $i a
		echo -n $first
		echo -n $numlines
		echo  a
	elif [[ "$(cat $i | wc -l)" -gt $first && "$(cat $i | wc -l)" -lt $second ]];
	then
		#mv $i b
		 echo -n $first
		 echo -n $second
		echo -n $numlines
		echo b
	else
		#mv $i c
		echo -n $first
		echo -n $second
		echo -n $numlines
		echo c
	fi

done
