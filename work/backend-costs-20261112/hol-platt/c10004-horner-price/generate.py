from pathlib import Path
from math import gcd
import hashlib,json
here=Path(__file__).resolve().parent
receipt=here.parents[2]/"qrh-campaign/agents/integration/guarded_residue_evaluation_frontier_20261111.json"
blob=receipt.read_bytes()
assert hashlib.sha256(blob).hexdigest().upper()=="DA5B4B1C09A5D6F10D8B1133AF5F2BD95E9711BDB309DD1F1FEAB4E8E7E1A5F7"
rec=json.loads(blob)["selected_records"]["band1_K20_b94"]
stages=rec["stages"]
widths=[s["Mbits"] for s in stages]+[rec["output_signed_bits"]]
def coeff(i,k):
    size=2**(widths[i]-4)
    return ((-1)**i*(size+k),(-1)**(i//2)*(size//2+2*k+1))
def reference(a):
    k=(2048*a+10003)//20008
    r=1024*a-k*10004
    m=coeff(0,k)
    for i,s in enumerate(stages):
        assert all(abs(x).bit_length()<=s["Mbits"] for x in m)
        delta=s["grids"][1]-s["grids"][0]
        v=20008
        n=coeff(i+1,k)
        rounded=[]
        for val,co in zip(m,n):
            x=(r*val)<<delta
            l,rem=divmod(x,v)
            l+=2*rem>=v
            assert -v<=2*(x-l*v)<v
            rounded.append(l+co)
        m=rounded
    return tuple(64*x for x in m)
def lit(x):return str(x).replace("-","~")
def pair(x):return "("+",".join(map(lit,x))+")"
sml=["Theory Price","Ancestors integer list cv_std","Libs cv_transLib","Definition hp_round_def:","  hp_round (r:int) m d = (r*m*d+10004) / 20008","End","Definition hp_poly_def:","  hp_poly (a:num) =","    let k = &((2048*a+10003) DIV 20008):int; r = &(1024*a)-10004*k;"]
for i, width in enumerate(widths):
    size=2**(width-4)
    x=f"({size}+k)"
    y=f"({size//2}+2*k+1)"
    if i%2:x="~"+x
    if (i//2)%2:y="~"+y
    if i:
        lo,hi=stages[i-1]["grids"]
        x=f"hp_round r x{i-1} {2**(hi-lo)} + "+x
        y=f"hp_round r y{i-1} {2**(hi-lo)} + "+y
    sml.append(f"        x{i} = {x}; y{i} = {y}"+(";" if i<19 else ""))
sml.extend(["    in (64*x19,64*y19)","End","Definition hp_rows_def:", "  (hp_rows ([]:num list) = []) /\\", "  (hp_rows (a::rest) = hp_poly a :: hp_rows rest)", "End",'val hp_pre_def = cv_trans_pre "hp_pre" hp_round_def;',"Theorem hp_pre_ok[cv_pre]:","  !r m d. hp_pre r m d","Proof","  simp [hp_pre_def]","QED","val _ = cv_auto_trans hp_poly_def;","val _ = cv_auto_trans hp_rows_def;"])
units=[a for a in range(1,10004) if gcd(a,10004)==1]
assert len(units)==4800
for i in range(0,len(units),64):
    us=units[i:i+64]
    tm="hp_rows ["+";".join(map(str,us))+"]"
    expected="["+";".join(pair(reference(a)) for a in us)+"] : (int # int) list"
    sml.extend([f"val tm = ``{tm}``;",f"val expct = ``{expected}``;","val t0 = Timer.startCPUTimer ();","val th = cv_eval tm;","val {usr,sys} = Timer.checkCPUTimer t0;","val _ = if null(hyp th) andalso aconv (rhs(concl th)) expct andalso aconv (lhs(concl th)) tm then () else raise Fail \"output mismatch\";",f'val _ = print ("PRICE_GROUP {i//64} " ^ Real.toString(Time.toReal(Time.+(usr,sys))) ^ "\\n");'])
(here/"PriceScript.sml").write_text("\n".join(sml)+"\n",encoding="ascii")

