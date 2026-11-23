"""Four modular signed-bucket checks. Explicit series only; no theta/L oracle."""
from fractions import Fraction as F
from pathlib import Path
from math import gcd
import hashlib,json,time,sys
from flint import arb,acb,ctx
import flint

ctx.prec=192
HERE=Path(__file__).parent
PINS={
 '../integration/NONPRINCIPAL_THETA_MODULAR_BUCKETS_2026-11-11.md':'2EADB0ACEE2B3C8275D9C8CFA815E4E3E7CC39C3CB0EBA0A86763A4877F74F09',
 '../major-constants/REVIEW_NONPRINCIPAL_THETA_MODULAR_BUCKETS_2026-11-11.md':'FB6A7BD014A4417CD4D3AD2460C0785EDE3838226AA6F9013248863FB3135E70'}
for path,pin in PINS.items():assert hashlib.sha256((HERE/path).read_bytes()).hexdigest().upper()==pin
def ar(q):
 q=F(q);return arb(str(q.numerator))/q.denominator
def rb(x):return [str(x.lower().fmpq()),str(x.upper().fmpq())]
def cb(x):return {'real':rb(x.real),'imag':rb(x.imag)}
def eb(e):
 q=arb(0,e.upper());return acb(q,q)
def unitphase(q):
 q=F(q)%1
 exact={F(0):acb(1),F(1,4):acb(0,1),F(1,2):acb(-1),F(3,4):acb(0,-1)}
 return exact[q] if q in exact else acb(0,2*arb.pi()*ar(q)).exp()
def center(q):
 n=(q+F(1,2)).numerator//(q+F(1,2)).denominator
 return q-n,n
def reduce_label(alpha,beta,phase):
 alpha,p=center(alpha);beta,q=center(beta);phase=(phase+alpha*q)%1
 return alpha,beta,phase,[p,q]
def labels(c):
 units=[r for r in range(c) if gcd(r,c)==1]
 if c==5:
  coords={pow(2,j,5):[j] for j in range(4)}
  rows=[{'label':[k],'phases':{r:F(k*coords[r][0],4)%1 for r in units}} for k in range(4)]
 else:
  assert c==8
  coords={(pow(7,u,8)*pow(5,v,8))%8:[u,v] for u in range(2) for v in range(2)}
  rows=[{'label':[k,l],'phases':{r:F(k*coords[r][0]+l*coords[r][1],2)%1 for r in units}} for k in range(2) for l in range(2)]
 assert sorted(coords)==units
 for row in rows:
  ph=row['phases'];assert ph[1]==0
  for r in units:
   for s in units:assert ph[(r*s)%c]==(ph[r]+ph[s])%1
  row['parity']=0 if ph[c-1]==0 else 1
  assert ph[c-1] in [F(0),F(1,2)]
  row['conductor']=next(d for d in range(1,c+1) if c%d==0 and all(ph[r]==ph[s] for r in units for s in units if r%d==s%d))
  row['primitive']=row['conductor']==c
 return units,coords,rows

NRED=16;JDIR=512;gamma=F(6,5);u=F(2*NRED+1,2)
ered=2*(-ar(gamma*u*u/2)).exp()/(1-(-ar(gamma*(2*u+1)/2)).exp())
started=time.perf_counter()
def case(c,H,r):
 assert H>=1 and r>=0
 units,coords,chars=labels(c)
 b=arb.pi()/4-ar(F(1,H+1));z=(2*acb(ar(r),b)).exp();tau=acb(0,c)*z
 assert z.real>0 and tau.imag>0
 initial=tau;word=[];common=[acb(1),acb(1)];inversions=0
 while True:
  assert time.perf_counter()-started<60 and inversions<20
  re=F(str(tau.real.mid().fmpq()));n=(re+F(1,2)).numerator//(re+F(1,2)).denominator
  old=tau;tau-=n
  assert tau.real>ar(F(-3,5)) and tau.real<ar(F(3,5))
  word.append({'op':'T','n':n,'tau_before':cb(old),'tau_after':cb(tau)})
  if tau.imag>ar(F(2,5)):break
  assert tau.imag<ar(F(1,2))
  old=tau;rootarg=-acb(0,1)*old
  assert rootarg.real>0
  root=rootarg.sqrt();assert root.real>0
  factor=1/root;tau=-1/old
  assert tau.imag>ar(F(100,61))*old.imag
  common[0]*=factor;common[1]*=factor*tau;inversions+=1
  word.append({'op':'S','tau_before':cb(old),'tau_after':cb(tau),'root_input':cb(rootarg),
               'principal_root':cb(root),'A_factor':cb(factor),'odd_v_factor':cb(tau)})
 assert tau.imag>ar(F(2,5))
 # Strict direct tail lower exponent: sin(u)>=u-u^3/6>=3u/4, u<=1.
 d0=F(9,2*c*(H+1));assert F(2,H+1)<=1
 assert arb.pi()*z.real/c>ar(d0)
 tails=[]
 for a in [0,1]:
  n0=JDIR+1;ratio=ar(F(n0+1,n0)**a)*(-ar(d0*(2*JDIR+3))).exp()
  assert ratio<1
  tails.append(ar(n0**a)*(-ar(d0*n0*n0)).exp()/(1-ratio))
 direct={(rr,a):acb(0) for rr in units for a in [0,1]};positive={}
 for n in range(1,JDIR+1):
  e=(-arb.pi()*n*n*z/c).exp();positive[n]=e
  rr=n%c
  if rr in units:
   for a in [0,1]:
    direct[rr,a]+=n**a*e
    direct[(-rr)%c,a]+=(-n)**a*e
 for key in direct:direct[key]+=eb(2*tails[key[1]])
 modular={};bucket_rows=[]
 for rr in units:
  alpha,beta,phase,shift=reduce_label(F(rr,c),F(0),F(0))
  trace=[{'op':'initial_E','alpha':str(alpha),'beta':str(beta),'phase_turns':str(phase),'integer_shifts':shift}]
  for op in word:
   if op['op']=='T':
    n=op['n'];phase-=F(n,2)*alpha*(alpha-1);beta+=n*(alpha-F(1,2))
   else:
    phase+=alpha*beta;alpha,beta=beta,-alpha
   alpha,beta,phase,shift=reduce_label(alpha,beta,phase)
   assert (2*c)%alpha.denominator==0 and (2*c)%beta.denominator==0
   trace.append({'op':op['op']+'_then_E','alpha':str(alpha),'beta':str(beta),'phase_turns':str(phase),'integer_shifts':shift})
  for a in [0,1]:
   partial=acb(0)
   for k in range(-NRED,NRED+1):
    t=ar(F(k)+alpha)
    partial+=t**a*(acb(0,arb.pi())*t*t*tau+acb(0,2*arb.pi())*t*ar(beta)).exp()
   multiplier=c**a*common[a]*unitphase(phase)
   value=multiplier*(partial+eb(ered));modular[rr,a]=value
   assert value.overlaps(direct[rr,a])
   assert abs(value-direct[rr,a])<ar(F(1,10**35))
   bucket_rows.append({'residue':rr,'a':a,'label_trace':trace,'terminal_alpha':str(alpha),'terminal_beta':str(beta),
                       'phase_turns':str(phase),'phase_value':cb(unitphase(phase)),'finite_H':cb(partial),
                       'multiplier':cb(multiplier),'amplification_bound':rb(abs(multiplier)),
                       'modular_bucket':cb(value),'direct_bucket':cb(direct[rr,a]),'overlap':True})
 char_rows=[]
 for row in chars:
  if not row['primitive']:continue
  a=row['parity'];ph=row['phases'];weighted=sum((unitphase(ph[rr])*modular[rr,a] for rr in units),acb(0))/2
  opp=sum((unitphase(ph[rr])*modular[rr,1-a] for rr in units),acb(0))
  assert opp.contains(0)
  dp=sum((unitphase(ph[n%c])*n**a*positive[n] for n in range(1,JDIR+1) if n%c in units),acb(0))+eb(tails[a])
  assert weighted.overlaps(dp) and abs(weighted-dp)<ar(F(1,10**35))
  char_rows.append({'label':row['label'],'parity':a,'conductor':row['conductor'],
                    'exact_unit_phases':{str(k):str(v) for k,v in ph.items()},
                    'half_modular_contraction':cb(weighted),'direct_positive_theta':cb(dp),'overlap':True,
                    'opposite_parity_signed_contraction':cb(opp)})
 return {'c':c,'H':H,'r':str(r),'b':rb(b),'z':cb(z),'initial_tau':cb(initial),'terminal_tau':cb(tau),
         'word':word,'inversions':inversions,'common_multipliers':[cb(x) for x in common],
         'unit_coordinates':{str(k):v for k,v in coords.items()},
         'all_character_metadata':[{k:v for k,v in row.items() if k!='phases'} for row in chars],
         'direct_d0':str(d0),'positive_direct_tails':[rb(x) for x in tails],
         'buckets':bucket_rows,'primitive_contractions':char_rows}

out={'status':'PASS_EXTERNAL_MODULAR_BUCKET_PILOT_ONLY','parameters':{'bits':ctx.prec,'reduced_N':NRED,'direct_J':JDIR,
      'gamma':str(gamma),'reduced_H_tail':rb(ered)},'source_pins':PINS,
     'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
     'cases':[case(c,H,r) for H,r in [(64,F(0)),(1024,F(1,8))] for c in [5,8]],
     'elapsed_seconds':time.perf_counter()-started,'flint_version':flint.__FLINT_VERSION__,
     'scope':'Four fixed points, all unit signed buckets, both moments, matching primitive contractions. No contour, FFT, spectral or Lean claim.'}
path=Path(__file__).with_suffix('.json')
if '--recompute' in sys.argv:
 prior=json.loads(path.read_text());prior.pop('elapsed_seconds');compare=out.copy();compare.pop('elapsed_seconds');assert prior==compare
else:path.write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({'status':out['status'],'elapsed_seconds':out['elapsed_seconds'],
 'cases':[{'c':v['c'],'H':v['H'],'r':v['r'],'word':[{'op':w['op'],**({'n':w['n']} if w['op']=='T' else {})} for w in v['word']],
           'buckets':len(v['buckets']),'primitive_contractions':len(v['primitive_contractions'])} for v in out['cases']]},indent=2))
