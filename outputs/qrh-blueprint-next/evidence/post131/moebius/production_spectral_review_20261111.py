"""Bounded replay and independent sampled-Cauchy check.
FLINT zeta remains trusted for point samples; no RS proof or full contour.
"""
from pathlib import Path
from fractions import Fraction as Q
import contextlib,hashlib,io,json,time
from flint import arb,acb,ctx
HERE=Path(__file__).resolve().parent;AUTHOR=HERE.parent/'zero-sum'
pins={'PRODUCTION_SPECTRAL_EVALUATOR_2026-11-11.md':'8494e089bb937b0595dec607eee0d49b4f549134a9371230d3a74a67c74daf9a',
'rs_panel_benchmark_20261111.py':'caccea1dada0d8bdad105fdff6404b19953509bb98f6b4d08bfed877de49ba0d',
'rs_panel_benchmark_20261111.json':'79e020183d5877e680dd1be7d56ecc5ceec2cd8d23c1c3d7e4f2621f7cbe6800',
'rs_cauchy_block_benchmark_20261111.py':'3a06a92d1f09d6ed8b1bab8ddda946bd15dc2b3eb134400b0714c0727bd9d79e',
'rs_cauchy_block_benchmark_20261111.json':'2a5e255442b3151fb08109d326c18c1a856c08eba6dc3d1d751d0981fa778f26'}
for n,h in pins.items():assert hashlib.sha256((AUTHOR/n).read_bytes()).hexdigest()==h
# Replay unchanged source text but set output __file__ inside the reviewer's directory.
replays={}
for stem in ['rs_panel_benchmark_20261111','rs_cauchy_block_benchmark_20261111']:
    virtual=HERE/('review_replay_'+stem+'.py')
    env={'__name__':'__main__','__file__':str(virtual)}
    with contextlib.redirect_stdout(io.StringIO()):
        exec(compile((AUTHOR/(stem+'.py')).read_text(),str(virtual),'exec'),env)
    replays[stem]=json.loads(virtual.with_suffix('.json').read_text())
old=json.loads((AUTHOR/'rs_panel_benchmark_20261111.json').read_text())
for a,b in zip(old['runs'],replays['rs_panel_benchmark_20261111']['runs']):
    assert (a['sigma'],a['height'],a['point_calls'])==(b['sigma'],b['height'],b['point_calls'])
    assert [p['halfplane_nonzero'] for p in a['panels']]==[p['halfplane_nonzero'] for p in b['panels']]==[0,0,16,16]
old=json.loads((AUTHOR/'rs_cauchy_block_benchmark_20261111.json').read_text())
for a,b in zip(old['runs'],replays['rs_cauchy_block_benchmark_20261111']['runs']):
    assert b['complete_local_nonvanishing'] and (a['leaves'],a['maxdepth'])==(b['leaves'],b['maxdepth'])
ctx.prec=192
def ar(x):x=Q(x);return arb(str(x.numerator))/x.denominator
T=10**6;m=64;rho=Q(1,4);r=Q(1,8);R=Q(1,2)
# Entirely rational alternative disk growth majorant from source Abel bound.
M_alt=400000802
assert Q(T+2,T-1)+400*(T+2)<M_alt
factor=((r/R)**m+(rho/R)**m/(1-(rho/R)**m))/(1-r/R)
error=Q(M_alt)*factor
assert error<Q('2.9e-11')
# Also validate author's scalar Rademacher substitution without proving its theorem.
Mrad=33*ar(T+3)/(T-1)*(ar(T+3)/6)**ar(Q(3,5))
assert Mrad<44836 and Mrad*ar(factor)<ar(Q('3.240744e-15'))
independent=[]
for sigma in [Q(201,400),Q(111,200)]:
    assert sigma-R>=Q(1,400) and sigma+R<=Q(211,200)
    c=acb(ar(sigma),T)
    roots=[acb(ar(Q(2*j,m)).cos_pi(),ar(Q(2*j,m)).sin_pi()) for j in range(m)]
    vals=[(c+ar(rho)*w).zeta() for w in roots]
    coeff=[sum((v*(w.conjugate()**k) for w,v in zip(roots,vals)),acb(0))/m for k in range(m)]
    def image(lo,hi):
        z=acb(0,arb(ar((lo+hi)/2),ar((hi-lo)/2)))/ar(rho)
        value=coeff[-1]
        for ck in reversed(coeff[:-1]):value=value*z+ck
        e=arb(0,ar(error).upper());return value+acb(e,e)
    leaves=[]
    def check(lo,hi,depth=0):
        v=image(lo,hi)
        for axis,iv in enumerate([v.real,v.imag]):
            for sign in [1,-1]:
                if sign*iv>0:
                    leaves.append({'lo':str(lo),'hi':str(hi),'axis':axis,'sign':sign,'coordinate_margin':str((sign*iv).lower())});return
        assert depth<8
        mid=(lo+hi)/2;check(lo,mid,depth+1);check(mid,hi,depth+1)
    check(-r,r)
    assert Q(leaves[0]['lo'])==-r and Q(leaves[-1]['hi'])==r
    assert all(a['hi']==b['lo'] for a,b in zip(leaves,leaves[1:]))
    diagnostics=[]
    for t in [-r,-r/2,Q(0),r/2,r]:
        assert image(t,t).overlaps((c+acb(0,ar(t))).zeta());diagnostics.append(str(t))
    independent.append({'sigma':str(sigma),'precision_bits':ctx.prec,'samples':m,
        'M_alternative':M_alt,'error_upper_rational':str(error),'leaves':leaves,
        'point_overlap_diagnostics':diagnostics,'local_block_pass':True})
# Exact operation counts, using conservative rational pi bounds.
pl=Q('3.1415926');pu=Q('3.1415927')
assert 398**2*2*pu<T<399**2*2*pl
assert T+rho<399**2*2*pl
assert 3989**2*2*pu<10**8<3990**2*2*pl
blocks=4*(T-1500);samples=64*blocks;summands=samples*2*399
assert blocks==3994000 and samples==255616000 and summands<204000000000
storage=blocks*64*4*16
assert storage==16359424000
out={'status':'Frozen bounded patterns replay and independent local Cauchy wrapper pass; point zeta remains trusted',
 'input_sha256':pins,'frozen_replay_panel_patterns':[0,0,16,16],
 'frozen_replay_cauchy_leaves':[x['leaves'] for x in replays['rs_cauchy_block_benchmark_20261111']['runs']],
 'independent_local_blocks':independent,'operation_counts':{'blocks':blocks,'samples':samples,
 'two_399_term_summands':summands,'DFT_products_per_block':64**2,'radix2_butterflies_per_block':32*6,'coefficient_raw_bytes':storage},
 'wording_correction':'Balanced AFE real length sqrt(1e8/(2pi)) is between3989and3990; floor3989, ceiling3990.',
 'limitations':'No full contour, winding, production strip, independently proved RS point values, or formal Rademacher theorem.'}
HERE.joinpath('production_spectral_review_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k!='input_sha256'},indent=2))
