#!/bin/bash

IN_TEMPLATE=$1
R_BOOT_BINARY=$2
M_BOOT_BINARY=$3
OUT=${@: -1}

R_BOOT_SIZE=$(du -b $R_BOOT_BINARY | cut -f1)
R_BOOT_HASH=$(sha512sum $R_BOOT_BINARY | cut -d " " -f1)
M_BOOT_SIZE=$(du -b $M_BOOT_BINARY | cut -f1)
M_BOOT_HASH=$(sha512sum $M_BOOT_BINARY | cut -d " " -f1)

TOTAL_BOOT_SIZE=$(echo $R_BOOT_SIZE + $M_BOOT_SIZE | bc)

cp $IN_TEMPLATE $OUT
sed "s/<R_BOOT_SIZE>/$R_BOOT_SIZE/g" -i $OUT
sed "s/<R_BOOT_HASH>/$R_BOOT_HASH/g" -i $OUT
sed "s/<M_BOOT_SIZE>/$M_BOOT_SIZE/g" -i $OUT
sed "s/<M_BOOT_HASH>/$M_BOOT_HASH/g" -i $OUT
sed "s/<TOTAL_BOOT_SIZE>/$TOTAL_BOOT_SIZE/g" -i $OUT
