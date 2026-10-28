# Copyright (C) 2020-2024 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Shared libraries are installed by architecture-specific Soong modules.
PRODUCT_COPY_FILES += \
    $(filter-out vendor/huawei/mediapadm5lte/proprietary/odm/lib/%.so vendor/huawei/mediapadm5lte/proprietary/odm/lib64/%.so vendor/huawei/mediapadm5lte/proprietary/vendor/lib/%.so vendor/huawei/mediapadm5lte/proprietary/vendor/lib64/%.so, \
        $(call find-copy-subdir-files,*,vendor/huawei/mediapadm5lte/proprietary/odm/,odm/) \
        $(call find-copy-subdir-files,*,vendor/huawei/mediapadm5lte/proprietary/vendor/,vendor/))

$(call inherit-product, vendor/huawei/mediapadm5lte/proprietary-libraries.mk)
