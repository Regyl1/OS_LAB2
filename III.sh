#!/usr/bin/bash

ps -A o pid,start_time --sort=start_time | tail -n 5 | head -n 1 | awk '{print $1}'
