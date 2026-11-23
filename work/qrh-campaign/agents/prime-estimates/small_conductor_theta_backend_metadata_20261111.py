"""Rational parameter/schedule witnesses only; no character or analytic values."""
from fractions import Fraction as F
from pathlib import Path
import json

def ceil(x):
    return -(-x.numerator // x.denominator)

def group(axes):
    v = 1
    for d in axes:
        v *= d
    butterflies = products = 0
    for d in axes:
        lines = v // d
        if d & (d-1) == 0:
            butterflies += lines * (d//2) * (d.bit_length()-1)
        else:
            n = 1 << (2*d-2).bit_length()
            butterflies += lines * n * (n.bit_length()-1)
            products += lines * (n+2*d)
    return v, butterflies, products

def parameters(c, theta, labels, channels, axes):
    # The auxiliary1000 is a sensitivity scenario, not a successful count region.
    V = F(100000000,c)+1000
    tau = F(1,2**80)
    eps = tau/(4*3**theta)
    W = c*V/theta
    assert V >= 2*theta and W >= 1
    r=F(3,8)
    K=1
    while 32*W*W*r**K >= eps/4: K+=1
    L=1
    while 12*W*r**L >= eps/4: L+=1
    X=1
    while F(8,3)**(2*X) < W*(2*X+L): X+=1
    delta=F(5,64)
    while delta*X>1: delta/=2
    N=8
    period_min=max(2*V*K/theta,V+2*K,F(6))
    while N*delta < period_min: N*=2
    P=N*delta
    J=ceil(P*X/6)
    assert J < N//2
    C=4*(X+1)
    n0=1
    while True:
        v=3*n0*n0/W
        z=3*(2*n0+1)/W-F(1,n0)
        if v>=2 and z>0:
            tail=2*n0*(1+1/z)*r**(v.numerator//v.denominator)
            if C*tail<eps/8: break
        n0*=2
    pref=2*3**(3*(X+1))
    seed_bits=1
    while 6*F(1,2**seed_bits) > eps/(32*C*pref*n0**4): seed_bits+=1
    R=J+1
    terms=ceil(n0*(1+P/3)+R)
    v,g,p=group(axes)
    quotient=V/delta
    desired=quotient.numerator//quotient.denominator+1
    return dict(c=c,V=str(V),tilt_theta=theta,requested_Y_error=str(tau),F_error=str(eps),
        K=K,L=L,X=X,grid_step=str(delta),time_length=N,period=str(P),
        positive_frequency_count=R,first_omitted_central_n=n0,
        uniform_tail_bound=str(tail),retained_width_bound=C,
        uniform_Gaussian_seed_fractional_bits=seed_bits,
        Gaussian_term_count_upper=terms,Gaussian_unit_multiplications_upper=2*terms,
        bucket_additions_upper=channels*terms,
        unit_group_size=v,primitive_labels=labels,parity_channels=channels,
        group_butterflies=channels*R*g,group_point_products=channels*R*p,
        time_butterflies=labels*(N//2)*(N.bit_length()-1),
        desired_nonnegative_grid_nodes_per_label=desired,
        full_time_outputs=labels*N,
        frequency_to_desired_node_ratio=str(F(R,desired)),
        char_transform_call_ratio_to_point_EM=str(F(channels*R,desired)),
        point_EM_group_butterflies_comparator=desired*g,
        point_EM_group_products_comparator=desired*p,
        point_EM_P20_residue_terms_comparator=20*v*desired)

rows=[]
for c,labels,channels,axes in [(3,1,1,[2]),(4,1,1,[2]),(101,99,2,[100]),
                              (1000,160,2,[2,2,100]),(10000,1600,2,[2,4,500])]:
    for theta in [32,64,128]: rows.append(parameters(c,theta,labels,channels,axes))
out=Path(__file__).with_suffix('.json')
assert not out.exists(), 'Do not overwrite frozen metadata'
out.write_text(json.dumps(dict(scope='Conditional parameter and operation counts only; no analytic values',
    height_scenario='V=100000000/c+1000, not a certified adequate auxiliary height',
    rows=rows),indent=2)+'\n')
print(json.dumps({'rows':len(rows),'output':str(out)}))
