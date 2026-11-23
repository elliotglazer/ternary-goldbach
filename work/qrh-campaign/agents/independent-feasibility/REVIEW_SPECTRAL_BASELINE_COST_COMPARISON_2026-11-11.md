# Independent review of spectral baseline cost metadata

2026-11-11. Verdict: PASS within source-domain and exact metadata scope. No correction to the author packet is required. This is not a runtime model, zero count, certified finite-RH computation, compiled hypothesis refactoring, or validation of a complete QRH proof.

Reviewed immutable author files:

| Workspace-relative path | SHA256 |
|---|---|
| work/qrh-blueprint/SPECTRAL_BASELINE_COST_COMPARISON_2026-11-11.md | 0DD28598568EC61FC8B589017680AA9A3AE350608ADA32FD94D9869B9C06B9A5 |
| work/qrh-blueprint/rh_domain_cost_metadata_20261111.py | 666EAB12F4D630CB754A1ED8A89CBA8753094CA27C3B956B843CB0A4F41704F7 |
| work/qrh-blueprint/rh_domain_cost_metadata_20261111.json | 737CD40E56EBA16A2DE903AFBB74CC1FFD6B3FD5DC4CB13413425715FD58DE98 |

I read all three files. I did not import or execute the author script. A separate Python calculation used prime-power multiplicativity, independent piecewise height formulas and independent integer-directed sums. It exited zero with `PASS_MULTIPLICATIVE_METADATA_RECOUNT` and33 grouped assertions. All three author hashes were checked again afterward and were unchanged. No L-function, zero, character value, ladder prime candidate, analytic numerical function or Lean evaluator was run. Factoring the finite conductor indices for this metadata calculation is not a search for certificate primes.

## Domain fidelity

The declared domain is odd c<=300000 and even c<=400000, with height1e8/c in the odd case and max(1e8/c,200+7.5e7/c) in the even case. The smaller original-analysis domain is odd c<=150000 and even c<=300000 at those same heights. Only primitive characters count. There are no primitive characters at c=2 modulo4, so the independent implementation directly restricted even indices to multiples of four rather than trusting a zero supplied by the author's inversion.

The sufficient-domain argument is supplied by the now-completed companion report `ORIGINAL_RH_CONSUMER_DOMAIN_RESEARCH_2026-11-11.md`, SHA256 `AC14194BAB999170E7444DD0EDAA0285A3758942681AB44E4E2047CF8A87D48C`. In particular:

- the retained odd/even conductor bounds follow from actual arc modulus geometry and conductor divisibility;
- the current base-gap helper forgets parity, so its witness must be strengthened locally before the restricted input is usable;
- generic Cor713 and the public `Fact PlattGRH` interface still have broader binders;
- original principal psi/E1/Mertens uses keep RH to1e8; large auxiliary H2/Gamma cutoffs are not additional RH heights;
- the target's finite prime-gap coverage uses the checked ladder and binary Goldbach, not a new RH height.

The author's pending-report sentences were accurate when it froze. They are now historical status, superseded by that completed source report. They do not invalidate the immutable numerical packet. For citation precision, the high-even Thm714 branch is at661-671, beyond the abbreviated568-649 range quoted in the author note.

For the selected QRH strip profile, let qt(c)=2c for odd c and c otherwise. At c<=100000 the root code uses

`200 + max(1000, ceil(844800000/(7*qt(c))))`, capped by1e8/c.

The selected profile writes the equivalent expression with the ceiling outside `200+max(1000,...)`. These agree exactly because200 and1000 are integers and ceiling is monotone. The independent implementation used a single integer ceiling of the whole rational expression, then took the cap. Above100000 it used5e7/c for odd c and9.9e7/c for even c. The c=1 row is consequently60343058 in this profile, whereas both original-analysis profiles retain100000000.

The profile retains its separate RH1500/count/moment work and the global QRH provider. Those are not silently represented by the height-sum statistic. Likewise, the labels here quantify over every primitive character, with no asserted savings from inverse/conjugate sharing.

## Independent primitive-character count

Write A(n) for the number of primitive complex Dirichlet characters of conductor n. Unique induction from the conductor gives

`phi(n) = sum_{d|n} A(d)`.

Since phi and the Möbius function are multiplicative, A=phi*mu is multiplicative. Directly on prime powers:

`A(1)=1`,

`A(p)=p-2`,

`A(p^e)=p^(e-2)*(p-1)^2` for e>=2.

This follows by subtracting phi(p^(e-1)) from phi(p^e), and also accounts for A(2)=0. The independent calculation built a least-factor array through400000. For each n it extracted the full smallest-prime power p^e and set `A(n)=A(n/p^e)*A(p^e)`. It never constructed phi by divisor inversion and never called the root's inversion routine.

| Domain | Nonempty conductor indices | Odd-character labels | Even-character labels | All primitive labels |
|---|---:|---:|---:|---:|
| Declared original | 250000 | 14783008063 | 3285144543 | 18068152606 |
| Consumed original candidate | 150000 | 3695775215 | 1847864973 | 5543640188 |
| Selected QRH strips | 150000 | 3695775215 | 1847864973 | 5543640188 |

Every entry matches the author's saved JSON. The last two domains have the same character support; they differ in permitted real part and height.

## Directed sums and ratio checks

The statistic is the positive-height measure

`V = sum_c A(c)*H(c)`.

For exact H(c)=u/v and a positive integer scale S, the independent checker added `floor(S*A(c)*u/v)` for the lower endpoint and the corresponding ceiling for the upper endpoint. Termwise inequalities remain valid on summation. Zero remainders add no artificial upper unit.

The separate implementation reconstructed both the root's S=10^6 endpoints and finer S=10^9 endpoints. All six root endpoints matched exactly, not just within overlapping intervals. The finer intervals are contained in the root intervals:

| Domain | Lower numerator at denominator10^9 | Upper numerator at denominator10^9 |
|---|---:|---:|
| Declared original | 11808455664209070159015 | 11808455664209070408897 |
| Consumed original candidate | 6285356689342937568257 | 6285356689342937718151 |
| Selected QRH strips | 4559691844047240175984 | 4559691844047240284136 |

All endpoints and sums are positive. Thus for numerator domain X and denominator domain Y the directed ratio is `[lo(X)/hi(Y), hi(X)/lo(Y)]`. Independent exact cross-multiplications give

`532275/10^6 <= 6285356689342937568257/11808455664209070408897`

and

`6285356689342937718151/11808455664209070159015 <= 532276/10^6`.

For the QRH-to-smaller-original comparison they give

`725446/10^6 <= 4559691844047240175984/6285356689342937718151`

and

`4559691844047240284136/6285356689342937568257 <= 725447/10^6`.

The checker also reconstructed both saved coarse ratio fractions, both ppm endpoints, and the label ratios `2771820094/9034076303` and1. Those agree exactly. The prose's approximately46.8% and27.5% reductions are correct rounded descriptions of1 minus these V ratios.

## Reproduction algorithm

This is the complete essential independent recurrence and sum rule; the executed check additionally compared every displayed field with the immutable JSON and checked its hashes. `S` was each of10^6 and10^9. There is no floating-point arithmetic.

```python
N = 400000
spf = list(range(N + 1))
for p in range(2, isqrt(N) + 1):
    if spf[p] == p:
        for n in range(p*p, N + 1, p):
            if spf[n] == n:
                spf[n] = p
A = [0] * (N + 1)
A[1] = 1
for n in range(2, N + 1):
    p, m, e = spf[n], n, 0
    while m % p == 0:
        m //= p
        e += 1
    A[n] = A[m] * (p-2 if e == 1 else p**(e-2)*(p-1)**2)

# For each domain, restrict c to its odd bound or its divisible-by-four bound.
# For either original domain:
u = 100000000 if c % 2 or c <= 125000 else 200*c + 75000000
v = c
# Instead, for the selected QRH domain:
if c > 100000:
    u = 50000000 if c % 2 else 99000000
else:
    d = 7*c*(2 if c % 2 else 1)
    k = (200*d + max(1000*d, 844800000) + d-1) // d
    u = min(k*c, 100000000)
v = c
# Apply to the chosen domain's u,v:
q, r = divmod(S*A[c]*u, v)
lo += q
hi += q + (r != 0)
```

The piecewise original-height formula follows from `200*c+75000000 <= 100000000` exactly when c<=125000. The metadata caps are therefore checked at the correct closed boundary.

## Accepted meaning and remaining work

The report correctly argues for using the restricted original-analysis route as the comparison baseline. It does not establish that this route has the shortest runtime or smallest proof. In particular V is not a count of zeros: zero density has conductor/height-dependent logarithmic terms, and a proof must pay for complete counting, arithmetic precision, function evaluation, shared transforms, exceptional cases and final checker verification. A location certificate on the line and an exclusion certificate for a wider strip have different work profiles. A smaller V alone cannot decide which wins.

No certificate-generation cost, Lean/MM0 ratio, or end-to-end speedup follows from the two verified intervals. The author's separation of metadata, source-domain sufficiency, formal refactoring, and eventual certified computation is accurate. Subsequent work should now compare concrete arithmetic certificate batches on the accepted domains rather than repeat this metadata audit.
