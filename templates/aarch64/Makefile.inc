# Architecture Linux
export CONF_LINUX_ARCH=arm64

# Linux kernel image name
export CONF_LINUX_IMG=Image

# Architecture busybox
export CONF_BUSYBOX_ARCH=aarch64

# Cross-compiler prefix
export CONF_CROSS_COMPILE_PREFIX=aarch64-linux-gnu-

# Name of the Linux TAR archive
export CONF_LINUX_ARCHIVE=linux-4.18.16.tar.xz

# URL of Linux archive
export CONF_LINUX_URL=https://cdn.kernel.org/pub/linux/kernel/v4.x/$(CONF_LINUX_ARCHIVE)

# Name of the Busybox TAR archive
export CONF_BUSYBOX_ARCHIVE=busybox-1.36.tar.bz2

# URL of Busybox archive
export CONF_BUSYBOX_URL=https://busybox.net/downloads/$(CONF_BUSYBOX_ARCHIVE)

# Number of CPUs for compilation
export CONF_CPUS=3
