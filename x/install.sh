# configure hid-apple for bluetooth keyboards
modprobe hid-apple

sudo ln -sf "$PWD/00.keyboard.conf" "/etc/X11/xorg.conf.d/00-keyboard.conf"
sudo ln -sf "$PWD/hid_apple.conf" "/etc/modprobe.d/hid_apple.conf"

sudo mkinitcpio -P
