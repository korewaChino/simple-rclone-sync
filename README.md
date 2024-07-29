# A simple Rclone sync script for backing up files.

This script is a simple wrapper for the `rclone` command line tool.
All it does is simply iterate an array of directories inside this script and sync them to a remote location (or vice versa).

## Usage
0. Fork this repository if you're not me.
1. Install `rclone` from [rclone.org](https://rclone.org).
2. Configure `rclone` with `rclone config`. (optional if you already have a config or are simply syncing to a local/mounted directory)
3. Edit the `folder_sync` and `base_backup_path` variables in the script to match your desired directories.
4. Run the script.

```bash
./sync-files.sh
```

Or to restore files from the remote location to the local directory:

```bash
./sync-files.sh restore
```

That's it!

## License

This script is released into the public domain under the [Unlicense](https://unlicense.org).
I think this script is just too simple to be copyrighted, so feel free to do whatever the hell you want with it (including selling it, if you're that desperate, but at that point you should just write your own and make it more robust).

