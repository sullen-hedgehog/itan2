#!/bin/sh

rm -f ${TARGET_DIR}/linuxrc
rm -f ${TARGET_DIR}/etc/init.d/S40xorg

cp -dpfR ../board/skeleton/* ${TARGET_DIR}
