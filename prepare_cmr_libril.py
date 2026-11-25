#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0

"""Route only the CMR C00 64-bit RIL's standard HIDL registration to Radio 1.4."""

import hashlib
import sys
from pathlib import Path


SOURCE_SHA256 = "264ea484874707d38cb3a4a589ebe5ee6fc5276c9dc5939e1914b5971ff4e8d9"
REGISTER_1_1 = (
    b"_ZN7android8hardware5radio4V1_16IRadio17registerAsServiceERKNSt3__1"
    b"12basic_stringIcNS4_11char_traitsIcEENS4_9allocatorIcEEEE"
)


def prepare(source):
    if hashlib.sha256(source).hexdigest() != SOURCE_SHA256:
        raise ValueError("Unrecognized CMR libril.so. Check its registration ABI before porting.")
    data = bytearray(source)
    # Both strings are unique entries in this ELF's .dynstr. Reuse the empty
    # Android 15 transport stub's DT_NEEDED slot. Keep all offsets and trailing
    # suffixes intact, including the separate Huawei private registration.
    for old, new in ((b"libhidltransport.so", b"libcmr_radio.so"),
                     (REGISTER_1_1, b"cmr_register_radio_1_4")):
        entry = b"\0" + old + b"\0"
        if len(new) > len(old) or data.count(entry) != 1:
            raise ValueError(f"Unexpected CMR dynamic string: {old!r}")
        start = data.index(entry) + 1
        data[start:start + len(new) + 1] = new + b"\0"
    return data


if __name__ == "__main__":
    source, destination = map(Path, sys.argv[1:])
    destination.write_bytes(prepare(source.read_bytes()))
