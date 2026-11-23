# Independent paper preflight of the conductor-eight tensor pilot

2026-11-11. **PASS on the revised specification, before implementation or execution.** The mathematical parameters and error bounds are consistent. Two acceptance-policy repairs were required and incorporated: independent full containment rather than overlap-only comparison, and an unambiguous fixed-attempt resource policy with mandatory telemetry. No code, numerical scalar script, function value, moment, FFT, model, contour or Lean build was run for this review.

## Frozen version and accepted inputs

Reviewed `zero-sum/NONPRINCIPAL_TENSOR_PILOT_DESIGN_2026-11-11.md`, SHA256 `3B4B21946F89CA503F03A2BBC030B73F556B31254BA643C427AFB1B39CA5A43B`. This supersedes the initially reviewed `06109CC07C361FEE7B2F73CB23968D6E3E7D682ACBC73B13E1D616D7AA9881F3`.

The main analytic dependencies are the finite-EM character/height adapter `17D6A2E7478E3C03D8B9406C01A5AD93D4277E33B09009B6550D02357DE54BEC` and its source review `9E6004112BFBD8F565FBD2A6871B2E9C123751B5F35C9DEEFE631F7997EAAD64`; the corrected pole-difference jet plan `3F73AF600725DDB51ED622577BF374251B38C408D0D52D4EA06CFCF1BDD60011` and its review `39D7D84D0706FE27A7DEF211684FA1DCA4D9E3544AB1A496AE435DDF4E04F577`; the uniform finite-U scalar budget `9D2AEE85DB76673ACE63D17057B1B2B3BEAEC925F9A38A9980171696FF4EC233` and its review `2D8AA8B58F64AC7DCF82887F6EECAF973F06EC0DD12EC68592F9DD243314C7CF`; and the unit-group transform plan `DFA02789B3025A997F98E0500B001B3C5A7D983C400EEDC8F7B6DD4ADDAE4866`, reviewed at `222346A598FB72100005E065A6BFA77DCDE91B8B8F9F068847BE9DCBA0FB558D`. I read the relevant statements and verified these pins. Their paper/source status is not upgraded to a kernel proof here.

## Characters, centers and actual functions

The coordinates `(-1)^e*5^f mod8`, indexed with f fastest, give exactly units (1,5,7,3). Since (-1)^2=5^2=1 and the four images are distinct, this is the required C2 x C2 group, not a cyclic group of order four. The rows are independently reconstructed as

| Label | Values in that unit order | Status |
|---|---|---|
| 00 | 1,1,1,1 | Principal, conductor 1, excluded from actual-L outputs |
| 01 | 1,-1,1,-1 | Primitive conductor 8, even |
| 10 | 1,1,-1,-1 | Nonprincipal conductor 4 induced to level 8, odd |
| 11 | 1,-1,-1,1 | Primitive conductor 8, odd |

The kernel of reduction to units modulo 4 is {1,5}. A row is nontrivial on that kernel exactly when its second label is 1, proving the primitive criterion. Row 10 descends to the nontrivial character modulo 4 and cannot descend to modulus 2, whose unit group is trivial. Parity is evaluation at -1=7, hence the first label. All rows are real and self-inverse. This tests noncyclic indexing and primitive filtering but not genuinely complex character values.

The three centers are precisely 1+i/8, 1, 1-i/8. Each target disk has radius 1/16; the vertical diameters meet at +/-i/16 and end at +/-3i/16 relative to 1. There are nine nonprincipal character/center models, with 270 normalized complex-s jet coefficients. Height differentiation would introduce extra powers of i and is not the requested convention.

The 148 head bases 8nu+a, nu=0,...,36, are distinct and lie between 1 and 295. Endpoint bases are 297,301,303,299 in unit order. The correction factors `8^(2m-1)*X_a^(1-s-2m)` are exactly `X_a^(-s)/(37+a/8)^(2m-1)`. All sixteen corrections and the normalized rising-factorial products are retained. No second factor 8^(-s), no multiplication by s-1 and no division by s-1 is permitted.

At s=1, the entire pole difference has value -d_a/8 and the full normalized derivatives from the reviewed moment formula. The reference residue a=1 has identically zero pole-difference jets: three centers times thirty orders gives ninety exact zeros. Nonreference jets at s=1 are not set to zero. These branches use exact input identities. The actual source identification is continuation of the nonprincipal combination; it does not substitute an ordinary individual Hurwitz finite part for Mathlib's totalized value. The conductor-four row is valid because this continuation requires nonprincipality, not primitivity. The principal row may exist as a finite transform artifact but has no actual-L interpretation in this pilot, especially at 1.

## The two transforms and arithmetic

With Delta=-1/8 and L=16, the bin argument is exactly -log(n)/pi. Full signed integer labels are required inside the residual, while only their residues index the array. The accepted midpoint rule bounds |r_n|<1 with J=3. The identity

`j*Delta*log n = 2*pi*j*q_n/16 + (j/3)*r_n`

requires the negative time output labels 0,15,14 of the normalized positive time transform. The character kernel remains positive. The normalized group transform contributes 1/4 and the time transform 1/16, so the final scale is exactly 64. No Gaussian scale, Gauss factor, root phase or parity half occurs. The nondyadic parameters 1/3 and 2/3 must be represented exactly or have their errors charged.

The proposed per-mode schedule performs 3840 length-16 time transforms and 2880 size-four group transforms. This agrees with vKp and KpJ. It avoids silently commuting rounded character transforms with a rounded residual contraction. The total normalized circuit error is measured against the exact transform of serialized moment centers; actual-moment input errors are counted separately.

With epsilon=2^-90, the 64 inputs and 32 residual modes give at most 2^-79 from input uncertainty, and another 2^-79 from normalized circuit error after scaling. Contraction contributes 2^-79, complete corrections 2^-79, and final assembly 2^-77. Their sum is at most 2^-76. The author's internal epsilon/4 proofs leave room for independent containment in published epsilon balls; this tighter requirement changes none of the upper budgets. It is a future acceptance obligation, not a prediction that 192-bit arithmetic succeeds.

## Pole moments and complete disk bounds

The symbolic exponential partial sum through order seven at 6 is 2101/7>297, so ell=log297<6. Consequently ell+1/37<7. The common moment-argument bound 2/37 is below 1/16. The normalized log-power weight is below exp(7)<3^7<2^12. Multiplying by the reviewed 9/2 prefactor and discarding the positive factorial denominator in the safe direction proves the fixed Q32 per-jet pole-moment tail below 2^-113. At s=1 that tail is zero. Its finite arithmetic is still separately required at 2^-85, yielding a complete P-jet error below 2^-84.

For each residue, the half block, complete sixteen-term Bernoulli block, complete P block and their addition each receive at most 2^-84. Their sum is at most 2^-82; the exact four-sign contraction and its additional 2^-80 arithmetic allowance give at most 2^-79 per character coefficient. The Bernoulli allowance is for the entire block, not each term. The P moment tail is already included here.

The uniform scalar rule applies with c=8,T=1,N=ceil(T)+36=37,M=16,K=30,R=1,rho=1/16. In particular, cT=8 satisfies its workload domain and the centers have real part 1. Its target is the full complex disk, not just a vertical diameter. Its outer factor inequality may be non-strict at T+33, as the accepted scalar review notes, but is still strict against N=37. The finite-U outer bound 2^42, actual-point EM bound below 2^-70 and Taylor tail below 2^-77 therefore apply. None is borrowed from principal zetaF, and there is no final s-1 quotient.

The revised per-order main residual bound is valid for all thirty orders: n^(-1)<=1 and `(log n)^h/h!<exp(6)<3^6`, so W_h<148*3^6=107892<2^17. For the factorial comparison, `16!=20922789888000>17592186044416=2^44`, while each of the eight pairs 17*32,18*31,...,24*25 is greater than 2^9. Thus 32!>2^116 and `2^17/32!<2^-99`, without evaluating an exponential. Combining that tail with the finite arithmetic bound 2^-76 gives midpoint error below 2^-75 for each exact normalized L_fin coefficient. Hence the canonical Euclidean balls of radius 2^-75 are justified conditionally on the arithmetic checks. These are 270 character coefficients, not 360 residue coefficients.

Those complete balls contribute at most `(16/15)*2^-75` on a target disk. Adding the allocated final polynomial arithmetic and the padded analytic EM/Taylor terms gives the stated bound below 2^-68. The former weighted main residual and the P tail must not be added again: both have already entered the full coefficient certificates. All norm conversions are explicit; a coordinate radius is not silently treated as a Euclidean radius. The scalar inequality bounds approximation error, not the variation or nonvanishing of the polynomial over the disk.

## Required repairs and the final independent gate

The initial version called direct reconstruction a consistency check. That was insufficient for the desired independent enclosure claim. The revision now requires:

* Full independent containment of every actual moment enclosure in its canonical epsilon ball, including exact zero and unused slots.
* A direct finite normalized tensor transform of exact serialized centers, with independent roots, and full containment of every consumed output. This verifies circuit claims separately from actual-input uncertainty.
* Direct unbatched finite-U jets and direct character sign sums, including independent P-moment tails, at all three centers. Every complete direct L_fin coefficient enclosure must lie in its published radius-2^-75 ball.
* A uniform full-disk check: coefficient-center differences plus direct radii are bounded by D_h<=2^-75, and `sum rho^h D_h+E_ind+Tay_ind+e_eval<2^-68`. This is an analytic polynomial-tube containment, not a sample-based test.
* Full containment at all eighteen endpoint incidence records, with exact shared input coordinates. Overlap, conjugation and realness checks remain auxiliary only.

These contracts are sufficient for an independent external model-validation experiment when implemented soundly. The underlying source identifications and analytic remainder proofs remain necessary; no collection of overlapping numerical boxes replaces them. The disks and endpoints may contain zeros. No winding or zero-exclusion status is permitted.

The revised cap is one 192-bit producer attempt, total 180 seconds from launch through serialization, and one separate 256-bit independent attempt with a total 300-second deadline. Both have 512 MiB peak-working-set and aggregate 64 MiB retained-output caps. There is no automatic precision ladder or retry. Mandatory OS peak telemetry, an external deadline supervisor and fail-closed handling of missing telemetry/overruns replace the earlier ambiguous “where available” wording. Worker subprocesses are forbidden, so the producer-tree metric reduces to the single evaluator process; any later implementation must bind the measurement and supervisor precisely. These are stop/acceptance policies, not proof of runtime feasibility or execution authorization.

## Size and verdict limits

I independently recounted 142080 head moment contributions, 61440 dense moment slots, 3840 time transforms, 2880 group transforms, 11520 per-mode tensor outputs, twelve residue/center correction packets, 192 Bernoulli term-series packets, 270 retained coefficients and eighteen endpoint evaluations. The last number counts shared endpoints twice by model incidence; there are twelve distinct character/endpoint pairs. Principal tensor rows are only finite-array artifacts. Elementary operations, correction jets, bit complexity, proof records and precision costs remain additional.

No further paper repair is needed for the revised design. Its next gate is implementation and static receipt review, followed only by separately authorized bounded execution and complete independent validation. It supplies no tested coefficient, useful spectral margin, full-family cost, complex-character conditioning result or new spectral coverage.
