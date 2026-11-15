#!/usr/bin/bash

path="/home/friday/Documents/Projects/Linux/logs"
pattern=("ERROR" "FATAL" "CRITICAL")

echo -e "\n this files modified last 24 hrs"
LOG_FILES=$(find $path -type f -name "*.log" -mtime -1)
echo -e "\n$LOG_FILES"

for files in $LOG_FILES; do
    for msg in ${pattern[@]}; do
        echo -e "\n$msg msg in '$files' file" 
        grep -c "$msg" "$files"  
    done    
done




