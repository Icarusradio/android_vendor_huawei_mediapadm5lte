# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),mediapadm5lte)
$(call add-radio-file,firmware/cmr_c00_modem_fw_s007_s008.p)
endif
