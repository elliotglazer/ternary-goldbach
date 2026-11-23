from delivery import *
n=524288;pbits=128;G=1<<(pbits+76);S=1<<76
hs=seed(n,G);r,E=mid(hs[-1]);delta,D=mid(hs[-2]);z=(G,0);radius=0
refs={};slots={}
for label in (3,6667,11,9091):
 for line in (p.parent/'small-time-selected-consumer'/f'selected-{label}.tsv').open():
    j,_,_,_,x,y,*rest=map(int,line.split());k=abs(j-128);v=(x>>112,y>>112)
    if k in refs:assert refs[k]==v
    refs[k]=v
amb=axis=0
for j in range(max(refs)+1):
 if j in refs:
    b=radius+1 # includes rounding from any p>=working precision before truncation
    lo=[(a-b)//S for a in z];hi=[(a+b)//S for a in z]
    if lo!=hi:
       q,rem=divmod((j*j)%(2*n),n//2)
       if rem==0:
          vv=[(1<<128,0),(0,1<<128),(-(1<<128),0),(0,-(1<<128))][q];axis+=1
       else:amb+=1;vv=refs[j]
    else:vv=tuple(lo)
    assert vv==refs[j]
 z,r=prod(z,r,G),prod(r,delta,G);radius+=1+2*(E+j*(2*D+1))
out=dict(distinct=len(refs),analytic_axis=axis,nonaxis_fallback=amb,q=204,p=128)
(p/'floor128.json').write_text(json.dumps(out,indent=2));print(out)
