"""Floating-point diagnostics for the pinned cde-moebius consumer inequalities.
Run with Python 3. No dependencies or repository mutation.
These are research calculations, not Lean-certified inequalities.
"""
import math

K = 11815
B = 100000001
P = 1.2338
X = 10000
TAU = 0.00050423

def elementary_tolerances():
    a = 1.64495 + 2 / 9 * 1.0117
    b = 1.414214 * 5.6 * 0.04
    print("Liouville c_max", (0.99 - b) / a)
    print("Liouville at c=.14", 0.14 * a + b)
    print("fixed-tail uniform c after 1e8",
          math.sqrt((TAU / 1.00001 - 0.03**2 *
                    (1 / math.log(K) - 1 / math.log(B))) * math.log(B)))
    l = 160.54
    eta = lambda t: 0.033 / t + 0.0395 / t**2
    pts = [0.18, 0.216, 0.2592, 0.311, 0.3732, 0.4479,
           0.5375, 0.645, 0.774, 0.9288]
    j = 0
    for i, c in enumerate(pts):
        low = c * l - 1e-9
        high = pts[i + 1] * l + 1e-9 if i + 1 < len(pts) else l
        err = 0.588 if i + 1 < len(pts) else 1.166
        j += (0.607927101855 * (high - low) + err) / low
    constant = (1e-9 + 0.039329 / l**2 + 19.925014134314 * eta(l - 14.5089)
                + 0.033 * 0.36 / 0.82
                + 0.36 * 0.0395 * l / (0.82 * l - 0.6933)**2)
    coefficient = j + eta(0.82 * l - 0.6933) / (0.18 * l - 1e-9)
    print("tail C5_max", (0.033 * (1 - 1/l) - constant) / coefficient)
    for c in [1, 10, 100]:
        lo, hi = 24.0, 300.0
        for _ in range(70):
            mid = (lo + hi) / 2
            if c * math.exp(-mid/8) * mid**3 > 0.00985:
                lo = mid
            else:
                hi = mid
        print("QRH coefficient and log crossover", c, hi)

def g2_model(target=0.0082):
    mu, spf = [1] * K, [0] * K
    mu[0] = 0
    for p in range(2, K):
        if spf[p]:
            continue
        for n in range(p, K, p):
            if not spf[n]:
                spf[n] = p
            mu[n] *= -1
        for n in range(p*p, K, p*p):
            mu[n] = 0
    prefix, m = [0.0], 0.0
    for j in range(1, K):
        m += mu[j] / j
        prefix.append(prefix[-1] + m*m*math.log1p(1/j))
    def odd_primes(n):
        out = []
        while n > 1:
            p = spf[n]
            if p > 2:
                out.append(p)
            while n % p == 0:
                n //= p
        return out
    primes = [odd_primes(n) for n in range(X + 1)]
    den = [n * math.prod(p+1 for p in primes[n]) for n in range(X + 1)]
    terms = []
    for d in range(1, X+1, 2):
        if not mu[d]:
            continue
        sigma = math.prod(p+1 for p in primes[d])
        hs = [(X//(d*a), math.prod(p+1 for p in primes[d] if a%p == 0)/den[a])
              for a in range(1, X//d + 1)]
        rest = 2*P*sigma/d - sum(h for _, h in hs)
        terms.append((sigma, hs, rest))
    def value(tau):
        values = [0.0] + [prefix[-1] + tau - prefix[k-1] for k in range(1, X+1)]
        lambdas = [0.0] + [2**(math.floor(math.log2(v*1e24))//2)/1e12
                          for v in values[1:]]
        weights = [0.0] + [values[k]/lambdas[k] for k in range(1, X+1)]
        total = values[1]*4*P*P/X
        for sigma, hs, rest in terms:
            left = rest*lambdas[1] + sum(h*lambdas[k] for k, h in hs)
            right = rest*weights[1] + sum(h*weights[k] for k, h in hs)
            total += left*right/sigma**2
        return total
    print("G2 finite exact-m floating sum", prefix[-1])
    print("G2 floating baseline", value(TAU))
    print("G2 source certified constants evaluated as float",
          76543490188064834013184551386427677464246145966465219367994725/1e64
          + 0.549755813888*1.483286220167*4*P*P/X)
    lo, hi = TAU, 0.002
    for _ in range(60):
        mid = (lo + hi)/2
        if value(mid) <= target:
            lo = mid
        else:
            hi = mid
    print("G2 target and floating tau boundary", target, lo)
    print("Rounding is omitted. This tau_max requires a fresh exact certificate.")
    for tau in [TAU, 0.00052, 0.00059, 0.000591, 0.0006, 0.001]:
        print("tau, G2", tau, value(tau))

if __name__ == "__main__":
    elementary_tolerances()
    g2_model()
    from fractions import Fraction
    t2cap = (Fraction('0.37273') - Fraction('1.4423050431')/4 - Fraction('9.2185538')/10000)*Fraction(4,5)
    print('Exact G2 cap preserving T2', t2cap, float(t2cap))
    g2_model(float(t2cap))

