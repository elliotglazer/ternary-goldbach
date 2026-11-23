"""One P node, recomputed with outward rational interval arithmetic only.

No floating-point/special-function library is imported. Analytic tail and
modular identities are justified in the companion paper proof, not by Python.
"""
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
from collections import Counter
import hashlib, importlib.util, json, sys

sys.dont_write_bytecode=True
HERE=Path(__file__).resolve().parent; AGENTS=HERE.parent
BITS=320; SCALE=1<<BITS
OPS=Counter(); EVENTS=[]
PINS={
 'integration/lossless_modular_word_20261111.py':'9B6B49FF7EBC546BD4D340F89A954519B420047F0858D8DFF1001E4F708E4720',
 'integration/lossless_modular_word_20261111.json':'E60FCABF3A3A71F7FBDD39CDD58A00495973B0A3B2D2245F91A317F46D6C6910',
 'prime-estimates/r1over8_seed_rational_20261111.py':'099E38BEAF5C184234FA35D30C896C996FC166CBE5E0002B532692D4F298C173',
 'prime-estimates/r1over8_seed_rational_20261111.json':'E4EFD292003D1216EDA8E4BD9BFF7921050874F9378222C34A5A71EC39974E89',
}

def module(name,path):
 s=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def floorq(x):return x.numerator//x.denominator
def ceilq(x):return -((-x.numerator)//x.denominator)
def rnd(lo,hi):
 assert lo<=hi
 OPS['outward_roundings']+=1
 a,b=Q(floorq(lo*SCALE),SCALE),Q(ceilq(hi*SCALE),SCALE)
 assert a<=lo<=hi<=b
 return a,b
def pt(x):x=Q(x);return x,x
def add(a,b):OPS['real_add']+=1;return rnd(a[0]+b[0],a[1]+b[1])
def neg(a):return -a[1],-a[0]
def sub(a,b):return add(a,neg(b))
def mul(a,b):
 OPS['real_multiply']+=1;v=[x*y for x in a for y in b];return rnd(min(v),max(v))
def div(a,b):
 OPS['real_divide']+=1;assert not b[0]<=0<=b[1]
 v=[x/y for x in a for y in b];return rnd(min(v),max(v))
def scale(a,q):return mul(a,pt(q))
def widen(a,e):return rnd(a[0]-e,a[1]+e)
def cadd(a,b):return add(a[0],b[0]),add(a[1],b[1])
def cneg(a):return neg(a[0]),neg(a[1])
def csub(a,b):return cadd(a,cneg(b))
def cmul(a,b):return sub(mul(a[0],b[0]),mul(a[1],b[1])),add(mul(a[0],b[1]),mul(a[1],b[0]))
def cscale(a,q):return scale(a[0],q),scale(a[1],q)
def cinv(a):
 # General square range, not the possibly negative lower bound of a*a.
 def sq(x):return rnd(Q(0) if x[0]<=0<=x[1] else min(x[0]**2,x[1]**2),max(x[0]**2,x[1]**2))
 d=add(sq(a[0]),sq(a[1]));assert d[0]>0
 return div(a[0],d),neg(div(a[1],d))
def wire(a):return [str(q.numerator)+'/'+str(q.denominator) for q in a]
def cw(a):return {'re':wire(a[0]),'im':wire(a[1])}
def norm_upper(a):return sum(max(abs(x),abs(y)) for x,y in a)
ZERO=pt(0);ONE=pt(1);CI=(ZERO,ONE)

def atan_bounds(x):
 assert 0<x<1
 N=128
 lo=sum((-1)**k*x**(2*k+1)/(2*k+1) for k in range(N))
 hi=lo+x**(2*N+1)/(2*N+1)
 assert lo<hi
 return lo,hi

def make_pi():
 a,b=atan_bounds(Q(1,5)),atan_bounds(Q(1,239))
 p=rnd(16*a[0]-4*b[1],16*a[1]-4*b[0])
 assert 3<p[0]<p[1]<4
 EVENTS.append({'kind':'Machin_pi','terms':128,'atan_1_5':wire(a),'atan_1_239':wire(b),'output':wire(p)})
 return p

def exp_positive_point(x):
 assert x>=0
 k=0;t=x
 while t>Q(1,2):t/=2;k+=1
 assert k<=16
 N=96
 term=ONE;s=ONE
 for j in range(1,N):
  term=mul(term,pt(t/j));s=add(s,term)
 # Uniform reduced-domain tail avoids serializing a power of a long rational.
 tail=Q(1,2**N)*Q(N+1,N*factorial(N))
 s=rnd(s[0],s[1]+tail)
 assert s[0]>0
 for _ in range(k):s=mul(s,s)
 EVENTS.append({'kind':'exp_positive','input':str(x),'reduced':str(t),'squarings':k,'terms':N,'tail':str(tail),'output':wire(s)})
 return s

def exp_point(x):
 return exp_positive_point(x) if x>=0 else div(ONE,exp_positive_point(-x))
def exp_interval(a):
 low=exp_point(a[0]);high=exp_point(a[1]);return low[0],high[1]

def cis(a,p):
 # Proposal uses a rational pi midpoint. The full interval reduction is checked.
 amid=(a[0]+a[1])/2;pmid=(p[0]+p[1])/2
 k=floorq(amid/(2*pmid)+Q(1,2))
 y=sub(a,scale(p,2*k));assert -4<=y[0]<=y[1]<=4
 N=160;K=N//2;assert Q(4,N+1)<=Q(1,2)
 yy=mul(y,y);tc=ONE;ts=y;co=tc;si=ts
 for j in range(1,K):
  tc=scale(mul(tc,yy),Q(-1,(2*j-1)*(2*j)))
  ts=scale(mul(ts,yy),Q(-1,(2*j)*(2*j+1)))
  co=add(co,tc);si=add(si,ts)
 tail=Q(2*4**N,factorial(N))
 result=(widen(co,tail),widen(si,tail))
 EVENTS.append({'kind':'cis','input':wire(a),'turns':k,'reduced':wire(y),'exp_taylor_terms':N,'tail':str(tail),'output':cw(result)})
 return result

def cexp(a,p):
 e=exp_interval(a[0]);u=cis(a[1],p);return mul(e,u[0]),mul(e,u[1])

def run():
 OPS.clear();EVENTS.clear()
 for path,pin in PINS.items():assert hashlib.sha256((AGENTS/path).read_bytes()).hexdigest().upper()==pin,path
 wmod=module('node_word',HERE/'lossless_modular_word_20261111.py')
 smod=module('node_seed',AGENTS/'prime-estimates/r1over8_seed_rational_20261111.py')
 wd=json.loads((HERE/'lossless_modular_word_20261111.json').read_text())
 sd=json.loads((AGENTS/'prime-estimates/r1over8_seed_rational_20261111.json').read_text())
 assert wmod.verify(wd['packet'])==wd['verification'] and wd['verification']['whole_word_composes_conditional_on_seed']
 assert smod.verify(sd['certificate'])==sd['verification']
 nodes={n['id']:n for n in wd['packet']['nodes']}
 def read_d(d):return Q(int(d['mantissa']))*Q(2)**d['exponent']
 def box(k):return tuple((read_d(nodes[k]['value'][part]['lo']),read_d(nodes[k]['value'][part]['hi'])) for part in ('re','im'))
 p=make_pi();v=box('s5.t');tau=box('tau')
 assert v[1][0]>=9
 g=[(ZERO,ZERO) for _ in range(3)];terms=[]
 for n in range(4):
  a=Q(2*n+1,2);z=(ZERO,scale(p,a*a))
  e=cscale(cexp(cmul(z,v),p),2)
  row=[e,cmul(e,z),cmul(cmul(e,z),z)]
  g=[cadd(x,y) for x,y in zip(g,row)]
  terms.append({'half_integer':str(a),'jet':list(map(cw,row))})
 # Whole omitted half-integer tail, uniform for Y>=9, j=0,1,2:
 # <=128 exp(-2*9*(9/2)^2)<=128 exp(-364)<=2^-357.
 assert 2*9*Q(9,2)**2>=364
 tail=Q(1,2**357)
 g=[(widen(x[0],tail),widen(x[1],tail)) for x in g]
 terminal=list(map(cw,g))
 # Final T(6) acts on theta2 by exp(6*pi*i/4)=-i.
 minus_i=(ZERO,pt(-1));g=[cmul(minus_i,x) for x in g]
 transports=[];tail_amplification=Q(1)
 for i in reversed(range(5)):
  t,A=box(f's{i}.t'),box(f's{i}.A');B=cinv(t)
  B2=cmul(B,B);B3=cmul(B2,B);B4=cmul(B2,B2)
  g0,g1,g2=g
  f0=cmul(A,g0)
  f1=cmul(A,cadd(cscale(cmul(g0,B),Q(-1,2)),cmul(g1,B2)))
  f2=cmul(A,cadd(cadd(cscale(cmul(g0,B2),Q(3,4)),cscale(cmul(g1,B3),-3)),cmul(g2,B4)))
  g=[f0,f1,f2]
  # Before T(4) and T(-12), theta2 contributes -1; other T steps only swap.
  phase=-1 if i in (1,3) else 1
  if phase==-1:g=[cneg(x) for x in g]
  E=norm_upper(B);Ab=norm_upper(A)
  rows=(Ab,Ab*(E/2+E**2),Ab*(3*E**2/4+3*E**3+E**4))
  H=max(rows);tail_amplification*=H
  transports.append({'stage':i,'T_integer':wd['packet']['shifts'][i],
                     'selected_T_multiplier':phase,'inverse_t':cw(B),'jet':list(map(cw,g)),
                     'E_upper':str(E),'A_norm_upper':str(Ab),'jet_error_row_bounds':list(map(str,rows)),
                     'jet_error_operator_bound':str(H)})
 bhalf=sub(scale(p,Q(1,8)),pt(Q(1,2000002)))
 u=cis(bhalf,p);er=exp_interval(pt(Q(1,16)))
 pref=(mul(er,u[0]),mul(er,u[1]))
 P=cmul(pref,cadd(cscale(cmul(tau,g[1]),6),cscale(cmul(cmul(tau,tau),g[2]),4)))
 tau_norm=norm_upper(tau);pref_norm=norm_upper(pref)
 tail_amplification*=pref_norm*(6*tau_norm+4*tau_norm**2)
 tail_error=tail*tail_amplification
 assert tail_error<Q(1,2**200)
 # Dyadic output center; exact l1 radius bounds Euclidean error.
 center=tuple(Q(floorq((q[0]+q[1])/2*(1<<192)),1<<192) for q in P)
 radius=sum(max(abs(q[0]-c),abs(q[1]-c)) for q,c in zip(P,center))
 assert 0<radius<Q(1,2**128)
 separated=any(q[0]>0 or q[1]<0 for q in P);assert separated
 assert P[0][0]>10**12 and P[1][1]<-2*10**12
 result={'status':'PASS one nonzero P-node enclosure, exact external arithmetic with paper analytic lemmas',
         'pins':PINS,'precision_bits':BITS,'pi':wire(p),'terminal_point':cw(v),
         'finite_theta2_terms':terms,'theta2_tail_each_derivative':str(tail),
         'terminal_jet':terminal,'transports':transports,'prefactor':cw(pref),
         'tail_only_total_amplification':str(tail_amplification),
         'tail_only_final_error_bound':str(tail_error),'tail_only_error_lt_2pow_minus200':True,
         'selected_theta_path':['theta3','T(-1):theta4','S:theta2','T(4):-theta2','S:theta4',
                                'T(2):theta4','S:theta2','T(-12):-theta2','S:theta4',
                                'T(-2):theta4','S:theta2','T(6):-i*theta2'],
         'P_box':cw(P),'center':[str(c) for c in center],'exact_l1_error_bound':str(radius),
         'claimed_absolute_radius':str(Q(1,2**128)),'P_box_excludes_zero':separated,
         'coarse_separation':{'real_strictly_above':10**12,'imag_strictly_below':-2*10**12},
         'elementary_events':list(EVENTS),'operation_counts':dict(OPS),
         'scope':'Only T1e6,r1/8; no Lean, no grid, no spectral assertion; no numerical transcendental oracle'}
 return result

def corruption_controls(r):
 import copy
 fields=[('false_center','center',['0','0']),('missing_tail','theta2_tail_each_derivative','0'),
         ('false_precision','precision_bits',128),('false_nonzero','P_box_excludes_zero',False)]
 out={}
 for label,key,value in fields:
  bad=copy.deepcopy(r);bad[key]=value;out[label]=(bad!=r)
 assert all(out.values());return out

if __name__=='__main__':
 r=run()
 if len(sys.argv)>1 and sys.argv[1]=='--check':
  saved=json.loads(Path(sys.argv[2]).read_text());assert saved['result']==r
  assert saved['corruption_controls']==corruption_controls(r)
  print(json.dumps({'status':r['status'],'P_box_excludes_zero':r['P_box_excludes_zero'],'absolute_radius':r['claimed_absolute_radius']}))
 else:
  d={'result':r,'corruption_controls':corruption_controls(r),
     'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()}
  dest=Path(__file__).with_suffix('.json');dest.write_text(json.dumps(d,indent=2)+'\n',encoding='utf-8')
  print(json.dumps({'status':r['status'],'P_box':r['P_box'],'center':r['center'],
                    'absolute_radius':r['claimed_absolute_radius'],'counts':r['operation_counts'],
                    'events':len(r['elementary_events']),'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()},indent=2))
