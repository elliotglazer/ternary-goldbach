import hashlib,json,sys
from pathlib import Path
sys.set_int_max_str_digits(0)
here=Path(__file__).resolve().parent
src=(here.parent.parent/"c10004-p20-slab/slab.json").read_bytes()
assert hashlib.sha256(src).hexdigest()=="ed4ad0e7516fedcb62bf7fec7cc94076b4222d80ce7c7238fcc47d2b5ef54d05"
slab=json.loads(src)
r=-4884
v=20008
n=16
rows=[[z[c] for z in reversed(h["mixed"]["1"])] for h in slab["rows"][:8] for c in range(2)]
pin=json.loads((here.parent.parent/"c10004-exact-horner/h1-8-a5.json").read_text())
degree=len(pin["columns"])-1
skip=19-degree
assert all(not any(row[:skip]) for row in rows)
rows=[row[skip:] for row in rows]
factors=[(1<<(94-g))*v**p for p,g in enumerate(reversed(slab["grids"][:degree+1]))]
B=1<<(8*pin["width_bytes"])
one=sum(B**i for i in range(n))
offset=one*(B//2)
cols=[sum(row[i]*f*B**j for j,row in enumerate(rows)) for i,f in enumerate(factors)]
assert cols==list(reversed(pin["columns"]))
z=cols[0]
xs=[row[0]*factors[0] for row in rows]
for i in range(1,degree+1):
    z=r*z+cols[i]
    xs=[r*x+row[i]*factors[i] for row,x in zip(rows,xs)]
    assert max(map(abs,xs))<B//2
    assert all((z+offset)//(B**j)%B-B//2==x for j,x in enumerate(xs))
assert z==pin["packed_numerator"]
den=v**degree
out=[(x+den//2)//den for x in xs]
assert out==pin["centers"]
def lit(x):return str(x).replace("-","~")
def L(xs):return "["+";".join(map(str,xs))+"]"
s=["Theory Delayed","Ancestors arithmetic integer list cv_std","Libs cv_transLib intLib"]
def df(name,body):s.extend(["Definition "+name+"_def:",body,"End"])
def translate(name):s.append("val _ = cv_auto_trans "+name+"_def;")
df("heads","(heads ([]:int list list) = []) /\\ (heads ([]::rs) = (0:int)::heads rs) /\\ (heads ((x::xs)::rs) = x::heads rs)")
df("tails","(tails ([]:int list list) = []) /\\ (tails ([]::rs) = []::tails rs) /\\ (tails ((x::xs)::rs) = xs::tails rs)")
df("packc",f"(packc ([]:int list) (f:int) = 0:int) /\\ (packc (x::xs) f = x*f + &{B}*packc xs f)")
df("columns","(columns ([]:int list) rows = []) /\\ (columns (f::fs) rows = packc (heads rows) f :: columns fs (tails rows))")
df("step","(step ([]:int list) (z:int) = z) /\\ (step (x::xs) z = step xs (x-4884*z))")
df("evalp","(evalp ([]:int list) = 0:int) /\\ (evalp (x::xs) = step xs x)")
df("round_final",f"round_final (x:int) = (x + &{den//2}) / &{den}")
s.extend(['val pre_def = cv_trans_pre "round_pre" round_final_def;','Theorem pre_ok[cv_pre]:',' !x. round_pre x','Proof',' simp [pre_def]','QED'])
df("decode",f"(decode 0 (z:num) = []:int list) /\\ (decode (SUC n) z = round_final (&(z MOD {B}) - &{B//2}) :: decode n (z DIV {B}))")
df("scalar","(scalar ([]:int list) (fs:int list) (z:int) = z) /\\ (scalar (x::xs) [] z = z) /\\ (scalar (x::xs) (f::fs) z = scalar xs fs (x*f-4884*z))")
df("scalars","(scalars ([]:int list list) fs = []) /\\ (scalars (x::xs) fs = round_final (scalar x fs 0) :: scalars xs fs)")
for t in ["columns","evalp","decode","scalars"]:translate(t)
for key,term in [("rows",L([L(map(lit,row)) for row in rows])+" : int list list"),("factors",L(factors)+" : int list"),("cached",L(map(lit,cols))+" : int list")]:
    df(key,key+" = "+term)
    translate(key)
for name,term,exp in [("scalar","scalars rows factors",L(map(lit,out))+" : int list"),("prepare","columns factors rows",L(map(lit,cols))+" :int list"),("hot","evalp cached",f"{lit(z)}:int"),("warm",f"decode {n} (Num (evalp cached + &{offset}))",L(map(lit,out))+" :int list"),("cold",f"decode {n} (Num (evalp (columns factors rows) + &{offset}))",L(map(lit,out))+" :int list")]:
    df("p_"+name,"p_"+name+" = "+term)
    translate("p_"+name)
    s.extend(['val t0=Timer.startCPUTimer();',f'val th=cv_eval ``p_{name}``;','val {usr,sys}=Timer.checkCPUTimer t0;',f'val _ = if null(hyp th) andalso aconv (lhs(concl th)) ``p_{name}`` andalso aconv (rhs(concl th)) ``{exp}`` then () else raise Fail "{name}";',f'val _ = print ("DELAYED_PRICE {name} "^Real.toString(Time.toReal(Time.+(usr,sys)))^"\\n");'])
(here/"DelayedScript.sml").write_text("\n".join(s)+"\n")
(here/"outputs.json").write_text(json.dumps(out)+"\n")

