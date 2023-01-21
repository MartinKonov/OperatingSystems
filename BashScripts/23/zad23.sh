#!/usr/bin/bash

toSort=$(
while read Name Path; do
	find 2</dev/null ${Path} -type f -printf "${Name} %T@, %p \n"

done < <(awk -F ":" '{print $1, $6}' /etc/passwd)
)

echo "${toSort}" | sort -k 1,1 | head -n 1
