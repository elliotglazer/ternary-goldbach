"""Exact geometry and conditional cost ratios; no prime search or timing run."""
from fractions import Fraction
import json
from pathlib import Path

N = 10**27
B0 = 4 * 10**18
F = 2**45
S0 = 111616
K0 = (N - 5) // (S0 * F)


def frac(x):
    return str(x.numerator) + "/" + str(x.denominator)


def geometry(B, W):
    # Uniform window t in [0,W-1], i >= 1; S >= W guarantees k>0.
    S = (B - 2) // F - (W - 1)
    if S < W:
        return None
    D = S * F
    K = (N - 5) // D
    assert (S + W - 1) * F + 2 <= B
    assert S * K < F  # required by this particular Proth criterion
    assert W & (W - 1) == 0
    bits = W.bit_length() - 1
    # Endpoints cover all possible n and offsets in each regular window.
    tests = 0
    for i in sorted({1, 2, max(1, K - 1), K}):
        for n in (i * D + 5, (i + 1) * D + 3):
            for t in (0, W - 1):
                p = (S * i - t) * F + 1
                assert p > 1 and p % 2 == 1 and n % 2 == 1
                assert 4 <= n - p <= B
                assert (n - 5) // D == i
                tests += 1
    assert D + 3 <= B + 3  # initial interval is in binary-plus-three base
    return dict(binary_cutoff=B, window_candidates=W, stride=S,
                stride_integer=D, rungs=K, old_rung_ratio=frac(Fraction(K,K0)),
                offset_bits=bits, raw_regular_offset_bytes=(K*bits+7)//8,
                endpoint_checks=tests,
                uses_more_than_28_index_bits=K >= 2**28)


def fallback_limit(B, K, q, c, r):
    # B0 binary cost = 1, old total ladder cost = q; c scales ordinary
    # per-rung total cost, r is fallback/ordinary per-rung total cost.
    # Candidate total: B/B0 + q*c*(K/K0)*(1+f*(r-1)).
    assert r > 1 and q > 0 and c > 0
    result = ((1 + q - Fraction(B,B0)) /
              (q*c*Fraction(K,K0)) - 1) / (r-1)
    return dict(unclipped=frac(result),
                clipped=frac(max(Fraction(0), min(Fraction(1), result))),
                ordinary_alone_beats_baseline=result > 0)


def main():
    candidates=[]
    for B in (2*10**15,4*10**15,10**16,2*10**16,10**17,
              2*10**17,10**18,4*10**18):
        for W in (8,16,32,64,128,256,512,1024,2048):
            row=geometry(B,W)
            if row is not None:
                candidates.append(row)
    comparisons=[]
    selected={(10**16,128),(2*10**16,256),(10**17,1024),
              (2*10**17,2048)}
    for row in candidates:
        if (row['binary_cutoff'],row['window_candidates']) not in selected:
            continue
        for q in (Fraction(1,10**6),Fraction(1,10**4),Fraction(1,100)):
            for c in (Fraction(1),Fraction(4)):
                for r in (Fraction(10),Fraction(1000)):
                    lim=fallback_limit(row['binary_cutoff'],row['rungs'],q,c,r)
                    u=Fraction(lim['unclipped'])
                    # Algebraic threshold is exact, including infeasible roots.
                    total=(Fraction(row['binary_cutoff'],B0)+q*c*
                           Fraction(row['rungs'],K0)*(1+u*(r-1)))
                    assert total == 1+q
                    comparisons.append(dict(B=row['binary_cutoff'],
                        W=row['window_candidates'],q=frac(q),c=frac(c),
                        r=frac(r),fallback_fraction_limit=lim))
    # Reference geometry and a deliberately invalid stride are discriminated.
    assert K0 == 254638308
    assert (S0+2047)*F+2 <= B0
    invalid = (B0-2)//F - 2047 + 1
    assert (invalid+2047)*F+2 > B0
    output=dict(scope='Exact conditional geometry/cost ratios, not measured forecasts',
                N=N,B0=B0,F=F,K0=K0,candidates=candidates,
                comparisons=comparisons,
                endpoint_checks=sum(r['endpoint_checks'] for r in candidates),
                threshold_identity_checks=len(comparisons),negative_controls=1)
    out=Path(__file__).with_suffix('.json')
    out.write_text(json.dumps(output,indent=2)+'\n',encoding='utf-8')
    print(json.dumps({k:output[k] for k in
         ('scope','endpoint_checks','threshold_identity_checks','negative_controls')}))
    for row in candidates:
        if (row['binary_cutoff'],row['window_candidates']) in selected:
            print(json.dumps(row))


if __name__ == '__main__':
    main()
