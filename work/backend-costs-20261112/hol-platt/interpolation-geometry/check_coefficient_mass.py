from pathlib import Path
import json
import hashlib

here = Path(__file__).resolve().parent
source = here.parent / "full-height-count" / "coefficients.tsv"
labels = [3, 6667, 11, 9091]
maximum = [0] * 4
total = [0] * 4
indices = [0] * 4
with source.open() as stream:
    for j, line in enumerate(stream):
        index, *coords = map(int, line.split())
        assert index == j and len(coords) == 8
        for i in range(4):
            mass = abs(coords[2*i]) + abs(coords[2*i+1])
            if mass > maximum[i]:
                maximum[i], indices[i] = mass, j
            total[i] += (1 if j == 0 else 2) * mass
assert j == 68267
# Entries before the 16-bit conversion of the 240-bit selected consumer.
unit = 1 << 256
cap = 2 * 1250000**2 + 1
assert all(m + 2 <= cap * unit for m in maximum)
receipt = dict(source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
               scale_bits=256, max_frequency=j, per_mode_cap=cap,
               channels=[dict(label=k, argmax=q, max_l1_raw=m,
                              symmetric_l1_raw=s) for k,q,m,s
                         in zip(labels,indices,maximum,total)])
(here / "coefficient-mass.json").write_text(json.dumps(receipt, indent=2)+"\n")
print([(k, s / unit) for k,s in zip(labels,total)])
