# Include common makefile
$(call inherit-product, device/samsung/u8500-common/common.mk)


ifneq ($(TARGET_SCREEN_HEIGHT),800)
# Call cm.mk because somehow it's not being called!
$(call inherit-product, device/samsung/janice/cm.mk)
endif

LOCAL_PATH := device/samsung/janice

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# This device is HDPI
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

# TEE
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/tee/cops_ta.ssw:system/lib/tee/cops_ta.ssw \
    $(LOCAL_PATH)/tee/custom_ta.ssw:system/lib/tee/custom_ta.ssw \
    $(LOCAL_PATH)/tee/libbassapp_ssw:system/lib/tee/libbassapp_ssw \
    $(LOCAL_PATH)/tee/smcl_ta_8500bx_secure.ssw:system/lib/tee/smcl_ta_8500bx_secure.ssw 

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
    mobiledata.interfaces=pdp0,wlan0,gprs,ppp0 \
    ro.ril.hsxpa=2 \
    ro.ril.gprsclass=10 \
    ro.telephony.ril_class=SamsungU8500RIL \
    ro.telephony.sends_barcount=1

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/fstab.samsungjanice:root/fstab.samsungjanice \
    $(LOCAL_PATH)/rootdir/init.samsungjanice.rc:root/init.samsungjanice.rc \
    $(LOCAL_PATH)/rootdir/init.samsungjanice.usb.rc:root/init.samsungjanice.usb.rc \
    $(LOCAL_PATH)/rootdir/prerecovery.rc:root/prerecovery.rc \
    $(LOCAL_PATH)/rootdir/ueventd.samsungjanice.rc:root/ueventd.samsungjanice.rc

# RIL
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/configs/manuf_id.cfg:system/etc/AT/manuf_id.cfg \
   $(LOCAL_PATH)/configs/model_id.cfg:system/etc/AT/model_id.cfg \
   $(LOCAL_PATH)/configs/system_id.cfg:system/etc/AT/system_id.cfg

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/usr/keylayout/janice-kp.kl:system/usr/keylayout/janice-kp.kl \
    $(LOCAL_PATH)/usr/keylayout/Vendor_04e8_Product_7021.kl:system/usr/keylayout/Vendor_04e8_Product_7021.kl

# Use non-open-source parts if present
$(call inherit-product-if-exists, vendor/samsung/u8500-common/janice/janice-vendor-blobs.mk)
