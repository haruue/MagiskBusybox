# Magisk Busybox
Add it back as a module after Magisk just removed busybox option.

## Installation
1. Download your platform version from https://github.com/haruue/MagiskBusybox/releases/latest
2. Magisk Manager -> Module -> `+` button -> choose downloaded file
3. Reboot your device
4. Enjoy it

## Build & Customize
+ You can build this module package with its default config by simply `make`, then you can find Magisk module package in `build/out/busybox-*.zip`
+ You can modify Makefile and add architectures you want in `TARGET_ARCHITECTURES`, or customize `DOWNLOAD_URL_PREFIX`
+ If you prefer add your customize busybox directly rather than download it, put your own busybox binary to `build/download` with name like `busybox-<architecture>`, then build it by `make busybox-<architecture>`
+ If you want to add some other files to package, don't forget to add them to `STATIC_FILE_LIST`
+ If you want to modify symbol link to busybox, modify `system/xbin/symbol-links.tar`

## License
GPLv2

