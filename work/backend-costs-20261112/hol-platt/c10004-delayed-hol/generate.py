"""Build actual C40 length-five leaf integer terms and exact independent expected pairs."""
from pathlib import Path
import sys,hashlib,json
from fractions import Fraction
from time import perf_counter,process_time
root=Path(__file__).resolve().parent
sys.path.insert(0,str(root.parent/"c10004-packed-transform"))
import packed
start=process_time()
h,sources,_,files=packed.read_data(8)
S=packed.S
roots=packed.ROOTS[5]
def literal(x):return str(x).replace("-","~")
def pairs(rows):return " ".join(literal(x) for pair in rows for x in pair)
def ref(row):
    return [(sum(x*roots[k*j%5][0]-y*roots[k*j%5][1] for j,(x,y) in enumerate(row)),
             sum(x*roots[k*j%5][1]+y*roots[k*j%5][0] for j,(x,y) in enumerate(row))) for k in range(5)]
def rounded(x):return (x+S//2)//S
sizes={}
entries=[]
for leaf in range(8):
    # The sign axis is fastest. C40 repeatedly splits even and odd rows.
    vals=[]
    for xs in sources:
        vals.append([tuple(x-y for x,y in zip(xs[2*i],xs[2*i+1])) for i in range(leaf,40,8)])
    checked=[ref(row) for row in vals]
    for n in [1,4,8]:
        batches=range(8) if n==1 else range(0,8,n)
        for offset in batches:
            block=vals[offset:offset+n]
            B=max(abs(x) for row in block for z in row for x in z)
            bits=(B*packed.bound_factor(5)).bit_length()+81
            layout=packed.Layout(n,bits,0)
            row=[tuple(layout.pack([r[j][coord] for r in block]) for coord in range(2)) for j in range(5)]
            out=packed.transform(row,False,layout,True)
            for k,(x,y) in enumerate(out):
                decoded=list(zip(layout.unpack(x),layout.unpack(y)))
                assert decoded==[q[k] for q in checked[offset:offset+n]]
                assert [tuple(map(rounded,v)) for v in decoded]==[tuple(map(rounded,q[k])) for q in checked[offset:offset+n]]
            entries.append(f"{leaf} {n} {offset} {pairs(row)} {pairs(out)}")
            sizes.setdefault(n,set()).add(layout.bits)
(root/"terms.txt").write_text("\n".join(entries)+"\n")
sml=["Theory LeafPrice","Ancestors integer list cv_std","Libs cv_transLib","Definition leafrot_def:","  leafrot (wr:int) wi (z:int # int) =","    let x=FST z; y=SND z; t=wr*(x+y) in (t-y*(wr+wi), t+x*(wi-wr))","End","Definition leafscale_def:",f"  leafscale (z:int # int) = ({S}*FST z,{S}*SND z)","End","Definition leafadd_def:","  leafadd (z:int # int) (w:int # int) = (FST z+FST w,SND z+SND w)","End","Definition leaf5_def:","  leaf5 (a:int # int) b c d e =","    let a0=leafscale a; b0=leafscale b; c0=leafscale c; d0=leafscale d; e0=leafscale e"]
for k in range(1,5):
    for j,z in enumerate("bcde",1):
        wr,wi=roots[k*j%5]
        sml.append(f"      ; {z}{k}=leafrot ({literal(wr)}) ({literal(wi)}) {z}")
out=["leafadd (leafadd (leafadd (leafadd a0 b%d) c%d) d%d) e%d"%(k,k,k,k) for k in range(5)]
sml+=["    in ["+";".join(out)+"]","End"]+[f"val _=cv_auto_trans {n}_def;" for n in ("leafadd","leafscale","leafrot","leaf5")]
(root/"LeafPriceScript.sml").write_text("\n".join(sml)+"\n"+(root/"bench.smlfrag").read_text())
print(json.dumps({"cases":len(entries),"cpu":process_time()-start,"field_bits":{n:sorted(v) for n,v in sizes.items()},"source_sha256":{str(f.relative_to(root.parent)):hashlib.sha256(f.read_bytes()).hexdigest() for f in [*files[::2],packed.HOL/"c10004-roots/table.json",Path(packed.__file__)]}},indent=2))
