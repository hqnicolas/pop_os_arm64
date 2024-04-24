#!/bin/bash
sudo add-apt-repository ppa:liujianfeng1994/panfork-mesa
sudo add-apt-repository ppa:liujianfeng1994/rockchip-multimedia
sudo apt update
sudo apt dist-upgrade
sudo apt install mali-g610-firmware rockchip-multimedia-config
sudo apt install libv4l-rkmpp
sudo apt install v4l-utils
sudo apt install ffmpeg

env MOZ_ENABLE_WAYLAND=1 /snap/bin/firefox
export MOZ_ENABLE_WAYLAND=1

# sudo nano /etc/rc.local
# Copy and paste below, above the "exit o" line.
# echo dec > /dev/video-dec0
# chown root:video /dev/video-dec0
# chmod 0660 /dev/video-dec0
# echo enc > /dev/video-enc0
# chown root:video /dev/video-enc0
# chmod 0660 /dev/video-enc0

# sudo nano /etc/udev/rules.d/11-rockchip-multimedia.rules
# KERNEL=="mpp_service", MODE="0660", GROUP="video"
# KERNEL=="rga", MODE="0660", GROUP="video"
# KERNEL=="system-dma32", MODE="0666", GROUP="video"
# KERNEL=="system-uncached-dma32", MODE="0666", GROUP="video" RUN+="/usr/bin/chmod a+rw /dev/dma_heap"
