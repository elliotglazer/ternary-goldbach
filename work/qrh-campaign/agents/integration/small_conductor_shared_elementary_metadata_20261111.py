"""Exact schedule metadata only; no analytic values, imports of evaluators or transforms."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
BASE = HERE.parent
SOURCE = BASE/'prime-estimates/small_conductor_theta_backend_metadata_20261111.json'
assert hashlib.sha256(SOURCE.read_bytes()).hexdigest().upper() == '2B149E2EE2CD5C20EDD14A38B009321847FB8FE2344D63DE5405291B3A183A1F'

def bits(x):
    p = 0
    while F(1, 2**p) > x:
        p += 1
    return p

rows = []
checks = 0
for old in json.loads(SOURCE.read_text())['rows']:
    c, X, theta = old['c'], old['X'], old['tilt_theta']
    R = old['positive_frequency_count']; J = R-1
    n, v = old['primitive_labels'], old['unit_group_size']
    n0 = old['first_omitted_central_n']
    B = 3**(X+1); M = B+1
    delta = F(1, 2**old['uniform_Gaussian_seed_fractional_bits'])
    eps = F(old['F_error']); V = F(old['V']); W = c*V/theta
    epref = eps/(64*old['retained_width_bound']*(n0*n0+2))
    D = min(delta/16, 1/W)
    sigma = min(F(1,4), D/(64*M**4), epref/(16*M**3), F(1,16*n0))
    dr = sigma/(4*B*max(1,J))
    k0 = min(dr/16, sigma/(16384*c*c))
    eta = sigma/256
    assert J*dr <= F(1,2)
    assert 12*M**3+6*M*M+3+2*M**4 <= 15*M**4
    assert 6*M*M+2*M+3+2*M**3 <= 7*M**3
    assert 15*M**4*sigma < D
    assert 7*M**3*sigma < epref
    assert 4*n0*sigma <= F(1,4)
    assert k0 <= eta/(8*c) and 3*k0 <= eta/(32*v)
    Jout = old['desired_nonnegative_grid_nodes_per_label']
    escale = F(old['requested_Y_error'])/(4*(2*W*W+1))
    scale_step_error = escale/(8*3**theta*max(1,Jout-1))
    assert (Jout-1)*scale_step_error < F(1,2)
    checks += 9
    rows.append(dict(c=c,theta=theta,Rfreq=R,Jout=Jout,
        sigma_bits=bits(sigma),radial_step_bits=bits(dr),setup_leaf_bits=bits(k0),
        canonical_scale_step_bits=bits(scale_step_error),
        added_frequency_real_products=J+(5+2*n)*R,
        canonical_scale_recurrence_real_products=max(0,Jout-1),
        canonical_output_real_products=n*Jout,
        cutoff_exact_divisions=R,
        outer_complex_exp_upper=R,real_exp_setup=2,
        additive_root_cis=v,tilt_cis=1+old['parity_channels'],
        root_phase_sqrt=n,root_phase_division=n,conductor_positive_roots=2,
        extra_gauss_transform_butterflies=old['group_butterflies']//(old['parity_channels']*R),
        extra_gauss_transform_products=old['group_point_products']//(old['parity_channels']*R),
        time_root_cis_upper=old['time_length']//2,
        parent_time_butterflies=old['time_butterflies'],
        parent_gaussian_unit_gates_upper=old['Gaussian_unit_multiplications_upper']))
out = Path(__file__).with_suffix('.json')
assert not out.exists(), 'preserve frozen output'
out.write_text(json.dumps(dict(scope='Exact metadata, not analytic values or timing',checks=checks,
    source_sha256=hashlib.sha256(SOURCE.read_bytes()).hexdigest().upper(),rows=rows),indent=2)+'\n')
print(json.dumps({'checks':checks,'rows':len(rows),'output':str(out)}))
