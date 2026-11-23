# Independent source and hidden-input review of the fresh finite-RH frontier

Date: 2026-11-11. Verdict: **PASS as a conditional paper implication and source-normalization review.** No correction is required to the frozen main note. This is not finite-RH evidence, a Lean/MM0 proof, strategy adoption, or a finding of lower total proof cost. No builds, prime or zero computations, or analytic-function evaluations were performed.

## Frozen scope

Reviewed the complete `major-constants/EFFICIENCY_JOHNSTON_FINITE_RH_FRONTIER_2026-11-11.md`, SHA256 `0305EF19674FF97D13C2FA3F897E1106B5B0C4618287C9002842B87233F617DF`. Its exact scalar source is `F604ED6FD4B2E48D3809C38358449F1FB4BA8DEFB1C76DAF3461204FE0532FC2`, receipt `46CF6EF8910874F372BC34D4B34A67F154ED135D02C0FB92512C8765AB9369CE`. All eight entries in its frozen evidence table match the current files. I read the scalar source but did not rerun it; independent_feasibility separately checks its rational comparisons and continuum estimates.

The result has real parameters `1<=Q<=50`, `10^16<=x<=10^27`, ordinary theta, coefficient `.031+2.261/Q`, and finite RH through the inclusive height `4*10^10*Q`. The analytic interfaces are retained proof obligations, not evidence inferred from a theorem name.

## Primary-source contracts

I inspected [Johnston v2, section 2](https://arxiv.org/pdf/2109.02249v2), including its [equations in HTML](https://ar5iv.labs.arxiv.org/html/2109.02249), and the original [Büthe v4, Propositions 2–5](https://arxiv.org/pdf/1410.7015v4). The source inspection supports the following transcription checks:

* The high-tail exponential contains `sqrt(c*epsilon)`. The intermediate condition is `a*c/epsilon>=1000`; Johnston's displayed denominator `e` is a transcription error resolved by the original Proposition 3.
* The alpha-zero desmoothing bound applies at the same x, with the stated B0 and prefactor. No displaced argument is being substituted.
* The general Bessel comparison applies with c0=20. It does not require the separate numerical lower bound restricted to c>26.
* The counting functions in Johnston's local setup use endpoint half weights. The paper's ordinary-theta conclusion therefore needs its explicit jump payment.

These local lemmas do not invoke Johnston's section-3 finite-RH bootstrap. The new proof never consumes his Theorem 3.2 or 4.1 or Büthe's finite-range Theorem 2. Their earlier historical high-RH computations and finite prime-count patches are consequently not hidden inputs to this implication.

## Independent normalization and domain checks

The entire power series in the note has ell(0)=1 and is even. With the positive even unit-mass kernel, lambda is positive and equals the kernel's exponential moment. Integrating paired t and -t shows `|w(rho)|<=1` throughout the critical strip. This uses the actual normalized quotient, not an unnormalized eta from another convention. The real sqrt/sin expression identified as defective in the PNT dependency is not consumed.

The supplied ranges give c>24, epsilon<10^-4, a=sqrt(2/c) in (0,1), and t2=sqrt(2c)/epsilon>60000. They satisfy the high/intermediate and desmoothing domains. The older explicit formula additionally requires `log x>2/|log epsilon|`: here `|log epsilon|>4 log 10>9.2`, while log x>36, so this condition holds strictly. The D(20) positive-series witness supplies the required lower constant at every c in the range, including the part below 26.

The zero partition can be taken as `0<|gamma|<=t2`, `t2<|gamma|<=c/epsilon`, and `|gamma|>c/epsilon`. It has neither gaps nor duplicate endpoint atoms. Monotonicity of c/epsilon and the endpoint bound place both finite pieces strictly below H(Q). RH there gives x^beta=sqrt(x); the exterior bound is unconditional. Orders are retained throughout, and neither simplicity nor a global RH statement is needed.

## The two historical numerical inputs really are replaced

Read both frozen companions:

| Packet | SHA256 |
|---|---|
| `zero-sum/RECIPROCAL_HEAD_REUSE_2026-11-11.md` | `8EC98EEAC527630E0D3F558B63A0CE9897189DA389932FC7B0F536510EA9D27F` |
| `zero-sum/INVERSE_SQUARE_HEAD_REUSE_2026-11-11.md` | `1C4A0493A913D1E57EF6DBF9C8D9DE0F4E8DD4E2F14ED506FD8970CD9D1702F0` |

The centered Q1500 is not a raw reciprocal sum. Independently integrating the closed count envelope gives the exact Abel expression printed in the main note, including `207/8` and the negative `5/U` endpoint remainder. This argument needs Q1500 and the count envelope but not the exact N(1500). Both signs come from conjugation with multiplicity. The analytic envelope is used only at t>=1500; no unproved extension to t=14 is taken. The main proof uses its own conservative excess .1, rather than needing the companion's .08.

The inverse-square argument separately uses N(1500)=1069 and exclusion through height 14. Its head bound and tail integration give a total below .344; the tail constant `187/4` is correct. Closed head/open tail conventions preserve an atom at 1500.

For the constant adapter, [Büthe v4, equation (3.1)](https://arxiv.org/pdf/1410.7015v4) is the appropriate starting identity. On each symmetric finite zero carrier, reflection preserves orders and gives

`sum w(rho)/rho = (1/2) sum w(rho)/(rho*(1-rho))`.

The right series converges absolutely by the inverse-square bound; this justifies the symmetric limit without asserting absolute convergence of the left series from `|w|<=1`. Its norm is below 1/2. Together with the stated elementary constant, trivial-zero and epsilon corrections, the absolute remainder is below 3. The main scalar source charges 3 directly. Thus neither the old height-5000 reciprocal receipt nor the sharp historical inverse-square .05 input is needed. Real-axis nontrivial-zero exclusion remains an explicit analytic fact.

The existing head is external evidence awaiting its formal bridge. Reuse does not eliminate that bridge or turn the head into a kernel theorem.

## Ordinary theta and complete coverage

The normalized-to-ordinary psi jump is at most half log x. Its payment in (6), followed by the separate nonnegative prime-power difference, yields the asserted ordinary-theta estimate. The elementary prime-power bound is valid: isolate exponent 2 and bound the remaining at most `log x/log 2` terms by `log 4*x^(1/3)`. The real/floor extension and exact finite prime-power identity still need implementation.

For y=n-B and x=n-4, both arguments lie in the proved domain when n>=A+B. A positive ordinary-theta difference supplies p in `(n-B,n-4]`, which leaves an even binary argument in [4,B]. The closed endpoints and strict gap reserve are sufficient. If half-weight theta were used instead, only a closed prime interval would follow automatically; the present proof does not make that substitution.

I reread cached Mathlib `NumberTheory/Bertrand.lean:225–226`, SHA256 `91AED0AE5E324993157982FF06A5EB8002FD7224C2A3FA1B47DB937650CEF9DD`. Its prime A<p<=2A is odd here, so equality with 2A is impossible. With B>=2A this closes the remaining odd integers above B+3, while prime 3 covers the smaller ordinary range. No chosen large Bertrand prime or ladder receipt is required. The original exceptional small cases remain separate.

## Surviving obligations and final scope

The remaining analytic work includes the correct Logan Fourier identity, its actual prime-power smoothing, the explicit-formula limit and archimedean terms, unconditional tail estimates, desmoothing, Bessel comparison, and the elementary count/prime-power adapters. Published source lemmas are mathematical targets for this work, not extra permanent assumptions. The inspected GoodSmoothing API does not automatically admit Logan; the existing placeholder/degenerated Logan definition cannot discharge these targets.

Actual inclusive finite-RH/completeness evidence through H(Q) is still required, as are compatible standard-axioms validation and the head/count bridges. The nonprincipal family and the large-N analysis are unchanged. The original final Statement can retain only its original binary input through 4*10^18, weakening that input to B internally. Realizing a smaller standalone binary computation is a separate certificate-production choice. The unconditional large root gains no new final spectral hypothesis: every internal finite-RH premise must eventually be proved. This review establishes no runtime advantage from the binary-range reduction alone.
