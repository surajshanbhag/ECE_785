#!/bin/bash
NumTest=$1
min1=999999

minvalues1=()
minvalues2=()
make clean all
min1=999999
for ((i=0; i<NumTest; i++));
do
    output=`./alpha.out fore.rgba back.rgba out.rgba`
    count=$((count+1))
    set -- $output
    printf "%d \t" "$3"
    if [ "$3" -lt "$min1" ]
    then
        min1=$3
    fi
done
cp ./alpha.out ./output/change_$flagn.out
cp ./out.rgba ./output/output_$flagn.rgba
size=`wc -c alpha.out`
set -- $size
printf "\n\nminimum value is %d\n" "$min1"
echo "size is :" $1

exit
