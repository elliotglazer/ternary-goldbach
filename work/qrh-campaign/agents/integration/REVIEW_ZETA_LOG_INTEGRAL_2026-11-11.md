# Independent review of the zeta-log integral upper bound

2026-11-11. Verdict: PASS for the analytic reduction and external elementary interval evidence. The bound

```
integral from 5/4 to infinity of log(zeta(s)) ds < 1.184
```

follows from the reviewed paper argument and the accepted Arb computations. This review does not establish a Lean theorem or the horizontal Turing theorem that consumes this scalar. There was no Lean build, spectral scan, dependency change, or mutation of any producer file.

## Exact packet and independent replay

The producer files are in `work/qrh-blueprint/turing-scalars/` and were hash-checked before and after the replay.

| File | SHA256 |
| --- | --- |
| `ZETA_LOG_INTEGRAL_2026-11-11.md` | `66DCFC80712A8773682D23F2121BB05A2494CEE1AD7EB7A975EEAED7B399852E` |
| `zeta_log_integral.py` | `5BB356E9FF112ADFF19919CD946F2C60D6D621F78B17AED50A4E4B5FBC803FAD` |
| `zeta_log_integral.json` | `687344FFD5E44B52059B848867AE09C316A827EEE8108E6342316C41D9B0B5BC` |

The reviewer-owned files beside this report are:

| File | SHA256 |
| --- | --- |
| `review_zeta_log_integral_20261111.py` | `2181F28966F197056D5E2530DF34B4C3EA841A26EBCF3E34F5B9F96F2AC4E408` |
| `review_zeta_log_integral_20261111.json` | `BFCE8994CA2FCE477310C4F0833134C62669920F9A26BD767F8F7C6AC8E21EFB` |

The existing `work/qrh-campaign/interval-env/Scripts/python.exe` runtime, with python-flint 0.9.0, ran the independent script with exit 0. The command, from the repository root, was:

```powershell
& 'work/qrh-campaign/interval-env/Scripts/python.exe' -X utf8 'work/qrh-campaign/agents/integration/review_zeta_log_integral_20261111.py'
```

The script does not execute the producer script. It reads its receipt, verifies all three producer hashes, and independently evaluates each endpoint power as exp(-s log n). It never calls builtin zeta, Gamma, numerical integration, or a prime table. Only the reviewer-owned receipt is written.

Two runs succeeded:

| Run | Cutoff B | Panels | Right endpoint | Precision | Total scalar upper-bound enclosure |
| --- | ---: | ---: | ---: | ---: | --- |
| Direct producer-grid replay | 64 | 2048 | 32 | 192 bits | `1.18349673917994498037700923829911872995366556748604831 +/- 4.32e-54` |
| Independent alternate grid | 96 | 3072 | 36 | 224 bits | `1.183467944755571107786459337747950930862987855689177931344164281 +/- 4.95e-64` |

The first run agrees with all 2049 producer endpoint intervals and with the producer's trapezoid, tail, and total intervals. The second changes all four numerical parameters and avoids the producer's recurrent power update. Its exact grid step is 139/12288. Its tail bound is `2.21936317031386699495559413572565490632658476341168527404127559593e-11 +/- 2.75e-77`.

Both runs use strict Arb comparisons against the exact rational 5918/5000, and then 148/125. The alternate run leaves a margin greater than 0.00013205 below 1.1836. These enclosures describe the constructed upper-bound scalar, not a two-sided enclosure of the actual integral. All endpoint enclosures are retained in the independent receipt.

## Convexity and the direction of quadrature

For real s>1, the positive absolutely convergent series for zeta gives zeta(s)>1. There is no complex logarithm branch choice in log(zeta(s)). On every compact subinterval of this half-line, choose sigma0>1 below the interval. The functions `(log n)^j n^(-sigma0)` are summable for j=0,1,2, by bounding the logarithmic factors by a sufficiently small positive power of n. This justifies both differentiations locally and makes all moment sums finite.

Writing p_n=n^(-s)/zeta(s), the probabilities sum to one and

```
(log zeta)'' = sum p_n (log n)^2 - (sum p_n log n)^2 >= 0.
```

Weighted Cauchy-Schwarz applies because the second moment is finite. Thus the claimed convexity holds for actual log zeta. On each panel [a,b], convexity bounds the function by its endpoint chord. Integration gives the upper bound `(b-a)(f(a)+f(b))/2`. The panel endpoints cover the full finite interval exactly, with no overlap error or missing endpoint contribution.

Replacing f at the endpoints by any larger log U_B is valid because the trapezoid weights are positive. The argument does not need log U_B to be convex. Confusing these two convexity claims would be a gap, but neither the note nor the acceptance script does so.

## Euler-Maclaurin remainder

For f(x)=x^(-s), the integer-cutoff Euler-Maclaurin identity gives the sum over 1<=n<B, the integral from B to infinity, f(B)/2, and the correction `-B_2 f'(B)/2!`. Since f'(B)=-s B^(-s-1), the correction is positive and equals `s B^(-s-1)/12`.

On a unit interval the periodized Bernoulli polynomial is `r^2-r+1/6`. Its maximum is 1/6 at the endpoints and its minimum is -1/12 at r=1/2. Hence its absolute value is at most 1/6. The remainder after the B2 correction has magnitude at most

```
(1/2)*(1/6)*s*(s+1)*integral_B^infinity x^(-s-2) dx
  = (s/12)*B^(-s-1).
```

All derivatives and improper integrals here converge for s>1; the finite-endpoint terms vanish when the upper endpoint tends to infinity. The remainder's sign is immaterial. Adding its full absolute bound to the displayed positive B2 correction gives precisely the author's coefficient s/(6B):

```
zeta(s) <= sum_(1<=n<B) n^(-s)
           + B^(-s)*(B/(s-1) + 1/2 + s/(6*B)).
```

The script's split at B is consistent: `values[:-1]` includes 1 through B-1, while the last value is B^(-s). There is no missing or duplicated n=B term. The independent script keeps the integral tail, half endpoint, correction, and remainder majorant as separate expressions before summing, and reaches the same endpoint values.

## Infinite tail

For s>1, log zeta(s)<=zeta(s)-1. Monotonicity of x^(-s) gives

```
sum_(n>=3) n^(-s) <= integral_2^infinity x^(-s) dx.
```

Consequently `log zeta(s)<=2^(-s)*(1+2/(s-1))`. For s>=R>1, replace the second factor by `1+2/(R-1)` and integrate 2^(-s) exactly. The tail is at most

```
2^(-R)/log(2) * (1+2/(R-1)).
```

This proves convergence of the original improper integral and supplies the correct tails for R=32 and the independent R=36. Since log zeta is positive and continuous on the finite interval, there is no further improper endpoint issue at 5/4.

## Interval arithmetic and acceptance limits

The producer grid starts at exact 5/4, ends at exact 32, and has exact step 123/8192. Initial powers and recurrent multipliers are elementary Arb enclosures. Multiplication preserves containment inductively, so repeated multiplication does not assume exact real arithmetic. All endpoints remain above 1, making the logarithm valid. The producer includes the first and last endpoint with weight one and all interior endpoints with weight two, then multiplies by half the step.

The independent runs use direct endpoint exponentials and exact rational construction of each grid point. This reduces shared implementation risk while retaining the same trusted Arb arithmetic and elementary exp/log primitives. Interval overlap is only a consistency check on the producer receipt; the independent strict rational comparison is what establishes the alternate external certificate. No timing or decimal approximation is an acceptance premise.

No substantive correction is required. The reviewed result supplies the scalar J<1.184 within paper/external-evidence scope. Formal identification of real zeta with its positive series, log convexity, the Euler-Maclaurin specialization, integration of the panel inequalities, the tail estimate, and replay through a proved interval checker all remain open. The horizontal-log bound and its other analytic inputs require their separate reviews. This scalar computation does not close those obligations or introduce an allowed assumption into the Goldbach theorem.
