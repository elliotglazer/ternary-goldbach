# Independent review of the conductor-101 right slab

2026-11-11. **PASS as a bounded external interval and argument-principle certificate.** The actual uncompleted L-function of the single character chi_1 specified below is nonzero on and inside

    [111/200,2] + i[7999/8,8001/8].

This conclusion uses the reviewed analytic enclosure formulas and the external interval-arithmetic contract. It is not a Lean theorem, an initial-height certificate, a result for any other character, or full-family spectral evidence. No canonical or frozen file was changed, and no Lean build or full scan was run.

## Frozen inputs and bounded independent run

Reviewed producer files under `agents/zero-sum/`:

| File | SHA256 |
|---|---|
| `C101_RIGHT_SLAB_CERTIFICATE_2026-11-11.md` | `37B695DE90964AF2C1C1AC43F3884C13C320B800E703A0637F482D7A0F111020` |
| `c101_right_slab_20261111.py` | `8CCFDD54A75E0A71B88959EA8B2DC762DB46D630B47CABE31E3526570D4C9B9F` |
| `c101_right_slab_20261111.json` | `FA01A922E0BDDDF2104A268938AE6C76323D51DA2B48536B17708BC6D7A3ADC2` |

The producer reads only the definition/table prefix of the prior evaluator `c101_cauchy_alpha_block_20261111.py`, SHA256 `FD75DAC17AF6735E9A5AE72E5A47096592609D2371CD5A65643B544F5B8F4E11`. Its original all-character run is not executed. I inspected that prefix and its stopping point. It contains no built-in L-function, zeta, Hurwitz evaluator, or zero oracle.

The predecessor analytic/evaluator review is `moebius/C101_CAUCHY_ALPHA_REVIEW_2026-11-11.md`, SHA256 `A27762CDE69D0E903A515487F4192F4B48AAD25F508EBE80E128A0C5FC8A2B4E`. That review covered the left vertical segment; it is not used as a substitute for the three new sides here.

The new independent checker is `moebius/c101_right_slab_review_20261111.py`, SHA256 `DF5E246DCDE52D95C7DAAAE907ED7F028CE4DEA570D07FF417A0DD2E49A1A7EC`. Its receipt `c101_right_slab_review_20261111.json` has SHA256 `B49C00BEC68DFFCD5B81CAD6426A0DB186A9D5AE9ECEDFEB37742FD3EDE84E9E`.

The independent run used the existing python-flint environment and took 61.46012 seconds internally, below the ten-minute computation limit. It did not regenerate the author's six models. Instead it independently rebuilt six models with a different evaluator and checked **every** original whole-panel witness, as well as the exact contour geometry and a rotated winding computation. All input hashes were checked before and after the run and remained unchanged.

| Quantity | Independent result |
|---|---:|
| Actual character label | 1 |
| Exact character multiplication checks | 10,000 |
| Alternate Cauchy models | 6 |
| Samples per alternate model | 48 |
| Original boundary panels checked | 16 |
| Panels needing further subdivision | 0 |
| Accepted alternate leaves | 16 |
| Rotated-ray winding | 0 |
| Minimum positive coordinate lower bound, diagnostic | about 0.02948719349 |

The margin and timings are diagnostics. Acceptance uses strict interval inequalities, exact rational geometry, and integer crossings. No interval-overlap comparison is used as the proof of correctness.

## Exact character and actual entire function

The label was fixed before the producer's evaluations:

    chi_1(2^j mod 101)=exp(2*pi*i*j/100), j=0,...,99,
    chi_1(0)=0.

I independently checked trial divisibility of 101 through 10, that its 100 generator powers enumerate all nonzero residues exactly once, and the discrete-log multiplication identity on all 10,000 pairs of units. Thus these values define the stated multiplicative character. It is nonprincipal because the value at generator 2 is not 1. Since 101 is prime, the only possible smaller inducing conductor is 1, so it is primitive. Its value at −1 is −1 because 2^50=−1; it is odd. It is nonreal, and its conjugate is label 99, not label 1.

The function checked is **L(s,chi_1)**, with no Gamma factor, root phase, or s−1 multiplier. In the half-plane of absolute convergence it equals

    101^(−s) * sum_(a=1)^100 chi_1(a)*HurwitzZeta(s,a/101).

The common Hurwitz pole cancels because the character sum is zero. The author's deflated version subtracts the same 1/(s−1) from each term, so the same identity holds initially there. Analytic continuation identifies this nonprincipal sum with the actual source L-function. The independent evaluator uses the raw Hurwitz pole terms instead; all its sample points have imaginary part close to 1000, so no division near s=1 occurs.

This does not identify an individual ordinary deflated Hurwitz value at s=1 with Mathlib's different totalization convention. The source-faithful adapter is the entire nonprincipal combination, equivalently a sum of Hurwitz differences. The rectangle does not meet s=1 in any event.

Pinned `Mathlib/NumberTheory/LSeries/DirichletContinuation.lean:74` provides agreement with the L-series where Re(s)>1. Its `differentiable_LFunction` at line 97 proves the nonprincipal L-function is entire. These source declarations were read during the review. The interval evaluator's correspondence to those declarations is a reviewed mathematical bridge, not a compiled Lean result.

## Author model domains and retained error bounds

The six centers have real parts

    c_j=111/200+(j+1/2)*289/1200, j=0,...,5,

and imaginary part 1000. They are fixed geometrically, not selected from numerical values. The author's outer radius, sampling radius and target radius are respectively 1/2, 1/4 and 1/5. The first center is 1621/2400, so the least possible outer real part is 421/2400, and the least sampling real part is 1021/2400.

Both bounds are stronger than the conservative floors used by the code: outer floor 11/200 and sampling floor 61/200. The original EM error formula with sampling floor 61/200 therefore remains valid, including its shifted floor 61/200+k for alpha coefficient index k. All actual sample points have modulus less than 1002: each center has modulus less than 1001 and the sample radius is 1/4. Thus the retained alpha remainder with numerator product_(j=0)^31(1002+j) is also valid on the new samples.

The author uses EM N=512,M=40 and a 16-cell, 32-coefficient alpha construction at 160 bits. Every scalar coefficient includes its EM error; the alpha remainder is added before the character sum and the conductor factor. The whole-sample uncertainty remains in the discrete Cauchy coefficients. The current domain checks justify reuse of these formulas; they do not merely rely on success of the prior vertical-line experiment.

I reread `TernaryGoldbach/Explicit/LGrowth.lean:179`, `norm_LFunction_le`. For a nonprincipal character and Re(s)>0 it gives

    |L(s,chi)| <= (q+1)*|s|/Re(s),

without a spectral premise. On every outer disk, |s|<1003 and Re(s)>11/200. Therefore the author's M=2,000,000 is a valid bound on **actual L**. It is not a bound asserted for the finite EM approximation.

The exact geometry test

    (289/2400)^2+(1/8)^2 < (1/5)^2

places every horizontal piece and both vertical sides within their selected target disks. Convexity ensures that checking a segment's endpoints suffices for this geometric inclusion. Rounded interval boxes may extend slightly outside a disk, but the analytic error is claimed for actual segment points only; arithmetic over the larger box still encloses their polynomial values.

The author's discrete Cauchy error uses the accepted formula

    M/(1−r/R)*[(r/R)^m+(rho/R)^m/(1−(rho/R)^m)]

with m=64. I recomputed its exact rational value from the receipt and checked it is below 2*10^(−13). Both the Taylor tail and coefficient alias are included.

## Independent evaluator and all-panel acceptance

The alternative computation changes all of the following:

- It uses 192-bit ball arithmetic, direct Hurwitz EM with N=768,M=48, and no alpha grid.
- It sums residues in natural numerical order, using the independently checked discrete-log permutation for chi_1.
- It uses trigonometric root enclosures instead of the author's complex-exponential root enclosures.
- It uses 48 sample points and coefficients per Cauchy model rather than 64.
- It uses the actual stronger sampling floor 1021/2400 and a newly derived actual-L growth bound M=600,000.

The stronger growth bound follows from

    102*1003/(421/2400) < 600000.

This is valid on all six complete outer disks. The new analytic Cauchy error is the exact rational

    45475749209126594475670270785667904
    /12799999999999954525264911353588104248046875,

which is less than 3.6*10^(−9). Its larger value, compared with the author's remainder, is fully included in every alternative panel enclosure.

For each positive rational alpha=a/101, the direct EM formula includes terms through B_96, with the full rising factorial and the remainder

    4*|(s)_96|*(768+alpha)^(1−sigma_floor−96)
      /[6^96*(sigma_floor+95)].

The underlying bound is the reviewed Bernoulli Fourier estimate followed by the absolutely convergent improper remainder integral. The floor is positive and all denominators are positive. The rising factorial is enclosed at the whole sample ball. All logarithms in the finite sum have positive real bases. The source identity for raw Hurwitz terms is analytically continued, not obtained by summing a divergent critical-strip Dirichlet series.

Each alternate sample ball therefore encloses the actual L-value. Finite root sums enclose the actual discrete Cauchy coefficients. Horner evaluation on each whole segment, plus the alternate analytic remainder square, encloses every actual L-value on that segment. The recorded original coordinate/sign witness was strictly positive for all 16 alternate enclosures. No extra subdivision was needed and no unresolved panel remains.

The checker also repeats the interval-constructor probes that ensure midpoint uncertainty and an uncertain radius are retained by the installed arithmetic API. These bounded probes do not formally verify FLINT itself. Both calculations rely on its outward ball-arithmetic contract and on the reviewed classical EM/Cauchy mathematics; they are not independent kernel implementations.

## Complete boundary, homotopy, and winding multiplicities

The exact geometry check starts at the lower-left corner and verifies bottom/right/top/left order, nonempty panel direction, adjacency and closure. The four summed edge lengths are exactly

    289/200, 1/4, 289/200, 1/4.

This checks all four complete sides, not just total perimeter. Every model index is in range, and every panel endpoint lies in the corresponding target disk.

Adjacent panels share exactly the same rational image vertex, including final closure. For each panel, both vertices and every actual image point are in its strict recorded half-plane. Since that half-plane is convex, linear interpolation between the actual image and the polygon segment stays away from zero. At a shared endpoint, both neighboring interpolations use the same actual value and the same rational vertex, so the homotopies agree. This produces a closed homotopy in C minus {0}.

The rational image vertices need not be exact L-values. Their membership in both relevant half-planes and shared identity are sufficient; midpoint overlap is not a substitute for those checks.

Independently of the producer's positive-real-ray crossing calculation, I applied the orientation-preserving linear map

    (x,y) -> (3*x+4*y, −4*x+3*y),

whose determinant is 25, and used half-open crossing rules with exact rational determinants. There were zero positive and zero negative crossings of the rotated ray, hence winding zero. The strict half-plane checks exclude any polygon segment through the origin, including degenerate crossing cases.

The actual L-function is entire and nonzero on the boundary. By the argument principle, its interior zero count, with analytic multiplicity, equals this winding. There is no pole subtraction and no simplicity assumption. Every zero multiplicity is positive, so the zero count 0 excludes all interior zeros; the whole-panel checks exclude boundary zeros as well. This proves the stated **closed** slab result at the external mathematical-certificate level.

## Scope and reproduction

No correction to the frozen producer is required. This is a genuine full-rectangle extension for one previously fixed character. It does not cover label 99, the negative-ordinate channel, heights below 999.875 or above 1000.125, an initial interval through Hcert, or the other 98 characters. It is not a general-conductor performance estimate.

The analytic adapters, character-to-source identification, interval primitives, and polygon/argument-principle checker still require Lean implementation. No final spectral assumption has been introduced in their place.

The independent check can be repeated without altering the producer files:

    work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/moebius/c101_right_slab_review_20261111.py 37B695DE90964AF2C1C1AC43F3884C13C320B800E703A0637F482D7A0F111020 8CCFDD54A75E0A71B88959EA8B2DC762DB46D630B47CABE31E3526570D4C9B9F FA01A922E0BDDDF2104A268938AE6C76323D51DA2B48536B17708BC6D7A3ADC2

The script writes only its owned receipt, and imposes a 570-second internal deadline. A failure or unresolved panel does not produce a PASS receipt.
