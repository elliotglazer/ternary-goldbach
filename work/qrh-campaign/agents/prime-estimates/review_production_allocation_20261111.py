"""Independent scalar planning checks only. No node or special-function evaluation."""
from fractions import Fraction as F
import json
import hashlib
from pathlib import Path

def run():
    agents=Path(__file__).parent.parent
    author_path=agents/'major-constants/principal_production_scalar_plan_20261111.json'
    author=json.loads(author_path.read_text())
    for path,pin in author['input_pins'].items():
        assert hashlib.sha256((agents/path).read_bytes()).hexdigest().upper()==pin
    rows = []
    for T,p,V,d in [(1000000,20,15,19),(60343058,26,18,24)]:
        U=T+1
        C=F(3,2*U); q=C/2; z0=3*C/2
        A=(2048/C**2+96/C)*(1+z0)/z0
        M=A/q; D=A*(1/q+1/q**2)
        ae,me,de=11+3*p,12+4*p,13+5*p
        J=de+12; h=F(3,U*J); K=F(V,h)
        assert K.denominator==1
        K=int(K); count=2*K+1
        nb=15+5*V; ce=ae+V+1; cb=count.bit_length(); wb=ce+cb+9
        assert U<2**p and 2*V==p+10
        assert A<2**ae and M<2**me and D<2**de
        assert 0<h<1 and K*h==V
        # exp(T*r)<2 and exp((T+1)*r)<2; Den>2^J-1.
        Q=4*D/(2**J-1)
        # x=q*exp(2V)>768, (x+1)*exp(-x/2)<=2.
        assert q*2**(2*V)>768
        S=2*D/F(2**384)
        # exp(5V/2)<2^(5V), exp(V/2)<2^V.
        B=(2*V+h)*F(2**(5*V),2**nb)
        assert A*2**V+F(1,2**nb)<2**ce
        W=F(count*2**ce,2**wb)
        assert all(e<F(1,512) for e in (Q,S,B,W))
        rho=F(1,64)
        coeff=(Q+S+B+W)*sum(rho**j for j in range(d+1))
        tail=D*rho**(d+1)/(1-rho)
        assert coeff<F(1,126) and tail<F(1,126)
        assert coeff+tail<F(1,63)
        inversions=0
        while 5*100**inversions<2*U*61**inversions:
            inversions+=1
        assert F(100,61)**inversions/U>=F(2,5)
        transport=inversions*(3+5*p)+4+9*V
        tailbits=transport+nb+12
        modes=1
        while F((2*modes+1)**2,20)<tailbits:
            modes+=1
        assert F(384,2**tailbits)*2**transport<=F(1,8*2**nb)
        # The author's stronger stop target is 1/2, with the same resulting caps.
        assert 2*100**inversions>=U*61**inversions
        assert inversions==0 or 2*100**(inversions-1)<U*61**(inversions-1)
        n=(q*2**(2*V)//2)
        author_s=F(2**(de+1),2**n)
        author_coeff=sum(rho**j for j in range(d+1))*(F(1,512)+author_s+B+W)
        ar=author['rows'][len(rows)]
        exact_fields=dict(T=T,U=U,p=p,r=str(F(1,2*U)),kappa=str(F(1,2*U)),q=str(q),
            A_power2_exponent=ae,M_power2_exponent=me,D_power2_exponent=de,
            J=J,h=str(h),V=V,K=K,nonnegative_nodes=K+1,signed_nodes=count,
            rho=str(rho),degree=d,coefficient_count=d+1,center_products=count*(d+1),
            known_zero_products_at_k0=d,node_radius=str(F(1,2**nb)),node_radius_bits=nb,
            node_center_grid_bits=nb+2,center_norm_power2_exponent=ce,
            weight_radius=str(F(1,2**wb)),weight_radius_bits=wb,weight_center_grid_bits=wb+2,
            center_sum_grid_bits=nb+wb+4,Q_each_upper='1/512',spatial_qR_lower=str(q*2**(2*V)),
            spatial_exp2_div2_floor=int(n),S_each_upper=str(author_s),B_each_upper=str(B),
            weight_each_upper=str(W),summation_error=0,Cauchy_upper='1/126',
            coefficient_disk_upper=str(author_coeff),total_disk_upper=str(author_coeff+F(1,126)),
            simple_total_upper='1/63')
        assert set(ar)==set(exact_fields)|{'optional_analytic_backend'}
        for key,value in exact_fields.items(): assert ar[key]==value,(key,ar[key],value)
        op=ar['optional_analytic_backend']
        for key,value in dict(max_S=inversions,max_translations=inversions+1,
            jet_transport_power2_exponent=transport,tail_M=tailbits,paired_modes=modes,
            max_terminal_mode_exponentials=(K+1)*modes,max_S_operations=(K+1)*inversions).items():
            assert op[key]==value
        rows.append(dict(T=T,U=U,p=p,h=str(h),K=K,signed_nodes=count,
                         J=J,V=V,degree=d,node_bits=nb,center_bits=ce,
                         count_bits=cb,weight_bits=wb,Q=str(Q),S=str(S),
                         B=str(B),W=str(W),coefficient_disk=str(coeff),
                         Taylor=str(tail),total=str(coeff+tail),
                         S_cap=inversions,transport_exponent=transport,
                         reduced_tail_bits=tailbits,half_integer_modes=modes))
    return {'scope':'Exact scalar envelopes only; no nodes or runtime claim',
            'author_receipt_sha256':hashlib.sha256(author_path.read_bytes()).hexdigest().upper(),
            'all_author_numerical_fields_match':True,'rows':rows}

if __name__=='__main__':
    out=Path(__file__).with_suffix('.json')
    out.write_text(json.dumps(run(),indent=2)+'\n',encoding='utf-8')
    print('PASS: two scalar allocations; no node evaluations')
