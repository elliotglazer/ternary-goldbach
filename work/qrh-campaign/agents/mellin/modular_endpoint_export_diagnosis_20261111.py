"""One frozen modular translation: internal balls versus endpoint export."""
from pathlib import Path
from fractions import Fraction as Q
import hashlib
import importlib.util
import json
import sys

sys.dont_write_bytecode=True
HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
 'prime-estimates/principal_theta_modular_pilot_20261111.py':'EAFAC6A19BE3947CBF6D4BA6F900FE3E8BAB58E1C1963E0C1DC35A61A6F55B14',
 'prime-estimates/principal_theta_modular_pilot_20261111.json':'C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF',
 'integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md':'C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D',
}
for name,expected in PINS.items():
 assert hashlib.sha256((AGENTS/name).read_bytes()).hexdigest().upper()==expected,name
helper=AGENTS/'prime-estimates/principal_theta_modular_pilot_20261111.py'
spec=importlib.util.spec_from_file_location('frozen_modular_helper_for_one_edge',helper)
m=importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
m.ctx.prec=256

def val(x):
 a,b=x.man_exp()
 return Q(int(a))*Q(2)**int(b)
def dyadic(q):
 q=Q(q)
 assert q.denominator&(q.denominator-1)==0
 n=q.numerator;e=-(q.denominator.bit_length()-1)
 if n==0: return {'mantissa':'0','exponent':0}
 while n%2==0: n//=2;e+=1
 return {'mantissa':str(n),'exponent':e}
def from_dyadic(d): return Q(int(d['mantissa']))*Q(2)**int(d['exponent'])
def bits(q): return abs(int(dyadic(q)['mantissa'])).bit_length()
def inspect(x):
 mid=val(x.mid());rad=val(x.rad())
 lo=mid-rad;hi=mid+rad
 elo=val(x.lower());ehi=val(x.upper())
 assert elo<=lo<=hi<=ehi
 return {'mid':mid,'rad':rad,'exact_lo':lo,'exact_hi':hi,
         'export_lo':elo,'export_hi':ehi,
         'lower_export_inflation':lo-elo,'upper_export_inflation':ehi-hi}

# Reproduce run_point's initial expression, not reduction(), jets or direct().
eta=m.ar(Q(1,1000001));er=(2*m.ar(Q(0))).exp()
tau=m.acb(-er*(2*eta).cos(),er*(2*eta).sin())
n=-1
translated=tau-n
original=json.loads(helper.with_suffix('.json').read_text())
point=original['points'][0];step=point['steps'][0]
assert point['T']==1000000 and Q(point['r'])==0
assert step['kind']=='T' and step['n']==n
for label,z in [('input',tau),('output',translated)]:
 for part,x in [('re',z.real),('im',z.imag)]:
  assert m.binary(x)==step[label]['binary_'+part],(label,part)

components={}
for part,x,y,shift in [('re',tau.real,translated.real,Q(1)),('im',tau.imag,translated.imag,Q(0))]:
 a,b=inspect(x),inspect(y)
 assert b['mid']==a['mid']+shift and b['rad']==a['rad']
 assert b['exact_lo']==a['exact_lo']+shift and b['exact_hi']==a['exact_hi']+shift
 low_deficit=b['export_lo']-(a['export_lo']+shift)
 high_deficit=a['export_hi']+shift-b['export_hi']
 components[part]={
  'input':{k:dyadic(v) for k,v in a.items()},
  'output':{k:dyadic(v) for k,v in b.items()},
  'exact_shift':str(shift),'internal_translation_is_exact':True,
  'exported_hull_lower_deficit':dyadic(low_deficit),
  'exported_hull_upper_deficit':dyadic(high_deficit),
  'exported_hull_contained':low_deficit<=0 and high_deficit<=0,
  'input_exact_endpoint_mantissa_bits':[bits(a['exact_lo']),bits(a['exact_hi'])],
  'input_export_endpoint_mantissa_bits':[bits(a['export_lo']),bits(a['export_hi'])],
  'output_exact_endpoint_mantissa_bits':[bits(b['exact_lo']),bits(b['exact_hi'])],
 }
real=components['re']
delta=Q(133693435)*Q(2)**-283
assert from_dyadic(real['exported_hull_lower_deficit'])==delta
assert from_dyadic(real['exported_hull_upper_deficit'])==delta
assert from_dyadic(real['input']['rad'])==Q(134742021)*Q(2)**-283
assert from_dyadic(real['input']['lower_export_inflation'])==delta
assert from_dyadic(real['input']['upper_export_inflation'])==delta
assert from_dyadic(real['output']['lower_export_inflation'])==0
assert from_dyadic(real['output']['upper_export_inflation'])==0
assert components['im']['exported_hull_contained']

# Re-export the SAME already-created ball at sufficient precision; do not
# recompute the transcendental input or the arithmetic operation.
m.ctx.prec=283
a_exact_lo=from_dyadic(real['input']['exact_lo'])
a_exact_hi=from_dyadic(real['input']['exact_hi'])
assert val(tau.real.lower())==a_exact_lo and val(tau.real.upper())==a_exact_hi
m.ctx.prec=256

# Proposed compact lossless payload, computed only with exact integer arithmetic.
lossless={part:{label:{'mid':components[part][label]['mid'],'rad':components[part][label]['rad'],
                     'lo':components[part][label]['exact_lo'],'hi':components[part][label]['exact_hi']}
                 for label in ['input','output']} for part in ['re','im']}
for part in lossless:
 for label in lossless[part]:
  d=lossless[part][label]
  assert from_dyadic(d['lo'])==from_dyadic(d['mid'])-from_dyadic(d['rad'])
  assert from_dyadic(d['hi'])==from_dyadic(d['mid'])+from_dyadic(d['rad'])

out={'status':'PASS one-edge diagnosis; frozen endpoint-hull replay still fails as recorded',
 'pins':PINS,'precision_bits':256,'locator':'points[0].steps[0] (T=1000000,r=0,n=-1)',
 'components':components,'same_input_ball_reexport_at_283_bits_is_exact':True,
 'lossless_proposed_payload':lossless,
 'local_api_contracts':{'mid':m.arb.mid.__doc__,'rad':m.arb.rad.__doc__,
                       'lower':m.arb.lower.__doc__,'upper':m.arb.upper.__doc__,
                       'man_exp':m.arb.man_exp.__doc__},
 'scope':'One initial translation only. No reduction loop, series, Gaussian jets, node grid, FFT, full pilot or Lean run. Original receipt unchanged. No conclusion about other failed translation/root operations.'}
dest=HERE/'modular_endpoint_export_diagnosis_20261111.json'
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'status':out['status'],'real_internal_mid_shift_exact':True,
 'real_radius_unchanged':'134742021 * 2^-283',
 'input_export_inflation_each_side':'133693435 * 2^-283',
 'output_export_inflation_each_side':'0',
 'input_exact_endpoint_mantissa_bits':real['input_exact_endpoint_mantissa_bits'],
 'output_exact_endpoint_mantissa_bits':real['output_exact_endpoint_mantissa_bits'],
 'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()},indent=2))
