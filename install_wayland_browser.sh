#!/bin/bash
sudo add-apt-repository ppa:liujianfeng1994/rockchip-multimedia
sudo apt update
sudo apt dist-upgrade
sudo apt install libv4l-rkmpp -y
sudo apt install v4l-utils -y
sudo apt install ffmpeg -y
sudo apt install rockchip-multimedia-config -y
sudo apt install v4l-utils -y
sudo apt install chromium-browser -y
sudo apt install libv4l-rkmpp -y

sudo apt install glmark2-es2-wayland -y
glmark2-es2-wayland

# Edit the file /etc/gdm3/custom.conf 
# WaylandEnable=true 

sudo sed -i 's/WaylandEnable=false/WaylandEnable=true/' /etc/gdm3/custom.conf

sudo sed -i 's/exit 0$/echo dec > \/dev\/video-dec0\nchown root:video \/dev\/video-dec0\nchmod 0660 \/dev\/video-dec0\necho enc > \/dev\/video-enc0\nchown root:video \/dev\/video-enc0\nchmod 0660 \/dev\/video-enc0\nexit 0/g' /etc/rc.local

echo -e "# Add multimedia group permissions\n" > /etc/udev/rules.d/11-rockchip-multimedia.rules
echo -e "KERNEL==\"mpp_service\", MODE=\"0660\", GROUP=\"video\"\n" >> /etc/udev/rules.d/11-rockchip-multimedia.rules
echo -e "KERNEL==\"rga\", MODE=\"0660\", GROUP=\"video\"\n" >> /etc/udev/rules.d/11-rockchip-multimedia.rules
echo -e "KERNEL==\"system-dma32\", MODE=\"0666\", GROUP=\"video\"\n" >> /etc/udev/rules.d/11-rockchip-multimedia.rules
echo -e "KERNEL==\"system-uncached-dma32\", MODE=\"0666\", GROUP=\"video\"RUN+=\"/usr/bin/chmod a+rw /dev/dma_heap\"\n" >> /etc/udev/rules.d/11-rockchip-multimedia.rules

$ sudo reboot
