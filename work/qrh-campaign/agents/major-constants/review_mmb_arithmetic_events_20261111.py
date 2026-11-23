"""Independent source/encoding metadata review. Emits no MMB or proof instance."""
from pathlib import Path
import re,json,hashlib
ROOT=Path(__file__).resolve().parents[4]
A=ROOT/'work/qrh-campaign/agents/moebius'
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
own_pins={'MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md':'E57FCF240BB386E783A653AD28162AFFCA2D4C5273BD1915C6C4E930ACF9CCB6',
'mmb_arithmetic_event_expansion_20261111.py':'2BDBDD0E6FE9778F30C665AA93E62AF43C3CFDFFA9BBDE850996C5F5DCB5048E',
'mmb_arithmetic_event_expansion_20261111.json':'022682B141671DC2C2F5FEC6F58715BE076735B45DE8CF8BB047E5FCA32146F8'}
for f,h in own_pins.items():ck(hashlib.sha256((A/f).read_bytes()).hexdigest().upper()==h)
note=(A/'MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md').read_text()
pins=dict(re.findall(r'^\|(work/[^|]+)\|([A-F0-9]{64})\|$',note,re.M));ck(len(pins)==13)
saved=json.loads((A/'mmb_arithmetic_event_expansion_20261111.json').read_text());ck(pins==saved['pins'])
texts={}
for f,h in pins.items():
 raw=(ROOT/f).read_bytes();ck(hashlib.sha256(raw).hexdigest().upper()==h);texts[f]=raw.decode()
hs=texts['work/mm0-efficient/toolchain-sources/examples__peano_hex.mm1']
ops={'=':(0,'eq'),'+':(1,'add'),'*':(2,'mul'),':x':(3,'hex')}
def parse(s):
 tok=re.findall(r':x|[a-g]|[=+*]',s);p=0
 def expr(level=0):
  nonlocal p
  left=tok[p];p+=1
  while p<len(tok) and tok[p] in ops and ops[tok[p]][0]>=level:
   op=tok[p];p+=1;right=expr(ops[op][0]+1);left=(ops[op][1],left,right)
  return left
 t=expr();ck(p==len(tok));return t
def leaves(t):return {t} if isinstance(t,str) else set().union(*(leaves(x) for x in t[1:]))
def hexvars(t):
 if isinstance(t,str):return set()
 z=leaves(t[2]) if t[0]=='hex' else set()
 return z|set().union(*(hexvars(x) for x in t[1:]))
def coerced(t,hexes,want='nat'):
 if isinstance(t,str):return ('h2n',t) if t in hexes and want=='nat' else t
 return (t[0],coerced(t[1],hexes),coerced(t[2],hexes,'hex' if t[0]=='hex' else 'nat'))
def nodes(t):return 1 if isinstance(t,str) else 1+sum(nodes(x) for x in t[1:])
headers={}
for name,expected in [('add_xx0',([11,5,8],6,2,27,14,48)),('mul_x2x',([9,5,8,5],7,3,31,16,54))]:
 decl=next(line for line in hs.splitlines() if line.startswith('theorem '+name+' '))
 forms=re.findall(r'\$([^$]+)\$',decl);trees=list(map(parse,forms));hv=set().union(*(hexvars(t) for t in trees))
 ct=[coerced(t,hv) for t in trees];sizes=[nodes(ct[-1])]+[nodes(t) for t in ct[:-1]]
 a=len(set().union(*(leaves(t) for t in trees)));h=len(forms)-1
 commands=a+h+6;unify=sum(sizes)+h+1;upper_bytes=3*(a+h+3)+5*3
 ck((sizes,a,h,unify,commands,upper_bytes)==expected)
 old=saved['source_lemma_models'][name]
 ck(a==old['expression_args'] and h==old['hypotheses'])
 ck(unify==old['unshared_unify_commands_including_end'])
 headers[name]=dict(source_line=hs.splitlines().index(decl)+1,hex_variables=sorted(hv),expression_sizes=sizes,arguments=a,premises=h,unify_commands=unify,fresh_commands=commands,cached_commands=a+h+2,fresh_byte_upper=upper_bytes)
v=texts['work/formal-goldbach-bench/mm0/src/verifier.c']
for s in ['get_uheap(data) == pop_ustack()','sizeof(store_term) + 4 * t->num_args','g_uheap_size = t->num_args;','run_unify(UThm, (u8*)&targs[t->num_args], e);','push_ustack(as_type(pop_stack(), STACK_TYPE_PROOF));','run_unify(UThmEnd, (u8*)&args[t->num_args], val);','g_store_size = 0;','g_heap_size = 0;']:
 ck(s in v)
vt=texts['work/formal-goldbach-bench/mm0/src/verifier_types.c']
for s in ['#define HEAP_SIZE 65536','#define STORE_SIZE (1 << 26)','u32 args[];']:ck(s in vt)
hx=texts['work/mm0-efficient/toolchain-sources/examples__peano_hex.mm0']
for s in ['axiom h2nlt','axiom h2n0','axiom c2nch']:ck(s in hx)
ck('@eval-check axiom h2n0' in hs)
pa=texts['work/mm0-efficient/toolchain-sources/examples__peano.mm1']
for s in ['theorem eqdivmod (h1: $ G -> R < b $) (h2: $ G -> b * Q + R = a $):','theorem powadd:','theorem powmul:']:ck(s in pa)
def size(d):return 1+next(w for w in (0,1,2,4) if d<2**(8*w))
ck([size(d) for d in (0,1,255,256,65535,65536,2**32-1)]==[1,2,2,3,3,5,5])
dag_cases=0
for V in range(1,13):
 for H in range(V-1,V+5):
  for R in (V,3*V,8*V):
   for T,C in [(0,0),(2,4),(19,38)]:
    if R+C<T:continue
    proofrefs=H-V+1;exprrefs=R+C-T
    ck(V+proofrefs+T+exprrefs+1==H+R+C+2);dag_cases+=1
    ck(5*(V+T)+3*(proofrefs+exprrefs)+1>=V+proofrefs+T+exprrefs+1)
def M(m,n):return 5*m*n+2*n+1
def add(bits):return 2*((bits+7)//8)+1
rectangle=[13*3,3*13*3,13*3,2*3,1];ck(sum(rectangle)==M(13,3)==202)
round_counts=[M(13,3),M(13,3),add(122),add(123),add(22),add(113)]
ck(round_counts==[202,202,33,33,7,31]);ck(sum(round_counts)==508)
data=json.loads(texts['work/qrh-campaign/agents/moebius/signed_horner_schedule_costs_20261111.json'])
row=next(x for x in data['results']['first_four']['uniform100']['uncancelled']['rows'] if x['stage']==0)
ck(row['magnitude_bit_caps']==dict(residual_add=122,range_add=123,guard_add=22,coefficient_add=113));ck(row['product_events']==808)
# Symbolic product/adder call identities, no arithmetic-proof signatures assumed.
for d in [0,1,39,156]:
 for aL,hL,a1,h1,a2,h2,aB,hB in [(0,4,1,1,1,1,0,0),(7,5,6,2,8,3,1,1)]:
  V=39+6+1+d;H=39*hL+3*(h1+h2)+hB;R=39*(aL+1)+3*(a1+a2+2)+aB+1+d
  ck(H+R+2==48+d+39*(aL+hL)+3*(a1+h1)+3*(a2+h2)+aB+hB)
out=dict(status='PASS_BOUNDED_STATIC_SOURCE_REVIEW',checks=checks,author_pins=own_pins,source_pins=pins,source_parsed_headers=headers,dag_algebra_cases=dag_cases,rectangle_events=rectangle,real_round_events=round_counts,scope='No MMB output, proofs, compilation, ABI measurement, arithmetic instances, runtime estimate or backend validation')
path=Path(__file__).with_suffix('.json')
with path.open('x') as f:json.dump(out,f,indent=2)
print(json.dumps(dict(checks=checks,dag_cases=dag_cases,headers=headers,sha256=hashlib.sha256(path.read_bytes()).hexdigest().upper())))
