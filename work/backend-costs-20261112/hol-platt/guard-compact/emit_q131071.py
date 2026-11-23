"""Instantiate HOL4 bounds using the pinned q131071 j5694 k266 inputs."""
from pathlib import Path
from fractions import Fraction as F
from hashlib import sha256
from math import floor
import json

here=Path(__file__).resolve().parent
base=here.parent
archive=base/"dispatched-score/precision-fine-hidden.json"
gamma=base/"guard-repricing/gamma-magnitude-p24.bin"
def H(p): return sha256(p.read_bytes()).hexdigest()
assert H(gamma)=="bea652361b24592515de478748f2eafc0e97fa07fe404787ac3aa62e949bcb7c"
j,k,p=5694,266,24
a=k%2
rows=json.loads(archive.read_bytes())
assert rows["q"]==131071
v,d=next((int(v),int(d)) for jj,kk,pp,v,d in rows["rows"] if (jj,kk,pp)==(j,k,p))
assert d>0 and v+d<0
off=4*(2*j+a)
record=gamma.read_bytes()[off:off+4]
ex=int.from_bytes(record[:1],"big",signed=True)
lo=2**24 + int.from_bytes(record[1:],"big")
g0=lo*F(2)**(ex-24); g1=(lo+1)*F(2)**(ex-24)
spec=dict(q=131071,j=j,k=k,p=p,parity=a,t=str(F(5*j,64)),full=[v,d],full_sha256=H(archive),
  gamma_sha256=H(gamma),offset=off,record=record.hex(),gain=[str(g0),str(g1)],known_midpoint=rows["midpoint"]["266/24"])
def R(x):
    x=F(x)
    if x<0:return "(-"+R(-x)+")"
    if x.denominator==1:return str(x.numerator)
    return f"({x.numerator}/{x.denominator})"

def lemma(name,v,d,lo,hi):
    unit=2**(3*p)
    output=2**p
    l,h=F(output,unit)*lo,F(output,unit)*hi
    c=v*(l+h)/2
    z=floor(c+F(1,2));rad=abs(v)*(h-l)/2+d*h+abs(c-z)
    theorem=f"""
Theorem {name}:
 !amp gain. abs({unit}*amp-{R(v)}) <= {d} /\\
  {R(lo)}<=gain /\\ gain<={R(hi)} ==>
  abs({output}*(amp*gain)-{R(z)}) <= {R(rad)}
Proof
 rpt gen_tac >> strip_tac >>
 mp_tac (Q.SPECL [`{R(v)}:int`,`{d}:int`,`{R(l)}:real`,`{R(h)}:real`,
   `{unit}*amp:real`,`{R(F(output,unit))}*gain:real`] spectral_node) >>
 impl_tac >- (simp[real_of_int_num,real_of_int_neg] >> REAL_ASM_ARITH_TAC) >>
 `node_center {R(v)} {R(l)} {R(h)} = {R(z)}:int` by
  (simp_tac bool_ss [node_center_def,nearest_def,INT_FLOOR',raw_center_def,midpoint_def,
     real_of_int_num,real_of_int_neg] >> REAL_ARITH_TAC) >>
 asm_simp_tac bool_ss [node_radius_def,raw_radius_def,raw_center_def,midpoint_def,halfwidth_def,
   real_of_int_num,real_of_int_neg,abs] >> REAL_ASM_ARITH_TAC
QED
"""
    return theorem, dict(z=z,radius=str(rad),input_unit=unit,output_unit=output)
text, spec["full_identity"]=lemma("q131071_full_gain_one",v,d,1,1)
packet=base/"dispatched-score/precision-gain-packet.json"
if packet.exists():
    row=json.loads(packet.read_bytes())
    assert (row["q"],row["j"],row["k"],row["p"])==(131071,j,k,p)
    text2,spec["phase_only_scaled"]=lemma("q131071_phase_gain",int(row["pregain"]["v"]),int(row["pregain"]["d"]),g0,g1)
    text+=text2
    spec["phase_only_packet_sha256"]=H(packet)
    pv,pd=int(row["pregain"]["v"]),int(row["pregain"]["d"])
    z=spec["phase_only_scaled"]["z"]; rr=F(spec["phase_only_scaled"]["radius"])
    text+=f"""
Theorem q131071_compact_node:
 !xs scale key f amp gain. admitted_r scale xs /\\ abs(scale*f-real_of_int key)<=1/2 /\\
 abs({2**(3*p)}*amp-{R(pv)})<={pd} /\\ {R(g0)}<=gain /\\ gain<={R(g1)} ==>
 admitted_r scale ((key,{R(z)},f,{2**p}*(amp*gain),{R(rr)})::xs)
Proof
 rpt gen_tac >> strip_tac >>
 mp_tac (Q.SPECL [`amp:real`,`gain:real`] q131071_phase_gain) >>
 impl_tac >- asm_rewrite_tac[] >>
 asm_simp_tac bool_ss [CompactRadiiTheory.admitted_r_def,real_of_int_num,real_of_int_neg] >>
 REAL_ARITH_TAC
QED
"""
    from math import prod
    nodes=list(range(5690,5700))
    midpoint=F(11389,2)
    w=[prod((midpoint-m)/(n-m) for m in nodes if m!=n) for n in nodes]
    balls={jj:(int(vv),int(dd)) for jj,kk,pp,vv,dd in rows["rows"] if kk==k and pp==p}
    constraints=[]
    center=F(0);err=F(1,4); terms=[]
    for ix,(n,wt) in enumerate(zip(nodes,w)):
        term=f"x{ix}"
        if n==j:
            b=spec["phase_only_scaled"]
            c,rr=F(b["z"],2**p),F(b["radius"])/2**p
            term="(amp*gain)"
        else:
            nv,nd=balls[n]; c,rr=F(nv,2**(3*p)),F(nd,2**(3*p))
            constraints.append(f"abs({term}-{R(c)})<={R(rr)}")
        center+=wt*c;err+=abs(wt)*rr
        terms.append(f"{R(wt)}*{term}")
    assert center>err
    constraints.extend([f"abs({2**(3*p)}*amp-{R(int(row['pregain']['v']))})<={row['pregain']['d']}",
                        f"{R(g0)}<=gain",f"gain<={R(g1)}","abs(y-("+"+".join(terms)+"))<=1/4"])
    spec["midpoint_certificate"]=dict(nodes=nodes,weights=list(map(str,w)),lower=str(center-err),
            remainder_assumed="1/4",conditional_lower_positive=True)
    text+="\nTheorem midpoint_11389_2_positive:\n !amp gain y "+" ".join(f"x{n}" for n in range(10) if nodes[n]!=j)+".\n  "
    text+=" /\\\n  ".join(constraints)+" ==> 0<y\nProof\n rpt gen_tac >> strip_tac >>\n"
    text+=" mp_tac (Q.SPECL [`amp:real`,`gain:real`] q131071_phase_gain) >>\n"
    text+=" impl_tac >- asm_rewrite_tac[] >> PURE_REWRITE_TAC[ABS_BOUNDS] >> fs[ABS_BOUNDS] >> REAL_ASM_ARITH_TAC\nQED\n"
(here/"Q131071NodeScript.sml").write_text("Theory Q131071Node\nAncestors SpectralNode real integer intreal\nLibs realLib intLib\nval _=realLib.prefer_real();\n"+text)
(here/"q131071-node.json").write_text(json.dumps(spec,indent=2)+"\n")
