"""Price the same gcd certificate at the far end of a 2^36 odd-slot source."""
import hashlib
import json
import math
from pathlib import Path
from time import process_time, monotonic

BASE = 2**37 - 2*(262144+4096) + 1
SLOTS = 262144+4096
CUTOFF = math.isqrt(BASE+2*(SLOTS-1))
begin = process_time()
wall = monotonic()
small = bytearray(b"\x01")*(CUTOFF+1)
small[:2] = b"\x00\x00"
for p in range(2,math.isqrt(CUTOFF)+1):
    if small[p]:
        small[p*p::p]=b"\x00"*len(small[p*p::p])
slots=bytearray(b"\x01")*SLOTS
for p in range(3,CUTOFF+1,2):
    if small[p]:
        i=(-BASE*pow(2,-1,p))%p
        slots[i::p]=b"\x00"*len(slots[i::p])
sieve_end=process_time()
factorial=math.factorial(CUTOFF)
factorial_end=process_time()
chunks=0
max_bits=0
for start in range(0,SLOTS,512):
    product=math.prod(BASE+2*i for i in range(start,min(SLOTS,start+512)) if slots[i])
    if math.gcd(product,factorial)!=1:
        raise ValueError(f"invalid marked entries in chunk {start}")
    chunks+=1
    max_bits=max(max_bits,product.bit_length())
end=process_time()
receipt=dict(first=BASE, slots=SLOTS, last=BASE+2*(SLOTS-1), cutoff=CUTOFF, marked=sum(slots),
             chunk_slots=512,chunks=chunks,max_chunk_product_bits=max_bits,
             factorial_bits=factorial.bit_length(), factorial_bytes=(factorial.bit_length()+7)//8,
             sieve_seconds=sieve_end-begin,factorial_seconds=factorial_end-sieve_end,
             gcd_product_seconds=end-factorial_end, total_cpu_seconds=end-begin,wall_seconds=monotonic()-wall,
             implementation="Python standard library, native timing; no Lean replay",
             odd_slot_flags_sha256=hashlib.sha256(slots).hexdigest())
Path(__file__).with_name("high-source.json").write_text(json.dumps(receipt, indent=2)+"\n")
print(json.dumps(receipt))
