#!/bin/bash
sudo apt install git
sudo add-apt-repository ppa:apandada1/libhandy-1
git clone -branch master_jammy https://github.com/pop-os/shop.git
sudo apt-get install gettext libappstream-dev libgee-0.8-dev libgranite-dev libgtk-3-dev libjson-glib-dev libpackagekit-glib2-dev libsoup2.4-dev libunity-dev libxml2-dev libxml2-utils repoman meson valac make build-essential cmake libhandy-0.0-dev libflatpak-dev flatpak
sudo ninja install
sudo apt install libhandy-1-dev
sudo apt install libpolkit-gobject-1-dev
cd shop 
sudo meson build --prefix=/usr
cd build
sudo ninja
sudo ninja install
sudo io.elementary.appcenter --gapplication-replace
# Reboot the system
sudo reboot