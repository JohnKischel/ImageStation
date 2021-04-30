# ImageInstaller

## Description
This script copies an **iso** file **to** an **usb device** when its gets plugged in.
There is **no confirmation** or anything.
This script is intended to quickly image an usb device.

# Preperation

### Step 1
First make the script 10-my.rules in the folder /etc/udev/rules.d available.

```bash
sudo ln -s 10-my.rules /etc/udev/rules.d/
```
or
```bash
sudo cp 10-my.rules /etc/udev/rules.d/
```

This script contains udev rules with following options:
| Trigger       | Description
| ------------- | --------------- |
| ACTION | ON device added |
| SUBSYSTEM | If its a block device |
| RUN | runs the /scripts/installimage.sh |

You can modify this parameters if needed.

### Step 2
Place the iso you like to automatically install in:

/_currentiso_/your.iso