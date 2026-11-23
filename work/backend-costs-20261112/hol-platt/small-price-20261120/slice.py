"""One 1024-point forward leg of the c=10000 Bluestein circuit."""
from decimal import Decimal as D, getcontext
from random import Random
from time import process_time_ns
import statistics

den = 2**80*4*3**64*128*44*(2*3**33)*4000*496582*(8192**2+2)
p = (den-1).bit_length()
Q = 1 << p
getcontext().prec = 160
cos = D(0)
for _ in range(8):  # pi/2 -> pi/512
    cos = ((1+cos)/2).sqrt()
sin = (1-cos*cos).sqrt()
z,w = D(1),D(0)
roots=[]
for i in range(512):
    roots.append((int((z*Q).to_integral_value()), int((w*Q).to_integral_value())))
    z,w=z*cos-w*sin,z*sin+w*cos
rng=Random(20)
src=[(rng.randrange(-Q,Q),rng.randrange(-Q,Q)) for _ in range(500)]+[(0,0)]*524
rev=[int(f"{i:010b}"[::-1],2) for i in range(1024)]
def run():
    a=[src[j] for j in rev]
    for k in range(1,11):
        half=1<<(k-1)
        for i in range(0,1024,2*half):
            for j in range(half):
                r,s=roots[j*(512//half)]
                x,y=a[i+j+half]
                u,v=a[i+j]
                t=(x*r-y*s+Q//2)>>p
                w=(x*s+y*r+Q//2)>>p
                a[i+j],a[i+j+half]=(u+t,v+w),(u-t,v-w)
    return a
samples=[]
for _ in range(15):
    start=process_time_ns()
    a=run()
    samples.append(process_time_ns()-start)
assert a[0]==tuple(map(sum,zip(*src)))
print("p",p,"butterflies",5120,"CPU ns median",statistics.median(samples),"aggregate CPU ns",sum(samples),"iterations",len(samples))
