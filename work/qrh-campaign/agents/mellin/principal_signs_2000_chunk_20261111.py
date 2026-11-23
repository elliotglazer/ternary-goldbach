"""Bounded complete sign-chain candidate on [1500,2000].

Run only after both named independent reviews PASS. No indexed zeros or
builtin special evaluator. Count inputs are separately certified all-zero counts.
"""
import argparse, hashlib, json, time
from fractions import Fraction as Q
from pathlib import Path
from flint import arb,ctx
import gabcke_bounded_point_pilot_20261111 as gp

BASE=Path(__file__).parent
ROOT=BASE.parents[2]
TOP=ROOT/'qrh-blueprint/principal-chunk-2000/em_top_2000.json'
TOP_SCRIPT=TOP.with_suffix('.py')
HEAD=BASE/'psi_head_counts_20261111_h1500.json'
OUT=Path(__file__).with_suffix('.json')
PINS={gp.__file__:'90aae865ff49e10d82532b51dd3f4cc967a4e702467be55625dfa81407fb7fda',
    str(TOP):'477bd15b17326bce7333346491ba820c98db2fe2b07dbdb7a0d11278cd2ae252',
    str(TOP_SCRIPT):'29fd53bc084fc38c3033e6c8d9e7ddb63e1af0d96a8789216ec069aa7d75f6cf',
    str(HEAD):'82ad7acdffbcac24d190a98acb78bf66471249d09bfe2c43051add2aaec0d030'}
REVIEW_PINS={'gabcke_pilot_review':'ec086a5da7e73386fd888c5448a1426dde76e21d82cde8a6e1063829dee0a09e',
    'top2000_review':'c3ca2aba8eda4ce9158cb4bd22203dfbeee0cec145a54fc8f0d630346b3fc89d'}

def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def ceilq(v):return -((-v.numerator)//v.denominator)
def count_inputs():
    for path,pin in PINS.items():assert sha(path)==pin,(path,'hash mismatch')
    top=json.loads(TOP.read_text());head=json.loads(HEAD.read_text())
    assert top['status']=='PASS_EXPLICIT_EM_TOP_PATH' and top['T']==2000
    assert len(top['blocks'])==6 and len(top['endpoints'])==7
    assert all(Q(r['zeta_image']['re'][0])>0 for r in top['blocks'])
    lo,hi=map(Q,top['count_interval']);upper=ceilq(lo)
    assert upper==hi.numerator//hi.denominator==top['unique_integer']
    assert head['status']=='PASS_EXTERNAL_HEAD_COUNTS' and head['height']=='1500'
    assert head['counts'][-1]['t']=='1500'
    lower=head['counts'][-1]['N'];assert (lower,upper)==(1069,1517)
    return lower,upper

def review_gate(path):
    data=json.loads(Path(path).read_text())
    assert set(data)=={'gabcke_pilot_review','top2000_review'}
    for key,item in data.items():
        assert item['verdict']=='PASS'
        assert sha(item['path'])==item['sha256'].lower()==REVIEW_PINS[key]
    return data

def run(budget,gate,recompute):
    start=time.perf_counter();ctx.prec=160
    lower,upper=count_inputs();expected=upper-lower
    approvals=review_gate(gate)
    def limit():
        if time.perf_counter()-start>budget:raise RuntimeError('120-second bounded discovery budget exhausted')
    result=dict(status='INCOMPLETE',domain=['1500','2000'],lower_count=lower,
        upper_count=upper,target_changes=expected,precision_bits=ctx.prec,
        budget_seconds=budget,review_gate=approvals,source_pins=PINS,
        script_sha256=sha(__file__),levels=[],fallbacks=[],unresolved_points=[],evaluation_failures=[],points=[])
    cache={};pi=arb.pi();logs=[arb(0)]+[arb(n).log() for n in range(1,1019)]
    def evaluate(t):
        if t in cache:return cache[t]
        limit();g,meta=gp.gabcke(t,pi,logs);sg=gp.sign(g)
        value=g;method='GabckeK0'
        if not sg:
            e,em=gp.em_reference(t,pi,logs,limit);se=gp.sign(e)
            result['fallbacks'].append(dict(t=str(t),gabcke=gp.rb(g),reference=gp.rb(e),
                reference_sign=se,EM_metadata=em))
            value=e;sg=se;method='explicitEM'
        row=dict(t=str(t),sign=sg,method=method,value=gp.rb(value),N=meta['N'])
        if not sg:result['unresolved_points'].append(str(t))
        cache[t]=row
        return row
    try:
        for k in range(2,7):
            step=Q(1,2**k);grid=[Q(1500)+j*step for j in range(500*2**k+1)]
            certified=[]
            for t in grid:
                try:row=evaluate(t)
                except Exception as exc:
                    result['evaluation_failures'].append(dict(t=str(t),reason=type(exc).__name__+': '+str(exc)))
                    raise
                if row['sign']:certified.append(t)
            assert certified and certified[0]==1500 and certified[-1]==2000,'endpoint sign not certified'
            changes=sum(cache[a]['sign']!=cache[b]['sign'] for a,b in zip(certified,certified[1:]))
            level=dict(step=str(step),grid_points=len(grid),certified_points=len(certified),
                changes=changes,distinct_evaluations=len(cache),fallbacks=len(result['fallbacks']),
                seconds=time.perf_counter()-start)
            result['levels'].append(level);print(json.dumps(level),flush=True)
            if changes>expected:
                result['status']='FAIL_COUNT_EXCEEDED';raise RuntimeError('more verified changes than independent all-zero count')
            if changes==expected:
                kept=[certified[0]];last=cache[kept[0]]['sign']
                for t in certified[1:]:
                    if cache[t]['sign']!=last:
                        kept.append(t);last=cache[t]['sign']
                kept[-1]=certified[-1]
                assert len(kept)==expected+1 and kept[0]==1500 and kept[-1]==2000
                assert all(a<b and cache[a]['sign']==-cache[b]['sign'] for a,b in zip(kept,kept[1:]))
                result['points']=[cache[t] for t in kept]
                result['status']='PASS_EXTERNAL_CHUNK_CANDIDATE'
                result['reason']='all-zero count difference matched by strict alternating actual-Z enclosures; independent full replay pending'
                break
        else:result['reason']='grid through1/64 exhausted without complete count match'
    except Exception as exc:
        result['reason']=type(exc).__name__+': '+str(exc)
    result['distinct_evaluations']=len(cache)
    result['retained_EM_fallbacks']=sum(r['method']=='explicitEM' for r in result['points'])
    result['elapsed_seconds']=time.perf_counter()-start
    if not recompute:OUT.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k not in ('points','fallbacks','source_pins','review_gate')},indent=2),flush=True)
    return 0 if result['status']=='PASS_EXTERNAL_CHUNK_CANDIDATE' else 2

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--budget',type=float,default=120)
    ap.add_argument('--review-gate',required=True);ap.add_argument('--recompute',action='store_true')
    args=ap.parse_args();assert 0<args.budget<=120
    raise SystemExit(run(args.budget,args.review_gate,args.recompute))
