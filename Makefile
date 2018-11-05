.PHONY: all clean distclean help

ifndef CONF_TEMPLATE
$(error You must define CONF_TEMPLATE variable)
endif

# Templates variables...
export CONF_TEMPLATE_MAKEFILE=$(CONF_TEMPLATE)/Makefile.inc
export CONF_TEMPLATE_FS=$(CONF_TEMPLATE)/fs
export CONF_TEMPLATE_LINUX_CONF=$(CONF_TEMPLATE)/linux-config
export CONF_TEMPLATE_BUSYBOX_CONF=$(CONF_TEMPLATE)/busybox-config
export CONF_TEMPLATE_START=$(CONF_TEMPLATE)/start.sh
export CONF_TEMPLATE_MODULE=$(CONF_TEMPLATE)/vuln.c

-include $(CONF_TEMPLATE_MAKEFILE)

# Root directory
export CONF_ROOT=$(PWD)

# Linux build directory
export CONF_LINUX_BUILD=$(CONF_ROOT)/linux
export CONF_LINUX_BZIMAGE=$(CONF_LINUX_BUILD)/bzImage
export CONF_LINUX_HEADERS=$(CONF_LINUX_BUILD)/build
export CONF_LINUX_SYSTEMMAP=$(CONF_LINUX_BUILD)/System.map

# Busybox build directory
export CONF_BUSYBOX_BUILD=$(CONF_ROOT)/busybox
export CONF_BUSYBOX_DONE=$(CONF_BUSYBOX_BUILD)/build/.done
export CONF_BUSYBOX_INSTALL=$(CONF_BUSYBOX_BUILD)/build/_install

# Initramfs build directory
export CONF_INITRAMFS_BUILD=$(CONF_ROOT)/initramfs
export CONF_INITRAMFS_FINAL=$(CONF_INITRAMFS_BUILD)/initramfs.cpio.gz

# Module build directory
export CONF_MODULE_BUILD=$(CONF_ROOT)/module
export CONF_MODULE_KO=$(CONF_MODULE_BUILD)/vuln.ko

# Build directory
export CONF_BUILD=$(CONF_ROOT)/build


##################################################################
# all rule
##################################################################
all:
	make -C $(CONF_INITRAMFS_BUILD) clean
	make -C $(CONF_BUILD) clean
	cp -a $(CONF_TEMPLATE_FS) $(CONF_INITRAMFS_BUILD)
	cp -a $(CONF_TEMPLATE_BUSYBOX_CONF) $(CONF_BUSYBOX_BUILD)/config
	cp -a $(CONF_TEMPLATE_LINUX_CONF) $(CONF_LINUX_BUILD)/config
	cp -a $(CONF_TEMPLATE_START) $(CONF_BUILD)
	cp -a $(CONF_TEMPLATE_MODULE) $(CONF_MODULE_BUILD)
	make -C $(CONF_LINUX_BUILD)
	make -C $(CONF_BUSYBOX_BUILD)
	make -C $(CONF_MODULE_BUILD)
	make -C $(CONF_INITRAMFS_BUILD)
	make -C $(CONF_BUILD)
	@echo ""
	@echo "##############################################################"
	@echo " Your VM is built in $(CONF_BUILD)"
	@echo "##############################################################"

##################################################################
# clean rule
##################################################################
clean:
	make -C $(CONF_MODULE_BUILD) clean ; \
	make -C $(CONF_LINUX_BUILD) clean ; \
	make -C $(CONF_BUSYBOX_BUILD) clean ; \
	make -C $(CONF_INITRAMFS_BUILD) clean ; \
	make -C $(CONF_BUILD) clean
	rm -f *~

##################################################################
# distclean rule
##################################################################
distclean:
	make -C $(CONF_MODULE_BUILD) distclean ; \
	make -C $(CONF_LINUX_BUILD) distclean ; \
	make -C $(CONF_BUSYBOX_BUILD) distclean ; \
	make -C $(CONF_INITRAMFS_BUILD) distclean ; \
	make -C $(CONF_BUILD) distclean
	rm -f *~

##################################################################
# help rule
##################################################################
help:
	@echo "make <all>      Build the VM"
	@echo "make clean      Reset some files to start rebuild"
	@echo "make distclean  Remove all generated files"
	@echo "make help       Print this help"
