setenv bootargs console=tty1 console=ttyS0,115200 root=/dev/mmcblk0p1 rootwait panic=10 ${extra}
ext4load mmc 0 0x49000000 /boot/itan2.dtb
ext4load mmc 0 0x46000000 /boot/zImage
env set fdt_high ffffffff
bootz 0x46000000 - 0x49000000
