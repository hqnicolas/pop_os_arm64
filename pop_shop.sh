#!/bin/bash
sudo apt install git -y
sudo add-apt-repository ppa:apandada1/libhandy-1
sudo apt-get install gettext libappstream-dev libgee-0.8-dev libgranite-dev libgtk-3-dev libjson-glib-dev libpackagekit-glib2-dev libsoup2.4-dev libunity-dev libxml2-dev libxml2-utils repoman meson valac make build-essential cmake libhandy-0.0-dev libflatpak-dev flatpak -y
apt-get install meson libhandy-1-dev libgee-0.8-2 libpolkit-gobject-1-dev libsoup2.4-dev gnome-software-plugin-flatpak -y
git clone https://github.com/pop-os/repoman.git
cd repoman
sudo python3 setup.py install
git clone https://github.com/pop-os/shop.git
cd shop
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
