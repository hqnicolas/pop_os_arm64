#!/bin/bash
sudo apt install git
git clone https://github.com/pop-os/shop.git
sudo apt-get install gettext libappstream-dev libgee-0.8-dev libgranite-dev libgtk-3-dev libjson-glib-dev libpackagekit-glib2-dev libsoup2.4-dev libunity-dev libxml2-dev libxml2-utils repoman meson valac make build-essential cmake libhandy-0.0-dev libflatpak-dev flatpak
git clone https://github.com/pop-os/repoman.git
cd repoman
sudo python3 setup.py install   
cd shop 
meson build --prefix=/usr
cd build
ninja
sudo ninja install
# Reboot the system
sudo reboot
