"""Export actual-prime masks for native and formal checker microbenchmarks."""
import json
import math
import numpy as np
from actual_cover import ROOT,D,M,prime_window,small_primes

data=json.loads((ROOT/"results.json").read_text())
primes=small_primes(math.isqrt(2*M+D)+1)
words=data["metadata"]["words_per_case"]
offsets=[w["offset"] for w in data["windows"]]
windows={o:prime_window(2*o+1,D//2+64*words,primes) for o in offsets}
with (ROOT/"source_masks.bin").open("wb") as f:
    source_words=(D//2+64*words+63)//64+1
    f.write(np.array([len(data["pools"])*len(offsets),words,1024,source_words],dtype="<u8").tobytes())
    for pool in data["pools"]:
        shifts=np.array([(pool["base"]-q-1)//2 for q in pool["anchors"]],dtype="<u8")
        for o in offsets:
            packed=np.packbits(windows[o],bitorder="little").tobytes()
            packed+=bytes(8*source_words-len(packed))
            f.write(shifts.tobytes()); f.write(packed)
with (ROOT/"native_masks.bin").open("wb") as f:
    f.write(np.array([len(data["pools"])*len(offsets)*words,1024],dtype="<u8").tobytes())
    for pool in data["pools"]:
        shifts=np.array([(pool["base"]-q-1)//2 for q in pool["anchors"]],dtype=np.int64)
        for o in offsets:
            idx=(shifts[:,None,None]+64*np.arange(words)[None,:,None]
                 +np.arange(64)[None,None,:])
            packed=np.packbits(windows[o][idx],axis=2,bitorder="little")
            masks=packed.copy().view("<u8").reshape(1024,words).T.copy()
            f.write(masks.tobytes())

pool=data["pools"][0]
fixtures=[]
for width in (1024,16384,65536):
    offset=M-width
    shifts=[(pool["base"]-q-1)//2 for q in pool["anchors"][:512]]
    flags=prime_window(2*offset+1,D//2+width,primes)
    union=0
    for last,k in enumerate(shifts):
        mask=int.from_bytes(np.packbits(flags[k:k+width],bitorder="little").tobytes(),"little")
        union |= mask
        if union==(1<<width)-1:
            break
    assert union==(1<<width)-1
    used=shifts[:last+1]
    lo,hi=min(used),max(used)+width
    source=flags[lo:hi]
    source_int=int.from_bytes(np.packbits(source,bitorder="little").tobytes(),"little")
    relative=[k-lo for k in used]
    assert __import__("functools").reduce(int.__or__,[(source_int>>k)&((1<<width)-1) for k in relative])==union
    fixtures.append(dict(width=width,source_hex=hex(source_int),source_bit_length=len(source),
        shifts=relative,shift_unit="odd-number slots / bits",expected_hex=hex(union),
        base=pool["base"],target_origin=pool["base"]+2*offset,
        source_first_odd=2*offset+1+2*lo,
        anchors=pool["anchors"][:last+1],
        semantics="source bit i is primality of source_first_odd+2*i; slice j at shift s corresponds to target_origin+2*j minus the listed anchor"))
(ROOT/"lean_fixtures.json").write_text(json.dumps(fixtures,indent=2))
print([(f["width"],len(f["shifts"]),f["source_bit_length"]) for f in fixtures])
