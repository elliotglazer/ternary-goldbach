"""Bounded exact arithmetic witnesses for the K0 interval-evaluation plan.

No special-function call, sign scan, or Lean proof. Every acceptance comparison
uses Fraction. Function containment depends on the paper soundness lemmas.
"""
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
import json


def outward(x):
    d = 2**128
    lo = (x[0]*d).numerator // (x[0]*d).denominator
    neg = -x[1]*d
    hi = -(neg.numerator // neg.denominator)
    answer = Q(lo,d), Q(hi,d)
    assert answer[0] <= x[0] <= x[1] <= answer[1]
    return answer


def add(x, y):
    return outward((x[0] + y[0], x[1] + y[1]))


def mul(x, y):
    corners = [a * b for a in x for b in y]
    return outward((min(corners), max(corners)))


def scale(a, x):
    return mul((a, a), x)


def square(x):
    lo = Q(0) if x[0] <= 0 <= x[1] else min(a * a for a in x)
    return outward((lo, max(a * a for a in x)))


def divide(x, y):
    assert 0 < y[0] <= y[1]
    return mul(x, (1 / y[1], 1 / y[0]))


def atan_box(x, n):
    assert 0 < x < 1 and n > 0 and n % 2 == 0
    s = sum(((-1) ** j * x ** (2*j+1) / (2*j+1)
             for j in range(n)), Q(0))
    return outward((s, s + x ** (2*n+1) / (2*n+1)))


def sinc_box(x, m=16):
    assert -2 <= x[0] <= x[1] <= 2 and m >= 2
    c, r = (x[0]+x[1])/2, (x[1]-x[0])/2
    s = sum(((-1) ** j * c ** (2*j) / factorial(2*j+1)
             for j in range(m)), Q(0))
    tail = Q(2 * 2 ** (2*m), factorial(2*m+1))
    e = tail + r/2
    return outward((s-e, s+e))


def f_box(w, pi):
    assert 0 <= w[0] <= w[1] <= 1
    a = scale(Q(1,2), mul(pi, add(square(w), (-Q(1,4), -Q(1,4)))))
    b = mul(pi, add(w, (-Q(1,2), -Q(1,2))))
    numerator = mul(scale(Q(1,2), add(w, (Q(1,2), Q(1,2)))), sinc_box(a))
    denominator = sinc_box(b)
    assert denominator[0] > Q(1,2)
    return divide(numerator, denominator), denominator


def qs(x):
    return f"{x.numerator}/{x.denominator}"


def boxs(x):
    return [qs(y) for y in x]


def run():
    pi = add(scale(16, atan_box(Q(1,5), 24)),
             scale(-4, atan_box(Q(1,239), 8)))
    assert 3 < pi[0] < pi[1] < Q(22,7)
    assert Q(22,7)**2 < 10
    assert 1-Q(10,24) == Q(7,12) > Q(1,2)
    h = Q(1,2**30)
    examples = [("zero", (Q(0),Q(0))),
                ("removable", (Q(1,2),Q(1,2))),
                ("cross_removable", (Q(1,2)-h,Q(1,2)+h)),
                ("left_removable", (Q(1,2)-2*h,Q(1,2)-h)),
                ("right_removable", (Q(1,2)+h,Q(1,2)+2*h)),
                ("endpoint", (Q(1),Q(1)))]
    rows = []
    for name, w in examples:
        f, den = f_box(w, pi)
        assert f[1]-f[0] < Q(1,10**7)
        if name in ("removable", "cross_removable"):
            assert f[0] < Q(1,2) < f[1]
        rows.append({"case":name,"w":boxs(w),"F":boxs(f),
                     "denominator":boxs(den),"width":qs(f[1]-f[0])})
    # Rational points on both sides of the a=16 boundary. These use proven
    # rational pi bounds, not a floating approximation to the boundary.
    gap = Q(1,10**20)
    floors = []
    for name, t, n in [("1500",Q(1500),15),
                       ("below_a16",512*pi[0]-gap,15),
                       ("above_a16",512*pi[1]+gap,16)]:
        assert 2*pi[1]*n*n < t < 2*pi[0]*(n+1)**2
        requested = Q(1,10**9)
        eta = min(requested, Q(19,1000)/t)
        assert eta > 0 and eta <= requested
        assert eta**4 * t**3 <= Q(19,1000)**4
        floors.append({"case":name,"t":qs(t),"N":n,"eta":qs(eta),
                       "strict_floor_test":True,"budget_fourth_power_test":True})
    for m in range(2,20):
        em = Q(2*2**(2*m),factorial(2*m+1))
        en = Q(2*2**(2*m+2),factorial(2*m+3))
        assert en/em == Q(4,(2*m+2)*(2*m+3)) <= Q(2,21)
    return {"status":"PASS exact rational witnesses only",
            "scope":"No Khat values, signs, prime counts, or zero data computed",
            "pi":boxs(pi),"sinc_m":16,"outward_dyadic_bits":128,
            "uniform_sinc_tail":qs(Q(2*2**32,factorial(33))),
            "F_examples":rows,"floor_examples":floors,
            "tail_ratio_checks":18}


if __name__ == "__main__":
    result = run()
    out = Path(__file__).with_suffix('.json')
    out.write_text(json.dumps(result, indent=2)+'\n', encoding='utf-8')
    print(json.dumps({"status":result["status"],"F_examples":len(result["F_examples"]),
                      "floor_examples":len(result["floor_examples"]),"output":str(out)}))
