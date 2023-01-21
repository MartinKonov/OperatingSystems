#!/bin/bash
[ $# -eq 2 ] || exit 1
name=$(basename $2)
version=$(cat $2/version)
tar cvf ${name}.tar $2/tree
xz ${name}.tar
checksum=$(sha256sum ${name}.tar.xz|awk '{print $1}')
occurences=$(grep "${name}-${version}" $1/db|wc -l)
lineChecksum=""
if [ ${occurences} -eq 0 ]; then
        echo ${name}-${version}" "${checksum}>>$1/db
   #sort $1/db > $1/db
else
   line=$(grep "${name}-${version}" $1/db)
   lineChecksum=$(echo ${line}| awk '{print $2}')
  sed "s/${line}/${name}-${version} ${checksum}/" $1/db
  rm $1/packages/${lineChecksum}.tar.xz
fi
mv ${name}.tar.xz $1/packages/${checksum}.tar.xz
