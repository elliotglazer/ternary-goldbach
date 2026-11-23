# Conditional spectral inventory for R140000

2026-11-11. Integer-only metadata. **The R140000 mathematical profile is a pending candidate, not accepted by this report.** No character, root, Fourier transform, L-function or zero was evaluated; no build or spectral verification was run. All previous reports and receipts are unchanged.

If the proposed conductor restriction is accepted, the existing mixed-radix character circuit above c=10000 uses .916376–.916377 times its R150000 general complex products and .916230–.916231 times its additions. This is a circuit-subdomain comparison, not a total runtime or complete proof-cost ratio.

## Fixed comparison

For R in {150000,140000}, retain odd conductors 3<=c<=R and conductors divisible by four with c<=2R. Conductor one is excluded from this nonprincipal inventory. The original heights remain

    H(c)=100000000/c,                 c odd or c<=125000;
    H(c)=200+75000000/c,              c even and c>125000.

The nominal nonnegative coarse grid has step5/64 and J(c)=ceil(64H(c)/5)+1 nodes. It includes zero and its last point can lie above H(c). These are neither ordinary interpolated sign nodes nor zero counts. Extra analytic guards, auxiliary Turing heights, repairs and proof of inclusive coverage are not included.

The c=10000 switch, exact unit-group axes, positive unnormalized DFT, mixed-radix selection, cheap-root classification and full-output computation are unchanged. Every axis is transformed before primitive filtering. The new profile removes precisely 5000 odd conductors in(140000,150000] and 5000 multiples of four in(280000,300000]. All removed conductors lie above the switch.

For each c, v=phi(c), with axis lengths m_i, the five-category circuit cost is

    J(c) sum_i (v/m_i) C_mixed(m_i).

All five categories retain their old meanings: general complex products, complex additions/subtractions, quarter turns, negations and exact dyadic scalings. In particular, cached Bluestein kernel FFTs are setup rather than per-input work. These counts do not change to the separate three-real-product implementation unless that backend is explicitly selected and priced.

## Conductor and grid inventory

| Quantity, all nonprincipal conductors | R150000 | Conditional R140000 |
|---|---:|---:|
|Conductors|149999|139999|
|Primitive character labels|5543640187|4829158813|
|Real primitive labels|121577|113481|
|Nonreal inverse pairs|2771759305|2414522666|
|Unit coefficients at one node per conductor|9118941848|7943636860|
|Sum of nominal conductor-height nodes|10979779734|10906251119|
|Coarse residue inputs / full character outputs|120706437078428|112067381988794|
|Coarse primitive outputs|80459602925766|74855673008489|

The character-label ratio is .871116–.871117, appreciably smaller than the coarse-output ratio .930351–.930352: removed large conductors have shorter height ranges. Label reduction alone must not be substituted for the grid-weighted cost reduction.

| Quantity, c>10000 only | R150000 | Conditional R140000 |
|---|---:|---:|
|Conductors|142500|132500|
|Primitive labels|5525163079|4810681705|
|Unit coefficients at one node per conductor|9093611126|7918306138|
|Sum of nominal conductor-height nodes|2863650650|2790122035|
|Coarse residue inputs / full outputs|114223068442718|105584013353084|
|Coarse primitive outputs|75730502011007|70126572093730|
|Maximum number of coarse height nodes|127989|127989|

The last line matters for shared Hurwitz/alpha seed generation. If the prior fixed P24 adaptive seed schedule is reused verbatim, its height-index union is unchanged. Fewer conductors reduce contractions and character transforms, but do not reduce this shared seed schedule merely by the conductor or label ratio. Ordinary interpolation may use fewer character channels, yet its exact selected-sign, guard and repair costs require their own accounting.

Inverse pairs are metadata, not a factor-of-two discount in these tables. Both character labels are retained in the full transform. Using their positive-height data for opposite ordinates still requires the same proven conjugation/normalization and central-height treatment as before.

## Same mixed circuit, c>10000

| Category | R150000 | Conditional R140000 | Removed |
|---|---:|---:|---:|
|General complex products|3041383327064694|2787051874367696|254331452696998|
|Complex additions/subtractions|6301213142003526|5773363484523660|527849657479866|
|Quarter turns|279797486233036|256592386748025|23205099485011|
|Negations|66590728284|61675282036|4915446248|
|Dyadic scalings|271405257746112|248843952956864|22561304789248|

The corresponding new/old ratios are respectively .916376–.916377, .916230–.916231, .917064–.917065, .926184–.926185 and .916872–.916873. Small-conductor data and all five diagnostic character-circuit totals below the switch match exactly. The actual hybrid architecture may use theta/time evaluation there; this report does not replace or price that unchanged component. The receipt includes all-conductor character-circuit totals only as a separate diagnostic, not an addition to a small-conductor theta/time budget.

## Setup and representation

Setup is one cache per distinct used length and precision, not multiplied by J(c). The same set of axis lengths happens to occur above the switch as in the all-conductor diagnostic for each profile.

| Setup quantity | R150000 | Conditional R140000 |
|---|---:|---:|
|Distinct axis lengths|13943|13103|
|Active circuit nodes|37117|34721|
|CT split lengths|30625|28520|
|Bluestein kernel lengths|6472|6181|
|Padded kernel entries|382342624|354678240|
|Chirp entries|153585028|145093425|
|Largest padded Bluestein length|262144|262144|
|Full CT root-table entry upper bound|1436913503|1247555730|
|Small direct-prime root entries|26|26|

Both profiles use16 radix-two lengths and four small direct-prime lengths. The root-table entry count is the same deliberately loose full-table bound used previously, not proof of minimal storage. Root construction, accuracy and memory movement remain separate.

The kernel setup FFT categories (G,A,Q,N,S) are

    old=(2559613840,6266229664,191164840,0,0),
    new=(2364827978,5793665952,177332939,0,0).

These setup FFT counts omit construction of their input chirps. Kernels may be streamed and rebuilt at higher precision; neither entry totals nor active-node totals are peak RAM. The candidate does not lower the maximum padded length, so a maximum-size allocation cannot be reduced on this evidence alone.

## Reproduction, checks and status

The new script copies the preceding pinned integer circuit definitions into a separately named file; it does not import the old producer with its eager output writes. It recalculates both profiles. Assertions recover the frozen R150000 large/all operation totals, conductor/label/grid totals and complete canonical plan hash, and establish exact equality of the small-conductor records. The candidate changes only the conductor eligibility bound. No output or old source file is overwritten.

The new R140000 active-plan SHA256 is `c107083781248e5c412a48493588609754a99e27a707475b02e0548c37b4c615`; the recovered R150000 plan hash is `fa64e941393518f8debe960c0b81d977e0100cc033a9028287f6d86cc2917d5b`. Hashes identify serializations; the finite identities and integer formulas supply the mathematics.

Source report: `MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md`, SHA256 `C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01`. Frozen source receipt: `mixed_radix_character_inventory_20261111.json`, SHA256 `2AC4DBAF9D0C41D1DFD8006AC280619DFF6C3059D7DA7FAEF6F1C477D2CE4D3F`.

New script: `conditional_r140000_mixed_inventory_20261111.py`, SHA256 `D5A0466A9EEEE81F96BD42CD4D916C798854D090BA6BC746C6775C8B927CC512`. New receipt: `conditional_r140000_mixed_inventory_20261111.json`, SHA256 `DA26BF4BA4744CF5AF096670873FE9CA258735A8EFA4DE09D0F490A56F36F5F7`. Status `PASS_CONDITIONAL_R140000_INTEGER_INVENTORY` means these integer calculations passed, not that the mathematical reduction or any finite-RH certificate passed.

The overall comparison must still retain unchanged principal verification, small-conductor work, shared seeds and analytic-library checking, then separately price changed contractions, transforms, normalization, selected signs, exceptional precision and Turing completeness. No single ratio here applies to their sum.
