# Independent review: finite-EM rational checker blueprint

2026-11-11. **PASS as a paper/source blueprint.** I found no blocking mathematical or specification defect in `integration/FINITE_EM_RATIONAL_CHECKER_BLUEPRINT_2026-11-11.md`, SHA256 `F6B784776E24F767FA3A45C3006394F0E718FF491712077FC9EBDC74EDE92F22`. This is not approval of Lean declarations or an implemented checker, nor proof that any concrete rational certificate accepts. No Lean/Lake build, numerical evaluation, evaluator import, code preparation or completed-smallbatch rerun was performed. Only source and report reads, hashes and elementary mathematical derivations were used.

All paths below are relative to the campaign's `agents` directory unless explicitly named otherwise. The exact target sources remain Goldbach commit `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`.

## 1. Fixed claim and index audit

The chosen first slice is genuinely the last complete panel, not the simpler zeroth center:

- `s7 = 629/1250 + i*(31985/16) = .5032 + 1999.0625 i`.
- Radius `1/16` gives exactly `[1999,15993/8] = [1999,1999.125]` on that vertical line.
- Canonical endpoint indices 7 and 8 both use model 7. Their singleton offsets are respectively `+i/16` and `-i/16`.
- The retained coefficient indices are 0 through 15; the local expansion degree is 15. The coefficients are complex-s derivatives divided by h!, not height derivatives.
- `Delta=-1/8`, `J=8`, `L=32` give contraction argument `7/8` and positive normalized-transform output label `-7 mod 32 = 25`.

The theorem target binds exact mathematical inputs and the proposed coefficient/image endpoints independently of certificate assertions. An untrusted converter cannot change the target by merely supplying a different certificate record. A theorem about a typed imported value is distinguished from a theorem about JSON bytes; a hash does not prove either the analytic meaning or decoding.

The slice requires sixteen actual finite-g coefficient enclosures and actual-zeta membership throughout the whole closed panel plus both singleton endpoint images. A midpoint result, arithmetic acceptance with undischarged leaves, or an h=0 identity would not meet it. The full objective remains all 128 coefficients, eight panels and nine endpoints. The union is `[1999,2000]`; neither the first slice nor that union is a closed contour or a zero-count theorem.

## 2. Actual function and coefficient semantics

The finite expression has the correct parentheses:

`g(s)=(s-1)D(s)+exp(-s log B)*((s-1)R(s)+B)`.

Here D is the sum from 1 through 1024, R includes the half term and all sixteen signed Bernoulli corrections, and B=1025. The B term is exactly the separate pole-removal exponential `B^(1-s)`. The last correction uses rising length 31; the EM remainder uses length 32. No extra `(s-1)` is applied to the pole-removal term.

The old-array rising-factorial recurrence and the exponential recurrence compute ordinary Taylor coefficients. Finite convolution cannot depend on discarded entries of degree at least 16. The final main-sum combination contains both `(s_j-1)D_h` and `D_(h-1)`, while the complete correction includes the half term, all Bernoulli terms and the B term. The blueprint explicitly requires the theorem identifying this arithmetic with `iteratedDeriv h g s_j / h!`; the word “jet” alone does not assert it.

The named source `TernaryGoldbach.Explicit.zetaF` is the entire updated function with value 1 at the pole, not the raw totalized product at s=1. I reread `Explicit/ZetaGrowth.lean:17–30`. On this panel s is never 1, so the proved off-pole identity followed by division by the full s-1 rectangle gives actual `riemannZeta`. No arbitrary function with a supplied coefficient hypothesis replaces this source object.

Reused accepted paper interfaces were read directly: `EM_SOURCE_PROOF_PLAN` (`A02698DDD8A5965551CC6A09AA2CF275FE12F2C0236264CB3AD10BF77ABC8485`), `EM_FINITE_COEFFICIENT_SEMANTICS` (`ADE7149EE7D5C3586A2AA7267C39363828747D801DE5EF1F4508A21B737F69D3`), and the completed-pilot scalar budget (`47256C6265C63BF1851B0FD7347F57BC18849AA7B629FFA72442EF9D05A22D23`). Their source bridges remain formal proof work.

## 3. Elementary and finite-arithmetic boundaries

The typed graph requires earlier references, checked operation meanings, correctly ordered intervals and nonzero divisors. Directed rounding must preserve endpoint containment for both signs. Cartesian boxes and Euclidean norm disks have distinct semantics. A zero-radius output requires an exact zero proof. No unchecked numerical-value tag is admitted.

The log certificate matches the actual source theorem. For reduced `u>1`, substitute `a=1/(u-1)` into `RamPf.log_one_add_inv_bounds`; then `1/(2a+1)=(u-1)/(u+1)`. Its positivity hypothesis holds, and the displayed finite sum and tail agree. At `u=1`, the separate exact-zero branch is necessary and present. Positive-base power/log conversion and signed integer-power reduction still require their stated domain proofs.

Pi reduction carries the uncertainty multiplied by the entire reduction integer. Trigonometric enclosure is universal over the reduced input interval, not based on monotonicity or midpoint proximity. Exp certificates use actual exponential identities and proved finite tails. The graph's closed arithmetic check does not establish these analytic lemmas by itself. The note correctly requires them to discharge every final semantic leaf.

The plan imports only generic interval gates from the earlier principal-node blueprint (`E3ACCCDAB3D3A6F34D51702843A4D7A6807D0CD4DE52DA7AA2485BB3C0835398`); it does not inherit theta identities, P/xi identities, or the previous disk's analytic claims. No modular square-root machinery is needed for this EM target.

## 4. Batch signs, uncertainty and the direct alternative

The exact phase factor at center j decomposes as

`exp(-i*j*Delta*log n) = exp(-2*pi*i*j*q_n/32) * exp(-i*(j/8)*r_n)`.

Thus the full signed q belongs in the residual, its residue modulo 32 belongs only in binning, and the positive normalized transform is consumed at `-j`. The transform is applied to exact stored moment centers. The two kinds of uncertainty are correctly distinct: actual moments versus centers, and arithmetic error in the transform of those centers.

For contraction argument y, the error is

`sum_m y^m sum_k epsilon(h,m,k) + 32 sum_m y^m alpha(h,m,j) + beta`.

There is no extra 32 on the first term. The h! and m! appear once in their respective factors. The first batch slice still requires all 12,288 moment disks and 384 consumed transform disks, not merely sixteen values. The full batch claim requires 3,072 selected outputs.

The residual estimate uses real Taylor's integral remainder for `exp(-i theta)` with derivative norm one. For degree 23 it is `|theta|^24/24!`, valid for negative theta as well. I reread the source's signed `uIcc` integral remainder API; the note correctly leaves within-derivative and signed-interval adapters to prove. A generic complex-tail estimate carrying an extra constant cannot be inserted into this ledger without recomputing the bound.

The complete correction error is an error for the full correction block, not only R before multiplication by s-1. Phase recurrence or direct-phase certification are both allowed if they establish that same exact phase. A rational checker can use fresh internal enclosures and a different sound evaluation order. It cannot infer containment in a target square merely from overlap with an old numerical result.

A direct-g construction is a valid alternative for the actual panel and endpoint images. It removes bin, residual and FFT lemmas from that theorem, because actual coefficient enclosures suffice. It does not validate the old moment/transform records or prove the batching algorithm sound. The blueprint expressly preserves this distinction and makes neither method a required extra premise of the other.

## 5. Analytic enclosure assembly

The three remaining analytic obligations are stated correctly and separately:

1. Complex EM with the exact finite expression, Bernoulli signs, convergent remainder and continuation to `Re(s)>-31` for M=16.
2. The entire finite-g outer-circle bound `|g|<=2^27`, plus normalized coefficient identity and the geometric Taylor-tail theorem.
3. The actual-point EM bound on the vertical panel, with positive denominator at least `63/2` and the exact scalar allowance from the reviewed budget.

The outer disk may extend to the left of real part 1/2; it concerns finite entire g. Applying the actual-point EM estimate there would be unjustified, and the blueprint does not do so. At radius 1/16, sixteen retained terms give `2^27*(1/16)^16/(1-1/16)=2^-33/15`. The EM and Taylor norm errors each imply coordinate-square pads. They are added once before division. Existing coefficient uncertainty is already in the Horner squares and is not added again.

The whole s-1 rectangle has imaginary coordinate at least 1999. Its norm-square interval has a positive lower endpoint; taking the conjugate and dividing by that interval gives a sound reciprocal enclosure. Singleton endpoints use the same owner and appropriately singleton offsets. The optional scalar reserve `2^-64` is not an unexplained pad in exact rational image reconstruction. The total approximation-error bound below `2^-44` is not an upper bound for image variation over a panel.

## 6. Source checks and unresolved gates

I directly reread the target log theorem and zetaF definition, Mathlib's `taylor_integral_remainder` around line 535, and `dft_apply`, `invDFT_apply`, `invDFT_apply'` at lines 106–122. They have the domains and transform conventions used here. I independently rehashed all ten source files in the blueprint's selected-hash table; every pin matches, including RamareHarm `C3B8A215…BBA688`, ZetaGrowth `ED215852…591E9E4`, Taylor `0AB79A53…8CA18A`, and Fourier/ZMod `012663E2…84EFE10`. This is source inspection, not a transitive axiom or elaboration check.

The following remain substantive obligations rather than consequences of this review:

- Universal arithmetic, elementary and graph soundness, including all analytic domain conditions.
- The actual source EM identity, coefficient normalization, and finite-g Taylor wrapper.
- A concrete typed rational certificate and a closed kernel proof of its acceptance, with rejection controls at the real checker boundary.
- Literal target audit and, only if required, a verified relation to external file bytes.
- Proof-size, denominator-growth and runtime evidence. Selected-rounding budgets do not authorize rounding at every operation; such an implementation needs its own accumulation proof.
- Actual compiled theorem-type and transitive-axiom audit. The permitted set here is exactly `propext`, `Classical.choice`, and `Quot.sound`; the blueprint's “such as” wording does not enlarge that set.

The new elementary precision schedule and proof-cost comparison are pending separate reviews. They are not consumed as proved feasibility or as an acceptance witness by this verdict. Finite checker termination does not imply it can prove every proposed narrow box, and no fixed precision guarantees success. Strict slack may support eventual witness existence only once justified; exact-boundary and zero cases need their own treatment.

The final closed panel theorem must retain none of the intermediate “input enclosure”, checker correctness, numerical success, EM identity, or coefficient correctness hypotheses. Generic soundness and concrete acceptance are separate required proofs. There is no new mathematical premise for `TernaryGoldbachFrom (10^27)`; full Statement retains only the original inclusive `BinaryGoldbachInput` through `4*10^18`. Production spectral evidence, global seven-eighths provider validation and consumer formalization remain independent open work. This blueprint does not claim otherwise.
