make clean
make all
size=`wc -c mandelbrot.out`
set -- $size
NTESTS=20
total=0
mintime=1000000000
printf "test Number\t Test Runtime: Total"
for (( i=1 ; i <= $NTESTS ; i++))
do 
    timeval=`./mandelbrot.out`
    total=$((total+timeval))
    printf "\nTest Run $i :\t$timeval \t$total"
    if [ $timeval -lt $mintime ]
    then
        mintime=$timeval
    fi
done
printf "\nAverage of $NTESTS is: \t$((total/NTESTS))"
printf "\nMinimum of $NTESTS is: \t$mintime"
printf "\nFile size : $1 bytes\n\n"
