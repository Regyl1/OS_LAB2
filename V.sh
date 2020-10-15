#!/usr/bin/bash

sum=0
previousPPID=-1
count=0

while read line
do

ppid=$(echo $line | cut -d ":" -f 2 | grep -E -s -o "[0-9]+")
runTime=$(echo $line | cut -d ":" -f 3 | grep -E -s -o "[0-9]+")

if (( previousPPID != -1 && ppid != previousPPID ))
then
echo "Average_Sleeping_children_of_ParentID=$ppid is" $(echo "scale=2; $sum / $count" | bc -l)
sum=0
count=0
fi

sum=$(echo "scale=2; $sum + $runTime" | bc -l)
previousPPID=$ppid
count=$(($count+1))

done < "ansIV" > "ansV"

echo "Average_Sleeping_children_of_ParentID=$previousPPID is" $(echo "scale=2; $sum / $count" | bc -l) >> "ansV"

