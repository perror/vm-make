#!/bin/sh

# Create mount point if needed
/usr/bin/mkdir -p mountpoint/

# Running QEMU
/usr/bin/qemu-system-aarch64 \
    -machine virt -machine type=virt \
    -cpu cortex-a57 -smp 1 \
    -kernel ./bzImage -initrd ./initramfs.cpio.gz  \
    -append 'console=ttyAMA0' \
    -no-reboot -nographic \
    $1 $2
