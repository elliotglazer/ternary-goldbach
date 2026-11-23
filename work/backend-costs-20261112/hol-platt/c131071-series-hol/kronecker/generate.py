from pathlib import Path
import sys,json
sys.set_int_max_str_digits(0)
p=Path(__file__).resolve().parent
cases=json.loads((p.parent/"cases.json").read_text())
lines=iter((p.parent/"terms.txt").read_text().splitlines())
common=(p.parent/"pair/NatPairScript.sml").read_text()
s=[common[:common.index("Definition bits_def")].replace("Theory NatPair","Theory KDot")]
def df(n,b):s.extend(["Definition "+n+"_def:",b,"End"])
df("mom","mom (q:num) z k = if z < q then (q ** k - z ** k) DIV (q-z) else 0")
df("ap","(ap ([]:int list) (e:int) b t alter = 0:num) /\\ (ap (x::xs) e b t alter = Num (e+(if alter /\\ t then -x else x)) + b*ap xs e b (~t) alter)")
df("ac","ac xs ys e b shift alt = ap xs e b F alt + shift*ap ys e b F alt")
df("pairout","pairout prod (h:num) (b:num) (cut:num) (cut2:num) v = if cut=0 \\/ cut2=0 \\/ b=0 then (0:int,0:int) else (rnd v (&((prod DIV cut) MOD b) - &h), rnd v (&((prod DIV cut2) MOD b) - &h))")
df("provided","(provided ([]:num list) hs (r:int) pos neg b x y v = []:int list) /\\ (provided (a::ws) [] r pos neg b x y v = []) /\\ (provided (a::ws) (h::hs) r pos neg b x y v = let (l,m)=pairout ((if r<0 then neg else pos)*a) h b x y v in l::m::provided ws hs (r+1024) pos neg b x y v)")
df("makeq","(makeq 0 (r:int) q k e = []:num list) /\\ (makeq (SUC n) r q k e = e*mom q (Num(ABS r)) k :: makeq n (r+1024) q k e)")
df("cold","cold n r q k xs ys e b x y shift v = provided (makeq n r (q*b) k 1) (makeq n r q k (Num e)) r (ac xs ys e b shift F) (ac xs ys e b shift T) b x y v")
for name in ["signed","cold"]:s.append("val _=cv_auto_trans "+name+"_def;")
with (p/"terms.txt").open("w") as out:
 for c in cases:
    next(lines);xy=[];ex=[];ds=[]
    d=c["d"];q=2*131071;den=q**d
    for _ in range(2):
        D=list(map(int,next(lines).split()));next(lines);E=list(map(int,next(lines).split()))
        ds.append(D);ex.append(E);xy.append([x//q**(d-j) for j,x in enumerate(D)])
    e=1+max(abs(x) for arr in xy for x in arr)
    B=1<<(3*e*den).bit_length()
    cut=B**d;cut2=B**(3*d+1);shift=B**(2*d+1)
    AA=[sum(((e+x*((-1)**j if neg else 1))+shift*(e+y*((-1)**j if neg else 1)))*B**j for j,(x,y) in enumerate(zip(*xy))) for neg in [0,1]]
    for start,size,mode in [(0,128,"full"),(0,8,"neg"),(120,8,"pos")]:
      lo=c["r"]+start*1024
      W=[];H=[];outv=[]
      for i in range(start,start+size):
        r=c["r"]+1024*i;z=abs(r);weights=[z**j*q**(d-j) for j in range(d+1)];w=sum(t*B**(d-j) for j,t in enumerate(weights));h=e*sum(weights)
        assert w==((B*q)**(d+1)-z**(d+1))//(B*q-z)
        G=AA[int(r<0)]*w
        result=[((G//C)%B-h+den//2)//den for C in (cut,cut2)]
        assert result==[ex[0][i],ex[1][i]]
        W.append(w);H.append(h);outv+=result
      print(c["name"]+"_"+mode,size,lo,d+1,q,den,e,B,cut,cut2,shift,file=out)
      for row in [*ds,*xy,AA,W if mode!="full" else [],H if mode!="full" else [],outv]:print(*row,file=out)
s.append((p/"bench.smlfrag").read_text())
(p/"KDotScript.sml").write_text("\n".join(s)+"\n")
