sudo apt-get install armbian-config
sudo armbian-config
# SYSTEM
# FREEZE
# KERNEL
wget https://raw.githubusercontent.com/hqnicolas/pop_os_arm64/main/install_pop_os_arm64.sh
sudo chmod 777 install_pop_os_arm64.sh
sudo ./install_pop_os_arm64.sh
wget https://raw.githubusercontent.com/hqnicolas/pop_os_arm64/main/install_wayland_browser.sh
sudo chmod 777 install_wayland_browser.sh
sudo ./install_wayland_browser.sh
