#!/bin/bash
sudo apt update
sudo apt dist-upgrade
sudo apt install libv4l-rkmpp -y
sudo apt install v4l-utils -y
sudo apt install ffmpeg -y

sudo apt install glmark2-es2-wayland -y
glmark2-es2-wayland

# Edit the file /etc/gdm3/custom.conf 
# WaylandEnable=true 

# Define the file path and search-and-replace patterns
/etc/gdm3/custom.conf

WaylandEnable=true



/etc/rc.local

echo dec > /dev/video-dec0
chown root:video /dev/video-dec0
chmod 0660 /dev/video-dec0
echo enc > /dev/video-enc0
chown root:video /dev/video-enc0
chmod 0660 /dev/video-enc0


/etc/udev/rules.d/11-rockchip-multimedia.rules

KERNEL=="mpp_service", MODE="0660", GROUP="video"
KERNEL=="rga", MODE="0660", GROUP="video"
KERNEL=="system-dma32", MODE="0666", GROUP="video"
KERNEL=="system-uncached-dma32", MODE="0666", GROUP="video" RUN+="/usr/bin/chmod a+rw /dev/dma_heap"


$ sudo reboot
