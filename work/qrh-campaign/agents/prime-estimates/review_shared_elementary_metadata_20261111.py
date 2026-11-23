"""Independent exact metadata reconstruction; no evaluator imports or analytic values."""
from fractions import Fraction as Q
from pathlib import Path
from hashlib import sha256
import json

base=Path(__file__).resolve().parents[1]
oldpath=base/'prime-estimates/small_conductor_theta_backend_metadata_20261111.json'
newpath=base/'integration/small_conductor_shared_elementary_metadata_20261111.json'
assert sha256(oldpath.read_bytes()).hexdigest().upper()=='2B149E2EE2CD5C20EDD14A38B009321847FB8FE2344D63DE5405291B3A183A1F'
assert sha256(newpath.read_bytes()).hexdigest().upper()=='117D2C82B8CA19CC24C3C359573598149F6B1CE6D53463B48B395B716350520E'
old=json.loads(oldpath.read_text())['rows']
new=json.loads(newpath.read_text())['rows']
def bits(q):
    b=max(0,q.denominator.bit_length()-q.numerator.bit_length())
    if Q(1,1<<b)>q:b+=1
    assert Q(1,1<<b)<=q and (b==0 or Q(1,1<<(b-1))>q)
    return b

checks=0
for x,y in zip(old,new,strict=True):
    c,t=x['c'],x['tilt_theta']; n=x['primitive_labels']; v=x['unit_group_size']
    N=x['time_length']; R=x['positive_frequency_count']; J=R-1
    B=3**(x['X']+1); M=B+1; n0=x['first_omitted_central_n']
    C=x['retained_width_bound']; V=Q(x['V']); W=c*V/t
    eps=Q(x['F_error']); delta=Q(1,2**x['uniform_Gaussian_seed_fractional_bits'])
    D=min(delta/16,1/W); epref=eps/(64*C*(n0*n0+2))
    sig=min(Q(1,4),D/(64*M**4),epref/(16*M**3),Q(1,16*n0))
    dr=sig/(4*B*max(J,1)); k0=min(dr/16,sig/(16384*c*c))
    jmax=x['desired_nonnegative_grid_nodes_per_label']-1
    es=Q(x['requested_Y_error'])/(4*(2*W*W+1)); ds=es/(8*3**t*max(1,jmax))
    expected=dict(c=c,theta=t,Rfreq=R,Jout=jmax+1,sigma_bits=bits(sig),
      radial_step_bits=bits(dr),setup_leaf_bits=bits(k0),canonical_scale_step_bits=bits(ds),
      added_frequency_real_products=J+(5+2*n)*R,canonical_scale_recurrence_real_products=jmax,
      canonical_output_real_products=n*(jmax+1),cutoff_exact_divisions=R,
      outer_complex_exp_upper=R,real_exp_setup=2,additive_root_cis=v,
      tilt_cis=1+x['parity_channels'],root_phase_sqrt=n,root_phase_division=n,
      conductor_positive_roots=2,
      extra_gauss_transform_butterflies=x['group_butterflies']//(x['parity_channels']*R),
      extra_gauss_transform_products=x['group_point_products']//(x['parity_channels']*R),
      time_root_cis_upper=N//2,parent_time_butterflies=x['time_butterflies'],
      parent_gaussian_unit_gates_upper=x['Gaussian_unit_multiplications_upper'])
    assert expected==y
    checks+=len(expected)
    tests=[M>=10,sig<=Q(1,16),J*dr<=Q(1,2),4*J*B*dr<=sig,
      (12*M**3+6*M*M+3+2*M**4)*sig<D,
      (6*M*M+2*M+3+2*M**3)*sig<epref,4*n0*sig<=Q(1,4),
      64*k0<sig/16,k0<=sig/(256*8*c),3*k0<=sig/(256*32*v),
      4*jmax*3**t*ds<=es/2,sig/256<=Q(1,4096)]
    assert all(tests);checks+=len(tests)
out=Path(__file__).with_suffix('.json')
receipt=dict(scope='Independent exact metadata and finite error-budget checks only',
             rows=len(old),checks=checks,author_receipt_sha256=sha256(newpath.read_bytes()).hexdigest().upper())
with out.open('x',encoding='utf8',newline='\n') as f:json.dump(receipt,f,indent=2);f.write('\n')
print(json.dumps(receipt))
print('receipt_sha256',sha256(out.read_bytes()).hexdigest().upper())
