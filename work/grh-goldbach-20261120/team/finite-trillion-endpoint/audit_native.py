"""Check the producer's anchor set using independent FLINT primality decisions."""
from pathlib import Path
import json
from time import process_time
from flint import fmpz

here = Path(__file__).resolve().parent
data = json.loads((here/"producer.json").read_bytes())
anchors = data["anchors"]
start = process_time()
assert len(anchors) == len(set(anchors)) and all(fmpz(q).is_prime() for q in anchors)
length = data["evens"]+data["halo"]
bits = bytearray((length+7)//8)
for i in range(length):
    if fmpz(3+2*i).is_prime():
        bits[i//8] |= 1 << (i%8)
marked = int.from_bytes(bits, "little")
covered = 0
for q in anchors:
    covered |= marked >> ((data["low"]-q-3)//2)
mask = (1 << data["evens"])-1
assert covered & mask == mask
result = dict(anchors=len(anchors),evens=data["evens"],cpu_s=process_time()-start,
              producer_source_sha256=data["sha256"])
(here/"independent.json").write_text(json.dumps(result,indent=2))
