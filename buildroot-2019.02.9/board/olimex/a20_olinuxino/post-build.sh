#!/bin/sh

mkdir -p ${TARGET_DIR}/boot

cp ${BINARIES_DIR}/boot.scr ${TARGET_DIR}/boot/boot.scr

if [ -e ${BINARIES_DIR}/script.bin ]; then
	# mali requires a legacy kernel
	cp ${BINARIES_DIR}/script.bin ${TARGET_DIR}/boot/script.bin
fi
