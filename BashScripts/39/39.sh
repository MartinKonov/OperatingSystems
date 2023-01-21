#! /bin/bash

[ $# -eq 2 ] || exit 1
[ -d $1 ]  || exit 2
mkdir $2
mkdir ${2}/images

while read p ; do
	removeSrc=$(echo ${p} | cut -d '/' -f 2-) 
	cleaned=$(echo ${removeSrc}| tr -s ' '|sed 's/^ //'|sed 's/ $//')
    title=$(echo ${cleaned} | sed -e "s/([a-zA-Z ]*)//g" | cut -d '.' -f 1 | tr -s ' ')
    album=$(echo ${cleaned} | egrep -o "\([a-zA-Z ]*\)" | sed "s/(//g" | sed "s/)//g" | tail -n 1)
	
	if [ $(echo $album | wc -c) -eq 1 ] ; then
		album="misc"
	fi
	
	date=$(stat "${p}" | grep "Modify" | awk '{print $2}')
	hesh=$(sha256sum "${p}" | head -c 16)
	cp "${p}" ${2}/images/${hesh}.jpg
	mkdir -p ${2}/by-date/${date}/by-album/"${album}"/by-title
	ln -s ${2}/images/${hesh}.jpg ${2}/by-date/${date}/by-album/"${album}"/by-title/"${title}".jpg
done< <(find $1 -name "*.jpg")


