"""Follow the frozen q131071 hard midpoint selection and escalation rule."""
from fractions import Fraction as F
from hashlib import sha256
import json,math,sys
from pathlib import Path
from time import process_time,perf_counter
from flint import acb,arb,ctx
from precision_contiguous import HERE,HOL,Q,N,arn,strip_error
from precision_audit import pairmul,quantize,ball,tsv
from precision_midpoints import source_half
from prime_panel import source,nearest,residues,positive_dft,phase_table

RULE=HERE/'precision-hard-rule.json';SEL=HERE/'precision-hard-selection.json'
COARSE=HERE/'precision-hard-coarse.json';RESCUE=HERE/'precision-hard-rescue.json'
ARC=HOL/'large-coarse-sign/prime-131071.json';SEC=HOL/'large-sector-second'
def digest(f):return sha256(f.read_bytes()).hexdigest()
def dump(p,d):p.write_text(json.dumps(d,indent=2)+'\n')
def sg(x):return int(x>0)-int(x<0)
def parts(s):return [(arb.pi()*s.imag/4).exp()*(acb(Q)/arb.pi())**((s+a)/2)*((s+a)/2).gamma()*acb(Q)**(-s) for a in (0,1)]

def select():
    start=process_time();t0=perf_counter();_,rs=residues(Q);ph=phase_table(rs,Q)
    ref=json.loads(ARC.read_bytes());masks={r['j']:bin(int(r['reference_signs_hex'],16))[2:] for r in ref['nodes']}
    s,raw=source_half(rs,5694);spectrum=positive_dft(raw);ff=parts(s);rank=[]
    for k in range(1,N):
        if masks[5694][k]!=masks[5695][k]:continue
        z=ph[k]*ff[k%2]*spectrum[k];assert z.imag.contains(0);sign=sg(z.real);assert sign
        if (sign>0)!=(masks[5694][k]=='1'):
            rank.append((abs(z.real)/abs(ff[k%2]),k,z.real))
    rank.sort(key=lambda row:float(row[0].mid()))
    best,k,value=rank[0];assert all(best<other[0] for other in rank[1:])
    dump(SEL,dict(k=k,midpoint=str(value),score=str(best),runner_up=[rank[1][1],str(rank[1][0])],hidden=len(rank),
        left_sign=1 if masks[5694][k]=='1' else -1,cpu=process_time()-start,wall=perf_counter()-t0,
        sha256={f.name:digest(f) for f in (RULE,ARC,HERE/'precision_midpoints.py',Path(__file__))}))
    print('selected',k,'from',len(rank),str(value),flush=True)

def chirps(p):
    n=N;S=1<<p;w=[]
    for h in range(n):
        j=h*h%(2*n);z=acb(0,arb.pi()*j/n).exp()
        if p>28:u,v=nearest(z,S)
        else:
            a=math.pi*j/n;u,v=round(S*math.cos(a)),round(S*math.sin(a))
        assert abs(z.real*S-u)<1 and abs(z.imag*S-v)<1;w.append((u,v))
    return w

def tap(k,p,x,w,phase,fac):
    S=1<<p;R=I=er=0
    for h,(a,b) in enumerate(x):
        u,v=quantize(pairmul((a,b),w[h]),S)
        r,i=w[(k-h)%N];R+=u*r+v*i;I+=v*r-u*i
        er+=(2*S+2)*(3+(abs(a)+abs(b)+2+S-1)//S)+abs(u)+abs(v)
    r,i=quantize(pairmul((R,I),w[k]),S*S)
    e=(2*S*er+abs(R)+abs(I)+2*er+S*S-1)//(S*S)+1
    return ball(*phase,*fac,e,r,i)

def evaluate(rows,p,k):
    x=F(11389,2);candidates=[]
    for m in range(2,13):
        ns=sorted(sorted(rows,key=lambda j:(abs(j-x),j))[:m]);weights=[arn(math.prod((x-j)/(h-j) for j in ns if h!=j)) for h in ns]
        dot=sum((w*rows[h] for w,h in zip(weights,ns,strict=True)),arb(0))
        error=min((strip_error(ns,x,b,k%2) for b in range(2,9)),key=lambda r:r.upper())
        out=dot+arb(0,error.upper());candidates.append((m,out,sg(out)))
    m,v,sign=min(candidates,key=lambda tup:tup[1].rad().upper())
    return dict(m=m,interval=str(v),signs=[sg(rows[5694]),sign,sg(rows[5695])],
        attempts=[dict(m=m,sign=sign,interval=str(out)) for m,out,sign in candidates])

def coarse():
    cpu=process_time();wall=perf_counter();selection=json.loads(SEL.read_bytes());k=selection['k'];_,rs=residues(Q)
    archives=tsv(SEC/'input28.tsv');assert [z[1] for z in archives]==rs
    ix,a,b=tsv(SEC/'roots28.tsv')[k-1];assert ix==k
    w={p:chirps(p) for p in (24,28)};setup=process_time()-cpu;stages=[];out={24:{},28:{}};pairs=[]
    for j in range(5689,5701):
        ts=process_time();s=acb(arb(1)/2,arb(5*j)/64)
        if j==5695:xs=[(u,v) for _,_,u,v in archives]
        else:
            _,_,raw=source(rs,Q,j);xs=[nearest(z,1<<28) for z in raw];del raw
        row=dict(j=j,source=process_time()-ts);ff=nearest(parts(s)[k%2],1<<28)
        for p in (24,28):
            ts=process_time();D=1<<(28-p)
            def rd(z):return (z+D//2)//D
            v,d=tap(k,p,[(rd(u),rd(v)) for u,v in xs],w[p],(rd(a),rd(b)),tuple(map(rd,ff)))
            out[p][j]=arb(arb((v,-3*p)),arb((d,-3*p)));pairs.append([j,p,str(v),str(d)])
            row[f'tap{p}']=process_time()-ts
        stages.append(row);print('coarse',j,flush=True)
    result={p:evaluate(out[p],p,k) for p in (24,28)}
    assert all(arb(r['interval']).overlaps(arb(selection['midpoint'])) for r in result.values())
    dump(COARSE,dict(k=k,source_sha256=digest(SEL),result=result,rows=pairs,stages=stages,setup=setup,cpu=process_time()-cpu,wall=perf_counter()-wall))

def rescue():
    sel=json.loads(SEL.read_bytes());r=json.loads(COARSE.read_bytes());k=sel['k'];ss=r['result']['28']['signs']
    pending=[x for x,z in zip((F(5694),F(11389,2),F(5695)),ss,strict=True) if z==0]
    assert all(a==0 or a==b for a,b in zip(ss,[sel['left_sign'],-sel['left_sign'],sel['left_sign']],strict=True))
    cpu=process_time();wall=perf_counter();stages=[]
    if pending:
        _,rs=residues(Q);ts=process_time();ph=nearest(phase_table(rs,Q)[k],1<<48);w=chirps(48);setup=process_time()-ts
        for x in pending:
            ts=process_time()
            if x.denominator==2:s,raw=source_half(rs,x.numerator//2)
            else:s,_,raw=source(rs,Q,int(x))
            xs=[nearest(z,1<<48) for z in raw];del raw;source_s=process_time()-ts
            ts=process_time();v,d=tap(k,48,xs,w,ph,nearest(parts(s)[k%2],1<<48));tap_s=process_time()-ts
            z=arb(arb((v,-144)),arb((d,-144)));expected=sel['left_sign'] if x.denominator==1 else -sel['left_sign']
            assert sg(z)==expected
            if x.denominator==2:assert z.overlaps(arb(sel['midpoint']))
            stages.append(dict(node=str(x),source_cpu=source_s,tap_cpu=tap_s,v=str(v),d=str(d),interval=str(z),sign=sg(z)))
    else:setup=0
    dump(RESCUE,dict(k=k,coarse_sha256=digest(COARSE),required=[str(x) for x in pending],setup_cpu=setup,stages=stages,cpu=process_time()-cpu,wall=perf_counter()-wall))
    print('p28',ss,'p48',stages,flush=True)

if __name__=='__main__':
    ctx.prec,ctx.threads=192,1
    select();coarse();rescue()
