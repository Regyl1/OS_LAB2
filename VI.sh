#!/usr/bin/bash

maxPID=-1
maxSize=-1

for pid in $(ps -A o pid)
do
currentSize=$(grep -s "VmSize" "/proc/"$pid"/status" | grep -E -o "[0-9]+")
if [[ $currentSize -gt $maxSize ]]
then
maxPID=$pid
maxSize=$currentSize
fi
done

top -p $maxPID -b -n 1 > "tempVI"

vmSize=$(cat "tempVI" | grep $maxPID | awk '{print $5}')

echo "PID with max VmSize:$maxPID"
echo "MEM in /proc $maxSize"
echo "MEM in top $maxSize"

rm "tempVI"
