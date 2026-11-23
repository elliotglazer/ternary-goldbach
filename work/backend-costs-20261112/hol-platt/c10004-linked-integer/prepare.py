from pathlib import Path
import csv,json,sys
from time import perf_counter
here=Path(__file__).resolve().parent
def rows(path):
    with path.open() as f:return list(csv.DictReader(f,delimiter='\t'))
def emit(name,lines):
    (here/name).write_bytes(('\n'.join(lines)+'\n').encode())
def bias(x,w):
    assert -(1<<(w-1))<=x<(1<<(w-1))
    return x+(1<<(w-1))
def rnd(x,b):
    return (x+(1<<(b-1)))>>b
def packseq(records,n,step):
    return [str(sum(z<<(step*j) for j,z in enumerate(records[i:i+n]))) for i in range(0,len(records),n)]
def expected(path1,path2,out):
    data=[]
    for row in rows(path1)+rows(path2):
        r,i=int(row['re']),int(row['im'])
        assert -(1<<95)<=min(r,i) and max(r,i)<1<<95
        data.append((r%(1<<96))|((i%(1<<96))<<96))
    emit(out,packseq(data,16,192))
start=perf_counter()
p1=here.parent/'c10004-p20-source'
p2=here.parent/'c10004-p20-h2'
h1=rows(p1/'h1-head-states.tsv')
h2=rows(p2/'h2-head-states.tsv')
raw1=rows(p1/'h1-rawhead.tsv')
raw2=rows(p2/'h2-rawhead.tsv')
assert len(h1)==len(h2)==4801 and len(raw1)==len(raw2)==4800
records=[]
for j,(v,w) in enumerate(zip(h1,h2,strict=True)):
    x,m=map(int,[v['x'],v['m98']])
    t,u=map(int,[v['step_re122'],v['step_im122']])
    assert m*m*x<=1<<196<(m+1)*(m+1)*x and 0<=m<1<<99
    a,b=rnd((m<<22)*t,122),rnd((m<<22)*u,122)
    c,d=rnd(a*t-b*u,122),rnd(a*u+b*t,122)
    assert (a,b)==(int(v['re120']),int(v['im120']))
    assert (x,t,u,a,b,c,d)==tuple(int(w[k]) for k in ('x','step_re122','step_im122','prev_re120','prev_im120','re120','im120'))
    z=m+(bias(t,124)<<99)+(bias(u,124)<<223)
    if j==0:
        assert x==10004
        q=(a,b,c,d)
        emit('conductor.txt',[str(z)])
    else:
        y=j-1
        res=(2501*(1+2*(y%2))+4880*pow(6,y//2%40,41)+2624*pow(2,y//80,61))%10004
        assert x==res
        for f,g,vv,ww,h in [(q[0],q[1],a,b,raw1[y]),(q[2],q[3],c,d,raw2[y])]:
            rr,ii=rnd(10004*(f*vv+g*ww),140),rnd(10004*(f*ww-g*vv),140)
            assert (x,rr,ii)==(int(h['a']),int(h['re']),int(h['im']))
        records.append(z)
emit('states.txt',packseq(records,4,347))
co=json.loads((p2/'h2-mixed.json').read_bytes())
js=list(range(19,-1,-1))
w={j:1+max(abs(int(x)).bit_length() for r in co.values() for x in r[j]) for j in js}
blocks=[]
for k in range(1025):
    z=0
    for j in reversed(js):
        a,b=map(int,co[str(k)][j]); bsz=w[j]
        z=(z<<(2*bsz)) + bias(a,bsz) + (bias(b,bsz)<<bsz)
    blocks.append(str(z))
emit('coeff2.txt',blocks)
bs=[1<<w[j] for j in js]
grids=[94,94,94,94,91,89,89,89,83,81,81,81,75,73,73,73,65,65,65,65]
ss=';'.join('(%s,%s)'%(b,1<<(grids[j]-grids[j+1])) for b,j in zip(bs[1:],js[1:]))
emit('coeff2.def',[f'Definition linked_coeff2_def:\n  linked_coeff2 z = (full_pair {bs[0]} z, full_stages [{ss}] (z DIV {bs[0]**2}))\nEnd'])
ref=rows(p2/'h2-rawspectrum.tsv')
params=(here.parent/'c10004-hol-shared-phase/h2-params.tsv').read_text().split()
params[-2]=str(max(int(row['abs_error_grid_units']) for row in ref))
assert all((1 if (int(params[-1])>>j)&1 else -1)==int(row['sign']) for j,row in enumerate(ref))
emit('params2.tsv',['\t'.join(params)])
for h,path in [(1,p1),(2,p2)]:
    for kind,fn in [('source','rawassembled'),('spectrum','rawspectrum')]:
        records=[]
        for row in rows(path/f'h{h}-{fn}.tsv'):
            a,b=int(row['re']),int(row['im'])
            assert -(1<<95)<=min(a,b) and max(a,b)<1<<95
            records.append((a%(1<<96))+((b%(1<<96))<<96))
        emit(f'h{h}-{kind}.txt',packseq(records,16,192))
print(json.dumps(dict(state_rows=len(h1),state_blocks=1200,coeff2_widths=[w[j] for j in js],radius2=params[-2],seconds=perf_counter()-start)))
