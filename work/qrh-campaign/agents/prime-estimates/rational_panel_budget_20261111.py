"""Envelope-only rational planning; no kernel nodes or function values."""
from fractions import Fraction as Q
from math import factorial
from functools import lru_cache
from pathlib import Path
import hashlib,json
GRID=2**192
def rnd(l,h):
 return Q((l*GRID).__floor__(),GRID),Q((h*GRID).__ceil__(),GRID)
@lru_cache(None)
def ep(x):
 assert x>=0
 k=0;t=x
 while t>Q(1,2):t/=2;k+=1
 n=64;lo=sum(t**j/factorial(j) for j in range(n))
 hi=lo+(t**n/factorial(n))/(1-t/(n+1))
 lo,hi=rnd(lo,hi)
 for _ in range(k):lo,hi=rnd(lo*lo,hi*hi)
 return lo,hi
def atan(x):
 n=48;l=sum((-1)**j*x**(2*j+1)/(2*j+1) for j in range(n))
 return l,l+x**(2*n+1)/(2*n+1)
def wire(q):return str(q.numerator)+'/'+str(q.denominator)
def updecimal(q,n=10**12):return wire(Q((q*n).__ceil__(),n))
def run():
 aa,bb=atan(Q(1,5)),atan(Q(1,239));pi=(16*aa[0]-4*bb[1],16*aa[1]-4*bb[0])
 assert 3<pi[0]<pi[1]<4
 a=kappa=Q(1,66);C=3*kappa;q=C/2;z=3*C/2
 A=(2048/C**2+96/C)*(1+z)/z;M=A/q;D=A*(1/q+1/q**2)
 assert (A,M,D)==(Q(46687168,3),Q(2054235392,3),Q(30813530880))
 rho=Q(1,64);T=14
 table=[]
 for den in (192,208,224,240,256,320,384):
  h=Q(1,den);Den=ep(2*pi[0]*a/h)[0]-1
  Q0=2*M*ep(T*a)[1]/Den;Qp=2*D*ep((T+1)*a)[1]/Den
  for V in (Q(7,2),Q(29,8),Q(15,4)):
   Rl,Ru=ep(2*V);assert q*Rl>=2
   expminus=1/ep(q*Rl)[0]
   S0=M*expminus;Sp=A*expminus*(Ru/q+1/q**2)
   for d in (5,6,7):
    coeffsum=sum(rho**j for j in range(d+1));positive=coeffsum-1
    tail=D*rho**(d+1)/(1-rho)
    analytic=Q0+S0+(Qp+Sp)*positive+tail
    K=V/h;assert K.denominator==1
    table.append({'denominator':den,'V':wire(V),'K':int(K),'degree':d,
     'nodes':int(K)+1,'analytic_error_upper_rounded':updecimal(analytic),
     'passes_one_eighth':analytic<Q(1,8)})
    if (den,V,d)==(256,Q(29,8),6):
     selected={'Q0':Q0,'Qpositive':Qp,'S0':S0,'Spositive':Sp,'Cauchy':tail,
      'analytic_total':analytic,'coefficient_radius_sum':coeffsum}
 h=Q(1,256);K=928;V=Q(29,8);d=6
 assert ep(Q(5,2)*V)[1]<2**14
 node_per_coeff=h*(2*K+1)*Q(1,2**24)*2**14
 assert node_per_coeff<Q(1,128)
 assert A*ep(V/2)[1]+Q(1,2**24)<2**27
 weight_per_coeff=(2*K+1)*Q(1,2**48)*2**27
 assert weight_per_coeff<Q(1,1024)
 assert ep(Q(11,10)*V)[1]<64
 total=selected['analytic_total']+(node_per_coeff+weight_per_coeff)*selected['coefficient_radius_sum']
 assert total<Q(1,10)
 # Geometric growth bound on the number of modular S steps for new seeds.
 eta=Q(1,33);x=2*eta
 assert x-x**3/6>Q(3,50)
 assert Q(3,50)*Q(100,61)**4>Q(2,5)
 assert ep(2*V)[1]<2048
 # Crude absolute terminal-jet tail, before interval-rounding error.
 # sum_(k>=0)(k+1)^4/2^k = 300 from the fourth geometric moment.
 moment=2*(Q(1,2)*(1+11*Q(1,2)+11*Q(1,2)**2+Q(1,2)**3)/(1-Q(1,2))**5)
 assert moment==300 and 2*16*17**4*moment<2**30
 assert Q(6,5)*16**2>307
 invbound=Q(50,3);jetamp=5*(Q(3,4)*invbound**2+3*invbound**3+invbound**4)
 assert jetamp<2**19
 assert 8*(6*2048+4*2048**2)<2**28
 return {'status':'PASS rational envelope planning only; no P/xi/theta value computed',
  'selected':{'h':'1/256','K':K,'V':wire(V),'degree':d,'rho':'1/64','T_work':14,
   'bounds':{k:updecimal(v) for k,v in selected.items()},
   'node_per_coefficient_upper':wire(node_per_coeff),'weight_per_coefficient_upper':wire(weight_per_coeff),
   'complete_disk_error_upper_rounded':updecimal(total),
   'nonnegative_nodes':K+1,'signed_nodes':2*K+1,'coefficient_products':(2*K+1)*(d+1),
   'maximum_S_steps':4*(K+1),'terminal_modes_max':16*(K+1)},
  'search_table':table,'pi_interval':[wire(v) for v in pi],
  'method':'48-term Machin atan, 64-term reduced exp plus geometric tail, 192-bit outward rational grid'}
if __name__=='__main__':
 out=run();out['script_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()
 Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2,sort_keys=True)+'\n',encoding='utf8')
 print(json.dumps(out['selected'],indent=2))
