"""Exact scalar plan only: no L/theta values, no node arrays, no transforms."""
from fractions import Fraction as F
from pathlib import Path
import json,hashlib

base=Path(__file__).parent
inputs={
 'integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md':'6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99',
 'integration/PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md':'5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571',
 'major-constants/THETA_JET_TAIL_TWO_FIFTHS_2026-11-11.md':'478DEDD2DC613670A5B2E6ECA18317733006D82CDE06860719302301B80FFE88',
}
for p,h in inputs.items():
 assert hashlib.sha256((base.parent/p).read_bytes()).hexdigest().upper()==h

rows=[]
for T,p,V in [(1000000,20,15),(60343058,26,18)]:
 U=T+1; assert 1<U<2**p and 2*V==p+10 and V%3==0
 r=kappa=F(1,2*U); C=3*kappa; q=C/2; z0=3*C/2
 A=(2048/C**2+96/C)*(1+z0)/z0; M=A/q; D=A*(1/q+1/q**2)
 ae,me,de=11+3*p,12+4*p,13+5*p
 assert A<2**ae and M<2**me and D<2**de and M<D
 J=de+12; h=F(3,U*J); K=V*U*J//3
 assert K*h==V and 0<h<=1 and 6*r/h==J
 # pi>3, exp(1)>2, exp(1/2)<2 imply all Q_j < this bound.
 Qcap=F(2**(de+2),2**(J-1))
 assert Qcap==F(1,512)
 xlo=q*2**(2*V); n=(xlo/2).__floor__()
 assert xlo>768 and n>=384
 Scap=F(2**(de+1),2**n)
 assert Scap<F(1,512)
 rho=F(1,64); d=(de+7+5)//6-1
 assert 6*(d+1)==de+7
 cauchy=2**de*rho**(d+1)/(1-rho)
 assert cauchy==F(1,126)
 node_bits=15+5*V; node_radius=F(1,2**node_bits)
 Bcap=(2*V+h)*2**(5*V)*node_radius
 assert 2*V+h<64 and Bcap<F(1,512)
 center_bits=ae+V+1
 assert 2**(ae+V)+node_radius<2**center_bits
 signed=2*K+1; length_bits=signed.bit_length()
 weight_bits=center_bits+length_bits+9
 weight_radius=F(1,2**weight_bits)
 Wcap=signed*2**center_bits*weight_radius
 assert Wcap<F(1,512)
 G=sum(rho**j for j in range(d+1))
 coeffcap=G*(Qcap+Scap+Bcap+Wcap)
 total=coeffcap+cauchy
 assert G<F(64,63) and coeffcap<F(1,126)
 assert total<F(1,63)<F(1,10)
 # Analytic seed-tail option, with all future roundoff still separately charged.
 m=0
 # Reach height >=1/2, so even an overlap-guard implementation cannot take another S.
 while 2*100**m<U*61**m: m+=1
 transport_bits=m*(3+5*p)+4+9*V
 tail_M=transport_bits+node_bits+12
 N=0
 while (2*N+1)**2<20*tail_M: N+=1
 assert F(384,2**tail_M)*2**transport_bits<node_radius/8
 rows.append(dict(T=T,U=U,p=p,r=str(r),kappa=str(kappa),q=str(q),
   A_power2_exponent=ae,M_power2_exponent=me,D_power2_exponent=de,
   J=J,h=str(h),V=V,K=K,nonnegative_nodes=K+1,signed_nodes=signed,
   rho=str(rho),degree=d,coefficient_count=d+1,
   center_products=signed*(d+1),known_zero_products_at_k0=d,
   node_radius=str(node_radius),node_radius_bits=node_bits,
   node_center_grid_bits=node_bits+2,center_norm_power2_exponent=center_bits,
   weight_radius=str(weight_radius),weight_radius_bits=weight_bits,
   weight_center_grid_bits=weight_bits+2,
   center_sum_grid_bits=node_bits+weight_bits+4,
   Q_each_upper=str(Qcap),spatial_qR_lower=str(xlo),spatial_exp2_div2_floor=n,
   S_each_upper=str(Scap),B_each_upper=str(Bcap),weight_each_upper=str(Wcap),
   summation_error=0,Cauchy_upper=str(cauchy),coefficient_disk_upper=str(coeffcap),
   total_disk_upper=str(total),simple_total_upper='1/63',
   optional_analytic_backend=dict(max_S=m,max_translations=m+1,
      jet_transport_power2_exponent=transport_bits,tail_M=tail_M,
      paired_modes=N,max_terminal_mode_exponentials=(K+1)*N,
      max_S_operations=(K+1)*m,
      scope='Analytic truncation only; finite elementary/word/transport roundoff still unproduced.')))

out={'scope':'Conditional scalar feasibility, not actual node/weight/contour evidence.',
     'input_pins':inputs,'rows':rows}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
for row in rows:
 print({k:row[k] for k in ['T','h','V','K','nonnegative_nodes','degree',
    'center_products','node_radius_bits','weight_radius_bits','center_sum_grid_bits']})
 print(row['optional_analytic_backend'])
print('All exact scalar checks passed; total disk error < 1/63 < 1/10 conditional on stated inputs.')
