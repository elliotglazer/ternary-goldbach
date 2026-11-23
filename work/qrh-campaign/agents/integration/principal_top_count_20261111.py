"""Bounded external interval certificate: top path at T=10^6 only.

No indexed zeros, S/count helper, vertical mesh, or zero enumeration.
FLINT zeta point enclosures remain an external analytic/numeric dependency.
"""
import argparse
import hashlib
import json
import platform
import time
from fractions import Fraction as Q
from pathlib import Path
from flint import arb, acb, ctx

P = argparse.ArgumentParser()
P.add_argument('--replay', action='store_true')
args = P.parse_args()
ctx.prec = 128
T = 10**6
m = 64
R, rho, radius = arb(1)/2, arb(1)/4, arb(1)/8
outpath = Path(__file__).with_suffix('.json')
clock = time.perf_counter()
cpu = time.process_time()

def a(q):
    q = Q(q)
    return arb(q.numerator)/q.denominator

def exact(x):
    return str(x.fmpq())

def real_box(x):
    assert x.is_finite()
    return [exact(x.lower()), exact(x.upper())]

def complex_box(z):
    return {'re': real_box(z.real), 'im': real_box(z.imag)}

def hp(z):
    if z.real > 0: return 'right'
    if z.real < 0: return 'left'
    if z.imag > 0: return 'upper'
    if z.imag < 0: return 'lower'
    return None

rotations = {'right': acb(1), 'left': acb(-1),
             'upper': acb(0,-1), 'lower': acb(0,1)}
endpoints = {}
def endpoint(x):
    x = Q(x)
    if x not in endpoints:
        endpoints[x] = acb(a(x),T).zeta()
    return endpoints[x]

# Every outer disk has Re>=1/8 and |s|<=T+3, |s-1|>=T-1/2.
# The source growth inequality yields |zeta(s)| < 2+8(T+3).
M = arb(8*(T+3)+2)
assert (a(T+3)/a(Q(T)-Q(1,2))) < 2
error = M/(1-radius/R)*((radius/R)**m+(rho/R)**m/(1-(rho/R)**m))
roots = [acb(0,2*arb.pi()*j/m).exp() for j in range(m)]
blocks = []
increments = []
panel_count = 0
sample_calls = 0

for bi in range(6):
    right = Q(2)-Q(bi,4)
    left = right-Q(1,4)
    center = (right+left)/2
    samples = [(acb(a(center),T)+rho*w).zeta() for w in roots]
    sample_calls += m
    coeff = [sum((samples[j]*roots[(-j*k)%m] for j in range(m)),acb(0))/m
             for k in range(m)]
    def model(lo,hi):
        z = acb(arb(a((lo+hi)/2-center),a((hi-lo)/2)))/rho
        value = acb(0)
        for c in reversed(coeff):
            value = value*z+c
        return value+acb(arb(0,error),arb(0,error))
    accepted = []
    def cover(lo,hi,depth):
        global panel_count
        value = model(lo,hi)
        side = hp(value)
        if side:
            rot = rotations[side]
            vr, vl = endpoint(hi), endpoint(lo)
            # One actual endpoint enclosure is shared across all incident panels.
            # It must lie in each selected rotated right half-plane.
            if (rot*vr).real > 0 and (rot*vl).real > 0:
                inc = ((rot*vl).log()-(rot*vr).log()).imag
                increments.append(inc)
                panel_count += 1
                accepted.append({'from': str(hi), 'to': str(lo), 'depth':depth,
                                 'halfplane':side, 'model_box':complex_box(value),
                                 'increment':real_box(inc)})
                return
        if depth>=16 or panel_count>=4096:
            raise RuntimeError(f'Unresolved nonvanishing/endpoint panel at T={T}: {lo}..{hi}')
        mid = (lo+hi)/2
        cover(mid,hi,depth+1)
        cover(lo,mid,depth+1)
    cover(left,right,0)
    assert accepted[0]['from']==str(right) and accepted[-1]['to']==str(left)
    for x,y in zip(accepted,accepted[1:]):
        assert x['to']==y['from']
    blocks.append({'index':bi,'from':str(right),'to':str(left),'center':str(center),
                   'sample_boxes':[complex_box(v) for v in samples],
                   'coefficient_boxes':[complex_box(c) for c in coeff],
                   'panels':accepted})

initial = endpoint(Q(2))
assert initial.real > arb(1)/4
initial_arg = initial.log().imag
horizontal_arg = sum(increments,arb(0))
continuous_arg = initial_arg+horizontal_arg
S = continuous_arg/arb.pi()
F = arb(T)/(2*arb.pi())*((arb(T)/(2*arb.pi())).log()-1)+arb(7)/8
count_interval = F+S+arb(0,arb(1)/8)
lower,upper = map(Q,real_box(count_interval))
lo_int = -((-lower.numerator)//lower.denominator)
hi_int = upper.numerator//upper.denominator
assert lo_int==hi_int, ('No unique integer', str(lower),str(upper))
assert blocks[0]['from']=='2' and blocks[-1]['to']=='1/2'

certificate = {'status':'PASS_EXTERNAL_TOP_PATH_AND_INTEGER_COUNT',
  'height':T,'orientation':'2+iT to 1/2+iT', 'precision_bits':ctx.prec,
  'model':{'m':m,'R':'1/2','rho':'1/4','r':'1/8','outer_growth_bound':8*(T+3)+2,
           'alias_plus_truncation_error':real_box(error)},
  'blocks':blocks,
  'endpoint_boxes':{str(k):complex_box(v) for k,v in sorted(endpoints.items())},
  'initial_arg':real_box(initial_arg),'horizontal_arg':real_box(horizontal_arg),
  'continuous_arg':real_box(continuous_arg),'S':real_box(S),'F':real_box(F),
  'count_interval':real_box(count_interval),'ceil_lower':lo_int,'floor_upper':hi_int,
  'positive_ordinate_zero_count':lo_int,
  'sample_point_calls':sample_calls,'endpoint_point_calls':len(endpoints),
  'accepted_panels':panel_count,
  'limits':{'complete_narrow_strip':False,'zero_enumeration':False,'lean_proof':False,
            'formal_RS_proof':False,'independent_review':'pending',
            'trusted_external_point_evaluator':'FLINT acb.zeta; elementary interval arithmetic'},
  'source_script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}

if args.replay:
    old=json.loads(outpath.read_text())
    assert old['certificate']==certificate, 'Regenerated certificate differs'
    print('PASS_EXTERNAL_REGENERATED_CERTIFICATE_MATCH')
else:
    outpath.write_text(json.dumps({'certificate':certificate,
      'measurement':{'wall_seconds':time.perf_counter()-clock,
                     'process_cpu_seconds':time.process_time()-cpu,
                     'python':platform.python_version(),'platform':platform.platform()}},indent=2))
print(json.dumps({'count':lo_int,'blocks':len(blocks),'panels':panel_count,
    'point_calls':sample_calls+len(endpoints),'S_display':str(S),
    'F_display':str(F),'count_interval_display':str(count_interval),
    'wall_seconds':time.perf_counter()-clock},indent=2))
