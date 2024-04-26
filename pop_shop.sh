#!/bin/bash
sudo apt install git
sudo add-apt-repository ppa:apandada1/libhandy-1
git clone https://github.com/pop-os/shop.git
sudo apt-get install gettext libappstream-dev libgee-0.8-dev libgranite-dev libgtk-3-dev libjson-glib-dev libpackagekit-glib2-dev libsoup2.4-dev libunity-dev libxml2-dev libxml2-utils repoman meson valac make build-essential cmake libhandy-0.0-dev libflatpak-dev flatpak
sudo ninja install
sudo apt install libhandy-1-dev
sudo apt install libpolkit-gobject-1-dev
cd shop 
apt-get install meson
sudo apt install valac
sudo apt install libgee-0.8-2
sudo apt install libgee-0.8-dev
sudo apt install libgranite-dev
sudo apt install libappstream-dev
sudo apt install libjson-glib-dev
sudo apt install libflatpak-dev
sudo apt install libgtk-3-dev
sudo apt install libxml2-utils
sudo apt install libxml2-dev
sudo apt install gettext
sudo apt install libappstream-dev
sudo apt install libflatpak-dev
sudo apt install libgee-0.8-dev
sudo apt install libgranite-dev
sudo apt install libgtk-3-dev
sudo apt install libhandy-1-dev
sudo apt install libjson-glib-dev
sudo apt install libpackagekit-glib2-dev
sudo apt install libpolkit-gobject-1-dev
sudo apt install libsoup2.4-dev
sudo apt install gnome-software-plugin-flatpak
git clone https://github.com/pop-os/repoman.git
cd repoman
sudo python3 setup.py install
sudo meson build --prefix=/usr
cd build
sudo ninja
sudo ninja install
sudo io.elementary.appcenter --gapplication-replace
sudo apt install snap
sudo snap install snap-store
# Reboot the system
sudo reboot
