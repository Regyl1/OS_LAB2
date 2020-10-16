#!/usr/bin/bash

for i in $(ps -A o pid,command | awk '{print $1":"$2}')
do
pid=$(echo $i | cut -d ":" -f 1)
cmd=$(echo $i | cut -d ":" -f 2)
pastReadBytes=$(grep -s "read_bytes" "/proc/"$pid"/io" | grep -E -o "[0-9]+")
if [[ -n $pastReadBytes ]]
then
echo "$pid $cmd $pastReadBytes"
fi
done > "tempVII"
sleep 1m
for i in $(ps -A o pid,command | awk '{print $1":"$2}' )
do
pid=$(echo $i | cut -d ":" -f 1)
cmd=$(echo $i | cut -d ":" -f 2)
newReadBytes=$(grep -s "read_bytes" "/proc/"$pid"/io" | grep -E -o "[0-9]+")
pastReadBytes=$(cat "tempVII" | grep "$pid" | awk '{print $3}')
if [[ -n $pastReadBytes && -n $newReadBytes ]]
then
readBytes=$(($newReadBytes - $pastReadBytes))
echo "PID:$pid CMD:$cmd BYTES:$(( $readBytes ))"
fi
done | sort -n -t ':' -k 3 | head -3

rm "tempVII"
