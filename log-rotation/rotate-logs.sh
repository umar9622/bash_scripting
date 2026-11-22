#!/usr/bin/bash

logs_path="$HOME/Documents/Projects/Linux/bash_scripting/bash-automation/log-rotation/logs"
archives_path="$HOME/Documents/Projects/Linux/bash_scripting/bash-automation/log-rotation/archives"

date=$(date +%F)

echo -e "\n===================================="
echo "------LOG ROTATION & CLEANUP-------"
echo -e "====================================\n"

# STEP 1: Identify old log files

echo "Identifying old logs..."

mapfile -t old_logs < <(find "$logs_path" -type f -name "*.log" -mtime +7)

if (( ${#old_logs[@]} == 0 )); then
    echo "No old log files found."
else

    # STEP 2: Archive old log files

    if tar -czf "$archives_path/old-log-$date.tar.gz" -C "$logs_path" -- "${old_logs[@]##*/}"; then

        echo -e "\nBackup done: old-log-$date.tar.gz"

        # STEP 3: Delete original log files

        if rm -- "${old_logs[@]}"; then
            echo "Original logs were deleted."
        else
            echo "Failed to delete some original logs."
            exit 1
        fi

    else
        echo "Archive creation failed."
        exit 1
    fi
fi

# STEP 4: Delete expired archives

echo -e "\nChecking expired archives..."

mapfile -t expired_archives < <(find "$archives_path" -type f -name "*.tar.gz" -mtime +30)

if (( ${#expired_archives[@]} == 0 )); then
    echo "No expired archives found."
else
    if rm -- "${expired_archives[@]}"; then
        echo "Expired archives deleted:"
        printf '%s\n' "${expired_archives[@]}"
    else
        echo "Failed to delete some expired archives."
        exit 1
    fi
fi

echo -e "\n===================================="
echo "------PROCESS COMPLETED--------"
echo -e "===================================="
