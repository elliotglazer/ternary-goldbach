"""Validate and time exact packed convolution on the actual-prime fixtures.

Outputs numerical operands, not a formal certificate of prime provenance.
"""
import hashlib
import json
from pathlib import Path
import statistics
import time
import numpy as np
from flint import fmpz

ROOT=Path(__file__).resolve().parent

def dilate(value,bit_length,k):
    table=[sum(((byte>>j)&1)<<(k*j) for j in range(8)).to_bytes(k,"little")
           for byte in range(256)]
    raw=value.to_bytes((bit_length+7)//8,"little")
    return int.from_bytes(b"".join(table[b] for b in raw),"little")

def digits(value,count,k):
    raw=np.frombuffer(value.to_bytes((count*k+7)//8,"little"),dtype=np.uint8)
    bits=np.unpackbits(raw,bitorder="little")[:count*k].reshape(count,k)
    return bits.astype(np.uint16) @ (1<<np.arange(k,dtype=np.uint16))

def timed(fn):
    n=20
    t=time.perf_counter()
    for _ in range(n):
        result=fn()
    elapsed=time.perf_counter()-t
    n=max(100,min(20000,int(n*.12/max(elapsed,1e-9))))
    trials=[]
    for _ in range(3):
        t=time.perf_counter(); c=time.process_time()
        for _ in range(n):
            result=fn()
        trials.append(dict(wall_seconds=time.perf_counter()-t,
                           cpu_seconds=time.process_time()-c,repetitions=n))
    return dict(median_us=statistics.median(r["wall_seconds"]/n*1e6 for r in trials),
                trials=trials)

def main():
    fixtures=json.loads((ROOT/"lean_fixtures.json").read_text())
    out=[]; measurements=[]
    for f in fixtures:
        width=f["width"]; shifts=f["shifts"]; m=len(shifts); S=max(shifts)
        assert len(set(shifts))==m
        k=(2*m).bit_length() # 2^(k-1)>m, including m a power of two.
        B=1<<k; half=B//2
        assert m<half
        source=int(f["source_hex"],16); n=f["source_bit_length"]
        assert n>=S+width
        t=time.perf_counter()
        p=dilate(source,n,k)
        a_bits=sum(1<<(S-s) for s in shifts)
        a=dilate(a_bits,S+1,k)
        L=((1<<(k*width))-1)//(B-1)
        H=half*L; K=H-L
        Hs=H<<(k*S); Ks=K<<(k*S)
        packing_seconds=time.perf_counter()-t
        product=p*a
        C=(product>>(k*S))&((1<<(k*width))-1)
        t1=((C|H)-L)&H==H
        t2=(C+K)&H==H
        t3=(product+Ks)&Hs==Hs
        assert t1 and t2 and t3
        # Independently compute every polynomial coefficient using array addition.
        src=np.unpackbits(np.frombuffer(source.to_bytes((n+7)//8,"little"),dtype=np.uint8),
                          bitorder="little")[:n].astype(np.uint16)
        direct=np.zeros(n+S,dtype=np.uint16)
        for s in shifts:
            direct[S-s:S-s+n]+=src
        decoded=digits(product,n+S,k)
        assert np.array_equal(direct,decoded)
        assert int(direct.max())<=m<half
        assert np.array_equal(digits(C,width,k),direct[S:S+width])
        assert int(direct[S:S+width].min())>0
        # A zero target digit must be detected, without borrowing elsewhere.
        j=width//2
        bad=product-(int(direct[S+j])<<(k*(S+j)))
        assert (bad+Ks)&Hs!=Hs
        row=dict(width=width,m=m,k=k,B=B,S=S,source_bit_length=n,
            p_expanded_hex=hex(p),anchor_poly_hex=hex(a),H_hex=hex(H),L_hex=hex(L),K_hex=hex(K),
            Hs_hex=hex(Hs),Ks_hex=hex(Ks),C_hex=hex(C),expected=True,
            product_bit_length=product.bit_length(),p_bit_length=p.bit_length(),
            a_bit_length=a.bit_length(),shift_bits=k*S,
            target_min_count=int(direct[S:S+width].min()),
            target_max_count=int(direct[S:S+width].max()),
            global_max_count=int(direct.max()),packing_seconds=packing_seconds,
            exact_all_coefficient_check=True,zero_digit_negative_control=True,
            formula="((p_expanded * anchor_poly + Ks) & Hs) == Hs",
            semantics="digit j of p_expanded is source bit j; anchor exponents are S-shift; target digits S..S+width-1 count covering anchors")
        out.append(row)
        fp,fa,fks,fhs=map(fmpz,(p,a,Ks,Hs))
        assert (fp*fa+fks)&fhs==fhs
        measure=dict(width=width,m=m,k=k,S=S,
            python_multiply=timed(lambda:p*a),
            python_full_test=timed(lambda:(p*a+Ks)&Hs==Hs),
            flint_multiply=timed(lambda:fp*fa),
            flint_full_test=timed(lambda:(fp*fa+fks)&fhs==fhs))
        measurements.append(measure)
        print(width,m,k,S,{a:measure[a]["median_us"] for a in
            ("python_multiply","python_full_test","flint_multiply","flint_full_test")},flush=True)
    (ROOT/"packed_fixtures.json").write_text(json.dumps(out,indent=2))
    (ROOT/"packed_timings.json").write_text(json.dumps(dict(
        script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        source_sha256=hashlib.sha256((ROOT/"lean_fixtures.json").read_bytes()).hexdigest(),
        warning="Python and FLINT numerical timing only, not Lean kernel or MM0 timing; packing and validation excluded",
        measurements=measurements),indent=2))

if __name__=="__main__":
    main()
