#!/bin/bash
sudo add-apt-repository ppa:liujianfeng1994/panfork-mesa
sudo add-apt-repository ppa:liujianfeng1994/rockchip-multimedia
sudo apt update
sudo apt dist-upgrade
sudo apt install rockchip-multimedia-config
sudo apt install mali-bifrost-wayland-driver
sudo apt install libv4l-rkmpp
sudo apt install v4l-utils
sudo apt install ffmpeg

sudo apt install glmark2-es2-wayland
glmark2-es2-wayland

# Define the file path and search-and-replace patterns
file_path="/etc/rc.local"
search_pattern="exit o"
replacement="echo dec > /dev/video-dec0
chown root:video /dev/video-dec0
chmod 0660 /dev/video-dec0
echo enc > /dev/video-enc0
chown root:video /dev/video-enc0
chmod 0660 /dev/video-enc0
exit o"

# Perform the substitution using sed
sudo sed -i "s/$search_pattern/$replacement/g" $file_path

# Define the file path and text to be appended
file_path="example.txt"
text_to_append="This is the text to be appended."

# Append the text to the file
sudo echo "KERNEL=="mpp_service", MODE="0660", GROUP="video"
KERNEL=="rga", MODE="0660", GROUP="video"
KERNEL=="system-dma32", MODE="0666", GROUP="video"
KERNEL=="system-uncached-dma32", MODE="0666", GROUP="video" RUN+="/usr/bin/chmod a+rw /dev/dma_heap"" >> /etc/udev/rules.d/11-rockchip-multimedia.rules


$ sudo reboot
