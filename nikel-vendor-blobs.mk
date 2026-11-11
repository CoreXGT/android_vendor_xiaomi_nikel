# The MIUI libicuuc.so must not overwrite the platform's own ICU on cm-13.0:
# the platform builds libicui18n from that ICU and the two builds are not
# ABI compatible (the platform's libicui18n references the icu_55 C++
# vtables, which the MIUI ICU build does not have).  On cm-14.1 the vendor
# ICU has to stay - that platform ships ICU 58 and the MTK blobs need the
# ICU-55 flavour (the icu55.c shim in libmtk_symbols provides it).
VENDOR_ICU_BLACKLIST :=
ifeq ($(PLATFORM_VERSION),6.0.1)
VENDOR_ICU_BLACKLIST := %:system/lib/libicuuc.so %:system/lib64/libicuuc.so
endif

PRODUCT_COPY_FILES += $(filter-out $(VENDOR_ICU_BLACKLIST),$(call find-copy-subdir-files,*,vendor/xiaomi/nikel/system/,system/))
