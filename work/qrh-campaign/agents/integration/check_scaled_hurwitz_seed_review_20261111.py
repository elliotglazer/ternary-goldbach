"""Independent exact envelope/matrix checks; no function values or author imports."""
from fractions import Fraction as Q
from math import comb, factorial
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent
checks = 0

def require(p):
    global checks
    assert p
    checks += 1

def run():
    pins = {
        'prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md': '251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231',
        'prime-estimates/scaled_hurwitz_seed_bounds_20261111.py': '51814FE2AA93B10AF604E635AD38831E8E6DDBAFEB32EB6A3DA5E1BDA98B52C5',
        'prime-estimates/scaled_hurwitz_seed_bounds_20261111.json': '2705A1CFACB0C9CECDA842DDF73A37696DF8A1BAD250AEA7F383D63AC11A99E8',
        'integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md': '1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E',
        'independent-feasibility/REVIEW_SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md': 'C4D2F0385C84FDC42B70D451378284E278EBA2527D0DC7B74BC9F85AECE73E4F',
        'integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md': '861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895',
        'independent-feasibility/REVIEW_SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md': 'F190270EC3A359A1251E24C1039826EFE13897499DE540EA9F877331804748BB',
    }
    for name, digest in pins.items():
        require(hashlib.sha256((AGENTS/name).read_bytes()).hexdigest().upper() == digest)
    author = json.loads((AGENTS/'prime-estimates/scaled_hurwitz_seed_bounds_20261111.json').read_text())
    eta, delta, u = Q(1, 2**100), Q(1, 2**118), Q(1, 2**122)
    bands = [(500,512,220),(1000,1024,387),(2000,2048,720),(5000,4096,1720),(10000,8192,3387)]
    require(len(author['rows']) == 25)
    row_index = 0
    seed_rows = []
    for V,D,N in bands:
        require(3*(N-1) < V+160 <= 3*N)
        a, b = Q(V+32,D), N+2
        require(a < Q(5,4))
        require(Q(6,D) < Q(1,2))
        for P in (20,24,27,28,32):
            # Recurrence error envelopes, in units of u.
            er = el = ee = Q(0)
            for k in range(P-1):
                er = er*a/(k+1)+1
                el = el*Q(6,D*(k+1))+1
                require(er < 3 and el < 2)
            for k in range(P+126):
                ee = ee/2+1
                require(ee < 2)
            require((4*b+122)*u < 1)
            # Independent triangle chain rather than a saved final decimal.
            head = 5*N*(delta+P*u)+3*N*u+u
            s_error = 64*(4*2+2+1)*u
            z_error = (4*b+1)*u+2*u+(s_error/6+u)
            require(z_error <= (4*b+122)*u)
            f_error = (4*b+122)*u+2*(2*b+2)*u+u
            end = (2*b+1)*delta+2*f_error+u
            tail = Q(216*b,255*2**128)
            require(tail < Q(1,2**116))
            total = head+end+u+tail
            require(total < eta/4)
            row = author['rows'][row_index]
            row_index += 1
            require((row['V'],row['D'],row['N'],row['P']) == (V,D,N,P))
            require(Q(row['seed_error']) == total)
            require(Q(row['remainder']) == tail)
            require(4*(3*N+5)+1 < 2**16)
            seed_rows.append({'V':V,'P':P,'error_over_eta':str(total/eta)})
    worst = 23714*delta+606562*u+Q(1,2**116)
    require(worst/eta == Q(493025,2097152))
    require(worst < eta/4)
    require(Q(author['worst_uniform_bound']) == worst)
    require(10000*Q(1,2**135) < delta/8)

    matrix_rows = []
    for P in (27,28,32):
        updates = [j for i in range(P-2,-1,-1) for j in range(i,min(P-2,i+19)+1)]
        require(len(updates) == 20*P-210)
        full = [[Q(comb(j,k),2**(j-k)) if j>=k else Q(0) for j in range(P)] for k in range(P)]
        mat = [[Q(int(k==j)) for j in range(P)] for k in range(P)]
        major = [Q(5,4)**j/factorial(j) for j in range(P)]
        for j in updates:
            mat[j] = [x+y/2 for x,y in zip(mat[j],mat[j+1])]
            # Every intermediate ideal coefficient obeys the full positive majorant.
            require(sum(mat[j][i]*major[i] for i in range(P)) < 4)
        require(mat[:20] == full[:20])
        for k in range(P):
            require(sum(full[k]) <= 2**P)
        # Reverse row-vector propagation gives the true suffix amplification
        # at every individual rounded update, independently of prefix argument.
        weights = [Q(1,4**k) if k<20 else Q(0) for k in range(P)]
        max_injection = Q(0)
        for j in reversed(updates):
            max_injection = max(max_injection, weights[j])
            require(weights[j] <= Q(3,4)**j <= 1)
            weights[j+1] += weights[j]/2
        require(sum(weights) < 4)
        L = len(updates)
        require(2**P*(eta+L*Q(1,2**110)) < 1)
        target = Q(1266)*Q(5,16)**20/factorial(20)
        shift = Q(1266)*Q(15,16)**P/factorial(P)
        total = target+shift+2532*eta+633*L*Q(1,2**110)+1688*eta
        require(total < Q(1,2**82))
        saved = next(x for x in author['shift'] if x['P']==P)
        require(Q(saved['total']) == total)
        matrix_rows.append({'P':P,'updates':L,'maximum_injection_weight':str(max_injection),'input_error_weight':str(sum(weights)),'alpha_fraction_of_budget':str(total*2**82)})
    return {'scope':'Independent exact rational envelopes and finite positive matrices only; no analytic evaluations.', 'checks':checks, 'pins':pins, 'seed_rows':seed_rows,'matrices':matrix_rows,'worst_seed_over_eta':str(worst/eta)}

if __name__ == '__main__':
    result = run()
    HERE.joinpath('check_scaled_hurwitz_seed_review_20261111.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(result['checks'], 'exact checks passed')
