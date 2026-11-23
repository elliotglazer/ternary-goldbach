from pathlib import Path
import json,hashlib
here=Path(__file__).resolve().parent
blob=(here.parent.parent/"c10004-exact-horner/edge-slab.json").read_bytes()
assert hashlib.sha256(blob).hexdigest()=="5e31d220f4890d833aab8de201ae4113ca59aa391b3329f8b4d99ba3c3ab8f49"
slab=json.loads(blob)
v=20008
s=["Theory Throughput","Ancestors arithmetic integer list cv_std","Libs cv_transLib intLib"]
def df(n,b):s.extend(["Definition "+n+"_def:",b,"End"])
def trans(n):s.append("val _ = cv_auto_trans "+n+"_def;")
# Use a fixed positive denominator for each rounded operation.
for name,den in [("rm",20008),("rd",20008**19)]:
    df(name,f"{name} (x:int) = (x + {den//2}) / {den}")
    s.extend([f'val {name}_p_def = cv_trans_pre "{name}_p" {name}_def;',f'Theorem {name}_ok[cv_pre]:',f' !x. {name}_p x','Proof',f' simp [{name}_p_def]','QED'])
for mode in ["delayed","mixed"]:
    f="loop_"+mode
    expr="r*z+x*g" if mode=="delayed" else "rm (r*z*g)+x"
    df(f,f"({f} (r:int) (fs:int list) ([]:int list) (z:int) = z) /\\ ({f} r [] (x::xs) z = z) /\\ ({f} r (g::gs) (x::xs) z = {f} r gs xs ({expr}))")
    row="row_"+mode
    df(row,f"{row} r fs xs = "+(f"rd ({f} r fs xs 0)" if mode=="delayed" else f"{f} r fs xs 0"))
    many="many_"+mode
    df(many,f"({many} r fs ([]:int list list) = []) /\\ ({many} r fs (x::xs) = {row} r fs x :: {many} r fs xs)")
    test="test_"+mode
    df(test,f"({test} (rs:int list) ([]:int list list) fs xs <=> rs = []) /\\ ({test} [] (y::ys) fs xs <=> F) /\\ ({test} (r::rs) (y::ys) fs xs <=> {many} r fs xs = y /\\ {test} rs ys fs xs)")
    trans(test)
def lit(x):return str(x).replace("-","~")
def L(xs):return "["+";".join(xs)+"]"
def ints(xs):return L(map(lit,xs))
cells=[]
for cell,aa in slab["cells"].items():
    original=[[pair[c] for pair in reversed(h["mixed"][cell])] for h in slab["rows"] for c in range(2)]
    skip=0
    while all(x[skip]==0 for x in original):skip+=1
    degree=19-skip
    assert degree==19
    rows=[x[skip:] for x in original]
    grids=list(reversed(slab["grids"][:degree+1]))
    delayed=[(1<<(94-g))*v**i for i,g in enumerate(grids)]
    mixed=[1]+[1<<(b-a) for a,b in zip(grids,grids[1:])]
    rs=[1024*a-int(cell)*10004 for a in aa]
    def outputs(mode,r):
        out=[]
        for row in rows:
            z=0
            for f,x in zip(delayed if mode=="delayed" else mixed,row):
                z=r*z+x*f if mode=="delayed" else (r*z*f+10004)//v+x
            out.append((z+v**19//2)//v**19 if mode=="delayed" else z)
        return out
    for a,r in zip(aa,rs):
        assert outputs("mixed",r)==[x for h in slab["rows"] for x in next(y[1:] for y in h["outputs"][cell] if y[0]==a)]
    cells.append(dict(rows=rows,rs=rs,delayed=delayed,mixed=mixed,dy=[outputs("delayed",r) for r in rs],my=[outputs("mixed",r) for r in rs]))
# Build ML-syntax integral lists outside the quotation parser, then time admission.
with (here/"terms.txt").open("w") as f:
    for c in cells:
        for k in ["rows","rs","delayed","mixed","dy","my"]:
            item=c[k]
            if isinstance(item[0],list):
                print(len(item),len(item[0]),*(v for row in item for v in row),file=f)
            else:
                print(len(item),*item,file=f)
# Separate timing into stock cv_compute pipeline phases using the existing timing harness.
s.append((here/"bench.smlfrag").read_text())
(here/"ThroughputScript.sml").write_text("\n".join(s)+"\n")


