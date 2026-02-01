#!/bin/bash

IN_TEMPLATE=$1
R_BOOT_BINARY=$2
OUT=$3

R_BOOT_SIZE=$(du -b $R_BOOT_BINARY | cut -f1)
R_BOOT_HASH=$(sha512sum $R_BOOT_BINARY | cut -d " " -f1)
sed "s/<R_BOOT_SIZE>/$R_BOOT_SIZE/g" $IN_TEMPLATE > $OUT
sed "s/<R_BOOT_HASH>/$R_BOOT_HASH/g" -i $OUT
