TARGET_ARCHITECTURES=armv6l i686 x86_64
DOWNLOAD_URL_PREFIX="https://www.busybox.net/downloads/binaries/1.26.2-defconfig-multiarch/"

BUILD_PREFIX=build
DOWNLOAD_DIR=$(BUILD_PREFIX)/download
OUTPUT_DIR=$(BUILD_PREFIX)/out

STATIC_FILE_LIST=META-INF/com/google/android/update-binary META-INF/com/google/android/updater-script common/post-fs-data.sh common/service.sh common/system.prop config.sh system/xbin/symbol-links.tar

$(DOWNLOAD_DIR)/%:
	mkdir -p $(DOWNLOAD_DIR)
	wget -c $(DOWNLOAD_URL_PREFIX)/$(notdir $@) -O $@

$(OUTPUT_DIR)/%.zip: $(DOWNLOAD_DIR)/% $(STATIC_FILE_LIST) _module.prop
	mkdir -p $(OUTPUT_DIR)
	sed "s/armv6l/$(patsubst busybox-%.zip,%,$(notdir $@))/g" _module.prop > module.prop
	zip -u $@ module.prop
	rm module.prop
	for f in $(STATIC_FILE_LIST); do \
		zip -u $@ $$f; \
	done
	install -Dm755 $(DOWNLOAD_DIR)/$(patsubst %.zip,%,$(notdir $@)) system/xbin/busybox
	zip -u $@ system/xbin/busybox
	rm system/xbin/busybox

.PHONY: busybox-% clean-out clean-download clean all 

.PRECIOUS: $(DOWNLOAD_DIR)/% $(OUTPUT_DIR)/%.zip

busybox-%: $(OUTPUT_DIR)/busybox-%.zip
	@true

all: $(patsubst %,busybox-%,$(TARGET_ARCHITECTURES))

clean-out: 
	-rm -r build/out

clean-download:
	-rm -r build/download

clean: clean-out clean-download

