#!/bin/bash
NumTest=$1
min1=999999

minvalues1=()
make clean all
min1=999999
for ((i=0; i<NumTest; i++));
do
    output=`./alpha_time fore.rgba back.rgba out.rgba`
    count=$((count+1))
    set -- $output
    printf "%d \t" "$3"
    if [ "$3" -lt "$min1" ]
    then
        min1=$3
    fi
done

size=`wc -c alpha.out`
set -- $size
printf "\n\nminimum value is %d\n" "$min1"
echo "size is :" $1

exit
