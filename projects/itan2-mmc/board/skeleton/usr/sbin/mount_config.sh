#!/bin/sh

MTD_PART=2
CFG_DIR=/mnt/config

source /etc/profile

mkdir -p $CFG_DIR
mount -t jffs2 /dev/mtdblock${MTD_PART} $CFG_DIR

if [ ! -d ${CFG_DIR}/etc ]; then
    umount /dev/mtdblock${MTD_PART}
    flash_erase -q -j /dev/mtd${MTD_PART} 0 0
    mount -t jffs2 /dev/mtdblock${MTD_PART} $CFG_DIR
fi

mkdir -p ${CFG_DIR}/etc ${CFG_DIR}/root

cp -dpfr ${CFG_DIR}/etc ${CFG_DIR}/root /
