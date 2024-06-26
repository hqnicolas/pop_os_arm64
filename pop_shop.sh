#!/bin/bash
sudo apt install git -y
sudo add-apt-repository ppa:apandada1/libhandy-1 -y
sudo apt-get remove libappstream4
sudo apt-get install libappstream4=0.15.2-2
sudo apt-get install gettext libappstream-dev libgee-0.8-dev libgranite-dev libgtk-3-dev libjson-glib-dev libpackagekit-glib2-dev libsoup2.4-dev libunity-dev libxml2-dev libxml2-utils repoman meson valac make build-essential cmake libhandy-0.0-dev libflatpak-dev flatpak -y
sudo apt-get install flatpak gettext gir1.2-appstream-1.0 libappstream4 libappstream-dev libflatpak-dev libgee-0.8-dev libgranite-dev libgtk-3-dev libhandy-1-dev libjson-glib-dev libpackagekit-glib2-dev libpolkit-gobject-1-dev libsoup2.4-dev libxml2-dev libxml2-utils meson valac
libgranite-dev elementary-sdk valac meson libhandy-1-dev libgee-0.8-2 libpolkit-gobject-1-dev libsoup2.4-dev gnome-software-plugin-flatpak -y
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
# INSTALL NEW LANGUAGE sudo apt-get install language-pack-[cod] language-pack-gnome-[cod] language-pack-[cod]-base language-pack-gnome-[cod]-base 
sudo apt-get install language-pack-pt language-pack-gnome-pt language-pack-pt-base language-pack-gnome-pt-base 
sudo add-apt-repository -r ppa:apandada1/libhandy-1 -y
cd ~
sudo rm -rf shop
# Reboot the system
sudo reboot
