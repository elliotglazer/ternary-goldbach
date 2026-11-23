"""Export exact selected 64-bit update traces, with accumulator resets and slices."""
import json
import math
import numpy as np
from actual_cover import ROOT,D,M,FULL,prime_window,small_primes

data=json.loads((ROOT/"results.json").read_text())
rows=[json.loads(s) for s in (ROOT/"words.jsonl").read_text().splitlines()]
pools={p["key"]:p for p in data["pools"]}
selected=[r for r in rows if r["size"]==512 and r["offset"]>4_000_000_000
          and r["pool"] in ("b0-nearest","b1-nearest")]
words=data["metadata"]["words_per_case"]
offset=selected[0]["offset"]
primes=small_primes(math.isqrt(2*M+D)+1)
flags=prime_window(2*offset+1,D//2+64*words,primes)
packed=np.packbits(flags,bitorder="little").tobytes()+bytes(8)
source_words=np.frombuffer(packed,dtype="<u8")
native=np.fromfile(ROOT/"native_masks.bin",dtype="<u8")
nr,nc=map(int,native[:2]);native=native[2:].reshape(nr,nc)
out=[]
for row in selected:
    p=pools[row["pool"]];acc=0;updates=[]
    pi=next(i for i,v in enumerate(data["pools"]) if v["key"]==row["pool"])
    native_row=pi*5*words+4*words+row["word"]
    for anchor in row["greedy_selected"]:
        q=p["anchors"][anchor]
        bit_index=(p["base"]-q-1)//2+64*row["word"]
        aligned,shift=divmod(bit_index,64)
        lo,hi=map(int,source_words[aligned:aligned+2])
        mask=((lo>>shift)|(hi<<(64-shift) if shift else 0))&FULL
        assert mask==int(native[native_row,anchor])
        before=acc;acc|=mask
        updates.append(dict(anchor_index=anchor,anchor=q,
            source_lo_hex=f"0x{lo:016x}",source_hi_hex=f"0x{hi:016x}",shift=shift,
            mask_hex=f"0x{mask:016x}",acc_before_hex=f"0x{before:016x}",
            acc_after_hex=f"0x{acc:016x}"))
    assert acc==FULL
    out.append(dict(id=f"{row['pool']}-{row['word']}",pool=row["pool"],
        target_start=row["target_start"],native_fixture_row=native_row,
        reset_hex="0x0000000000000000",updates=updates,expected_hex="0xffffffffffffffff"))
result=dict(metadata=dict(word_count=len(out),update_count=sum(len(r["updates"]) for r in out),
    width=64,selection="512-pool greedy; highest sampled offset; two distinct near-4e18 bases",
    slice_semantics="mask=((lo>>shift)|(hi<<(64-shift))) mod 2^64; shift=0 uses lo only",
    sequence_semantics="reset accumulator to 0 at each word; OR each selected mask in listed order",
    checked_against="native_masks.bin and words.jsonl",formal_prime_certificate=False),words=out)
(ROOT/"actual_trace.json").write_text(json.dumps(result,indent=2))
print(result["metadata"])
