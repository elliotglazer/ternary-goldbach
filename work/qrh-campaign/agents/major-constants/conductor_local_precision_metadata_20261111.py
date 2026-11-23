"""Approved saved-row precision/cache pass. No planner, factor or value production."""
from pathlib import Path
from collections import Counter
from math import prod
import hashlib
import json

HERE=Path(__file__).resolve().parent
AG=HERE.parent
LIMIT_BYTES=64*1024*1024
LIMIT_RECORDS=1000000
LIMIT_STATES=334053
PINS={
 'integration/transform_structural_manifest_20261111.json':
  (25110201,'A41D70DB2BB439D73CC817F80B24CB598D3EFA89CCE1D19A5FA618ABBE239637'),
 'zero-sum/mixed_radix_precision_metadata_20261111.json':
  (1911933,'8BAE81D30CA893F7728E9B13249A96A56D22A9EB87612E9D6B0FCD453140EE8E'),
}
CHECKS=0
def ck(ok):
 global CHECKS
 assert ok
 CHECKS+=1
def read(rel):
 raw=(AG/rel).read_bytes();size,pin=PINS[rel]
 ck(len(raw)==size and size<LIMIT_BYTES)
 ck(hashlib.sha256(raw).hexdigest().upper()==pin)
 return json.loads(raw)
def canonical(obj):return json.dumps(obj,sort_keys=True,separators=(',',':')).encode()
def write(name,obj):
 raw=json.dumps(obj,separators=(',',':')).encode()+b'\n'
 ck(len(raw)<LIMIT_BYTES)
 path=HERE/name
 with path.open('xb') as f:f.write(raw)
 return dict(path=name,bytes=len(raw),sha256=hashlib.sha256(raw).hexdigest().upper())

m=read(next(iter(PINS)))
e=read('zero-sum/mixed_radix_precision_metadata_20261111.json')
ck(m['schema']=='selected-transform-structural-manifest-1')
ck(m['conductor_fields']==['c','phi','primitive','H','J','ordered_axes_n_q','scenario_major_band_minor_height_nodes'])
ck(m['request_fields']==['n','q','kind','children_n_q_multiplicity_normfactor','local_five_counts','five_counts'])
ck(len(m['conductors'])==125400 and len(m['requests'])==35190)
ck(m['extras']==[0,167,320,640] and m['band_last_indices']==[6400,12800,25600,64000,128000])
ck(len(m['plan'])==37117)
ck(e['status']=='PASS_INTEGER_ERROR_COEFFICIENT_COMPARISON')
ck(len(e['axis_rows'])==13943)
ck(e['plan_sha256']==m['canonical_plan_sha256'])
ck(hashlib.sha256(canonical(m['plan'])).hexdigest()==e['plan_sha256'])
ck(e['max_old_sum_C']==424706204 and e['max_new_sum_C']==202305920)
ck(e['max_old_D']==29961461170177)
ck(2**100>max(29961461170177,2*424706204))
axis={}
for a in e['axis_rows']:
 ck(set(a)=={'n','old_C','new_C','old_D','new_D'})
 ck(all(type(v) is int and v>=0 for v in a.values()))
 ck(a['n'] not in axis and str(a['n']) in m['plan'])
 ck(a['old_D']>=1 and a['new_D']>=1 and a['new_C']<=a['old_C'])
 axis[a['n']]=a
for ns,node in m['plan'].items():
 n=int(ns);ch=node['choice']
 ck(n>=2 and str(n)==ns)
 ck(ch[0] in ['radix2','direct_prime','bluestein','split'])
 if ch[0]=='split':
  ck(len(ch)==3 and ch[1]*ch[2]==n)
  ck(all(1<d<n and str(d) in m['plan'] for d in ch[1:]))
 else:ck(len(ch)==1)

contract={
 'id':'local-u-rounded-normalized-blue-v1',
 'p_domain':[100,108],
 'coordinate_grid':'2^-p; exact grid100 input embedding',
 'root_chirp_norm_error':'<=u=2^-p from exact coefficient specified by saved full-plan convention',
 'complex_gate_absolute_error':'<=u, exact common-grid additions allowed',
 'original_kernel_error':'<=P*A*u from specified exact chirp FFT; A=1+3*(2*log2(P)+4)',
 'scaled_kernel_error':'<= (A+1)*u from exact K/P; center is Round_u(Khat/P)',
 'rounding_policy':'coordinate nearest, lower-closed upper-open residual; fixed across object',
 'cached_sums':'two exact REAL sums of the actual new scaled complex center',
 'lifetime':'one cold construction retained for this complete pass; rebuilds not credited free',
 'cache_identity':'full plan/hash, n,P,chirp/sign convention,variant,p,rounding,contract,lifetime',
}
contract_hash=hashlib.sha256(canonical(contract)).hexdigest().upper()
rows=[];precision=Counter();phis=Counter();primitives=Counter();test_count=0
top=set();cs=set();all_axes=set();max_tests=0
constant=(1266*202305920)**2
for rid,row in enumerate(m['conductors']):
 ck(len(row)==7)
 c,phi,prim,H,J,axes,weights=row
 ck(type(c) is int and c not in cs and c>10000 and c<=265800)
 ck((c%2==1 and c<=132900) or c%4==0)
 cs.add(c)
 ck(axes and all(len(a)==2 and type(a[0]) is int and type(a[1]) is int for a in axes))
 ck(all(n in axis and 0<=q<=n and (q==0 or n%q==0) for n,q in axes))
 ck(phi==prod(n for n,q in axes))
 ck(prim==prod(n if q==0 else n-n//q for n,q in axes))
 ck(len(weights)==20 and all(type(w) is int and w>=0 for w in weights))
 # Preserve source row order and axis multiplicity, including repeated lengths.
 S=sum(axis[n]['new_C'] for n,q in axes)
 Sold=sum(axis[n]['old_C'] for n,q in axes)
 D=max([1]+[axis[n][k] for n,q in axes for k in ['old_D','new_D']])
 ck(S<=202305920 and Sold<=424706204 and D<=29961461170177)
 rhs=c*constant;local_tests=0;chosen=None
 for p in range(100,109):
  local_tests+=1;test_count+=1
  slack=rhs-(2*phi*S)**2*2**(2*(108-p))
  ds=2**p-D;ss=2**p-2*Sold
  if slack>=0 and ds>=0 and ss>=0:
   chosen=(p,slack,ds,ss);break
 ck(chosen is not None and local_tests<=9)
 p,slack,ds,ss=chosen
 ck(local_tests==p-99)
 if p>100:
  ck(rhs-(2*phi*S)**2*2**(2*(109-p))<0)
 max_tests=max(max_tests,local_tests)
 rows.append([rid,c,phi,prim,axes,S,Sold,D,p,slack,ds,ss])
 precision[p]+=1;phis[p]+=phi;primitives[p]+=prim
 for n,q in axes:top.add((n,p));all_axes.add(n)
ck(len(rows)==125400 and sum(precision.values())==125400)
ck(test_count<=9*125400 and max_tests<=9)
ck(len(all_axes)==m['unchanged_setup']['axis_lengths']==12496)

# Traverse only supplied full-plan choices. No request-output pruning of cache.
todo=list(top);states=set();edges=[]
while todo:
 n,p=todo.pop()
 if (n,p) in states:continue
 states.add((n,p));ck(len(states)<=LIMIT_STATES)
 ch=m['plan'][str(n)]['choice']
 children=[] if ch[0]!='split' else [[d,p] for d in ch[1:]]
 todo.extend(tuple(x) for x in children)
 edges.append([n,p,ch,children])
edges.sort(key=lambda r:(r[0],r[1]))
kernels=[];cache_dist=Counter();cache_entries=Counter();base_lengths=set();base_nodes=set()
for n,p in sorted(states):
 base_nodes.add(n)
 if m['plan'][str(n)]['choice'][0]=='bluestein':
  P=1<<(2*n-2).bit_length()
  ck(2*n-1<=P<4*n)
  kernels.append([n,p,P]);cache_dist[p]+=1;cache_entries[p]+=P;base_lengths.add(n)
base_entries=sum(1<<(2*n-2).bit_length() for n in base_lengths)
ck(len(base_nodes)==m['unchanged_setup']['active_nodes']==32942)
ck(len(base_lengths)==m['unchanged_setup']['kernel_count']==6004)
ck(base_entries==m['unchanged_setup']['kernel_entries']==337702368)
ck(len(kernels)<=9*6004 and sum(cache_entries.values())<=9*base_entries)
ck(len(rows)+len(edges)+len(kernels)<LIMIT_RECORDS)
ck(len({(n,p) for n,p,P in kernels})==len(kernels))
mult=Counter(Counter(n for n,p,P in kernels).values())
ck(sum(mult.values())==6004)
ck(sum(k*v for k,v in mult.items())==len(kernels))
source_binding={rel:{'bytes':size,'sha256':pin} for rel,(size,pin) in PINS.items()}
row_art=write('conductor_local_precision_rows_20261111.json',dict(
 schema='conductor-local-precision-rows-1',inputs=source_binding,contract_sha256=contract_hash,
 fields=['source_row_id','c','phi','primitive','ordered_axes_n_q','S_mixed','S_old','D_local','p','squared_budget_slack','D_slack','peak_slack'],
 rows=rows,source_weight_binding='unchanged saved row identity; weights not folded',guards_included=False,prices_included=False))
cache_art=write('conductor_local_precision_caches_20261111.json',dict(
 schema='conductor-local-precision-caches-1',inputs=source_binding,contract=contract,contract_sha256=contract_hash,
 plan_sha256=m['canonical_plan_sha256'],full_node_fields=['n','p','saved_choice','ordered_child_n_p'],
 full_nodes=edges,kernel_fields=['n','p','P'],kernels=kernels,
 root_chirp_scope='Complete saved full-plan sets only; no rational-angle deduplication or root values.',
 guards_included=False,prices_included=False))
dist=[dict(p=p,conductors=precision[p],phi_total=phis[p],primitive_total=primitives[p],kernel_keys=cache_dist[p],kernel_entries=cache_entries[p]) for p in range(100,109)]
out=dict(scope='Approved first saved-row pass only. No guards, prices, planner, factors, unit/root/value enumeration, builds, or proofs.',
 preflight_sha256='1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A',
 preflight_review_sha256='15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2',
 inputs=source_binding,contract_sha256=contract_hash,checks_before_receipt_write=CHECKS,
 precision_tests=test_count,max_tests_per_row=max_tests,conductors=len(rows),full_plan_precision_states=len(states),
 total_output_records=len(rows)+len(edges)+len(kernels),precision_distribution=dist,
 baseline_kernel_lengths=len(base_lengths),baseline_kernel_entries=base_entries,
 local_kernel_keys=len(kernels),local_kernel_entries=sum(cache_entries.values()),
 extra_kernel_keys=len(kernels)-len(base_lengths),extra_kernel_entries=sum(cache_entries.values())-base_entries,
 precision_multiplicity_histogram=dict(sorted(mult.items())),
 scaled_cache_complex_rounds=sum(cache_entries.values()),exact_real_cache_sums=2*sum(cache_entries.values()),
 artifacts=[row_art,cache_art],production_selected=False,runtime_claim=False)
receipt=write('conductor_local_precision_metadata_20261111.json',out)
print(json.dumps(dict(checks=CHECKS,receipt=receipt,distribution=dist,
                     cache_keys=len(kernels),cache_entries=sum(cache_entries.values()),states=len(states))))
