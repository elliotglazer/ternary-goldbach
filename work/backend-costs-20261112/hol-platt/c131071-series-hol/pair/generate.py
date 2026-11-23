from pathlib import Path
import json,sys
sys.set_int_max_str_digits(0)
p=Path(__file__).resolve().parent
cases=json.loads((p.parent/"cases.json").read_text())
lines=iter((p.parent/"terms.txt").read_text().splitlines())
s=["Theory NatPair","Ancestors arithmetic integer list cv_std","Libs cv_transLib intLib"]
def df(n,b):s.extend(["Definition "+n+"_def:",b,"End"])
df("np","(np (z:num) ([]:num list) = 0) /\\ (np z (a::xs) = a+z*np z xs)")
df("ip","(ip (z:int) ([]:int list) = 0) /\\ (ip z (a::xs) = a+z*ip z xs)")
df("rnd","rnd (v:int) x = if v=0 then 0 else (x+v / 2) / v")
s.extend(['val pre_def = cv_trans_pre "rnd_pre" rnd_def;', 'Theorem pre_ok[cv_pre]:',' !v x. rnd_pre v x','Proof',' simp [pre_def]','QED'])
df("signed","(signed 0 r xs ys v = []:int list) /\\ (signed (SUC n) r xs ys v = rnd v (ip r xs) :: rnd v (ip r ys) :: signed n (r+1024) xs ys v)")
df("bits","bits (r:int) pos neg = np (Num (ABS r)) (if r<0 then neg else pos)")
df("unpk","unpk (b:num) h v (x:num) = if b=0 then (0:int,0:int) else (rnd v (&(x MOD b) - &h),rnd v (&(x DIV b) - &h))")
df("paired","(paired ([]:num list) r pos neg b v = []:int list) /\\ (paired (h::hs) r pos neg b v = let (x,y)=unpk b h v (bits r pos neg) in x::y::paired hs (r+1024) pos neg b v)")
df("hs","(hs 0 r bias = []:num list) /\\ (hs (SUC n) (r:int) bias = np (Num (ABS r)) bias :: hs n (r+1024) bias)")
df("col","(col ([]:int list) ys (fs:num list) (e:int) b (t:bool) = []:num list) /\\ (col (x::xs) [] fs e b t = []) /\\ (col (x::xs) (y::ys) [] e b t = []) /\\ (col (x::xs) (y::ys) (f::fs) e b t = (Num(e+(if t then -x else x))+b*Num(e+(if t then -y else y)))*f :: col xs ys fs e b (~t))")
df("poscol","(poscol ([]:int list) ys (fs:num list) (e:int) b = []:num list) /\\ (poscol (x::xs) [] fs e b = []) /\\ (poscol (x::xs) (y::ys) [] e b = []) /\\ (poscol (x::xs) (y::ys) (f::fs) e b = (Num(e+x)+b*Num(e+y))*f :: poscol xs ys fs e b)")
df("cold","cold n r xs ys fs e b v bias = paired (hs n r bias) r (poscol xs ys fs e b) (col xs ys fs e b F) b v")
for name in ["cold","signed"]:s.append("val _=cv_auto_trans "+name+"_def;")
with (p/"terms.txt").open("w") as out:
 for c in cases:
    next(lines)
    coord=[]
    for i in range(2):
        ds=list(map(int,next(lines).split())); next(lines); exp=list(map(int,next(lines).split()));coord.append((ds,exp))
    n,k,r,v=[c[x] for x in ["n","d","r","v"]]
    fs=[(2*131071)**(k-i) for i in range(k+1)]
    xy=[[x//f for x,f in zip(ds,fs)] for ds,_ in coord]
    assert all(all(x*f==d for x,f,d in zip(xs,fs,ds)) for xs,(ds,_) in zip(xy,coord))
    e=1+max(abs(z) for xs in xy for z in xs)
    b=1<<(3*e*v).bit_length()
    w=[[(e+sign*x+b*(e+sign*y))*f for j,(x,y,f) in enumerate(zip(*xy,fs)) for sign in [(-1)**j if neg else 1]] for neg in [False,True]]
    bias=[e*f for f in fs]
    hh=[sum(bb*abs(r+1024*i)**j for j,bb in enumerate(bias)) for i in range(n)]
    expected=[x for pair in zip(coord[0][1],coord[1][1]) for x in pair]
    for i,h in enumerate(hh):
        ri=r+1024*i
        z=sum(x*abs(ri)**j for j,x in enumerate(w[int(ri<0)]))
        assert [(u-h+v//2)//v for u in (z%b,z//b)]==expected[2*i:2*i+2]
    print(c["name"],n,r,e,b,v,file=out)
    for xs in [coord[0][0],coord[1][0],*xy,fs,bias,*w,hh,expected]:print(*xs,file=out)
s.append((p/"bench.smlfrag").read_text())
(p/"NatPairScript.sml").write_text("\n".join(s)+"\n")
