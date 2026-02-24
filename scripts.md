## Find an attached disk

```
MATCH="stefant"
ls -l /dev/disk/by-id/google-* | grep $MATCH
DISK_NAME=$(ls -lt /dev/disk/by-id/google-* | grep $MATCH | head -1 | awk -F'/' '{print $NF}')
echo "DISK_NAME=\"${DISK_NAME}\""
```

## Mount a data disk to a folder

```
MOUNT_PATH="/data1"
sudo mkdir -p $MOUNT_PATH
sudo mount -o discard,defaults /dev/$DISK_NAME $MOUNT_PATH
echo "Mounted $DISK_NAME to $MOUNT_PATH"
```

## Own folder and contents

```
TARGET_FOLDER="/data1"
sudo chmod -R 766 $TARGET_FOLDER
sudo chown -R $(whoami) $TARGET_FOLDER
```

## Make git ignore file owner changes

```
git config core.fileMode false
```
