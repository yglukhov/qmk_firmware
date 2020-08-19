
set -ex
THIS_DIR=$(dirname $0)

cd "$THIS_DIR"
make v60_type_r:uran

# dfu-programmer is called under current user, not root.
# for dfu device to be writable to user, add the following line to /etc/udev/rules.d/20-hw1.rules
# SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff4", MODE="0660", GROUP="users"

# To enter flash mode on the keyboard, press the reset button on the back cover. You can press it
# while running this script.


while ! dfu-programmer atmega32u4 erase
do
    echo "Retrying in 2 sec"
    sleep 2
done

dfu-programmer atmega32u4 flash "./v60_type_r_uran.hex"



dfu-programmer atmega32u4 reset

