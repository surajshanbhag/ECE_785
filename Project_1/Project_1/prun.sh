#!/bin/bash

make clean
perf_3.2 record make
perf_3.2 record ./sg 45 79

size=`wc -c sg`
set -- $size
printf "\nFile size : $1 bytes\n\n"
perf_3.2 report
