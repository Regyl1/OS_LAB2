#!/usr/bin/bash

ps a -u user o user | grep -c "user" | awk '{print $1}'> "ansI"
ps a -u user o user,pid,command | grep "user" | awk '{print $2 ":" $3 }' >> "ansI"
