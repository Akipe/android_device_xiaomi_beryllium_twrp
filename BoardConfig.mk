#
# Copyright (C) 2018 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

BOARD_VENDOR := xiaomi

# OTA Assert
TARGET_OTA_ASSERT_DEVICE := beryllium

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sdm845
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := sdm845
TARGET_BOARD_PLATFORM_GPU := qcom-adreno630

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo300

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a9

TARGET_USES_64_BIT_BINDER := true

ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Kernel
BOARD_KERNEL_CMDLINE := \
	console=ttyMSM0,115200n8 \
	earlycon=msm_geni_serial,0xA84000 \
	androidboot.hardware=qcom \
	androidboot.console=ttyMSM0 \
	video=vfb:640x400,bpp=32,memsize=3072000 \
	msm_rtb.filter=0x237 \
	ehci-hcd.park=3 \
	lpm_levels.sleep_disabled=1 \
	service_locator.enable=1 \
	swiotlb=2048 \
	androidboot.configfs=true \
	loop.max_part=7 \
	androidboot.usbcontroller=a600000.dwc3
#BOARD_KERNEL_CMDLINE += \
#  android.keymaster=1
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET := 0x01000000

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH   := arm64
KERNEL_TOOLCHAIN            := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_OS)-x86/aarch64/aarch64-linux-android-4.9/bin
KERNEL_TOOLCHAIN_PREFIX     := aarch64-linux-android-
TARGET_KERNEL_CONFIG := beryllium_defconfig
# TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_SOURCE := kernel/xiaomi/sdm845

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 57453555712
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
TARGET_USES_MKE2FS := true
BOARD_HAS_LARGE_FILESYSTEM := true

TARGET_COPY_OUT_VENDOR := vendor

TARGET_RECOVERY_FSTAB := device/xiaomi/beryllium/recovery.fstab

# Android version
PLATFORM_SDK_VERSION            := 27

# Full disk encryption
TARGET_CRYPTFS_HW_PATH          := vendor/qcom/opensource/cryptfs_hw
TARGET_HW_DISK_ENCRYPTION       := true
TW_INCLUDE_CRYPTO               := true
PLATFORM_SECURITY_PATCH         := 2029-10-01
PLATFORM_VERSION := 16.1.0
# Use system's VOLD and files in case TWRP's decryption fails
#TW_CRYPTO_USE_SYSTEM_VOLD := qseecomd

# Qualcomm
BOARD_USES_QCOM_HARDWARE := true
BUILD_WITHOUT_VENDOR := true

# Ramdisk
BOARD_ROOT_EXTRA_SYMLINKS := \
    /mnt/vendor/persist:/persist \
    /vendor/bt_firmware:/bt_firmware \
    /vendor/dsp:/dsp \
    /vendor/firmware_mnt:/firmware

# Display
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"

# Time
TARGET_RECOVERY_QCOM_RTC_FIX := true

# Recovery
RECOVERY_VARIANT                := twrp

# TWRP
#TW_USE_TOOLBOX                  := true
TW_THEME                        := portrait_hdpi
TW_BRIGHTNESS_PATH              := /sys/class/backlight/panel0-backlight/brightness
TW_MAX_BRIGHTNESS               := 4095
TW_DEFAULT_BRIGHTNESS           := 800
TW_INPUT_BLACKLIST              := "hbtp_vm"
#TW_CUSTOM_CPU_TEMP_PATH         := /sys/devices/virtual/thermal/thermal_zone1/temp
#TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun%d/file
RECOVERY_SDCARD_ON_DATA         := true
TW_DEFAULT_EXTERNAL_STORAGE     := true
TW_EXTRA_LANGUAGES              := true
TW_EXCLUDE_TWRPAPP              := true
BOARD_SUPPRESS_SECURE_ERASE     := true
TW_INCLUDE_NTFS_3G              := true
TW_NEW_ION_HEAP                 := true
TW_INCLUDE_FB2PNG               := true
TWRP_NEW_THEME                  := true
TW_Y_OFFSET := 80
TW_H_OFFSET := -80

TW_DEVICE_VERSION := reloadAkipe

ifeq ($(TARGET_BUILD_VARIANT),eng)
  TWRP_INCLUDE_LOGCAT           := true
  TARGET_USES_LOGD              := true
  # TWRP_EVENT_LOGGING            := true
  TW_CRYPTO_SYSTEM_VOLD_DEBUG   := true
  BOARD_KERNEL_CMDLINE          += loglevel=8
endif

#### Modules
# timezone
TARGET_RECOVERY_DEVICE_MODULES      += tzdata
TW_RECOVERY_ADDITIONAL_RELINK_FILES += $(TARGET_OUT)/usr/share/zoneinfo/tzdata

# Modules for debug
ifeq ($(TARGET_BUILD_VARIANT),eng)
  # debuggerd
  TARGET_RECOVERY_DEVICE_MODULES      += debuggerd
  TW_RECOVERY_ADDITIONAL_RELINK_FILES += $(TARGET_OUT)/bin/debuggerd
  # strace
  TARGET_RECOVERY_DEVICE_MODULES      += strace
  TW_RECOVERY_ADDITIONAL_RELINK_FILES += $(TARGET_OUT)/xbin/strace
  # twrpdec, useful for debug decrypt with strace
  TARGET_RECOVERY_DEVICE_MODULES      += twrpdec
  TW_RECOVERY_ADDITIONAL_RELINK_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/twrpdec
endif

