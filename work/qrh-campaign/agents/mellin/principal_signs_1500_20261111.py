"""Strict real-proxy signs via explicit EM; no indexed zeros or builtin zeta.

Completeness depends on the separately accepted complete head contour count.
External interval certificate only, not a Lean theorem.
"""
import argparse,hashlib,json,time
from pathlib import Path
from fractions import Fraction as F
from flint import acb,arb,ctx
import psi_head_counts_20261111 as em

BASE=Path(__file__).parent
HEAD=BASE/'psi_head_counts_20261111_h1500.json'
EM=BASE/'psi_head_counts_20261111.py'
HEAD_HASH='82ad7acdffbcac24d190a98acb78bf66471249d09bfe2c43051add2aaec0d030'
EM_HASH='d7f187fa357eaca184a2214f8952b396b9d2df42348580993005b7da00252a9a'
OUT=BASE/'principal_signs_1500_20261111.json'
N=500;M=32;PREC=128

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def head_contract():
    assert sha(HEAD)==HEAD_HASH and sha(EM)==EM_HASH
    data=json.loads(HEAD.read_text())
    assert data['status']=='PASS_EXTERNAL_HEAD_COUNTS' and data['height']=='1500'
    assert data['counts'][0]['t']=='14' and data['counts'][0]['N']==0
    assert data['counts'][-1]['t']=='1500' and data['counts'][-1]['N']==1069
    assert data['script_sha256']==EM_HASH
    return 1069

class Signs:
    def __init__(self):
        assert em.M==M;ctx.prec=PREC
        self.ev=em.Evaluator(N)
        self.pi=arb.pi();self.cache={};self.calls=0
    def value(self,t):
        t=F(t);assert 14<=t<=1500
        z=em.point((F(1,2),t))
        finite=self.ev.finite(z)
        zetaF=finite+em.error_box(self.ev.em_error(abs(z)))
        zeta=zetaF/(z-1)
        u=em.ar(t)
        theta0=u/2*((u/(2*self.pi)).log()-1)-self.pi/8
        proxy=(acb(0,theta0).exp()*zeta).real
        assert proxy.is_finite()
        sign=1 if proxy>0 else (-1 if proxy<0 else 0)
        return sign,proxy
    def sign(self,t):
        if t not in self.cache:
            sign,v=self.value(t);self.calls+=1
            if sign==0:raise RuntimeError('inconclusive EM sign at '+str(t))
            self.cache[t]=(sign,str(v))
        return self.cache[t][0]

def compress(points,signs):
    assert points[0]==14 and points[-1]==1500
    kept=[points[0]];last=signs[points[0]]
    for t in points[1:]:
        if signs[t]!=last:
            kept.append(t);last=signs[t]
    assert len(kept)>1
    kept[-1]=points[-1]
    assert all(a<b and signs[a]==-signs[b] for a,b in zip(kept,kept[1:]))
    return kept

def run(seconds,maxcalls,maxlevel,pilot):
    target=head_contract();started=time.perf_counter();ev=Signs();levels=[]
    status='INCOMPLETE';reason='not started';kept=[];end=F(100 if pilot else 1500)
    try:
        for level in range(maxlevel+1):
            step=F(1,2**(level+1))
            n=int((end-14)/step);points=[F(14)+j*step for j in range(n+1)]
            observed=0;old=None
            for t in points:
                if time.perf_counter()-started>seconds or ev.calls>=maxcalls:
                    raise RuntimeError('bounded search cost limit reached')
                sign=ev.sign(t)
                if old is not None and sign!=old:observed+=1
                old=sign
            levels.append(dict(step=str(step),points=len(points),strict_sign_changes=observed,
                               distinct_evaluations=ev.calls,seconds=time.perf_counter()-started))
            print(json.dumps(levels[-1]),flush=True)
            if pilot:
                status='PILOT_SIGNS_ONLY';reason='bounded[14,100] signs; no completeness asserted';break
            assert observed<=target, 'more sign changes than independently counted zeros'
            if observed==target:
                signs={t:ev.cache[t][0] for t in points}
                kept=compress(points,signs)
                assert len(kept)==target+1
                status='PASS_EXTERNAL_SIGN_COMPLETENESS';reason='strict alternating signs match independent total count';break
        else:reason='all bounded grid refinements exhausted without matching count'
    except RuntimeError as e:reason=str(e)
    return dict(status=status,reason=reason,domain=['14',str(end)],target_count=target,
                EM_N=N,EM_M=M,precision_bits=PREC,
                head_sha256=HEAD_HASH,em_script_sha256=EM_HASH,
                script_sha256=sha(Path(__file__)),levels=levels,distinct_evaluations=ev.calls,
                elapsed_seconds=time.perf_counter()-started,
                points=[dict(t=str(t),sign=ev.cache[t][0],value_diagnostic=ev.cache[t][1]) for t in kept],
                caveat='External EM signs plus analytic proxy/completeness proof and accepted head contour; not kernel-checked.')

def replay(data):
    target=head_contract();assert data['status']=='PASS_EXTERNAL_SIGN_COMPLETENESS'
    assert data['domain']==['14','1500'] and data['target_count']==target
    assert (data['EM_N'],data['EM_M'],data['precision_bits'])==(N,M,PREC)
    assert data['head_sha256']==HEAD_HASH and data['em_script_sha256']==EM_HASH
    assert data['script_sha256']==sha(Path(__file__))
    rows=data['points'];assert len(rows)==target+1
    ts=[F(row['t']) for row in rows]
    assert ts[0]==14 and ts[-1]==1500 and all(a<b for a,b in zip(ts,ts[1:]))
    ev=Signs();started=time.perf_counter();last=None
    for t,row in zip(ts,rows):
        sign,v=ev.value(t)
        assert sign in(-1,1) and sign==row['sign']
        if last is not None:assert last==-sign
        last=sign
    print(json.dumps(dict(status='REPLAY_PASS_EXTERNAL_SIGN_COMPLETENESS',points=len(rows),
                         sign_changes=len(rows)-1,total_count=target,seconds=time.perf_counter()-started)))

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--seconds',type=int,default=55)
    ap.add_argument('--maxcalls',type=int,default=60000);ap.add_argument('--maxlevel',type=int,default=5)
    ap.add_argument('--pilot',action='store_true');ap.add_argument('--replay',action='store_true');args=ap.parse_args()
    if args.replay:replay(json.loads(OUT.read_text()))
    else:
        data=run(args.seconds,args.maxcalls,args.maxlevel,args.pilot)
        dest=OUT.with_name(OUT.stem+'_pilot.json') if args.pilot else OUT
        dest.write_text(json.dumps(data,indent=2)+'\n')
        print(json.dumps({k:v for k,v in data.items() if k!='points'},indent=2))
