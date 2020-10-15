#!/usr/bin/bash

for pid in $(ps -A o pid)
do

ppid=$(grep -s "PPid" "/proc/"$pid"/status" | grep -E -o "[0-9]+")
sumExecRuntime=$(grep -s "sum_exec_runtime" "/proc/"$pid"/sched" | grep -E -o "[0-9]+(.[0-9]+)?")
nrSwithes=$(grep -s "nr_switches" "/proc/"$pid"/sched" | grep -E -o "[0-9]+")

if [[ -n $nrSwithes ]]
then
art=$(echo "scale=2; $sumExecRuntime / $nrSwithes" | bc -l)
echo "ProcessID=$pid : Parent_ProcessID=$ppid : Average_Running_Time=$art"
fi
done | sort -n -t = -k 3 > "ansIV"

