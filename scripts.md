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
(
set -eu
echo "${DISK_NAME:?DISK_NAME is not set}"

sudo mkdir -p $MOUNT_PATH
sudo mount -o discard,defaults /dev/$DISK_NAME $MOUNT_PATH
echo "Mounted $DISK_NAME to $MOUNT_PATH"
)
```

## Add fstab entry for a data disk

```
(
set -eu
echo "${DISK_NAME:?DISK_NAME is not set}"
echo "${MOUNT_PATH:?MOUNT_PATH is not set}"

UUID=$(sudo blkid -s UUID -o value /dev/$DISK_NAME)
if ! grep -q "UUID=$UUID" /etc/fstab; then
  echo "UUID=$UUID $MOUNT_PATH ext4 discard,defaults,nofail 0 2" | sudo tee -a /etc/fstab
fi
grep "$UUID" /etc/fstab
)
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

## Search for process

```
MATCH="pid"
ps -efj | { head -1; grep "$MATCH"; }
```

## Fix all ruff issues

```
uv run ruff format
uv run ruff check --fix
```

## Pre PR review checks

```
(
set -e
uv run ruff format
uv run ruff check --fix
uv run pytest
uv run pyright
)
```

