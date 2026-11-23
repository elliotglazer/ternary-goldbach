"""Alternative a/10000 checkpoint: arithmetic-only replay of existing538 endpoints.
No prime counting/sieving; frozen stress data and tight contract remain unchanged.
"""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import json,hashlib
H=Path(__file__).resolve().parent;D=10**9
pins={'resume_psi_short_gap_20261111.json':'E8065467BE53708445486B2F5EA5CBBE408B3A014CF2D1FA8746EC999485F595',
'resume_psi_multi32_20261111.json':'03B835D97BE31AEAA9E48D9AE1A3275BD033767BE8E07EFACAE5118820151D5D',
'resume_psi_stress512_20261111.json':'EADD08660ECD980AEEDBC12F87EB495BC2432F56C6C4A8DC626C4C699B67E593'}
data={}
for name,pin in pins.items():
 b=(H/name).read_bytes();assert hashlib.sha256(b).hexdigest().upper()==pin;data[name]=json.loads(b)
one=data['resume_psi_short_gap_20261111.json'];multi=data['resume_psi_multi32_20261111.json'];stress=data['resume_psi_stress512_20261111.json']
rows=[{'grid_window_index':1,'a':10**9,'b':one['pilot_endpoint'],'count':one['pilot_count'],'subwindows':one['pilot_subwindows'],
 'log_box':one['pilot_log_box'],'theta_lower':one['pilot_theta_lower'],'theta_upper':one['pilot_theta_upper']}]+multi['windows']+stress['windows']
assert len(rows)==538
A=10**9;L=F(999967635190289132,D);U=F(999970323068320645,D);left=(20723265833,20723265841)
assert L>=A-F(A,10000) and U<=A+F(A,10000)
def T12(f):return sum(f**i/F(factorial(i)) for i in range(12))
def valid(box,x):
 l,h=box;a,r=divmod(l,D);f=F(r,D);b,s=divmod(h,D);g=F(s,D)
 return F(27182818286,10**10)**a*(T12(f)+f**12*F(13,12*factorial(12)))<=x and x<F(27182818283,10**10)**b*T12(g) and h-l<=100
assert valid(left,A)
a=A;audited=[]
for index,row in enumerate(rows,1):
 b=row['b'];c=row['count'];right=tuple(row['log_box'])
 assert row['grid_window_index']==index and row['a']==a and b==a+a//4000
 n=a
 for sub in row['subwindows']:
  assert sub['n']==n and 0<sub['width']<=32768
  n+=sub['width']
 assert n==b and sum(s['count'] for s in row['subwindows'])==c
 assert valid(right,b)
 L+=c*F(left[0],D);U+=c*F(right[1],D)
 assert L==F(row['theta_lower']) and U==F(row['theta_upper'])
 ml=L-(b-F(b,10000));mu=b+F(b,10000)-U
 err=max(abs(L-b),abs(U-b))/b
 audited.append({'grid_window_index':index,'endpoint':b,'lower_margin':str(ml),'upper_margin':str(mu),
 'relative_abs_enclosure_error':str(err),'pass':ml>=0 and mu>=0,
 'tight_pass':L>=b-F(b,24000) and U<=b+F(b,24000)})
 a=b;left=right
assert all(r['pass'] for r in audited)
assert [r['grid_window_index'] for r in audited if not r['tight_pass']]==[538]
assert 31622**2<10**9 and F('1.4262')/31622<F(17,360000)
assert F('2.7')**23>5*10**9
lower=F(1,4000)+F(1,10000)
upper=F(1,4000)+(F(1,10000)+F(17,360000))*F(4001,4000)
assert lower<F(1,2300) and upper<F(1,2300)
worst=max(audited,key=lambda r:F(r['relative_abs_enclosure_error']));best=min(audited,key=lambda r:F(r['relative_abs_enclosure_error']))
out={'status':'arithmetic-only alternative checkpoint replay; no new counts or Lean proofs',
 'input_json_sha256':pins,'checkpoint_divisor_alternative':10000,'unchanged_grid_divisor':4000,
 'seed_also_passes':True,'computed_endpoints_after_seed':538,'endpoints_including_seed':539,
 'all_existing_endpoints_pass_alternative':True,'first':audited[0],'last':audited[-1],
 'worst_relative_enclosure_error':worst,'best_relative_enclosure_error':best,
 'minimum_lower_margin':min(audited,key=lambda r:F(r['lower_margin'])),
 'minimum_upper_margin':min(audited,key=lambda r:F(r['upper_margin'])),
 'psi_lower_coefficient':str(lower),'psi_upper_coefficient':str(upper),
 'conservative_target_coefficient':'1/2300','upper_coefficient_margin':str(F(1,2300)-upper),
 'original_tight_failed_endpoint_indices':[538],'remaining_uncounted_windows':5901,
 'new_Lean_count_proofs':0,'endpoints':audited}
(H/'resume_psi_relaxed_checkpoint_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k!='endpoints'},indent=2))
