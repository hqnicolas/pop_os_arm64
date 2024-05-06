# POP!_OS Arm64 Install Script

This script is for the installation of POP!_OS on top of Ubuntu 22.04 LTS Arm64 Server 

[Original blog post at Devtooler.com](https://www.devtooler.com/how-to-install-custom-pop-os-arm64-image-on-vmware-fusion-macos)

## Freeze Your Kernel
```bash
sudo apt-get install armbian-config
sudo armbian-config
# SYSTEM, # FREEZE, # KERNEL
```
## Install
```bash
wget https://raw.githubusercontent.com/hqnicolas/pop_os_arm64/main/install_pop_os_arm64.sh
sudo chmod 777 install_pop_os_arm64.sh
sudo ./install_pop_os_arm64.sh
```
```bash
wget https://raw.githubusercontent.com/hqnicolas/pop_os_arm64/main/install_wayland_browser.sh
sudo chmod 777 install_wayland_browser.sh
sudo ./install_wayland_browser.sh
```
```bash
wget https://raw.githubusercontent.com/hqnicolas/pop_os_arm64/main/pop_shop.sh
sudo chmod 777 pop_shop.sh
sudo ./pop_shop.sh
```
