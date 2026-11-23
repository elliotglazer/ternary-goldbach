"""Independent saved-plan reconstruction; no author imports, values or planning."""
from pathlib import Path
from collections import Counter
from functools import cache
from math import prod
import hashlib,json

HERE=Path(__file__).resolve().parent; AG=HERE.parent; AU=AG/'integration'
CHECKS=0
def ck(x):
 global CHECKS
 assert x
 CHECKS+=1
def digest(raw):return hashlib.sha256(raw).hexdigest().upper()
def canonical(x):return json.dumps(x,sort_keys=True,separators=(',',':')).encode()
INPUTS={
 'integration/transform_structural_manifest_20261111.json':(25110201,'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637'),
 'zero-sum/mixed_radix_precision_metadata_20261111.json':(1911933,'8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E'),
 'major-constants/conductor_local_precision_rows_20261111.json':(21933038,'B66C7532C242A27DA64A183E4A14E5624659BB7DC8029426A7FCCD6EC66224E7'),
 'major-constants/conductor_local_precision_caches_20261111.json':(1902325,'95A8551C038A0AFD8CC147C44FA0022FC89B148B5DA74A2026FBC4B900910584'),
 'major-constants/conductor_local_precision_metadata_20261111.json':(2686,'7A8A24F40924B696B818E4E6E1DE0F748C71F4E8B30B0EEF75FC9675C23F5978'),
 'integration/short_window_guard_ledger_20261111.json':(41665,'C04F477A1ACCDFFDAE76FEA972D09C270332BCB6766EDFF060C2678DAEF970A4'),
}
OUTPUTS={
 'integration/sharper_conductor_precision_rows_20261111.json':(20920838,'8FD72DC7FD9EACCCF986BE92502AE13491F974744C9E6A6E32BD63ADC27ED085'),
 'integration/sharper_conductor_precision_nodes_20261111.json':(1720100,'29A7C789AD3B5BC34D2177567FECEFB1FBBE7CFF432943150FCF18B868E7C9D6'),
 'integration/sharper_conductor_precision_caches_20261111.json':(1871369,'129ADFCF668378CA94140DB27F3A3D6EF43995E05EB1413D3BE8AC603061D831'),
 'integration/sharper_conductor_precision_metadata_20261111.json':(5188,'8CEA147C264CC963CAE2EBAFE58F32E4CCD53A99378D7403161510993862227F'),
}
PAPERS={
 'integration/SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_PREFLIGHT_2026-11-11.md':'2FDA2DDB0D8B0519377D026D1C88B70FD815BECD1C5C9A6E2EA826A75B335610',
 'major-constants/REVIEW_SHARPER_CONDUCTOR_PRECISION_SAVED_PASS_PREFLIGHT_2026-11-11.md':'2D21AF2BE4ADE3F8C58F066F1332C66C8A31D933BC5CD838F8D08C51ECE1E171',
 'audit/SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md':'08A06A83C73DBE295DD389F96D316F52C4DEFE7EE1B2243D2B04635B38AC786F',
 'prime-estimates/REVIEW_SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md':'3ADEA1B5860DA35E5BBF6DF26CEC3A005300096E60CA23BFE52EA3C084C9E9A3',
 'integration/sharper_conductor_precision_metadata_20261111.py':'6F41270DAF009B151432DD7619B69C46737598C8B3C8194D80FA719AE52864AE',
}
ck(len(OUTPUTS)==4 and len(PAPERS)>=3)
def read(rel,pin):
 raw=(AG/rel).read_bytes();size,h=pin
 ck(len(raw)==size and digest(raw)==h)
 return json.loads(raw)
for rel,h in PAPERS.items():ck(digest((AG/rel).read_bytes())==h)
base={rel:read(rel,pin) for rel,pin in INPUTS.items()}
saved={rel.split('/')[-1]:read(rel,pin) for rel,pin in OUTPUTS.items()}
m=base['integration/transform_structural_manifest_20261111.json']
e=base['zero-sum/mixed_radix_precision_metadata_20261111.json']
oldrows=base['major-constants/conductor_local_precision_rows_20261111.json']
oldcache=base['major-constants/conductor_local_precision_caches_20261111.json']
oldsum=base['major-constants/conductor_local_precision_metadata_20261111.json']
nr=saved['sharper_conductor_precision_rows_20261111.json']
nn=saved['sharper_conductor_precision_nodes_20261111.json']
nc=saved['sharper_conductor_precision_caches_20261111.json']
ns=saved['sharper_conductor_precision_metadata_20261111.json']
ck(m['schema']=='selected-transform-structural-manifest-1')
ck(len(m['conductors'])==125400 and len(m['plan'])==37117 and len(e['axis_rows'])==13943)
plan={int(n):v['choice'] for n,v in m['plan'].items()}
ck(digest(canonical(m['plan'])).lower()==m['canonical_plan_sha256']==e['plan_sha256'])
axis={a['n']:a for a in e['axis_rows']};ck(len(axis)==13943)

def radial(n):
 k=n.bit_length()-1
 ck(n==1<<k)
 return (0,1) if n==1 else (2*k+4,max(1,2*k))
def fullblue(n):
 # Use next power >=2n, equivalent for n>=2 to next power >=2n-1.
 P=1<<(2*n-1).bit_length(); k=P.bit_length()-1
 ck(n>=2 and P>=2*n and P<4*n)
 R=2*k+4; A=3*R+1
 legacy=2*(3*P*A+R*(2*n+1)+4)
 D=max(1,2*k,P*A,3*n*P*A+1)
 # Sharpen via the proved gap, not the author's expanded new formula.
 gap=R*(9*(P//2)+n-10)-6
 ck(gap>=74)
 return legacy,D,legacy-gap,D

@cache
def pair(n):
 ch=plan[n];kind=ch[0]
 if kind=='radix2':
  C,D=radial(n);z=(C,D,C,D)
 elif kind=='direct_prime':
  ck(n in (3,5,7,11));z=(2,1,2,1)
 elif kind=='bluestein':z=fullblue(n)
 else:
  ck(kind=='split' and len(ch)==3)
  r,b=ch[1:];ck(r*b==n and 1<r<n and 1<b<n)
  # Recursive depth follows only smaller saved children.
  cm,dm,sm,tm=pair(b);cr,dr,sr,tr=pair(r)
  z=(cm+cr+2,max(dm,dr,1,(2*cm+1)*cr+cm),
     sm+sr+2,max(tm,tr,1,(2*sm+1)*sr+sm))
 ck(z[2]<=z[0] and z[3]<=z[1])
 return z

node_rows=[]
for n in sorted(plan,reverse=True):pair(n)
ck(pair.cache_info().currsize==37117)
for n in sorted(plan):node_rows.append([n,*pair(n)])
ck(nn['rows']==node_rows)
for n,a in axis.items():
 ck(pair(n)[:2]==(a['new_C'],a['new_D']))
 b=radial(n) if n&(n-1)==0 else fullblue(n)[:2]
 ck(b==(a['old_C'],a['old_D']))

constant=(1266*202305920)**2
def precision(c,phi,S,D,Sb):
 rhs=c*constant;den=(2*phi*S)**2
 if den==0:p=100
 else:
  q=rhs//den;ck(q>=1)
  allowed_drop=(q.bit_length()-1)//2
  p=max(100,108-allowed_drop)
 ck(100<=p<=108 and 2**p>=D and 2**p>=2*Sb)
 slack=rhs-den*2**(2*(108-p))
 ck(slack>=0)
 previous=None if p==100 else rhs-den*2**(2*(109-p))
 ck(previous is None or previous<0)
 return p,slack,2**p-D,2**p-2*Sb,previous

expected_rows=[]; oldtop=set(); newtop=set(); transitions=Counter(); drops=Counter()
newdist=Counter(); olddist=Counter(); phis=Counter(); prims=Counter(); oldphis=Counter(); oldprims=Counter()
oldtests=0;newtests=0;axisids=set()
for i,row in enumerate(m['conductors']):
 c,phi,prim,H,J,axes,weights=row
 ck(phi==prod(n for n,q in axes) and prim==prod(n if q==0 else n-n//q for n,q in axes))
 Sm=sum(pair(n)[0] for n,q in axes);Ss=sum(pair(n)[2] for n,q in axes)
 Sb=sum(axis[n]['old_C'] for n,q in axes)
 D=max([1]+[axis[n][a] for n,q in axes for a in ('old_D','new_D')])
 po,so,do,go,prev_o=precision(c,phi,Sm,D,Sb)
 pn,sn,dn,gn,prev_n=precision(c,phi,Ss,D,Sb)
 ck(oldrows['rows'][i]==[i,c,phi,prim,axes,Sm,Sb,D,po,so,do,go])
 ck(Ss<=Sm and pn<=po)
 expected_rows.append([i,c,phi,prim,Sm,Ss,Sb,D,po,pn,sn,dn,gn,prev_n])
 oldtests+=1+(po>100);newtests+=pn-99
 transitions[po,pn]+=1;drops[po-pn]+=1;newdist[pn]+=1;olddist[po]+=1
 phis[pn]+=phi;prims[pn]+=prim;oldphis[po]+=phi;oldprims[po]+=prim
 for n,q in axes:oldtop.add((n,po));newtop.add((n,pn));axisids.add(n)
ck(nr['rows']==expected_rows)
ck(len(axisids)==12496 and oldtests<=250800 and newtests<=1128600)

def close(seeds):
 todo=list(seeds);seen=set()
 while todo:
  n,p=todo.pop()
  if (n,p) in seen:continue
  seen.add((n,p));ck(len(seen)<=334053)
  if plan[n][0]=='split':todo.extend((d,p) for d in plan[n][1:])
 full=[];ker=[]
 for n,p in sorted(seen):
  ch=plan[n]
  children=[[d,p] for d in ch[1:]] if ch[0]=='split' else []
  full.append([n,p,ch,children])
  if ch[0]=='bluestein':ker.append([n,p,1<<(2*n-1).bit_length()])
 ck(len({n for n,p in seen})==32942 and len(ker)<=54036)
 lens={n for n,p,P in ker}
 ck(len(lens)==6004 and sum(1<<(2*n-1).bit_length() for n in lens)==337702368)
 return full,ker,seen,{tuple(x) for x in ker}
of,ok,os,oks=close(oldtop);nf,nk,nst,nks=close(newtop)
ck(of==oldcache['full_nodes'] and ok==oldcache['kernels'])
ck(nf==nc['full_nodes'] and nk==nc['kernels'])
ck(oldcache['contract']==nc['contract'])
contract_hash=digest(canonical(oldcache['contract']))
ck(contract_hash=='22FFC752C26CC2E6225E57899F67B9973348DB34957745580EFD4BD84AC7A884')

def dist_table(ks,counts,ps,rs):
 return [dict(p=p,conductors=counts[p],phi_total=ps[p],primitive_total=rs[p],
              kernel_keys=sum(q==p for n,q,P in ks),kernel_entries=sum(P for n,q,P in ks if q==p)) for p in range(100,109)]
distribution=dist_table(nk,newdist,phis,prims)
ck(oldsum['precision_distribution']==dist_table(ok,olddist,oldphis,oldprims))
ck(ns['precision_distribution']==distribution)
ck(ns['transition_rows']==[[p,q,v] for (p,q),v in sorted(transitions.items())])
ck(ns['bit_drop_distribution']=={str(k):v for k,v in sorted(drops.items())})
totals=dict(legacy_selector_tests=oldtests,sharp_selector_tests=newtests,conductors=125400,
 full_coefficient_nodes=37117,axis_records=13943,changed_conductors=125400-drops[0],
 sharp_full_plan_precision_states=len(nf),sharp_kernel_keys=len(nk),sharp_kernel_entries=sum(P for n,p,P in nk),
 scaled_cache_complex_rounds=sum(P for n,p,P in nk),exact_real_cache_sums=2*sum(P for n,p,P in nk),
 state_intersection_with_legacy=len(nst&os),state_only_sharp=len(nst-os),state_only_legacy=len(os-nst),
 kernel_intersection_with_legacy=len(nks&oks),kernel_only_sharp=len(nks-oks),kernel_only_legacy=len(oks-nks),
 output_records=37117+125400+len(nf)+len(nk))
for k,v in totals.items():ck(ns[k]==v)
for k in ['state_intersection_with_legacy','state_only_sharp','state_only_legacy','kernel_intersection_with_legacy','kernel_only_sharp','kernel_only_legacy']:
 ck(nc[k]==totals[k])
for obj in [nr,nn,nc,ns]:
 ck(obj['contract_sha256']==contract_hash)
 ck(obj['guard_domain_applicable'] and not obj['guard_weights_folded'] and not obj['prices_included'] and not obj['production_selected'])
 ck(obj['inputs']=={r:{'bytes':s,'sha256':h} for r,(s,h) in INPUTS.items()})
 ck(obj['plan_sha256']==m['canonical_plan_sha256'])
ck(nc['sharp_assignment_sha256']==OUTPUTS['integration/sharper_conductor_precision_rows_20261111.json'][1])
ck(nc['legacy_assignment_sha256']==INPUTS['major-constants/conductor_local_precision_rows_20261111.json'][1])
ck(totals['output_records']<=550606<1000000)
out=dict(scope='Independent frozen saved-result reconstruction only. No author imports, planning, values, guard weights or prices.',
 checks=CHECKS,inputs=INPUTS,author_outputs=OUTPUTS,papers=PAPERS,totals=totals,
 distribution=distribution,transition_rows=[[p,q,v] for (p,q),v in sorted(transitions.items())],
 methods=['recursive saved-plan pairs; sharp coefficient from positive gap',
          'quotient bit-length selector; chosen and predecessor exact slack',
          'seeded full-node precision closure, not precision masks'])
dest=HERE/'review_sharper_conductor_precision_saved_pass_20261111.json'
raw=json.dumps(out,indent=2).encode()+b'\n';ck(len(raw)<1024**2)
with dest.open('xb') as f:f.write(raw)
print(json.dumps(dict(checks=CHECKS,sha256=digest(raw),totals=totals,distribution=distribution)))
