# Independent review of the full P20 input magnitude

2026-11-11. Verdict: PASS at conditional source/paper and fixed-rational scope, with no correction requested. The three specified full P20 evaluator profiles support uniform augmented runtime/error bound5691 and final-band-only bound5032 under the retained source and head contracts. No precision assignment, price fold, new evaluator or production schedule is adopted.

## Frozen evidence

Author paths are relative to `work/qrh-campaign/agents/independent-feasibility/`.

| Artifact | SHA256 |
|---|---|
| FULL_P20_INPUT_MAGNITUDE_5691_2026-11-11.md | 718CFC0DDAA0594A2AB26ADDCEBA09E472E07C1ED21FD8058821957251EAC223 |
| full_p20_input_magnitude_20261111.py | E5DBF113F5E791DB3C6DB1B69186429D36E15EAEEE14749ED7957102860F08CD |
| full_p20_input_magnitude_20261111.json | 8127C8DA33B6864CD464DA50E9364F778563571FF223DA00DF4920FC4E9A1B0B |

I read the full author, stored-degree source, fixed-profile source and their relevant reviews, together with the retained subgrid and generic runtime-width interfaces. An independent inline integer/Fraction check verified all twelve author/dependency/review hashes, both rational majorants, the six actual band/profile cases, the retained evaluation-error caps, head/regrid margins and exact width thresholds. All 57 grouped checks passed. The author program was not imported or executed. No source coefficients, inventory, roots, transforms or other analytic values were read or evaluated. No declarations, proof objects or builds occurred.

The separately pending square-root-N EM optimization was not consumed. The proof uses the pinned existing degree-zero constants5170 and4507+9/2.

## Actual finite vector and three profiles

The bounded objects are the delivered centers of finite translated coarse polynomials. The first four bands retain P27 source coefficients and the stated m64 construction, including the rightmost unshifted endpoint that needs only P20. The final band retains sourceD4096/N1500/P28/m159, shifts0,1/4,1/2,-1/4, and the2^-j output postscale to normalization8192. The stored bounds already contain numerical source and translation errors. They do not identify the delivered vector with exact fine-anchor derivatives.

The three consumed profiles match the pinned repricing source: uniform100, root_linear and fixed15442. Each converts every ORIGINAL stored coefficient directly to its listed grid, copies the top coefficient once, then performs nineteen rounded displacement products and nineteen exact coefficient additions. All outputs are on grid100 with no further rounding. An intervening conversion of all coefficients to grid100 would be another schedule and is not used here. The displacement bound is1/4.

The actual evaluator-error sum is separately below(8/3)*2^-100 for each profile. The new use of the loose b>=70 bound proves magnitude only. It does not admit an all-grid70 evaluator, a shortened polynomial or an unreviewed finite-difference output.

## Magnitude accounting

Let e_j=(3/4)*2^-b_j. The accepted recurrence is

    A19=Z19+e19,
    Aj=Zj+2ej+A_(j+1)/4, j18,...,0.

Its expansion weights Zj by4^-j and weights e_j by2*4^-j except for the top slot, whose weight is4^-19. Thus it includes exactly20 coefficient conversions and19 product rounds. Exact additions and export introduce no round. The large degree-zero term is added last and never passes through another product.

For the first-four envelope, the numerical coefficient term at degree zero is W. At positive degree j it is at most4^j*W, so its weighted contribution is at most W. Twenty slots therefore contribute at most20W. The positive-degree ideal factorial terms yield6 times the finite series at5/16, excluding its constant term. The rational H majorant bounds this series because successive terms after degree2 have ratio at most z/3. Together with R and the conservative rounding allowance, this gives the displayed strict bound5172.5.

For the final envelope, the numerical eta terms sum to less than4eta/3. The postscale is essential: the ideal coefficient factor7/8 becomes7/32 after the displacement weight. The constant is4507+9/2, and the positive terms have coefficient15/2. The same rational majorant and the counted rounds give the strict4513.5 bound. Source4096 cannot be substituted for output8192 in that step.

I independently compared the direct finite weighted sum and backward recurrence in all six cases. Both agree and lie below the author's rational majorants. The separate analytic finite-shift bias remains part of the actual-function enclosure. It is not another perturbation to add to these already specified finite-polynomial centers, nor has it been discarded from the spectral error contract.

## Head and single regrid

For the actual positive unit representative a and c<=265800, the raw head has norm sqrt(c/a)<=sqrt(c)<516, since516^2=266256. This is uniform in positive, negative and zero heights. A separately certified head-center radius at most1 then gives norm below517. Its much tighter accuracy and actual grid100 representation remain required.

The author's illustrative deduction of an individual head radius from a conductor-scaled head SUM requires a positive sum of individual enclosure radii, as its wording states. A direct bound on a transformed character error alone would not imply individual radii. The sufficient pointwise head premise and exact assembled-vector binding remain explicit, so no cancellation-based inference is needed for this proof.

Exact grid100 assembly gives raw norms below5689.5 and5030.5. The admitted single regrid contributes at most rho_p*2^-p. Adding that and the augmented1 gives strict bounds5691 and5032 for p80..108. The p>=100 branch has rho_p=0. No source round, extra head conversion or extra assembly round is silently inserted. The old converter capacities115/p+15/116 remain safe and are not repriced here.

The5032 bound belongs only to the actual final-band producer. A whole-conductor precision spanning several bands may safely use5691. It cannot use5032 solely because one of its samples has a final-band label.

## Error and capacity consequences

The generic error theorem permits this augmented magnitude for the same stored input. Keeping its old factor two gives the claimed11382*S term with the unchanged separate rho regrid term. The selector retains the old right-hand constant4196258524692480 and exact complete R108 ceiling. This does not compose any pending tighter leaf or tensor rule, and it spends no additional source or downstream tolerance.

For runtime data, the accepted generic context proof permits p+ceil(log2(fV)) using the exact positive full context multiplier f. Both5032 and5691 lie strictly between2^12 and2^13. If k=ceil(log2 f), the new integer exponent is k+12 or k+13, so the former p+k+14 envelope falls by one or two bits. The second bit occurs exactly when fV<=2^(k+12); equality is safe because the coordinate numerator bound is strict. This is an envelope comparison at fixed p, not an actual-value or byte-cost estimate.

Normalized inverse factors must remain rational until that ceiling. Coefficient/root widths, exact coefficient sums and cache setup remain separately bounded. Presum, product, output-combination and signed-rounding witness capacities keep the generic extra bits and independent pre-acceptance operand/output ranges. The same old local safety and semantic peak conditions are mandatory. No old exponent-only histogram can decide all of these new thresholds.

No actual assignments, operation frequencies, arithmetic savings or spectra follow. All source/head production, converter work, cache lifetimes, downstream sign/count checks and principal/finite-coverage obligations remain outside this magnitude result.
