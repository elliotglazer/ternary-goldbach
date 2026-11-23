"""Static schemas and four radix size formulas; no digit/table enumeration."""
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[3]
pins={
 'work/qrh-campaign/agents/prime-estimates/NAMED_NATURAL_DIGIT_HEADER_DESIGN_2026-11-11.md':'99A9F90BB5C7D4EBB8C63A24CD7BFA8CDB5D13DCA54790EAADA658E3A24BF988',
 'work/qrh-campaign/agents/moebius/REVIEW_NAMED_NATURAL_DIGIT_HEADER_DESIGN_2026-11-11.md':'5B9F0652F6312613094A68E3E8E794A78F119073409C95E0077F9AEEDADAC216',
 'work/qrh-campaign/agents/independent-feasibility/PA_PRODUCT_NUMERAL_BINDING_DESIGN_2026-11-11.md':'67631F57A93B6AE32303A148377AA1D4227FC5E34A4D25F265EA2561C42D6A59',
 'work/qrh-campaign/agents/integration/REVIEW_PA_PRODUCT_NUMERAL_BINDING_DESIGN_2026-11-11.md':'D5F0EB33433CBD04C1326D90F1B1EE46A87A11D3C5F7AC7A42ABB95D3D92CDB0',
 'work/mm0-efficient/toolchain-sources/examples__peano.mm1':'13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079',
 'work/formal-goldbach-bench/mm0/src/verifier.c':'71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5',
 'work/formal-goldbach-bench/mm0/src/types.c':'B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1'}
checks=0
def ck(x):
 global checks
 assert x;checks+=1
for p,h in pins.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
def op(h,*x):return(h,*x)
def size(t):return 1 if isinstance(t,str) else 1+sum(size(x) for x in t[1:])
def edges(t):return 0 if isinstance(t,str) else len(t)-1+sum(edges(x) for x in t[1:])
def eq(a,b):return op('eq',a,b)
def add(a,b):return op('add',a,b)
def mul(a,b):return op('mul',a,b)
def signature(a,pre,con):
 h=len(pre)
 return dict(args=a,premises=h,header_commands=sum(size(x) for x in pre)+size(con)+h+1,
  cached_call=a+h+2,fresh_call=a+h+2+edges(con),HR=a+h+1,conclusion_child_requests=edges(con))
rows=[]
for w in (8,10,12,16):
 beta='one'
 for _ in range(w):beta=op('b0',beta)
 ck(size(beta)==w+1)
 con=eq('S',add(mul('B','U'),'e'))
 new=signature(5,[eq('S',add(mul(beta,'T'),'d')),eq('T','U'),eq('d','e')],con)
 old=signature(4,[eq('S',add(mul(beta,'T'),'d')),eq('T','U')],eq('S',add(mul(beta,'U'),'d')))
 ck(new['header_commands']==w+24 and new['cached_call']==10 and new['fresh_call']==16)
 ck(new['HR']-old['HR']==2)
 ck(new['conclusion_child_requests']<=old['conclusion_child_requests'])
 b=2**w;defs=b-1;nodes=defs*(w+1);canon=(w-1)*b+w+1
 ck(nodes-canon==2*b-2*w-2)
 z=signature(1,[eq('T','zero')],eq(op('b0','T'),'zero'))
 one=signature(1,[eq('T','zero')],eq(op('b1','T'),'one'))
 ck(z==one and z['header_commands']==9 and z['cached_call']==4 and z['fresh_call']==7)
 # Formal substitution of hypotheses proves mixed glue; no numeric bit values.
 subst={'S':add(mul('beta','T'),'d'),'B':'beta','U':'T','e':'d'}
 def sub(t):return subst.get(t,t) if isinstance(t,str) else (t[0],*(sub(x) for x in t[1:]))
 ck(sub(con)[1]==sub(con)[2])
 rows.append(dict(w=w,beta=b,new_definitions=defs,padded_body_nodes=nodes,canonical_body_nodes=canon,
  extra_body_nodes=nodes-canon,definition_commands_each_stream=nodes+defs,
  definition_bytes_old_heads_two=20*defs+4*nodes,definition_bytes_old_heads_five=20*defs+10*nodes,
  full_digit_bridge_facts=b,full_digit_bridge_header_commands=b*(w+4),
  full_digit_bridge_header_bytes_old2_alias3=b*(2*w+8)-2,bridge_entry_bytes=8*b,
  exception_proof_apps_each=w+1,exception_proof_HR_each=3*w+2,
  mixed_glue=new,old_glue=old,exception_step=z,
  general_source_decoder_application_upper_per_L=3*w+2,source_decoder_application_constant=8))
out=dict(scope='Symbolic source-binding successor only; no emitted PA declarations or concrete arithmetic.',
 pins=pins,checks=checks,rows=rows,
 unpriced=['ordinary fixed helper and table proof bodies','actual distinct digit patterns and local pointer sharing',
 'catalogue/source spelling and all range proof transport','header execution and term reconstruction per lifetime',
 'whole stock admission and analytic foundation'])
raw=(json.dumps(out,indent=2)+'\n').encode();assert len(raw)<32768
with (HERE/'padded_named_digit_binding_20261111.json').open('xb') as f:f.write(raw)
print(json.dumps(dict(checks=checks,bytes=len(raw),w12=rows[2])))
