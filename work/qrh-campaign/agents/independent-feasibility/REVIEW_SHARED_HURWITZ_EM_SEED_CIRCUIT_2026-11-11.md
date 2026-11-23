# Review of the shared unscaled Hurwitz EM seed circuit

2026-11-11. PASS at paper, source-interface and exact scalar/count scope. No mathematical correction is required. This is a complete candidate formula and error allocation, not an implemented evaluator, a proof of cheap seed generation, or a spectral certificate. The scaled-jet follow-up is separate.

Author: `integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md`, SHA256 `1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E`. I verified its hash and four input pins, read the full report, independently derived its normalizations, and checked the exact tables. No source or frozen artifact was changed; no analytic values or builds were computed.

## EM formula and uniform remainder

The cited Hurwitz derivative identity applies in the positive-real argument half-plane away from its exceptional s values. All s+k=1/2+k+it here avoid zero and one. The finite head shift and EM representation are consistent with DLMF25.11.4 and25.11.7. The latter displays an odd-periodic-Bernoulli remainder; integration by parts gives the author's even-order form. At the lower integer endpoint the odd Bernoulli function vanishes, and the upper boundary vanishes by the stated decay. These sources support the identity, not the particular numerical allocation below. [DLMF derivative](https://dlmf.nist.gov/25.11.E17), [finite shift](https://dlmf.nist.gov/25.11.E4), [EM representation](https://dlmf.nist.gov/25.11.E7).

For w=s+k, b=N+1+alpha>0 and m>=1, Re(w)+2m>1 ensures absolute convergence of the even-order remainder. The complex power uses the real logarithm of b+u. The denominator |s+k-1| is at least1/2, including t=0. No removable pole convention or critical-line series interchange is needed.

Multiplication by the normalized alpha prefactor joins the rising products exactly:

    (s)_k*(s+k)_(2m)=(s)_(k+2m).

It retains the divisor k!. Integrating the absolute power of b+u then gives

    4 sqrt(b)/(k+2m-1/2) * (W/b)^k/k! * (W/(6b))^(2m).

For P<=32, k<P, W=V+32+2m and N=ceil(W/3), all factors are covered by W. The inequalities W/b<=3, b<=N+2, 3^k/k!<27 and k+2m-1/2>=2m-1/2 give the author's bound. It holds for every alpha in[0,1] and both signs of t, not just mesh endpoints. The Bernoulli Fourier estimate supplies the absolute constant; I also independently regenerated all64 signed rational correction factors and checked |6^(2r)B_(2r)/(2r)!|<4.

For m64, the five cutoffs220,387,720,1720,3387 and both stated remainder weakenings are correct. The rational weakening is already below2^-116 and hence eta/16 at eta=2^-100. For arbitrary eta the proposed scalar search terminates because N grows linearly in m while4^-m decays. The fixed table alone is not an arbitrary-accuracy evaluator.

## Finite head and endpoint identities

One base value B_x=x^(-s) and repeated multiplication by1/x supply the entire head jet at x. The exact prefactors r_k are shared per height. Their bound A=binom(V+P-1,P-1) follows from |s+j|<=V+j+1 and monotonicity of the resulting binomial product in k. Rounded term propagation is contractive because x>=1; exact grid accumulation avoids multiplying all term denominators together.

For the endpoint, I checked every power of6 and b in the change of variables. With E_l=(s)_l/(6b)^l and lambda_k=(-1)^k6^k/k!, the r-th correction in (lambda_k/6)gamma_r E_(k+2r-1) is precisely the original normalized EM correction. The pole term and half endpoint also match. The largest correction index is P+2m-2 and the recurrence reaches it; the remainder has a different rising-product length.

The E recurrence factor has norm at most1/2. Also |lambda_k|<729 and |lambda_k E_k|<27. The complete correction sum has magnitude at most (4/9)*27; its half endpoint contributes at most27/2. Together they are below27, while the pole term is at most54b. This proves the useful bound |F_k|<=27(2b+1) without postponing a large cancellation until final multiplication.

## Absolute error allocation

The head error is at most N*A*delta + N*A*(P-1)*u_D + u_out, bounded by3eta/32. This assumes the initial B_x center is on the term grid and its supplied ball includes all leaf and initial-rounding errors, as required by the author.

Each E error is at most2u_C. A gamma product therefore has error at most9u_C. Summing64 terms and multiplying by |lambda_k|/6 gives69984u_C. The pole and half components contribute2916b*u_C and729u_C, and their three final roundings add3u_C. The displayed total is below2^24u_C for every band.

For B_b*F_k, use the true F bound for the base error and |Bhat_b|<2 for the F error. This gives eta/32+eta/128+eta/32 including final rounding. Adding the head, the final head-plus-endpoint rounding and the remainder allowance gives at most33eta/128<eta. The proof accounts for the error cross term through |Bhat_b|<2. Each radius is a complex norm bound, not an unconverted coordinate halfwidth.

All rational factors remain exact proof obligations. The allocation does not license unchecked Bernoulli data, divisions, powers or recurrences. The reported P28 requirements383 base-error bits and388 head-grid bits are correct sufficient fractional thresholds from these bounds; they are neither relative mantissa widths nor the cost of proving the elementary leaves.

## Shared arguments, time recurrence and costs

At one height the base arguments form the full rational grid from1 throughN+2 with denominator D, giving (N+1)D+1 distinct arguments. Adjacent anchor heads and endpoints share grid values exactly. The five grids are nested because their denominators divide later denominators and N increases. Their final union sizes27754497 and55508993 are correct. No equality of approximate arguments or rounded logs is used.

The optional time recurrence uses one certified unit step per argument and starts at that argument's actual first active height. With the author's initialization and step/update errors, its displayed bound is below3delta/4 and hence below delta. The update cap128000 covers the nominal grid. The approximately21 extra fractional bits price the step contract, not free reuse. New phases, exact rational first heights, tighter late-band precision, persistent states and I/O all remain charged.

My independent table reconstruction matches all six operation categories for original P24, independent fine P20, shifted P27 and shifted P28. It preserves the special right endpoint's P20 arithmetic in shifted schemes. The omitted O(P) assemblies, shared r_k construction, rational-factor proofs, leaf certificates, rounding witnesses, and storage are explicitly additional work. The optional time method replaces per-pair cis work with per-argument phase certificates and per-update products; those are different categories, not interchangeable unit-cost operations.

The baseline therefore supplies meaningful circuit counts and a complete sufficient seed-error contract. It establishes no end-to-end winner. In particular, shifted P28 reduces independent fine-grid work but raises the unscaled precision burden, and the later character-transform width bounds do not bound these earlier seed intermediates.

## Owned exact checks

`review_shared_hurwitz_em_20261111.py` SHA256 `DB49A60E27FABB36338A8B62C48A4D04EDC3C08C689BBEAF004DC922A0FE8F47`.

`review_shared_hurwitz_em_20261111.json` SHA256 `F611ED993A99760532B428BF47635B46C75650317DCD8C3EE5D642BE10543F9C`.

The single run passed2378 exact finite checks, including regenerated Bernoulli factors, normalization exponents, remainder/rounding bounds, precision thresholds and operation totals. It imported no producer implementation and computed no Hurwitz, logarithmic, exponential, trigonometric or spectral values. Actual coefficients and an ordinary-rule checker for this circuit remain to be produced and validated.
