sudo wget http://apt.undo.it:7241/apt.undo.it.asc -O /etc/apt/trusted.gpg.d/apt.undo.it.asc
echo "deb http://apt.undo.it:7241/ubuntu jammy main" | sudo tee /etc/apt/sources.list.d/apt.undo.it.list
sudo apt update
sudo apt install ffmpeg-v4l2request mpv
sudo mkdir -p /etc/mpv
echo -e "hwdec=drm\ndrm-drmprime-video-plane=primary\ndrm-draw-plane=overlay" | sudo tee /etc/mpv/mpv.conf
