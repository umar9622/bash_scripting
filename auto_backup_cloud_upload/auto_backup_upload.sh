#!/usr/bin/bash

echo -e "\n========================================="
echo "-----Auto backup and cloud upload-----"
echo -e "=========================================\n"

path_dir="$HOME/Downloads/wallpaper"
backup_path="$HOME/Documents/Projects"
date=$(date +"%F_%H-%M-%S")
mkdir -p "$backup_path/backups"

if tar -czf "${backup_path}/backups/${date}.tar.gz" -C "$(dirname "$path_dir")" "$(basename "$path_dir")"; then

    if [[ -f "${backup_path}/backups/${date}.tar.gz" ]]; then
        echo -e "\nBackup success."
    else
        echo -e "\nFile not created."
        exit 1
    fi

else
    echo -e "\nBackup failure."
    exit 1
fi

echo -e "\n-----uploading to AWS-----"

if aws s3 cp "${backup_path}/backups/${date}.tar.gz" s3://umar-devops-backups/ \
    --profile floci \
    --endpoint-url http://localhost:4566; then

    echo -e "\nUploaded successfully."
    notify-send "Backup Completed" "Backup uploaded successfully to umar-devops-backups."
    
else
    echo -e "\nFailed to upload."
    exit 1
fi
