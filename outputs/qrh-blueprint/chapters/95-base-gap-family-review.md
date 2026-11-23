# Independent finite-family basegap review

Research review, 2026-11-11, against source commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build or canonical source edit.

Final status: **PASS as a conditional paper implication and exact external scalar certificate.** No blocking defect was found in the frozen producer note or final replay. The finite beta<=111/200 condition remains unproved. The shared uniform finite condition cannot be replaced automatically by a weighted moment certificate that merely proves averaged major-arc caps.

## Source phase geometry

Use m for the original rational modulus in alpha=a/m+delta/y, with a coprime to m. The actual major-arc definition supplies m odd<=150000 or m even<=300000. Its separate gap cases give

    odd m: 600000/(49m) <= |delta| < 600000/m,
    even m: 1200000/(49m) <= |delta| < 1200000/m.

Set q=m for odd m and q=m/2 for even m. Because a is coprime to m, reducing 2a/m gives exactly this denominator q. Put Delta=2delta and u=q|Delta|. Both cases imply 1200000/49<=u<1200000 and |delta|=u/(2q). Using a closed upper bound only strengthens the proposed estimate.

Important source adapter: `BaseGap2.gap_point:185` deliberately forgets parity and weakens the even lower bound and odd upper bound in its exposed conclusion. The stronger extraction above must be proved from the original `majorArcs` case split, as already visible in its proof. It cannot be deduced solely from that weakened theorem statement. I sent this requirement to the producer before finalization.

Source `S_etaStar_eq_expTsum` identifies the smoothing exactly with etaU(n/y), y=x/49. Its explicit formula therefore has physical twist delta, not delta/49. There is no factor49 in this pointwise character bound; factor49 occurred in the different major-arc L2 integration variable.

## Character reconstruction and height inclusion

Source `BaseGap.totient_mul_norm_le` and `Schar_primitive` supply the required additive-to-character expansion and induction. Retaining exact Gauss norms gives

    W(m)=(1/phi(m))*sum_psi |tau_m(psi)|
         =(1/phi(m))*sum_{m=c*r, sf(r), (c,r)=1} a(c)*sqrt(c).

Cauchy-Schwarz, the number phi(m) of characters and the exact identity sum |tau|^2=phi(m)^2 imply W(m)<=sqrt(phi(m))<=sqrt(q). For m=2q, phi(2q)<=q; for odd m=q, phi(m)<=q. This is a strengthened reconstruction lemma: applying the existing coarse `norm_expTsum_le_of_chars` directly gives sqrt(m), not the improved factor.

When q is odd, the possibilities m=q and m=2q have identical relevant primitive families, Gauss norms, phi and absolute mu. The absence of primitive conductors with v2(c)=1 matters here. When q is even, only m=2q arises. Thus enumerating m=2q and explicitly checking the odd-q identities covers both original-modulus cases without an unjustified parity identification.

The proposed star tail cutoff is

    H(q,u)=max(250,ceil(242u/(7q))).

Because |delta|=u/(2q) and pi<22/7, it is at least22pi|delta|. At the full u endpoint its value is ceil(290400000/(7q)); the minimum over q<=150000 exceeds250, so the max floor is inactive for the all-twist bound.

For every Gauss-active conductor c inducing to m, qt(c)<=qt(m)=2q. Hence the original shared cutoff satisfies

    Hp(c)>=200+422400000/(7q),

which dominates H(q,1200000), including the ceiling error. Also Hp(c)>=1200 dominates the floor250. The script checks the exact height inclusion on1094045 induction incidences. Thus no larger finite spectral domain is secretly required, and no conductor cutoff is imposed.

## Low zeros, pole and removal

The source Jensen count400 per3.48 window counts true multiplicity throughout the strip. It gives

    N(H)=ceil(400*(2H/3.48+2)).

With the finite upper beta<=.555 and the actual star transform bound<4, every primitive low-zero sum is bounded by4N(H)y^(-.445). The exact endpoint comparison y^(-.445)<7.5e-12 is valid at y>=10^25; this positive envelope decreases with y, independently of oscillatory phases.

For the pole main term, use the actual principal Gauss norm |mu(m)| and

    |Fourier etaU(-delta)|<=min(1.2534,1.016/delta^2).

I independently verified the convenient uniform bound<.000481 by sqrt(1.2534*1.016)<1.129, m/phi(m)<=30030/5760 for m<=300000, and |delta|>=600000/(49m). The final rational product is below .000481. An independent totient sieve checked the all-modulus totient inequality. The even source lower endpoint is stronger, so this bound is safe in both cases. The exact enumeration keeps the sharper mu/min expression.

The omitted-coefficient source bound `BaseGap2.sum_noncoprime_le` is unconditional. Choosing K from2log(y)/log2 gives the normalized bound2e-9 with enormous endpoint slack; (A log y+B)/y decreases throughout y>=10^25. The same omitted coefficients control primitive-to-coprime error through |chi|<=1. The reconstruction error is therefore (1+W)*2e-9, with the first term outside the character sum and the second inside. Both are retained.

The normalized contour/zero-at-zero allowance must use the larger twist range here, |delta|<=600000. The script uses theta>=4e-7, Kv<=900 and DN<150. The supplied VgL expression has the correct coefficients and a y^(-3/2) normalization. At zero the actual etaU Mellin absolute bound is already<2 (positive mixing mass<2 and Gaussian Mellin moment1); the chosen600 is conservative and independent of twist. Its multiplicity bound400 gives at most400*600/y. No zero-at-zero residue is silently classified as a nontrivial finite zero or discarded. Formal etaU GoodSmoothing/explicit-formula and multiplicity adapters remain required.

## Initial exact replay

The initial script SHA256 `587EB1CECA2B5A62DB966DB231540F226C198777F0DF8584D2B7AD2A24C510F4` was independently replayed with writes redirected to the audit directory. It exited0 and matched the author's JSON. It checked all150000 reduced denominators and all1094045 height inclusions.

For the simple route, N(H)<=20000H/87+801 and H<=A/q+1, A=290400000/7, give the low envelope a/sqrt(q)+b*sqrt(q). The exact inequality b*150000<a proves it decreases on the complete interval. The script's directed square-root brackets at40 then give total<.045752286025<.04712 for all q>=40. This uses the independently established pole-main cap, not a sampled main term.

The sharper exact-weight enumeration with transform cap4 leaves20 failures of this sufficient test: 1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,19,23,29,31. A failed sufficient envelope is not an impossibility result. Later script revisions with a sharper transform are reviewed separately below when frozen.

The unchanged actual consumer lower bound ghatY(y,150000)>.04712 is the previously reviewed all-scale envelope. This result would replace the source's unnecessarily strong .0121 pointwise target only at that consumer; it does not prove the old .0121 theorem.

## Frozen high-tail ledger: accepted

The final note recomputes the tail on the actual basegap twist interval, rather than borrowing the major-star interval divided by49. The etaU convolution transfers the Gaussian bound with mixing factor<2 and no etaPlus bandlimit shift200. H>=22pi*d and H>=250 satisfy the source tail conditions. The polynomial Jensen data give Z3<400 and c3<53/H on the required cutoff range.

Writing G=3+d/2.7, the geometric denominators are <=G. The bounds H>=69d and H>=250 imply G/H<1/39, so

    800G+(106/H)G^2 <803G<180000000.

I separately checked the exact rational inequalities in this correlation. EA<=.588*22^2*exp(-.1065*22^2)<2e-20 uses a decreasing Gaussian-polynomial envelope above22; zero twist uses its defined zero value. For EB, retaining H versus d is essential: 803G<5H+2500 gives the whole contribution below

    2*.892*H*(5H+2500)*exp(-.1598H)<1e-11.

Its logarithmic derivative is at most2/H-.1598<0 for H>=250. Thus evaluation at250 bounds every larger cutoff. Combining both terms and y^(1/8)>1333 yields a normalized primitive high tail<2e-14. The final replay checks the exponential comparisons with exact positive Taylor sums. The enlarged vertical/zero0 bound checked above is<1e-18, so the analytic allowance3e-14 is valid.

This argument uses global7/8 above H and the finite .555 strip below and including H, with no endpoint gap. It needs the actual etaU explicit-formula, integrability, off-line Jensen and finite-to-limit adapters. Those are formalization obligations, not additional zero-distribution hypotheses smuggled into the conclusion.

## Reflected finite strip and the sharper transform

The frozen note correctly uses reflection through the conjugate character to get beta>=.445 at the same conductor and absolute height. This needs the uniform finite hypothesis for every primitive character; it does not assert a quartet within a single nonreal character.

The actual positive convolution gives M_U(0)=4log(2)^2<1.922 and M_U(1)=sqrt(pi/2)<1.2534. Integrating t^beta<=(1-beta)+beta*t against etaU(t)dt/t gives

    |F_U(beta+i*gamma,delta)|
       <=(1-beta)M_U(0)+beta*M_U(1)
       <.555*1.922+.445*1.2534=1.624473<13/8.

The affine upper bound is decreasing in beta. This is the correct coefficient order at beta=.445. It is valid for every real twist and ordinate; integrability follows from the same Gaussian mixture. The exact script's positive exponential Taylor sum proves log2<.69315 in the right direction. There is no hidden factor49 or Mellin argument shift.

## Final result and independent replay

The final script was independently replayed with output redirected into this audit directory and exited0. Its JSON is byte-identical to the frozen producer JSON. I added explicit assertions that the sharp failure list is exactly [1,2,3], the exact largest passing rational bound is<.044797 and occurs atq=5, and every reported prefix both passes at its endpoint and fails this same sufficient test at the next integer.

The accepted conditional result is:

* Every reduced q in [4,150000] passes the full source gap, for every y>=10^25 and every u in [1200000/49,1200000].
* q=1 passes through the closed endpoint u=486477.
* q=2 passes through the closed endpoint u=972954.
* q=3 passes through the closed endpoint u=1068377.

The original gap upper endpoint is open, so the stronger closed full-range estimates are harmless. For the prefixes, the bound is nondecreasing in the proposed upper u endpoint because H is nondecreasing; the Fourier main allowance is already evaluated at the actual source lower endpoint. Thus each binary-search result certifies the whole stated interval rather than only its last point. The remaining portions forq=1,2,3 require the independent high-u branch and its original producer assumptions. This review does not accept that branch merely because the producer note mentions it.

The full-gap count is therefore149997 under the shared uniform finite spectral premise and listed analytic bridges. It must be labeled as a different conditional research route from the earlier78642 count based on repaired Type I/II producers. Neither count is a count of Lean-proved denominators. The weighted major-moment alternative and the smaller-height profile are not automatically sufficient for this pointwise route.

| Frozen artifact in agents/zero-sum | SHA256 |
|---|---|
| RESUME_BASE_GAP_FINITE_FAMILY_2026-11-11.md | 09340D4135D7E895E6F3FDA660DE9A7F773A91FF41F3B88FC125C814884D5E74 |
| resume_base_gap_finite_family_20261111.py | 7B51EFCE9DF84125EFFEA001154483B21C0DBE92EE7C80D514D90420EE08C036 |
| resume_base_gap_finite_family_20261111.json | BE725BE94D16589C47E4F2387559B994BBA8F75A008121D100930313935CFB7A |

Audit-directory evidence: `resume_base_gap_finite_family_20261111-independent.json` and its `-independent.log`. The final JSON hash is the same as the producer JSON above. The initially reviewed cap4 run was superseded in these replay files; its source hash and results remain recorded earlier in this note.

The parity-preserving gap extraction requirement identified during review is now stated explicitly in the frozen producer note. No remaining correction is required for this bounded conditional implication. No Lean theorem, admitted proof, custom axiom, canonical import or new sealed result was introduced.
