#!/bin/sh

rm -f ${TARGET_DIR}/linuxrc

cp -dpfR ../board/skeleton/* ${TARGET_DIR}
