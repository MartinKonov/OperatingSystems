[ $# -eq 1 ] || exit 1
#while read p; do
#       name= $(echo $p|cut -d "" -f 1)
#       timestamp=$(echo $p|awk -F "-" '{print $NF}'| cut -d "." -f 1)
#       while read i; do
#    mv $i /extracted/${name}${timestamp}.txt
#    done < <(tar -t $p|grep "meow.txt")
#done < <(find $1 -name ".tgz")
while read p; do
        touch temp.txt
        name=$(echo $p| cut -d "" -f 1)
        timestamp=$(echo $p| awk -F "-" '{print $NF}'|cut -d "." -f 1)
        while read i; do
                filename=$(echo $i| cut -d "  " -f 2)
            hesh=$(echo $i| cut -d "  " -f 1)
                if [ $filename=="meow.txt" ]; then
                        echo ${hesh}"  "/extracted/${name}${timestamp}.txt >> temp.txt
                else
                        echo $i >>temp.txt
                fi
        done< <(cat $p)
        rm ${1}/${p}
        mv temp.txt ${1}/${p}

done< <(find $1 -name ".tgz")
