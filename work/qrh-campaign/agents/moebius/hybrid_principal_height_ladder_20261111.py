"""Exact hypothetical suffix/chunk geometry only; no prime/analytic evaluations."""
from pathlib import Path
import hashlib
import json

ROOT=Path(__file__).resolve().parents[4]
N,F=10**27,2**45
rows=[]
for B,S,W in [(4*10**18,111616,2048),(10**16,157,128),(2*10**16,313,256)]:
    g=S*F
    assert (S+W-1)*F+2<=B
    last=(N-6)//g
    assert last==(N-5)//g
    for fraction in (1,2,3):
        C=N*fraction//4
        assert B+3<=C<N-1
        nfirst=2*((C+1)//2)+1
        first=(nfirst-5)//g
        assert first>=1 and C<nfirst<=C+2
        assert first*g+5<=nfirst<=(first+1)*g+3
        assert last*g+5<=N-1<=(last+1)*g+3
        count=last-first+1
        assert abs(count*g-(N-C))<2*g
        j0,j1=(first-1)//4096,(last-1)//4096
        retained=(j1-j0+1)*4096
        assert 1+4096*j0<=first<1+4096*(j0+1)
        assert 1+4096*j1<=last<1+4096*(j1+1)
        assert 0<=retained-count<8192
        rows.append({"B":B,"S":S,"W_lad":W,"hypothetical_C":C,
                     "first_uncovered_odd":nfirst,"first_rung":first,"last_rung":last,
                     "suffix_rungs":count,"first_chunk":j0,"last_chunk":j1,
                     "retained_whole_chunk_rungs":retained})
# Original generator's chunk/file partition, without executing it.
oldmax=(N-5)//(111616*F)
chunks=(oldmax+4095)//4096
base,extra=divmod(chunks,128)
assert (base,base+1)==(485,486)
assert 486*4096==1990656
paths=[
 "work/ternary-goldbach/TernaryGoldbach/Ladder/Check.lean",
 "work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean",
 "work/ternary-goldbach/TernaryGoldbach/Ladder/Main.lean",
 "work/ternary-goldbach/TernaryGoldbach/Ladder/Data.lean",
 "work/ternary-goldbach/scripts/gen_ladder.py",
 "work/qrh-blueprint/HYBRID_LADDER_COST_FRONTIER_2026-11-11.md",
]
A,B=10**20,2*10**16
C=A+B
f=2**34
width=2048
stride=(B-2)//f-(width-1)
g=stride*f
last=(C-6)//g
padded32=((last+31)//32)*32
assert (stride,g,last,padded32)==(1162106,19964829057941504,5009,5024)
assert (stride+width-1)*f+2==19999996250161154<B
assert stride*padded32<f and f*f>C
assert stride<2**21 and padded32<2**13
assert last*g+5<=C-1<=(last+1)*g+3
bertrand=Path("C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/NumberTheory/Bertrand.lean")
bertrand_hash=hashlib.sha256(bertrand.read_bytes()).hexdigest().upper()
assert bertrand_hash=="91AED0AE5E324993157982FF06A5EB8002FD7224C2A3FA1B47DB937650CEF9DD"
out={"scope":"Exact hypothetical coverage geometry and source pins, not analytic coverage or runtime.",
     "hypothetical_rows":rows,"original_chunks":chunks,"original_file_base_chunks":base,
     "original_extra_chunk_files":extra,
     "fallback_patch":{"A":A,"B":B,"C":C,"m":34,"F":f,"W_lad":width,
                       "S":stride,"g":g,"last_required":last,"padded32":padded32,
                       "padded4096":((last+4095)//4096)*4096,
                       "last_cell_low":last*g+5,"last_cell_high":(last+1)*g+3},
     "bertrand_source":{"path":str(bertrand),"sha256":bertrand_hash},
     "pins":[{"path":p,"sha256":hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()} for p in paths]}
Path(__file__).with_suffix(".json").write_text(json.dumps(out,indent=2)+"\n",encoding="utf-8")
print("PASS: exact suffix/chunk geometry only")
