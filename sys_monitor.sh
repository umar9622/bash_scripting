#!/bin/bash
while true
do
echo "Linux system monitor"
echo "---------------------------"
total_RAM=$(free | grep "Mem" | awk '{print $2}')
used_RAM=$(free | grep "Mem" | awk '{print $3}')
cal_RAM=$(awk "BEGIN {print ($used_RAM / $total_RAM)*100}")
RAM_percent=$(printf "%.0f" "$cal_RAM")

idle_CPU=$(top -bn1 | grep "%Cpu" | awk '{print $8}')
cal_CPU=$(awk "BEGIN {print (100 - $idle_CPU)}")
echo "Time: $(date +"%H:%M:%S")"
echo "CPU used: $cal_CPU%"
echo "RAM used: $RAM_percent%"
sleep 300	
done



