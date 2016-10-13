#!/bin/bash
NumTest=1
min1=999999
min2=999999

FLAGS=("-Wall -Wextra -lrt" "-fforward-propagate" "-march=armv7-a" "-mfloat-abi=hard" "-mcpu=cortex-a8 -mtune=cortex-a8" "-ftree-vectorize" "-ffast-math" "-fsingle-precision-constant" "-fmodulo-sched" "-fmodulo-sched-allow-regmoves" "-fgcse-las" "-fgcse-after-reload" "-fwhole-program" "-funsafe-math-optimizations" "-freciprocal-math" "-O" "-O1" "-O2" "-O3" )
flagn=0;
minvalues1=()
minvalues2=()
for i in "${FLAGS[@]}"
do
    flagn=$((flagn+1))
    flag=""
    for ((x=0; x<flagn; x++));
    do
        flag=$flag"${FLAGS[x]} "
    done
    echo "$flag"
    make clean all CFLAGS="$flag" #1&>/dev/null
    min1=999999
    min2=999999
    for ((i=0; i<NumTest; i++));
    do
        output=`./alpha.out fore.rgba back.rgba out.rgba`
        count=$((count+1))
        set -- $output
        #echo $count $output ":" $3 $4

        if [ "$4" -lt "$min2" ]
        then
            min2=$4
        fi
        if [ "$3" -lt "$min1" ]
        then
            min1=$3
        fi
    done
    cp ./alpha.out ./output/change_$flagn.out
    cp ./out.rgba ./output/output_$flagn.rgba
    #echo $min1 $min2
    #wc -c alpha.out
    minvalues1+=($min1)
    minvalues2+=($min2)
    echo $min1 $min2
    # or do whatever with individual element of the array
done

for ((i=0; i<flagn; i++));
do
    printf "%s %s %s %s \n" "$i" "${FLAGS[i]}" "${minvalues1[i]}" "${minvalues2[i]}"
done
exit
