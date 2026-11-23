"""Independent modular-word and direct-progression checks, without theta/L oracles."""
from fractions import Fraction as F
from pathlib import Path
from math import gcd
import hashlib,json,time,sys
from flint import arb,acb,ctx

START=time.perf_counter();sys.set_int_max_str_digits(1000000)
HERE=Path(__file__).resolve().parent;SRC=HERE.parent/'zero-sum'
PINS={
 'NONPRINCIPAL_MODULAR_BUCKET_PILOT_2026-11-11.md':'67B8600CE22CBCEA5C18AC9B969746A93901D694C3B54CD244425A443F6B8448',
 'nonprincipal_modular_bucket_pilot_20261111.py':'C214A9AE38D15A1F66ADE45CF697C422F8C8282253254A2D012035BBA937845F',
 'nonprincipal_modular_bucket_pilot_20261111.json':'FA310110205329FBD0E7D2710AF8267ED28E1C24320CEB7B4AE86E24486F126F'}
for name,pin in PINS.items():assert hashlib.sha256((SRC/name).read_bytes()).hexdigest().upper()==pin
data=json.loads((SRC/'nonprincipal_modular_bucket_pilot_20261111.json').read_text())
assert data['status']=='PASS_EXTERNAL_MODULAR_BUCKET_PILOT_ONLY'
for name,pin in data['source_pins'].items():assert hashlib.sha256((SRC/name).read_bytes()).hexdigest().upper()==pin
ctx.prec=224
def ar(q):
 q=F(q);return arb(str(q.numerator))/q.denominator
def rb(x):return [str(x.lower().fmpq()),str(x.upper().fmpq())]
def cb(x):return {'real':rb(x.real),'imag':rb(x.imag)}
def inside(x,old):
 lo,hi=map(F,rb(x));a,b=map(F,old);return a<=lo<=hi<=b
def cin(x,old):return inside(x.real,old['real']) and inside(x.imag,old['imag'])
def error(e):
 rad=arb(0,e.upper());return acb(rad,rad)
pi=arb.pi();I=acb(0,1)
def phase(q):
 q=F(q)%1
 fixed={F(0):acb(1),F(1,4):I,F(1,2):acb(-1),F(3,4):-I}
 if q in fixed:return fixed[q]
 angle=2*pi*ar(q);return acb(angle.cos(),angle.sin())
def cent(a,b,p):
 na=(a+F(1,2))//1;nb=(b+F(1,2))//1
 a-=na;b-=nb
 return a,b,(p+a*nb)%1,[na,nb]
def mm(x,y):return [[sum(x[i][k]*y[k][j] for k in range(2)) for j in range(2)] for i in range(2)]
def finite_H(alpha,beta,tau,a,N):
 total=acb(0)
 for k in range(-N,N+1):
  t=ar(F(k)+alpha)
  amp=(-pi*t*t*tau.imag).exp()
  angle=pi*t*t*tau.real+2*pi*t*ar(beta)
  total+=t**a*amp*acb(angle.cos(),angle.sin())
 return total
def reduced_tail(N):
 u=F(2*N+1,2);g=F(6,5)
 return 2*(-ar(g*u*u/2)).exp()/(1-(-ar(g*(2*u+1)/2)).exp())
assert inside(reduced_tail(16),data['parameters']['reduced_H_tail'])
assert reduced_tail(16)<ar(F(2286,10**74))
assert 194*reduced_tail(16)<ar(F(4435,10**72))

results=[];bucket_count=char_count=step_count=phase_count=0
for case in data['cases']:
 c,H,r=case['c'],case['H'],F(case['r'])
 assert (c,H,r) in [(5,64,F(0)),(8,64,F(0)),(5,1024,F(1,8)),(8,1024,F(1,8))]
 # Avoid subtracting a pi/2 phase: this is exactly exp(2r)*(sin(2eta)+i*cos(2eta)).
 eta=ar(F(2,H+1));growth=ar(2*r).exp()
 z=growth*acb(eta.sin(),eta.cos());tau=I*c*z;initial=tau
 assert cin(z,case['z']) and cin(tau,case['initial_tau'])
 common=[acb(1),acb(1)];mat=[[1,0],[0,1]];word_out=[]
 for step in case['word']:
  assert cin(tau,step['tau_before'])
  if step['op']=='T':
   n=step['n'];tau-=n;mat=mm([[1,-n],[0,1]],mat)
   assert tau.real>ar(F(-3,5)) and tau.real<ar(F(3,5))
  else:
   assert step['op']=='S' and tau.imag<ar(F(1,2))
   old=tau;arg=-I*old;assert arg.real>0
   # Explicit principal square root with positive real part.
   modulus=(arg.real**2+arg.imag**2).sqrt()
   root_re=((modulus+arg.real)/2).sqrt()
   root=acb(root_re,arg.imag/(2*root_re));assert root.real>0
   factor=1/root;tau=-1/old
   assert tau.imag>ar(F(100,61))*old.imag
   for val,key in [(arg,'root_input'),(root,'principal_root'),(factor,'A_factor'),(tau,'odd_v_factor')]:
    assert cin(val,step[key]),key
   common[0]*=factor;common[1]*=factor*tau;mat=mm([[0,-1],[1,0]],mat)
  assert mat[0][0]*mat[1][1]-mat[0][1]*mat[1][0]==1
  mobius=(mat[0][0]*initial+mat[0][1])/(mat[1][0]*initial+mat[1][1])
  assert tau.overlaps(mobius) and cin(tau,step['tau_after'])
  word_out.append({'op':step['op'],'matrix':mat,'tau':cb(tau)})
  step_count+=1
 assert tau.imag>ar(F(2,5)) and cin(tau,case['terminal_tau'])
 assert all(cin(common[a],case['common_multipliers'][a]) for a in (0,1))
 # Check the producer's original direct-tail balls, independently of our cutoff.
 old_d0=F(9,2*c*(H+1));assert str(old_d0)==case['direct_d0']
 assert pi*z.real/c>ar(old_d0)
 for a in (0,1):
  old_ratio=ar(F(514,513)**a)*(-ar(old_d0*1027)).exp()
  old_tail=ar(513**a)*(-ar(old_d0*513**2)).exp()/(1-old_ratio)
  assert old_ratio<1 and inside(old_tail,case['positive_direct_tails'][a])
  assert old_tail<ar(F(2266,10**63))

 units=[n for n in range(c) if gcd(n,c)==1]
 if c==5:
  coords={pow(2,j,5):[j] for j in range(4)}
  labels=[([k],{u:F(k*coords[u][0],4)%1 for u in units}) for k in range(4)]
 else:
  coords={(pow(7,j,8)*pow(5,k,8))%8:[j,k] for j in range(2) for k in range(2)}
  labels=[([j,k],{u:F(j*coords[u][0]+k*coords[u][1],2)%1 for u in units}) for j in range(2) for k in range(2)]
 assert {str(k):v for k,v in coords.items()}==case['unit_coordinates']
 chars={};metadata=[]
 for label,ph in labels:
  assert ph[1]==0
  for u in units:
   for v in units:assert ph[u*v%c]==(ph[u]+ph[v])%1
  a=0 if ph[c-1]==0 else 1;assert ph[c-1]==F(a,2)
  conductor=next(d for d in range(1,c+1) if c%d==0 and all(ph[u]==ph[v] for u in units for v in units if u%d==v%d))
  metadata.append({'label':label,'parity':a,'conductor':conductor,'primitive':conductor==c})
  if conductor==c:chars[tuple(label)]=(a,ph)
 assert metadata==case['all_character_metadata']
 assert len(chars)==(3 if c==5 else 2)

 # Independent signed progression sums, twice the author's cutoff and lower d0.
 J=1024;d0=F(3,c*(H+1));assert pi*z.real/c>ar(d0)
 tails=[]
 for a in (0,1):
  ratio=ar(F(J+2,J+1)**a)*(-ar(d0*(2*J+3))).exp();assert ratio<1
  tails.append(ar((J+1)**a)*(-ar(d0*(J+1)**2)).exp()/(1-ratio))
 positive={}
 for n in range(1,J+1):
  if n%c not in units:continue
  amp=(-pi*n*n*z.real/c).exp();angle=-pi*n*n*z.imag/c
  positive[n]=amp*acb(angle.cos(),angle.sin())
 direct={};buckets=[];modular={}
 for row in case['buckets']:
  rr,a=row['residue'],row['a']
  # Compute the actual arithmetic progression directly, including signed moment.
  total=acb(0)
  lo=-((J+rr)//c)
  hi=(J-rr)//c
  for k in range(lo,hi+1):
   n=rr+c*k
   assert -J<=n<=J and n!=0
   total+=n**a*positive[abs(n)]
  direct[rr,a]=total+error(2*tails[a])
  assert cin(direct[rr,a],row['direct_bucket'])
  alpha,beta,p,shift=cent(F(rr,c),F(0),F(0))
  traces=[{'op':'initial_E','alpha':str(alpha),'beta':str(beta),'phase_turns':str(p),'integer_shifts':shift}]
  for op in case['word']:
   if op['op']=='T':
    n=op['n'];p-=F(n,2)*alpha*(alpha-1);beta+=n*(alpha-F(1,2))
   else:
    p+=alpha*beta;alpha,beta=beta,-alpha
   alpha,beta,p,shift=cent(alpha,beta,p)
   assert -F(1,2)<=alpha<F(1,2) and -F(1,2)<=beta<F(1,2)
   assert (2*c)%alpha.denominator==0 and (2*c)%beta.denominator==0
   traces.append({'op':op['op']+'_then_E','alpha':str(alpha),'beta':str(beta),'phase_turns':str(p),'integer_shifts':shift})
  assert traces==row['label_trace'];phase_count+=len(traces)
  assert str(alpha)==row['terminal_alpha'] and str(beta)==row['terminal_beta'] and str(p)==row['phase_turns']
  ph=phase(p);mult=c**a*common[a]*ph
  assert cin(ph,row['phase_value']) and cin(mult,row['multiplier'])
  assert inside(abs(mult),row['amplification_bound']) and abs(mult)<194
  partial16=finite_H(alpha,beta,tau,a,16);assert cin(partial16,row['finite_H'])
  value=mult*(finite_H(alpha,beta,tau,a,20)+error(reduced_tail(20)))
  modular[rr,a]=value
  assert cin(value,row['modular_bucket'])
  assert value.overlaps(direct[rr,a]) and abs(value-direct[rr,a])<ar(F(1,10**50))
  buckets.append({'residue':rr,'a':a,'modular_N20':cb(value),'direct_J1024':cb(direct[rr,a])})
  bucket_count+=1
 charrows=[]
 for row in case['primitive_contractions']:
  a,ph=chars[tuple(row['label'])]
  assert a==row['parity'] and row['conductor']==c
  assert {str(k):str(v) for k,v in ph.items()}==row['exact_unit_phases']
  contracted=sum((phase(ph[u])*modular[u,a] for u in units),acb(0))/2
  dp=sum((phase(ph[n%c])*n**a*v for n,v in positive.items()),acb(0))+error(tails[a])
  opposite=sum((phase(ph[u])*modular[u,1-a] for u in units),acb(0))
  assert opposite.contains(0)
  assert contracted.overlaps(dp) and abs(contracted-dp)<ar(F(1,10**50))
  assert cin(contracted,row['half_modular_contraction']) and cin(dp,row['direct_positive_theta'])
  charrows.append({'label':row['label'],'parity':a,'modular_contraction':cb(contracted),'direct_positive':cb(dp)})
  char_count+=1
 results.append({'c':c,'H':H,'r':str(r),'z':cb(z),'word':word_out,'final_matrix':mat,
                 'direct_d0':str(d0),'positive_tail_bounds':[rb(e) for e in tails],
                 'buckets':buckets,'characters':charrows})
 assert time.perf_counter()-START<60

assert bucket_count==32 and char_count==10
out={'status':'PASS_INDEPENDENT_MODULAR_BUCKET_PILOT_ONLY','producer_pins':PINS,
     'bits':224,'direct_cutoff':1024,'independent_reduced_cutoff':20,
     'bucket_count':bucket_count,'character_contractions':char_count,'word_steps':step_count,
     'exact_phase_trace_entries':phase_count,'producer_tail_balls_checked':9,'cases':results,
     'scope':'Four fixed coefficient inputs only; no L-function, contour or spectral computation'}
(HERE/'review_nonprincipal_bucket_pilot_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({k:out[k] for k in ['status','bucket_count','character_contractions','word_steps','exact_phase_trace_entries']}))
