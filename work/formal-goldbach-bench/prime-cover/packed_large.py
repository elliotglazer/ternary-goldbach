"""Larger actual-prime packed fixtures; does not overwrite the smaller fixtures."""
import json
import math
import numpy as np
from flint import fmpz
from actual_cover import ROOT,D,M,small_primes,prime_window
from packed_cover import dilate,digits,timed
def shift_or(source,shifts,mask,zero):
    result=zero
    for shift in shifts:result |= source>>shift
    return result&mask==mask
pool=json.loads((ROOT/"results.json").read_text())["pools"][0]
primes=small_primes(math.isqrt(2*M+D)+1)
shifts=[(pool["base"]-q-1)//2 for q in pool["anchors"][:512]]
packed=[]; sources=[]
for width in (1<<18,1<<20):
    offset=M-width
    flags=prime_window(2*offset+1,D//2+width,primes)
    mask=(1<<width)-1;u=0
    for i,s in enumerate(shifts):
        u|=int.from_bytes(np.packbits(flags[s:s+width],bitorder="little").tobytes(),"little")
        if u==mask:
            break
    assert u==mask
    used=shifts[:i+1];lo=min(used);hi=max(used)+width
    bits=flags[lo:hi];source=int.from_bytes(np.packbits(bits,bitorder="little").tobytes(),"little")
    used=[s-lo for s in used];n=len(bits);S=max(used);m=len(used);k=(2*m).bit_length()
    p=dilate(source,n,k);a=dilate(sum(1<<(S-s) for s in used),S+1,k)
    L=((1<<(k*width))-1)//((1<<k)-1);H=(1<<(k-1))*L;K=H-L
    Hs=H<<(k*S);Ks=K<<(k*S);product=p*a
    assert (product+Ks)&Hs==Hs
    direct=np.zeros(n+S,dtype=np.uint16)
    for s in used:direct[S-s:S-s+n]+=bits
    assert np.array_equal(direct,digits(product,n+S,k))
    assert direct[S:S+width].min()>0 and direct.max()<=m<(1<<(k-1))
    packed.append(dict(width=width,m=m,k=k,S=S,source_bit_length=n,
        p_expanded_hex=hex(p),anchor_poly_hex=hex(a),Hs_hex=hex(Hs),Ks_hex=hex(Ks),
        expected=True,target_min_count=int(direct[S:S+width].min()),
        global_max_count=int(direct.max()),exact_all_coefficient_check=True,
        formula="((p_expanded * anchor_poly + Ks) & Hs) == Hs"))
    sources.append(dict(width=width,source_hex=hex(source),source_bit_length=n,shifts=used,
        expected_hex=hex(mask),base=pool["base"],target_origin=pool["base"]+2*offset,
        source_first_odd=2*offset+1+2*lo,anchors=pool["anchors"][:m]))
    print("prepared",width,m,k,S,flush=True)
(ROOT/"packed_large_fixtures.json").write_text(json.dumps(packed,indent=2))
(ROOT/"large_lean_fixtures.json").write_text(json.dumps(sources,indent=2))
print("large fixtures saved",flush=True)
out=[]
for f,s in zip(packed,sources):
    p,a,ks,hs=map(lambda x:fmpz(int(f[x],16)),("p_expanded_hex","anchor_poly_hex","Ks_hex","Hs_hex"))
    src=fmpz(int(s["source_hex"],16));mask=fmpz(int(s["expected_hex"],16));sh=s["shifts"]
    row=dict(width=f["width"],m=f["m"],k=f["k"],S=f["S"],
             flint_packed=timed(lambda:(p*a+ks)&hs==hs),
             flint_shift_or=timed(lambda:shift_or(src,sh,mask,fmpz(0))))
    out.append(row)
    print("timed",row["width"],row["flint_packed"]["median_us"],row["flint_shift_or"]["median_us"],flush=True)
(ROOT/"packed_large_timings.json").write_text(json.dumps(out,indent=2))
