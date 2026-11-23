import sys,random
from benchmark import *
sys.set_int_max_str_digits(0)
rng=random.Random(10004)
n=16
r=residual(5)
slab=json.loads((here.parent/"c10004-p20-slab/slab.json").read_bytes())
rows=[[pair[c] for pair in reversed(h["mixed"]["1"])] for h in slab["rows"][:8] for c in range(2)]
p,z=check(rows,r)
base=1<<(8*STRIDE)
def lit(x): return str(x).replace("-","~")
def L(xs):return "["+";".join(xs)+"]"
s=["Theory LanePrice","Ancestors arithmetic integer list cv_std","Libs cv_transLib intLib"]
def define(name,body):
    s.extend(["Definition "+name+"_def:",body,"End"])
def trans(name):s.append("val _ = cv_auto_trans "+name+"_def;")
define("hp_mask",f"(hp_mask 0 z b = 0:num) /\\ (hp_mask (SUC n) z b = z MOD b + {base} * hp_mask n (z DIV {base}) b)")
define("hp_pack",f"(hp_pack ([]:int list) (b:int) = 0:num) /\\ (hp_pack (x::xs) b = Num (x+b) + {base}*hp_pack xs b)")
define("hp_tails","(hp_tails ([]:int list list) = []) /\\ (hp_tails (([]:int list)::rs) = []::hp_tails rs) /\\ (hp_tails ((x::xs)::rs) = xs::hp_tails rs)")
define("hp_heads","(hp_heads ([]:int list list) = []) /\\ (hp_heads (([]:int list)::rs) = (0:int)::hp_heads rs) /\\ (hp_heads ((x::xs)::rs) = x::hp_heads rs)")
define("hp_cols","(hp_cols [] rs = []) /\\ (hp_cols (b::bs) rs = hp_pack (hp_heads rs) b :: hp_cols bs (hp_tails rs))")
define("hp_decode",f"(hp_decode 0 z = []:int list) /\\ (hp_decode (SUC n) z = 64*(&(z MOD {base})-&{bias[-1]}) :: hp_decode n (z DIV {base}))")
define("hp_round","hp_round (r:int) m d = (r*m*d+10004) / 20008")
s.extend(["val hp_pre_def = cv_trans_pre \"hp_pre\" hp_round_def;", "Theorem hp_pre_ok[cv_pre]:"," !r m d. hp_pre r m d","Proof"," simp [hp_pre_def]","QED"])
def stages(packed):
    lines=[]
    for i in range(20):
        lines.append("let a"+str(i)+" = "+("EL "+str(i)+" cs")+" in")
        if i==0: expr="a0"
        elif packed:
            c,off,cor,k,m,mask,twob=p[1][i-1]
            qb=parameters(r)[0][i-1][-1]
            inp=(f"({twob} - z{i-1})" if r<0 else f"z{i-1}")
            expr=f"hp_mask {n} ((({inp}*{c}+{off})*{m}) DIV {1<<k}) {1<<qb} + a{i} - {cor}"
        else:
            expr=f"hp_round ({lit(r)}) z{i-1} {1<<deltas[i-1]} + a{i}"
        lines.append(f"let z{i} = {expr} in")
    return "\n".join(lines)+("\nz19" if packed else "\n64*z19")
# Replace partial indexing by total list recursion.
define("hp_nthn","(hp_nthn (n:num) ([]:num list) = 0) /\\ (hp_nthn n (x::xs) = if n=0 then x else hp_nthn (n-1) xs)")
define("hp_nthi","(hp_nthi (n:num) ([]:int list) = 0) /\\ (hp_nthi n (x::xs) = if n=0 then x else hp_nthi (n-1) xs)")
define("hp_packed","hp_packed cs = "+stages(True).replace("= EL ","= hp_nthn "))
define("hp_one","hp_one cs = "+stages(False).replace("= EL ","= hp_nthi "))
define("hp_scalar","(hp_scalar [] = []) /\\ (hp_scalar (r::rs) = hp_one r :: hp_scalar rs)")
for f in ["hp_cols","hp_decode","hp_packed","hp_scalar"]:trans(f)
def measure(name,term,expected):
    define("price_"+name,"price_"+name+" = "+term)
    trans("price_"+name)
    s.extend(["val t0 = Timer.startCPUTimer ();",f'val th = cv_eval ``price_{name}``;', 'val {usr,sys} = Timer.checkCPUTimer t0;', f'val _ = if null(hyp th) andalso aconv (rhs(concl th)) ``{expected}`` then () else raise Fail "{name}";',f'val _ = print ("LANE_PRICE {name} "^Real.toString(Time.toReal(Time.+(usr,sys)))^"\\n");'])
def const(name,term):
    define(name,name+" = "+term)
    trans(name)
const("input_rows",L([L(map(lit,row)) for row in rows])+" : int list list")
const("input_bias",L(map(str,bias))+" : int list")
const("prepacked",L(map(str,p[0]))+" : num list")
out=L(map(lit,reference(rows,r)))+" : int list"
measure("scalar","hp_scalar input_rows",out)
measure("prepare","hp_cols input_bias input_rows",L(map(str,p[0]))+" : num list")
measure("hot","hp_packed prepacked",str(z)+":num")
measure("cold",f"hp_decode {n} (hp_packed (hp_cols input_bias input_rows))",out)
(here/"LanePriceScript.sml").write_text("\n".join(s)+"\n")


