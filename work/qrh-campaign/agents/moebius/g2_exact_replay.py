"""Exact-integer replay of the G2TailNum checker at pinned commit 23b2d68.
The original cP, Macc and tv_one must reproduce exactly before the new tail
budget is tested. This Python replay is not a Lean kernel certificate.
"""
from fractions import Fraction as F
from math import prod

X, K = 10000, 11815
S, SH = 10**12, 10**20
CP = 814940993196246650988643
ORIGINAL_MACC = 76543490188064834013184551386427677464246145966465219367994725

def cdiv(a, b):
    return (a + b - 1) // b

spf = [0] * K
for p in range(2, K):
    if spf[p]:
        continue
    for n in range(p, K, p):
        if not spf[n]:
            spf[n] = p

def prime_factors(n):
    ps = []
    while n > 1:
        p = spf[n]
        ps.append(p)
        while n % p == 0:
            n //= p
    return ps

factors = [prime_factors(n) for n in range(K)]
odd = [[p for p in ps if p != 2] for ps in factors]
den = [n * prod(p+1 for p in odd[n]) for n in range(K)]

def replay(tail_numerator):
    tail = tail_numerator * 10**16
    positive = negative = lower = upper = 0
    table = {}
    for k in range(1, K):
        ps = factors[k]
        if prod(ps) == k:
            if len(ps) % 2 == 0:
                positive += S // k
            else:
                negative += S // k
        value = max(CP + tail - lower, 0)
        lam = 2**((value.bit_length()-1)//2)
        if k <= X:
            table[k] = (lam, cdiv(value, lam))
        q = 2*k + 1
        lnum = 2*(3465*q**10 + 1155*q**8 + 693*q**6
                  + 495*q**4 + 385*q**2 + 315)
        lower += max(abs(positive-negative)-k, 0)**2 * lnum // (3465*q**11)
        hi_n = 13*(4*k*(k+1))*lnum + 6930
        hi_d = 45045*q**11*(4*k*(k+1))
        upper += cdiv((abs(positive-negative)+k)**2 * hi_n, hi_d)
    assert upper == CP, (upper, CP)
    total = 0
    for d in range(1, X+1, 2):
        ps = odd[d]
        if prod(ps) != d:
            continue
        sigma = prod(p+1 for p in ps)
        s1 = sl = sv = 0
        for a in range(1, X//d+1):
            sg = prod(p+1 for p in ps if a % p == 0)
            scaled = SH * sg
            s1 += scaled // den[a]
            hi = cdiv(scaled, den[a])
            lam, weight = table[X//(d*a)]
            sl += hi*lam
            sv += hi*weight
        b = cdiv(2*12338*sigma*SH, 10000*d)
        remainder = max(b-s1, 0)
        lam1, weight1 = table[1]
        left = sl + lam1*remainder
        right = sv + weight1*remainder
        total += cdiv(left*right, sigma*sigma)
    final = F(total, 10**64) + F(table[1][0]*table[1][1], 10**24)*4*F(12338,10000)**2/X
    return total, table[1], final

if __name__ == "__main__":
    original = replay(50423)
    assert original[0] == ORIGINAL_MACC
    assert original[1] == (549755813888,1483286220167)
    print("Original integer outputs reproduced exactly.")
    print("Original G2 bound", float(original[2]))
    new = replay(59100)
    profile = F(100001,100000) * (F(9,10000)/F(9377,1000) + F(91,10000)/F(1842,100))
    assert profile <= F(591,10**6)
    assert new[2] <= F(89,10000)
    t2 = F("1.4423050431")/4 + F("9.2185538")/10000 + F(5,4)*F(89,10000)
    assert t2 <= F("0.37273")
    print("New tailV", 59100*10**16)
    print("New Macc", new[0])
    print("New tv_one", new[1])
    print("New G2 bound exact", new[2])
    print("New G2 bound decimal", float(new[2]))
    print("Profile rational upper bound", float(profile))
    print("T2 bound using G2<=.0089", float(t2))
    print("All comparisons used exact integers or fractions. Lean replay remains required.")

