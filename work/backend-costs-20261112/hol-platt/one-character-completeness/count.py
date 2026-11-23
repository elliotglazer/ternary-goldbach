"""Complex argument-principle upper count and independent critical-line lower count."""
import csv
import json
from pathlib import Path
from time import perf_counter,process_time
from flint import acb,arb,ctx,dirichlet_char

ctx.prec=96
ctx.threads=1
here=Path(__file__).resolve().parent
chi=dirichlet_char(3,2)
assert chi.is_primitive() and chi.order()==2
# Integer coordinates in units of one half.
corners=[(-1,-40),(4,-40),(4,40),(-1,40),(-1,-40)]


def image(point):
    return chi.l(acb(*point))


def split(p,q):
    return tuple((x+y)/2 for x,y in zip(p,q))


def cover(p,q,start,end,depth,leaves):
    mid=split(p,q)
    ball=[arb(m,abs(b-a)/2) for m,a,b in zip(mid,p,q)]
    enclosure=image(ball)
    if enclosure.is_finite() and not enclosure.contains(0):
        # A zero-free convex rectangle lies in an open half-plane through zero.
        # The argument increment along the enclosed image equals the principal
        # endpoint ratio argument (its absolute value is strictly below pi).
        increment=(end/start).arg()
        if abs(increment)<arb.pi():
            leaves.append((p,q,enclosure,increment))
            return
    if depth==20:
        raise RuntimeError((p,q,enclosure))
    value=image(mid)
    cover(p,mid,start,value,depth+1,leaves)
    cover(mid,q,value,end,depth+1,leaves)


def run():
    wall,cpu=perf_counter(),process_time()
    pts=[tuple(arb(x)/2 for x in pair) for pair in corners]
    leaves=[]
    for p,q in zip(pts,pts[1:]):
        cover(p,q,image(p),image(q),0,leaves)
    winding=sum((r[3] for r in leaves),arb(0))/(2*arb.pi())
    n=winding.unique_fmpz()
    assert n is not None
    with (here/'contour.tsv').open('w',newline='') as f:
        wr=csv.writer(f,delimiter='\t',lineterminator='\n')
        wr.writerow(('start_re','start_im','end_re','end_im','image_box','delta_arg'))
        for p,q,z,d in leaves:
            wr.writerow((*p,*q,z,d))
    upper=dict(leaves=len(leaves),winding=str(winding),N=int(n),wall=perf_counter()-wall,cpu=process_time()-cpu)
    wall,cpu=perf_counter(),process_time()
    signs=[]
    for k in range(81):
        z=chi.hardy_z(arb(k)/4)
        real=z.real
        assert z.imag.contains(0)
        sig=1 if real>0 else -1 if real<0 else 0
        assert sig
        signs.append((k,sig,str(real)))
    with (here/'line-signs.tsv').open('w',newline='') as f:
        wr=csv.writer(f,delimiter='\t',lineterminator='\n')
        wr.writerow(('t_times_4','sign','hardy_real'))
        wr.writerows(signs)
    brackets=[(a[0],b[0]) for a,b in zip(signs,signs[1:]) if a[1]!=b[1]]
    assert 2*len(brackets)==int(n)
    lower=dict(positive_brackets_times_4=brackets,N_both=2*len(brackets),wall=perf_counter()-wall,cpu=process_time()-cpu)
    print(json.dumps(dict(conductor=3,conrey=2,T=20,precision=ctx.prec,upper=upper,lower=lower),indent=2))


if __name__=='__main__':
    run()
