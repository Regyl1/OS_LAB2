#!/usr/bin/bash

lines=$(ps a -u user o user,pid,command)
count=$(echo "$lines" | grep -c "user")

echo $(($count-2)) > "ansI"
echo "$lines" | tail -n $count | head -n $(($count-2)) | awk '{print $2 ":" $3}' >> "ansI"

