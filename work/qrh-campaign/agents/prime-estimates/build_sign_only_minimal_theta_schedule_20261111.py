"""Conditional saved-metadata join. No evaluator imports or function values."""
from pathlib import Path
from fractions import Fraction as Q
from copy import deepcopy
from collections import Counter
import argparse, hashlib, json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
PINS={
 'work/qrh-blueprint/MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md':'654484AF0793EA0D5A2D51A2842E06753F4D8CEC0BF75A96953EF017D9B3173F',
 'work/qrh-blueprint/minimal_theta_nonprincipal_schedule_20261111.json':'96483C8A5E47888AC9208A8B95CA1BD8261CBC9D42AFBCBAEE1A1ABF10AC9265',
 'work/qrh-campaign/agents/zero-sum/REVIEW_MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md':'C4DD11BAD42C5F6970FCABC93F90AC7506B5C01278C3EF02155AD6404B2B9F52',
 'work/qrh-campaign/agents/audit/SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md':'076030481DEB4A922356A5BC0B8CCB243DF3FBB15A0DD427A29DEB044E82D430',
 'work/qrh-campaign/agents/zero-sum/REVIEW_SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md':'5683768E8F7B8B93FD4CD2E45CDBED40BFA9CC1BAE238CF920A22B40FEBB820A',
 'work/qrh-campaign/agents/audit/raw_small_theta_sign_scalars_20261111.json':'D6FA13513E2A01B4B3ACFFD0A93B7B0C811F864A1C4FDAB3E907FA23626532CB',
}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
def ceil(x):return -(-x.numerator//x.denominator)
def bits(x):
 b=max(0,x.denominator.bit_length()-x.numerator.bit_length())
 if Q(1,2**b)>x:b+=1
 return b
def height(c):
 i=0 if c<100 else 1 if c<1000 else 2 if c<10000 else 3
 u=([Q(21),Q(20),Q(39,2),Q(96,5)] if c%2 else [Q(113,5),Q(211,10),Q(201,10),Q(191,10)])[i]
 return ceil(200+max(Q(240 if c%2 else 255),Q(3927,1250)*u*Q(531600 if c%2 else 1063200,c)))
def nfft(m,K,theta):
 need=max(ceil(Q(2*m*K,theta)),ceil(Q(5*m+128*K,5)),ceil(Q(384,5)))
 return max(8,1<<(need-1).bit_length())
def removed(t):
 c=t['conductors'];q=t['primitive_grid_outputs'];updates=t['conductor_grid_nodes']-c
 ck(t['omega_complex_scalings']==q and t['final_Y_real_products']==q)
 ck(t['positive_scale_real_updates']==updates)
 ck(t['real_exp_seed_certificates']==2*c)
 return dict(omega_complex_scalings=q,final_Y_real_products=q,
             positive_scale_real_updates=updates,real_exp_seed_certificates=c)
def change_counts(t):
 new=deepcopy(t);deductions=removed(t)
 for k,v in deductions.items():new[k]-=v
 ck(all(new[k]==v for k,v in t.items() if k not in deductions))
 ck(new['real_exp_seed_certificates']==t['conductors'])
 return new,deductions

parser=argparse.ArgumentParser()
parser.add_argument('--consumer-report',required=True)
parser.add_argument('--consumer-sha',required=True)
args=parser.parse_args()
consumer=Path(args.consumer_report)
ck(not consumer.is_absolute() and '..' not in consumer.parts)
ck(len(args.consumer_sha)==64 and all(ch in '0123456789abcdefABCDEF' for ch in args.consumer_sha))
PINS[consumer.as_posix()]=args.consumer_sha.upper()
for p,h in PINS.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
base=json.loads((ROOT/'work/qrh-blueprint/minimal_theta_nonprincipal_schedule_20261111.json').read_text())
raw=json.loads((ROOT/'work/qrh-campaign/agents/audit/raw_small_theta_sign_scalars_20261111.json').read_text())
out=deepcopy(base)
out['scope']='Conditional small-branch canonical-sign candidate through raw U; large branch unchanged. No values, signs, interpolation completion or RH certified.'
out['predecessor_pins']=deepcopy(base['pins'])
out['pins']=PINS
out['downstream_precision']='Small raw time gates use the selected coarse gate tolerance /8 (+3 fractional bits). No final omega or Y output rounding. All other construction/root/frequency tolerances remain.'
out['output_contract']={
 'small':'At admitted targets prove z>E_raw or z<-E_raw, E_raw=109*epsilon*P/704. Otherwise inconclusive. Fixed actual character/phase and polynomial binding required.',
 'large':'Unchanged predecessor output contract; no large-branch normalization deduction.',
 'amplitude_exceptions':'No Y/L amplitude, amplitude integral, Gaussian-sinc Y interpolation, contour winding or derivative certificate is supplied. Price separately when required.',
 'tau_role':'2^-80 remains the epsilon-parameter convention, not a promise to export small-branch Y amplitudes.',
 'cardinality':'Requested output/site counts are preserved as geometry only, not successful signs or a homogeneous amplitude-output count.'}
out['sign_only_required_unpriced']=[
 'Raw polynomial sample identity and retained/recomputed full-FFT dependency union.',
 'Exact rational threshold construction, outward rounding if chosen, and every strict comparison.',
 'Raw integer-part/product width and checker implementation costs.',
 'Fixed340 interpolation kernels, sample retention, products/additions/rounding for actual offgrid queries.',
 'Variable-order and polyphase alternatives remain separate; no costs or savings imported.',
 'Additional amplitude consumers and their required normalizations are exceptions to this deletion.',
]
params={(s['odd'],s['theta']):s for s in base['selectors']}
summaries=[];digest=hashlib.sha256()
for old,new,rrow in zip(base['scenarios'],out['scenarios'],raw['rows'],strict=True):
 ck(old['extra_nodes']==rrow['extra'])
 extra=old['extra_nodes'];s=old['small_minimal_theta_candidate'];t=deepcopy(s)
 t['totals'],deductions=change_counts(s['totals'])
 cohort_deductions={}
 for ckey,ct in s['by_conductor_parity'].items():
  t['by_conductor_parity'][ckey],cohort_deductions[ckey]=change_counts(ct)
 for key,value in t['totals'].items():
  ck(sum(ct[key] for ct in t['by_conductor_parity'].values())==value)
 ck(deductions['omega_complex_scalings']==rrow['removed_coarse_omega_scalings'])
 ck(deductions['final_Y_real_products']==rrow['removed_coarse_Y_products'])
 ck(deductions['positive_scale_real_updates']==rrow['removed_shared_positive_updates'])
 ck(deductions['real_exp_seed_certificates']==rrow['removed_positive_exp_seeds'])
 ck(t['totals']['time_dft_complex_outputs']==rrow['full_time_outputs'])
 ranges=t.pop('local_fractional_bit_ranges')
 retained={k:v for k,v in ranges.items() if k not in ('time','scale')}
 t['local_fractional_bit_ranges']=retained
 t['local_fractional_bit_ranges']['time_raw_sign']=[p+3 for p in ranges['time']]
 t['range_disposition']={
  'retained_keys':[k for k in ranges if k not in ('time','scale')],
  'time':{'old_coarse':ranges['time'],'new_raw_sign':[p+3 for p in ranges['time']],'factor':'1/8'},
  'scale':{'old_positive_Y_recurrence_only':ranges['scale'],'status':'inapplicable; not a radial/coefficient/phase tolerance'},
 }
 t['additional_rounding']='Retain all coefficient/prefactor/root/frequency rounding and rounded bucket additions. Remove only final output omega and positive Y operations. Raw time gates /8; new thresholds and interpolation remain required.'
 t['removed_prefix_categories']=deductions
 t['removed_by_conductor_cohort']=cohort_deductions
 t['real_exp_seed_split']={'radial_retained':t['totals']['conductors'],'positive_Y_removed':t['totals']['conductors']}
 index=[];time_bits=[];widths=[];lengths=Counter();multipliers={}
 for c,theta in t['conductor_theta']:
  p=params[c%2==1,theta];eps=Q(p['eps']);W=Q(p['W']);B=2*W*W+1
  m=ceil(Q(64*height(c),5))+extra;N=nfft(m,p['K'],theta);P=Q(5*N,64);H=Q(44,7)/P;L=6/P
  k=N.bit_length()-1;J=ceil(Q(25*N,192));CU=(2*J+1)*B
  utime=min(Q(1,2*k),eps*Q(5,64)/(56*(2*k+4)*(B+1)))
  uraw=utime/8
  ck(N*(2*k+4)*uraw*(B+1)<eps/(64*H))
  ck(eps/(64*H)<1 and H<1)
  ck(H*(CU+1)<=44*B+1)
  threshold=3*eps/(4*L)+3*eps/(16*H)
  ck(threshold==Q(109,704)*eps*P)
  ck(H*threshold==Q(109,112)*eps<eps)
  ck(bits(uraw)==bits(utime)+3)
  w=0
  while 2**w<CU+1:w+=1
  index.append([c,m,N,bits(uraw),w]);time_bits.append(bits(uraw));widths.append(w);lengths[N]+=1
  multipliers[str(N)]=str(Q(109,704)*P)
  digest.update(json.dumps([extra,c,theta,m,N,str(threshold)],separators=(',',':')).encode())
 ck({str(k):v for k,v in sorted(lengths.items())}==s['time_length_conductors'])
 ck([min(time_bits),max(time_bits)]==t['local_fractional_bit_ranges']['time_raw_sign'])
 t['raw_metadata_columns']=['conductor','last_coarse_grid_index','N','raw_time_fractional_bits','raw_sample_magnitude_power2_exponent']
 t['raw_metadata']=index
 t['threshold_multiplier_of_epsilon_by_N']=multipliers
 t['raw_sample_magnitude_power2_range']=[min(widths),max(widths)]
 new.pop('small_minimal_theta_candidate')
 new['small_sign_only_conditional_candidate']=t
 ck(new['large']==old['large'] and new['safe_cardinality_sum']==old['safe_cardinality_sum'])
 summaries.append(dict(extra_nodes=extra,deductions=deductions,raw_time_bit_range=[min(time_bits),max(time_bits)],
                       raw_sample_magnitude_power2_range=[min(widths),max(widths)],raw_outputs=t['totals']['time_dft_complex_outputs']))
for key in ('setup','setup_alias_rule','family_partition','selectors','common','required_unpriced'):
 ck(out[key]==base[key])
out['check_receipt']={'checks':checks,'row_digest':digest.hexdigest().upper(),'summary':summaries,
 'scope':'Saved metadata and exact rational bounds only; no sign success or function evaluation.'}
dest=HERE/'sign_only_minimal_theta_nonprincipal_schedule_20261111.json'
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(out['check_receipt'],indent=2))
