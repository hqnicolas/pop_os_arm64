    sudo wget https://apt.armbian.com/armbian.key -O key
    sudo gpg --dearmor < key | sudo tee /usr/share/keyrings/armbian.gpg > /dev/null
    sudo chmod go+r /usr/share/keyrings/armbian.gpg
    sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/armbian.gpg] http://apt.armbian.com $(lsb_release -cs) main  $(lsb_release -cs)-utils  $(lsb_release -cs)-desktop" | sudo tee /etc/apt/sources.list.d/armbian.list
    apt update
    apt install armbian-config
