"""Bounded candidate generation only; no acceptance from point residuals."""
import os
os.environ.setdefault('OPENBLAS_NUM_THREADS', '1')
from fractions import Fraction as F
from pathlib import Path
import importlib.util
import json
import time
import hashlib
from math import factorial
import numpy as np

HERE = Path(__file__).parent
SOURCE = HERE / 'c5_family_dft_certificate_20261111.py'
spec = importlib.util.spec_from_file_location('frozen_c5_em', SOURCE)
em = importlib.util.module_from_spec(spec)
spec.loader.exec_module(em)


def safe_exprel(z):
    value = term = em.acb(1)
    for k in range(1, 19):
        term = term*z/(k+1)
        value += term
    radius = abs(z).upper()
    return value + em.eb(radius.exp()*radius**19/factorial(20))


em.exprel = safe_exprel


def boundary(ny, nx):
    left, right, height = F(111, 200), F(2), F(12)
    out = []
    corners = [(left, -height), (right, -height),
               (right, height), (left, height), (left, -height)]
    for k, (a, b) in enumerate(zip(corners, corners[1:])):
        n = nx if k % 2 == 0 else ny
        out.extend((a[0] + (b[0]-a[0])*F(j,n),
                    a[1] + (b[1]-a[1])*F(j,n)) for j in range(n))
    return out


def main():
    start = time.perf_counter()
    train = boundary(384, 24)
    valid = boundary(768, 48)
    calls = 0
    cache = {}

    def values(points):
        nonlocal calls
        for point in points:
            if point not in cache:
                vals = em.evaluate(em.box(point, point))
                assert all(not v.contains(0) for v in vals)
                cache[point] = [complex(float(v.real.mid()), float(v.imag.mid()))
                                for v in vals]
                calls += 1
        return np.asarray([cache[p] for p in points], dtype=np.complex128)

    train_l = values(train)
    valid_l = values(valid)
    ztrain = np.asarray([complex(float(x),float(y)) for x,y in train])
    zvalid = np.asarray([complex(float(x),float(y)) for x,y in valid])
    trials = []
    best = None
    for denom in (8, 16):
        poles = [(F(1,2), F(j,denom)) for j in range(-12*denom,12*denom+1)]
        pp = np.asarray([complex(float(x),float(y)) for x,y in poles])
        matrix = np.column_stack((np.ones(len(train)),1/(ztrain[:,None]-pp[None,:])))
        vmat = np.column_stack((np.ones(len(valid)),1/(zvalid[:,None]-pp[None,:])))
        scale = np.linalg.norm(matrix,axis=0)
        coeff, _, rank, singular = np.linalg.lstsq(matrix/scale,1/train_l,rcond=1e-9)
        coeff /= scale[:,None]
        residual = 1-valid_l*(vmat@coeff)
        maxres = np.max(np.abs(residual),axis=0)
        rec = {'pole_spacing':str(F(1,denom)), 'poles':len(poles),
               'rank':int(rank), 'max_validation_residual':list(map(float,maxres)),
               'sum_abs_coefficients':list(map(float,np.sum(np.abs(coeff),axis=0))),
               'smallest_retained_scale_diagnostic':float(singular[min(rank-1,len(singular)-1)]),
               'seconds_so_far':time.perf_counter()-start}
        trials.append(rec)
        print(json.dumps(rec),flush=True)
        if max(maxres)<0.3:
            best = (poles, coeff)
            break
        if time.perf_counter()-start>100:
            break
    result = {'status':'CANDIDATE_ONLY_NO_BOUNDARY_ACCEPTANCE' if best else 'DIAGNOSTIC_FIT_INSUFFICIENT',
              'source_sha256':hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
              'characters':[1,2,3], 'generator':2, 'residues':[1,2,4,3],
              'rectangle':['111/200','2','-12','12'],
              'training_points':len(train), 'validation_points':len(valid),
              'actual_em_point_calls':calls, 'rcond':'1e-9','trials':trials,
              'prior_failed_attempts':[{'stage':'initial candidate generation',
                'reason':'Inherited abs(z)**19 returned nan for a zero-containing real Arb ball at real-axis points. Conservative upper-radius adapter used on retry.'}],
              'elapsed_seconds':time.perf_counter()-start}
    if best:
        poles, coeff = best
        result['poles'] = [[str(x),str(y)] for x,y in poles]
        result['coefficient_order'] = 'constant, followed by pole reciprocals; columns are characters1,2,3'
        result['coefficients'] = [[[str(F(float(z.real))),str(F(float(z.imag)))]
                                   for z in row] for row in coeff]
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n')
    print(result['status'],flush=True)


if __name__=='__main__':
    main()
