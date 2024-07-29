#!/bin/bash
set -x
# Simple Script to sync files from local to remote server
# Basically we will have an array and then the base backup path

# Additional `rclone sync` arguments, see `rclone sync --help` for more info
additional_rclone_args="-MP --links --ignore-errors"

__usage() {
    echo "Usage: $0 [restore]"
    exit 1
}

if [ "$#" -gt 1 ]; then
    __usage
fi


# base backup path
base_backup_path="/media/nas/stuff/sync-backup"

# Relative to $HOME
folder_sync=(
    ".config/zed"
    ".config/MusicBrainz"
    ".config/Zelda64Recompiled"
    ".config/sccache"
    ".config/user-tmpfiles.d"
    "Monero"
    ".ssh"
    ".krew"
    
    ".kube"
    ".gnupg"
    "Games"
    "Documents"
    "Pictures"
    "Videos"
    "Desktop"
    "AppImages"
    
)

if [ "$1" == "restore" ]; then
    echo "Restoring files"
fi

# check if path exists
if [ ! -d "$base_backup_path" ]; then
    echo "Backup path does not exist"
    exit 1
fi



rclone_sync() {
    rclone sync $additional_rclone_args $@
}

# should accept 2 args, the folder to sync and the direction to sync
# restore should reverse the direction and default is blank backup
clone_dir() {
    local folder=$1
    local direction=$2

    local source_path="$HOME/$folder"
    local dest_path="$base_backup_path/$folder"

    if [ "$direction" == "restore" ]; then
        rclone_sync "$dest_path" "$source_path"
    else
        rclone_sync "$source_path" "$dest_path"
    fi
}

# loop through the array and sync the folders

main() {
    for folder in "${folder_sync[@]}"; do
        clone_dir "$folder" $@
    done
}

main $@
