#!/usr/bin/bash

ps -A U user o user | grep -c user > test1
ps -A U user o pid,command | grep user | awk '{print $1 ":" $2 }' >> test1
