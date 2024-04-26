#!/bin/bash
sudo add-apt-repository ppa:liujianfeng1994/panfork-mesa -y
sudo add-apt-repository ppa:liujianfeng1994/rockchip-multimedia -y
sudo apt update
sudo apt dist-upgrade
sudo apt install rockchip-multimedia-config -y
sudo apt install mali-bifrost-wayland-driver -y
sudo apt install libv4l-rkmpp -y
sudo apt install v4l-utils -y
sudo apt install ffmpeg -y

sudo apt install glmark2-es2-wayland -y
glmark2-es2-wayland

# Edit the file /etc/gdm3/custom.conf 
# WaylandEnable=true 

# Define the file path and search-and-replace patterns
file_pat="/etc/gdm3/custom.conf"
search_patt="WaylandEnable=false"
replace="WaylandEnable=true"

# Perform the substitution using sed
sudo sed -i 's/$search_patt/$replace/g' $file_pat

# Define the file path and search-and-replace patterns
file_path="/etc/rc.local"
search_pattern="exit 0"
replacement="echo dec > /dev/video-dec0
chown root:video /dev/video-dec0
chmod 0660 /dev/video-dec0
echo enc > /dev/video-enc0
chown root:video /dev/video-enc0
chmod 0660 /dev/video-enc0
exit 0"

# Perform the substitution using sed
sudo sed -i "s@$search_pattern@$replacement@g" $file_path


# Define the file path and text to be appended
file_path="/etc/udev/rules.d/11-rockchip-multimedia.rules"
text_to_append1="KERNEL=="mpp_service", MODE="0660", GROUP="video""
text_to_append2="KERNEL=="rga", MODE="0660", GROUP="video""
text_to_append3="KERNEL=="system-dma32", MODE="0666", GROUP="video""
text_to_append4="KERNEL=='system-uncached-dma32", MODE="0666", GROUP="video" RUN+="/usr/bin/chmod a+rw /dev/dma_heap'"

# Append the text to the file
echo "$text_to_append1" >> $file_path
echo "$text_to_append2" >> $file_path
echo "$text_to_append3" >> $file_path
echo "$text_to_append4" >> $file_path

$ sudo reboot
