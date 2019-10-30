#
# Copyright (C) 2018 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0

$(call inherit-product, build/target/product/embedded.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

$(call inherit-product, vendor/omni/config/common.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.keystore=sdm845

PRODUCT_NAME            := omni_beryllium
PRODUCT_DEVICE          := beryllium
PRODUCT_BRAND           := Xiaomi
PRODUCT_MANUFACTURER    := Xiaomi
PRODUCT_MODEL           := Poco F1
