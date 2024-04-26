#!/bin/bash
sudo apt install git
sudo add-apt-repository ppa:apandada1/libhandy-1
git clone https://github.com/pop-os/shop.git
sudo apt-get install gettext libappstream-dev libgee-0.8-dev libgranite-dev libgtk-3-dev libjson-glib-dev libpackagekit-glib2-dev libsoup2.4-dev libunity-dev libxml2-dev libxml2-utils repoman meson valac make build-essential cmake libhandy-0.0-dev libflatpak-dev flatpak -y
sudo ninja install
sudo apt install libhandy-1-dev -y
sudo apt install libpolkit-gobject-1-dev -y
cd shop 
apt-get install meson -y
sudo apt install valac -y
sudo apt install libgee-0.8-2 -y
sudo apt install libgee-0.8-dev -y
sudo apt install libgranite-dev -y
sudo apt install libappstream-dev -y
sudo apt install libjson-glib-dev -y
sudo apt install libflatpak-dev -y
sudo apt install libgtk-3-dev -y
sudo apt install libxml2-utils -y
sudo apt install libxml2-dev -y
sudo apt install gettext -y
sudo apt install libappstream-dev -y
sudo apt install libflatpak-dev -y
sudo apt install libgee-0.8-dev -y
sudo apt install libgranite-dev -y
sudo apt install libgtk-3-dev -y
sudo apt install libhandy-1-dev -y
sudo apt install libjson-glib-dev -y
sudo apt install libpackagekit-glib2-dev -y
sudo apt install libpolkit-gobject-1-dev -y
sudo apt install libsoup2.4-dev -y
sudo apt install gnome-software-plugin-flatpak -y
git clone https://github.com/pop-os/repoman.git
cd repoman
sudo python3 setup.py install
sudo meson build --prefix=/usr
cd build
sudo ninja
sudo ninja install
sudo io.elementary.appcenter --gapplication-replace
sudo apt install snapd -y
sudo snap install snap-store
sudo snap install ms-365-electron
# Reboot the system
sudo reboot
