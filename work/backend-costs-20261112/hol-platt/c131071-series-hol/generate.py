from pathlib import Path
import json,sys,hashlib,math,time
sys.set_int_max_str_digits(0)
p=Path(__file__).resolve().parent
gr=[94,94,94,94,91,89,89,89,83,81,81,81,75,73,73,73,65,65,65,65]
low=json.loads((p.parent/"c10004-p20-source/h1-mixed.json").read_bytes())
edge=json.loads((p.parent/"c10004-exact-horner/edge-slab.json").read_bytes())
s=["Theory Series","Ancestors arithmetic integer list cv_std","Libs cv_transLib intLib"]
def df(name,body):s.extend(["Definition "+name+"_def:",body,"End"])
df("poly","(poly (r:int) ([]:int list) = 0) /\\ (poly r (x::xs) = x+r*poly r xs)")
df("vals","(vals 0 (r:int) cs = []) /\\ (vals (SUC n) r cs = poly r cs :: vals n (r+1024) cs)")
df("diff","(diff (z:int) ([]:int list) = []) /\\ (diff z (x::xs) = x-z :: diff x xs)")
df("repeatdiff","(repeatdiff 0 xs = xs) /\\ (repeatdiff (SUC n) xs = repeatdiff n (diff 0 xs))")
df("roundq","roundq (v:int) x = (x+v / 2) / v")
s.extend(['val rd_p_def=cv_trans_pre "rd_p" roundq_def;','Theorem rd_ok[cv_pre]:',' !v x. v <> 0 ==> rd_p v x','Proof',' simp [rd_p_def]','QED'])
df("rounded","(rounded v ([]:int list) = []) /\\ (rounded v (x::xs) = roundq v x :: rounded v xs)")
df("get","(get 0 (z:num) (b:num) = []:int list) /\\ (get (SUC n) z b = (&(z MOD b) - &(b DIV 2)) :: get n (z DIV b) b)")
df("geom","(geom 0 (b:num) = 0:num) /\\ (geom (SUC n) b = 1+b*geom n b)")
df("boundok","boundok (R:int) (b:num) (cs:int list) <=> 2*poly R (MAP ABS cs) < &b")
# Literal coefficient bound allows a small positive fixed upper bound for R.
df("boundpoly","(boundpoly (r:int) ([]:int list) = 0) /\\ (boundpoly r (x::xs) = ABS x+r*boundpoly r xs)")
df("divides0","divides0 (j:int) (x:int) <=> if j = 0 then F else x % j = 0")
s.append("val _ = cv_auto_trans divides0_def;")
df("cert","cert (n:num) (k:num) (r:int) (R:int) (b:num) (cs:int list) (z:int) <=> LENGTH cs=k /\\ 2*boundpoly R cs < &b /\\ ABS r <= R /\\ ABS (r+1024* &(n-1)) <= R /\\ 0 <= z + &((b DIV 2)*geom n b) /\\ z + &((b DIV 2)*geom n b) < &(b ** n) /\\ divides0 (&(b ** n)) ((1 - &b) ** k * z - poly (&b) (repeatdiff k (vals k r cs)))")
df("sink","sink n b (v:int) (z:int) = rounded v (get n (Num (z + &((b DIV 2)*geom n b))) b)")
df("direct","direct n r cs v = rounded v (vals n r cs)")
for i in ["cert","sink","direct"]:
    s.append(f'val {i}_p_def=cv_trans_pre "{i}_p" {i}_def;' if False else f'val _=cv_auto_trans {i}_def;')
# Define generic denominator operations at genuine positive values with total branches.
s=[line.replace('roundq (v:int) x = (x+v / 2) / v','roundq (v:int) x = if v=0 then 0 else (x+v / 2) / v').replace('v <> 0 ==> rd_p v x','rd_p v x').replace('LENGTH cs=k /\\','b <> 0 /\\ LENGTH cs=k /\\') for line in s]
# Explicitly guard division by variable b during digit extraction.
s=[line.replace('= (&(z MOD b) - &(b DIV 2)) :: get n (z DIV b) b','= if b=0 then [] else (&(z MOD b) - &(b DIV 2)) :: get n (z DIV b) b') for line in s]
cases=[]
for name,k,coeff in [('low',512,low['512']),('edge',1,edge['rows'][-1]['mixed']['1'])]:
    c=131071
    a=max(1,(2*c*k-c)//2048+1)
    end=min(c-1,(2*c*k+c)//2048)
    n=end-a+1
    assert all(math.gcd(c,i)==1 for i in range(a,end+1))
    r=1024*a-c*k
    R=max(abs(r),abs(r+(n-1)*1024))
    d=max(j for j,z in enumerate(coeff) if any(z))
    v=(2*c)**d
    ds=[[z[t]*(1<<(94-gr[j]))*(2*c)**(d-j) for j,z in enumerate(coeff[:d+1])] for t in range(2)]
    bound=max(sum(abs(x)*R**i for i,x in enumerate(xs)) for xs in ds)
    w=8*((bound.bit_length()+8)//8)
    B=1<<w
    streams=[]
    for xs in ds:
        start=time.process_time()
        ys=[sum(x*(r+i*1024)**j for j,x in enumerate(xs)) for i in range(n)]
        z=sum(x*B**i for i,x in enumerate(ys))
        secs=time.process_time()-start
        out=[(x+v//2)//v for x in ys]
        streams.append((xs,z,out,secs))
    cases.append(dict(name=name,h=1 if name=="low" else 6400,cell=k,a=a,end=end,n=n,r=r,R=R,d=d,w=w,v=v,B=B,streams=streams))
with (p/"terms.txt").open("w") as f:
    for c in cases:
        print(c["name"],*(c[t] for t in ["n","d","r","R","B","v"]),file=f)
        for xs,z,out,_ in c["streams"]:
            print(*xs,file=f);print(z,file=f);print(*out,file=f)
(p/"cases.json").write_text(json.dumps([{**{k:v for k,v in c.items() if k!='streams'},'candidate_times':[x[-1] for x in c['streams']]} for c in cases],indent=2))
s.append((p/"bench.smlfrag").read_text())
(p/"SeriesScript.sml").write_text("\n".join(s)+"\n")


