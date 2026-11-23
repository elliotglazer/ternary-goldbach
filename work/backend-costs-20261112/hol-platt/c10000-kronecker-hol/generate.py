import json,hashlib,sys,csv
from pathlib import Path
from time import process_time
here=Path(__file__).resolve().parent
start=process_time()
src=here.parent/"c10000-bluestein-hol"
S=1<<307
def rows(f):return [tuple(map(int,line.split())) for line in f.read_text().splitlines()]
def mul(z,w):
    a,b=z;x,y=w
    return a*x-b*y,a*y+b*x
def nearest(t,d):return tuple((2*u+d)//(2*d) for u in t)
xs=rows(src/"inputs.tsv"); chirp=rows(src/"chirps.tsv")
a=[nearest(mul(z,w),S) for z,w in zip(xs,chirp)]
b=[(x,-y) for x,y in chirp]
assert len(a)==len(b)==500
bound=1000*max(abs(v) for z in a for v in z)*max(abs(v) for z in b for v in z)
bits=((bound.bit_length()+8)//8)*8
base=1<<bits
assert bound<base//2-1
def pack(row):
    x=y=0
    for u,v in reversed(row):x,y=x*base+u,y*base+v
    return x,y
X,Y=pack(a);U,V=pack(b)
P=X*U; Q=Y*V; R=(X+Y)*(U+V)
c=[]
for k in range(500):
    pairs=[mul(z,b[(k-j)%500]) for j,z in enumerate(a)]
    c.append(tuple(map(sum,zip(*pairs))))
E,F=pack(c)
assert all(abs(v)<=bound for z in c for v in z)
assert (P-Q-E)%(base**500-1)==(R-P-Q-F)%(base**500-1)==0
ind=here.parent/"c10000-kronecker-error/expected.tsv"
with ind.open() as f:
    for k,row in enumerate(csv.DictReader(f,delimiter="\t")):
        assert tuple(map(int,(row["re"],row["im"])))==nearest(mul(c[k],chirp[k]),S*S)
assert k==499
for name,data in (("a",a),("b",b),("c",c)):
    (here/(name+".tsv")).write_text("".join(f"{x}\t{y}\n" for x,y in data))
small=65521
control=(X%small+Y%small+U%small+V%small)%small
probe=(P%small+Q%small+R%small)%small
(here/"constants.txt").write_text(f"{bits} {control} {probe}\n")
print(json.dumps(dict(bits=bits,n=500,operand_bits=[abs(x).bit_length() for x in [X,Y,U,V]],bound_bits=bound.bit_length(),control=control,probe=probe,native_fixture_cpu_sec=process_time()-start,sha256={f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in [src/"inputs.tsv",src/"chirps.tsv",ind,here/"a.tsv",here/"b.tsv",here/"c.tsv"]}),indent=2))
