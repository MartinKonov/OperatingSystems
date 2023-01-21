#! /bin/bash


[ $# -eq 2 ] || exit 1

[ $(ls -A $2 | wc -c) -eq 0 ] || exit 2

cp -r "${1}"* "${2}"


while read i; do
	rm $i
done< <(find $2 -name "*.swp")
	


