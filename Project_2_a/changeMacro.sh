#!/bin/bash
NumTest=$1
min1=999999

count=$2
for ((; count >= 0; count--));
do
    make clean all MACROS="-Dmacro=$count" 1&>/dev/null
    min1=999999
    for ((i=0; i<NumTest; i++));
    do
        output=`./alpha.out fore.rgba back.rgba out.rgba`
        set -- $output
        if [ "$3" -lt "$min1" ]
        then
            min1=$3
        fi
    done
    echo $count $min1 $mac
done

exit
