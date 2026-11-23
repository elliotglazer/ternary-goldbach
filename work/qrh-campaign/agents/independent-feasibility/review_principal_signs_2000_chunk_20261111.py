"""All 449 retained points, independently evaluated by direct EM.

No producer import, Gabcke correction, Gamma, zeta, RS or zero helper.
External elementary interval replay; analytic and formal bridges remain separate.
"""
from pathlib import Path
from fractions import Fraction as Q
from math import factorial
import hashlib,json,time
from flint import arb,acb,ctx

ctx.prec=192
AGENTS=Path(__file__).resolve().parents[1]
WORK=AGENTS.parents[1]
OUT=Path(__file__).with_suffix('.json')
PINS={
 'qrh-campaign/agents/mellin/principal_signs_2000_chunk_20261111.py':'4df68ba9028c9b59ba795e4d241ed9c5a77892ae732dfd1c3331f6aded1477d4',
 'qrh-campaign/agents/mellin/principal_signs_2000_chunk_20261111.json':'d3bcd8c499033314b54e4f354ef3faf074bc859f2f5888ef589b051ba3a4ea73',
 'qrh-campaign/agents/prime-estimates/REVIEW_TOP_COUNT_2000_2026-11-11.md':'c3ca2aba8eda4ce9158cb4bd22203dfbeee0cec145a54fc8f0d630346b3fc89d',
 'qrh-blueprint/principal-chunk-2000/em_top_2000.json':'477bd15b17326bce7333346491ba820c98db2fe2b07dbdb7a0d11278cd2ae252',
 'qrh-campaign/agents/mellin/psi_head_counts_20261111_h1500.json':'82ad7acdffbcac24d190a98acb78bf66471249d09bfe2c43051add2aaec0d030',
 'qrh-campaign/agents/audit/PRINCIPAL_SIGNS_1500_REVIEW_2026-11-11.md':'a2961debb4bf2734fb048f1500d6e495e42b5dcb8439dd2412299f803a37fffe',
 'qrh-campaign/agents/mellin/principal_signs_1500_20261111.json':'542346deb342369a1d53601dc051afadb39149db34c6e7426c33ab4094bc8cf4',
}
def a(q):
    q=Q(q);return arb(str(q.numerator))/q.denominator
def ends(v):return [Q(str(v.lower().fmpq())),Q(str(v.upper().fmpq()))]
def enc(v):return list(map(str,ends(v)))
def sign_pair(v):return 1 if v[0]>0 else -1 if v[1]<0 else 0
def ceil(q):return -((-q.numerator)//q.denominator)
def read(k):return json.loads((WORK/k).read_text())
def atan_box(q,n):
    p=sum((-1)**j*q**(2*j+1)/Q(2*j+1) for j in range(n))
    nxt=(-1)**n*q**(2*n+1)/Q(2*n+1)
    return min(p,p+nxt),max(p,p+nxt)
def ball(lo,hi):return a((lo+hi)/2)+arb(0,a((hi-lo)/2).upper())

def run():
    start=time.perf_counter()
    def limit():
        if time.perf_counter()-start>120:raise RuntimeError('120-second bound exhausted')
    actual={k:hashlib.sha256((WORK/k).read_bytes()).hexdigest() for k in PINS}
    assert actual==PINS,[(k,actual[k],v) for k,v in PINS.items() if actual[k]!=v]
    chunk=read('qrh-campaign/agents/mellin/principal_signs_2000_chunk_20261111.json')
    top=read('qrh-blueprint/principal-chunk-2000/em_top_2000.json')
    head=read('qrh-campaign/agents/mellin/psi_head_counts_20261111_h1500.json')
    low=read('qrh-campaign/agents/mellin/principal_signs_1500_20261111.json')
    clo,chi=map(Q,top['count_interval']); upper=ceil(clo)
    assert upper==chi.numerator//chi.denominator==top['unique_integer']==1517
    assert top['T']==2000 and len(top['blocks'])==6 and len(top['endpoints'])==7
    assert all(Q(b['zeta_image']['re'][0])>0 for b in top['blocks'])
    assert head['counts'][0]['t']=='14' and head['counts'][0]['N']==0
    assert head['counts'][-1]['t']=='1500'
    lower=head['counts'][-1]['N'];assert lower==1069
    target=upper-lower;assert target==448==chunk['target_changes']
    pts=chunk['points'];assert len(pts)==target+1==449
    ts=[Q(p['t']) for p in pts]
    assert ts[0]==1500 and ts[-1]==2000
    assert all(x<y for x,y in zip(ts,ts[1:]))
    assert all((4*t).denominator==1 for t in ts)
    assert all(sign_pair(list(map(Q,p['value'])))==p['sign']==(-1)**i for i,p in enumerate(pts))
    assert low['points'][-1]['t']=='1500' and low['points'][-1]['sign']==1
    assert len(low['points'])==1070
    # Independent rational Machin interval, no arb.pi call.
    b5=atan_box(Q(1,5),100);b239=atan_box(Q(1,239),100)
    plo=16*b5[0]-4*b239[1];phi=16*b5[1]-4*b239[0]
    assert Q(314159,100000)<plo<phi<Q(314160,100000)
    pi=ball(plo,phi)
    B=800;M=40
    logs=[arb(0)]+[arb(n).log() for n in range(1,B+1)]
    # Reciprocal formal series of (exp(z)-1)/z gives c_n=B_n/n!.
    coeff=[Q(1)]
    for n in range(1,2*M+1):
        coeff.append(-sum(coeff[k]/factorial(n+1-k) for k in range(n)))
    assert coeff[2]==Q(1,12) and coeff[4]==Q(-1,720)
    assert all(coeff[n]==0 for n in range(3,2*M,2))
    rows=[];minmargin=None;maxerr=Q(0)
    for i,t in enumerate(ts):
        limit();tt=a(t);s=acb(a(Q(1,2)),tt)
        v=sum((-s*logs[n]).exp() for n in range(1,B))
        bp=(-s*logs[B]).exp();v+=bp*(B/(s-1)+a(Q(1,2)))
        rising=acb(1);normprod=arb(1)
        for j in range(2*M):
            rising*=s+j
            normprod*=((a(Q(1,2)+j))**2+tt*tt).sqrt()
            if j%2==0:
                k=(j+2)//2
                v+=bp*rising*a(coeff[2*k])*a(Q(B)**(1-2*k))
        ez=4*normprod*((a(Q(1,2))-2*M)*logs[B]).exp()/(6**(2*M)*a(Q(2*M)-Q(1,2)))
        e=arb(0,ez.upper());v+=acb(e,e)
        theta0=tt*(tt.log()-arb(2).log()-pi.log()-1)/2-pi/8
        proxy=theta0.cos()*v.real-theta0.sin()*v.imag
        bounds=ends(proxy);expected=(-1)**i
        assert sign_pair(bounds)==expected==pts[i]['sign']
        margin=bounds[0] if expected>0 else -bounds[1]
        if minmargin is None or margin<minmargin[0]:minmargin=(margin,i,t)
        maxerr=max(maxerr,ends(ez)[1])
        rows.append(dict(index=i,t=str(t),sign=expected,proxy=enc(proxy),EM_error=enc(ez)))
        if i%100==0:print(json.dumps(dict(checked=i+1,total=len(ts))),flush=True)
    # Accepted coarse phase inequality |theta-theta0|<.347 has positive cosine.
    # Rational bound alone suffices: cos(x)>=1-x²/2>.939 on that interval.
    coarse=1-Q(347,1000)**2/2
    assert coarse>Q(939,1000)
    limit()
    result=dict(status='PASS_ALL_449_ALTERNATE_EM_SIGNS_AND_GEOMETRY',
        input_sha256=actual,script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        parameters=dict(precision_bits=ctx.prec,B=B,M=M,EM_terms=B-1,pi='Machin100+100 rational',phase='theta0 sign proxy, coarse analytic cosine bound'),
        count_interval=list(map(str,(clo,chi))),lower_count=lower,upper_count=upper,
        point_count=len(rows),distinct_open_brackets=target,low_join='1500 positive on both accepted chains',
        minimum_signed_proxy_lower=str(minmargin[0]),minimum_index=minmargin[1],minimum_t=str(minmargin[2]),
        max_EM_error_upper=str(maxerr),coarse_cosine_lower=str(coarse),rows=rows,
        elapsed_seconds=time.perf_counter()-start,
        scope='External all-retained-point sign replay; relies on accepted contour counts and analytic bridges; no Lean proof or higher-height claim.')
    OUT.write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({k:v for k,v in result.items() if k not in ('rows','input_sha256')},indent=2))

if __name__=='__main__':run()
