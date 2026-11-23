"""Recover sparse taps of the original even Bluestein transform on 12 Hurwitz rows."""
import hashlib,json,math,sys
from fractions import Fraction as F
from pathlib import Path
from time import process_time,perf_counter
from flint import acb,arb,ctx
from precision_audit import HOL,HERE,PINS,tsv,data,ball,quantize,pairmul

sys.path.insert(0,str(HOL/'large-coarse-sign'))
from prime_panel import source,residues,nearest
Q,N=131071,131070

def arn(q):return arb(q.numerator)/q.denominator

def strip_error(nodes,x,b,a):
    rho=F(2*b-1,2);p=F(b+a-1,2);dt=F(5,64)
    c=arn(2*rho*rho).sqrt();factor=2*(2*arb.pi()).sqrt()*(arb(Q)/arb.pi())**arn(F(b+a,2))
    def major(j):
        d=arn(b+2+j*dt);return factor*d**arn(p)*(arn(p)*c/d).exp()
    return max([major(min(nodes)),major(max(nodes))],key=lambda z:z.upper())*arn(abs(math.prod((x-i)*dt for i in nodes)))/arn(rho)**len(nodes)

def main():
    ctx.prec,ctx.threads=192,1
    cpu,wall=process_time(),perf_counter();timing={}
    d=HOL/'large-sector-second';archive=json.loads(data(HOL/'large-coarse-sign/prime-131071.json'))
    masks={j['j']:bin(int(j['reference_signs_hex'],16))[2:] for j in archive['nodes']}
    hidden=[k for k in range(1,N) if masks[5694][k]==masks[5696][k]!=masks[5695][k]]
    selected=hidden[:4];systematic=[1+i*(N-2)//7 for i in range(8)]
    modes=sorted(set(selected+systematic));assert len(modes)==12
    generator,rs=residues(Q);assert generator==3
    roots=tsv(d/'roots28.tsv');common=tsv(d/'input28.tsv');assert [r[1] for r in common]==rs
    roots={k:(a,b) for k,a,b in roots if k in modes}
    partsref=json.loads(data(d/'cohort.json'))['phase_parts_grid28']
    ws={}
    for p in (24,28):
        S=1<<p;ws[p]=[]
        for k in range(N):
            l=k*k%(2*N);a=math.pi*l/N;u,v=round(S*math.cos(a)),round(S*math.sin(a))
            w=acb(0,arb.pi()*l/N).exp();assert abs(w.real*S-u)<1 and abs(w.imag*S-v)<1
            ws[p].append((u,v))
    timing['setup']=process_time()-cpu
    rows={};stages=[]
    for j in range(5689,5701):
        start=process_time();s=acb(arb(1)/2,arb(5*j)/64)
        if j==5695:
            xs=[(r,i) for _,_,r,i in common]
        else:
            verify,order,raw=source(rs,Q,j);assert verify==s
            xs=[nearest(x,1<<28) for x in raw];del raw
        st={'j':j,'source_p28':process_time()-start}
        p28parts=[nearest((arb.pi()*s.imag/4).exp()*(acb(Q)/arb.pi())**((s+a)/2)*((s+a)/2).gamma()*acb(Q)**(-s),1<<28) for a in (0,1)]
        if j==5695:assert list(map(list,p28parts))==partsref
        for p in (24,28):
            start=process_time();S=1<<p;D=1<<(28-p);w=ws[p]
            def rd(x): return (x+D//2)//D
            x=[(rd(a),rd(b)) for a,b in xs];aa=[quantize(pairmul(z,t),S) for z,t in zip(x,w)]
            er=sum((2*S+2)*(3+(abs(a)+abs(b)+2+S-1)//S)+abs(u)+abs(v) for (a,b),(u,v) in zip(x,aa))
            for k in modes:
                rr=ii=0
                for h,(u,v) in enumerate(aa):
                    a,b=w[(k-h)%N];rr+=u*a+v*b;ii+=v*a-u*b
                r,i=quantize(pairmul((rr,ii),w[k]),S*S)
                e=(2*S*er+abs(rr)+abs(ii)+2*er+S*S-1)//(S*S)+1
                v,rad=ball(*(rd(a) for a in roots[k]),*(rd(a) for a in p28parts[k%2]),e,r,i)
                rows[j,k,p]=(v,rad)
                if j in masks and abs(v)>rad:assert (v>0)==(masks[j][k]=='1')
            st[f'p{p}_12_taps']=process_time()-start
        stages.append(st);print('checked',j,st,flush=True)
    # Withhold 5695. The other eleven source rows are distinct genuine grid ordinates.
    alternatives={}
    for p in (24,28):
        for k in modes:
            best=None
            for m in range(2,12):
                nodes=sorted(sorted((i for i in range(5689,5701) if i!=5695),key=lambda i:(abs(i-5695),i))[:m]);x=F(5695)
                weights=[math.prod((x-j)/(i-j) for j in nodes if j!=i) for i in nodes]
                dot=arb(0)
                for j,wgt in zip(nodes,weights):
                    v,rad=rows[j,k,p];dot+=arn(wgt)*arb(arb((v,-3*p)),arb((rad,-3*p)))
                err=min((strip_error(nodes,x,b,k%2) for b in range(2,9)),key=lambda z:z.upper());encl=dot+arb(0,err.upper())
                if best is None or encl.rad().upper()<best[1].rad().upper():best=m,encl
            m,encl=best;v,rad=rows[5695,k,p];center=arb(arb((v,-3*p)),arb((rad,-3*p)))
            assert encl.overlaps(center)
            sg=int(encl>0)-int(encl<0)
            if sg:assert (sg>0)==(masks[5695][k]=='1')
            alternatives[f'{k}/{p}']=dict(held_out=5695,m=m,sign=sg,interpolated=str(encl),direct=str(center))
    for f in [Path(__file__),HOL/'large-coarse-sign/prime_panel.py',HOL/'large-terminal-signs/even_full.py',HERE/'precision_audit.py']:
        PINS[str(f.relative_to(HOL))]=hashlib.sha256(f.read_bytes()).hexdigest()
    report=dict(q=Q,first=5689,last=5700,population=N-1,archive_hidden=len(hidden),selected_hidden=selected,systematic=systematic,
                units='real Hardy amplitude; multiply integer center and radius by 2^(-3p)',
                rows=[(j,k,p,str(v),str(e)) for (j,k,p),(v,e) in rows.items()],midpoint=alternatives,
                setup_cpu=timing['setup'],stages=stages,cpu=process_time()-cpu,wall=perf_counter()-wall,sha256=PINS)
    (HERE/'precision-contiguous.json').write_text(json.dumps(report,indent=2)+'\n')

if __name__=='__main__':main()
