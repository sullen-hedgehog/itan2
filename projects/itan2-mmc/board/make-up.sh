#!/bin/sh

rm -f ${TARGET_DIR}/linuxrc
rm -f ${TARGET_DIR}/etc/init.d/S40xorg
rm -f ${TARGET_DIR}/etc/init.d/*mdev*
rm -f ${TARGET_DIR}/usr/share/X11/xorg.conf.d/*

cp -dpfR ../board/skeleton/* ${TARGET_DIR}
