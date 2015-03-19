#!/bin/sh

cd work/busybox

# Change to the first directory ls finds, e.g. 'busybox-1.23.1'
cd $(ls -d *)

# Remove previously generated artefacts
make clean

# Create a default configuration file
make defconfig

# Change the configuration, so that busybox is statically compiled
# You could do this manually with 'make menuconfig'
sed -i "s/.*CONFIG_STATIC.*/CONFIG_STATIC=y/" .config

# Compile busybox
# TODO - Suggested by Ronny Kalusniok - test this for parallel compilation: "make busybox -j $(grep ^processor /proc/cpuinfo)".
make busybox

# Create the symlinks for busybox
# It uses the file 'busybox.links' for this
make install

cd ../../..

