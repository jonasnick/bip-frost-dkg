#!/bin/sh

# This script generates reference.py from the README.md file.

cat <<EOF > reference.py
# Reference implementation of BIP DKG. This file is automatically generated by
# reference_py_gen.sh.

from secp256k1 import n as GROUP_ORDER, Point, G, point_add, point_mul, schnorr_sign as sign, schnorr_verify as verify_sig, tagged_hash, bytes_from_point, individual_pk, point_add_multi, scalar_add_multi
from typing import Tuple, List, Optional, Callable, Any, Union
from network import *
from util import *
EOF

awk '/### Notation/,/### RecPedPop/ {
    if ($0 ~ /^```python$/) {
        in_python_block = 1;
        print "";
        next;
    }
    if (in_python_block && $0 ~ /^```$/) {
        in_python_block = 0;
    }
    if (in_python_block) {
        print $0;
    }
}' ../README.md >> reference.py
