"""Independent structural and alternate-parameter replay of the frozen c5 cover.
Reuses only independently written polynomial primitives, not author models.
No new fit, rectangle or boundary panels are introduced.
"""
from pathlib import Path
from fractions import Fraction as F
import importlib.util,json,hashlib,time
HERE=Path(__file__).resolve().parent;SRC=HERE.parent/'zero-sum'
HELP=HERE/'review_c5_taylor_panels_20261111.py'
assert hashlib.sha256(HELP.read_bytes()).hexdigest().upper()=='B00458A4885C842DAF57CBC6A095BA9134E115898A7670D49111E92B8385409F'
spec=importlib.util.spec_from_file_location('independent_taylor',HELP)
t=importlib.util.module_from_spec(spec);spec.loader.exec_module(t)
def box(a,b):
 return t.acb(t.arb(t.ar((a[0]+b[0])/2),t.ar(abs(a[0]-b[0])/2)),
              t.arb(t.ar((a[1]+b[1])/2),t.ar(abs(a[1]-b[1])/2)))
def horner(co,z):
 v=co[-1]
 for a in reversed(co[:-1]):v=v*z+a
 return v
def partition(rows,complete):
 L=F(111,200);R=F(2);T=F(12);prev=(L,-T);length=F(0)
 for row in rows:
  a,b=[tuple(map(F,row[k])) for k in ('a','b')]
  assert a==prev
  assert (a[1]==b[1]==-T and L<=a[0]<b[0]<=R or a[0]==b[0]==R and -T<=a[1]<b[1]<=T or
          a[1]==b[1]==T and L<=b[0]<a[0]<=R or a[0]==b[0]==L and -T<=b[1]<a[1]<=T)
  length+=sum(abs(b[j]-a[j]) for j in range(2));prev=b
 if complete:assert prev==(L,-T) and length==F(5089,100)
 return length
def mesh():
 corners=[(F(111,200),F(-12)),(F(2),F(-12)),(F(2),F(12)),(F(111,200),F(12)),(F(111,200),F(-12))]
 out=[]
 for i,(a,b) in enumerate(zip(corners,corners[1:])):
  n=47 if i%2==0 else 768
  for j in range(n):out.append(tuple(tuple(a[k]+(b[k]-a[k])*F(j+off,n) for k in range(2)) for off in (0,1)))
 return out
def main():
 start=time.perf_counter();path=SRC/'c5_centered_complete_attempt_20261111.json'
 d=json.loads(path.read_text());complete=d['status']=='PASS_EXTERNAL_COMPLETE_C5_GLOBAL_INVERSE'
 assert d['candidate_sha256'].upper()=='02C623629D3DF9218AFB7689F39698AF5C4F4D6FB6776056C4B275220D148E6E'
 assert d['characters']==[1,2,3] and d['rectangle']==['111/200','2','-12','12']
 assert d['panel_calls']<=4000 and d['max_calls']==4000 and d['max_seconds']==180
 assert d['panel_count']==len(d['panels']) and d['model_count']==len(d['models'])
 assert d['panel_calls']==len(d['attempts'])==d['panel_count']+d['failed_panel_evaluations']
 accepted=[]
 for r in d['attempts']:
  p=[F(r['l1_upper'])<1,F(r['T16_upper'])<1];assert p==r['passed']
  if any(p):accepted.append((r['model'],r['a'],r['b'],r['depth']))
 assert accepted==[(r['model'],r['a'],r['b'],r['depth']) for r in d['panels']]
 length=partition(d['panels'],complete);expected=mesh()
 if complete:assert len(d['models'])==len(expected)==1630
 tau=F(0);by_model={j:[] for j in range(len(d['models']))}
 for j,m in enumerate(d['models']):
  assert tuple(tuple(map(F,m[k])) for k in ('a','b'))==expected[j]
 for r in d['panels']:
  assert r['method'] in ('l1','T16')
  q=F(r['bound']);v=F(r['scalar_residual_upper']);assert 0<=q<1 and 0<=v<1
  assert q<= (v if r['method']=='l1' else v**32)
  tau=max(tau,v);by_model[r['model']].append(r)
 candidate=json.loads((SRC/'c5_global_inverse_candidate_20261111.json').read_text())
 cc=[[t.acb(t.ar(F(z[0])),t.ar(F(z[1]))) for z in row] for row in candidate['coefficients']]
 poles=[t.acb(t.ar(F(x)),t.ar(F(y))) for x,y in candidate['poles']]
 out=[];failures=[]
 for j,m in enumerate(d['models']):
  a,b=expected[j];center=tuple((a[k]+b[k])/2 for k in range(2));rho=sum(abs(b[k]-a[k]) for k in range(2))/2
  assert 0<rho<=F(1,64)<F(11,200) and rho<t.R and center[0]-t.R>0
  s=t.acb(t.ar(center[0]),t.ar(center[1]));gj=t.jets(center);bj=[t.const(x) for x in cc[0]];bt=[t.arb(0) for _ in range(3)]
  for pole,w in zip(poles,cc[1:]):
   diff=s-pole;dist=abs(diff).lower();assert dist>t.ar(rho)
   inv=1/diff;power=inv
   for k in range(t.D+1):
    for c in range(3):bj[c][k]+=w[c]*power
    power*=-inv
   fac=t.ar(rho)**(t.D+1)/(dist**(t.D+1)*(dist-t.ar(rho)))
   for c in range(3):bt[c]+=abs(w[c]).upper()*fac
  mg,_=t.controls(center,t.R);_,ep=t.controls(center,rho)
  le=ep+mg*t.ar(rho/t.R)**(t.D+1)/(1-t.ar(rho/t.R))
  residual=[];errors=[]
  for c in range(3):
   poly=t.scale(t.mul(gj[c],bj[c],2*t.D+1),-1);poly[0]+=1;residual.append(poly)
   errors.append((le*(t.norm(bj[c],rho)+bt[c])+t.norm(gj[c],rho)*bt[c]).upper())
  for r in by_model[j]:
   x,y=[tuple(map(F,r[k])) for k in ('a','b')]
   for p in (x,y):
    assert sum(abs(p[k]-center[k]) for k in range(2))<=rho
    assert all(min(a[k],b[k])<=p[k]<=max(a[k],b[k]) for k in range(2))
   z=box(tuple(x[k]-center[k] for k in range(2)),tuple(y[k]-center[k] for k in range(2)))
   vals=[horner(poly,z)+t.acb(t.arb(0,e),t.arb(0,e)) for poly,e in zip(residual,errors)]
   ii=t.acb(0,1)
   group=[sum((vals[k-1]*ii**((-k*g)%4) for k in (1,2,3)),t.acb(0))/4 for g in range(4)]
   q1=sum((abs(v).upper() for v in group),t.arb(0)).upper()
   q16=sum((abs(v).upper()**32 for v in vals),t.arb(0)).upper()
   good=bool(q1<1 or q16<1)
   rec={'model':j,'a':r['a'],'b':r['b'],'l1_upper':t.rat(q1),'T16_upper':t.rat(q16),'passes':good}
   out.append(rec)
   if not good:failures.append(rec)
  if (j+1)%200==0:print(json.dumps({'models':j+1,'panels':len(out),'failures':len(failures),'seconds':time.perf_counter()-start}),flush=True)
  assert time.perf_counter()-start<240,'bounded independent replay deadline'
 result={'status':'INDEPENDENT_COMPLETE_C5_COVER_PASS' if complete and not failures else 'INDEPENDENT_REPLAY_WITH_LIMITATIONS',
  'author_receipt_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),'author_complete':complete,
  'exact_length':str(length),'max_author_tau':str(tau),'models':len(d['models']),'panels':len(out),
  'parameters':{'N':t.N,'M':t.M,'D':t.D,'R':str(t.R),'bits':224},'failures':failures,
  'bounds':out,'elapsed_seconds':time.perf_counter()-start}
 Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
 print(json.dumps({k:v for k,v in result.items() if k not in ('bounds','failures')},indent=2))
if __name__=='__main__':main()
