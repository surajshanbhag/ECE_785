#!/bin/bash

sample_lattitude=(45 18 22 15)
# 31 32 23 23 45 22 14 15 22 31 13 3 15 40 35 1 1)
sample_longitude=(79 1 45 16)
# 33 1 23 29 38 44 12 29 28 19 7 38 11 1 49 19 19)
rm -f a.txt
FILES=./output/*
for f in $FILES
do
    echo "Processing $f file..."
    echo "Processing $f file...">>a.txt
    for i in {0..3}
    do
        echo .
        $f ${sample_lattitude[i]} ${sample_longitude[i]}>>a.txt
    done
done
