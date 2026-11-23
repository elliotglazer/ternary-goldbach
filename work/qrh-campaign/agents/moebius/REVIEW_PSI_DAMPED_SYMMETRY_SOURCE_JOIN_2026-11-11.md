# Independent review: damped principal symmetry and Gaussian psi sums

2026-11-11. **PASS as a paper/source derivation, after the selected-height text correction.** This supplies a finite-zero-sum inequality and its count-majorant reduction. It does not itself prove the scalar psi budget, the shared finite spectral assertion, or a Lean theorem.

Final author artifact: `zero-sum/PSI_DAMPED_SYMMETRY_SOURCE_JOIN_2026-11-11.md`, SHA256 `7574552D55981DCEC5CF5A419D6CEEB6FC7A264FE4A81CBAA8D0C3880F6DAFBE`. The earlier complete note `DF2924FEE0F76FD28F3922E512D1179D2ED303058BB80B9143E0224D99587880` was read in full; the final replacement corrects its selected application from one million to `T=H=60343058`. The generic proof and inequalities are unchanged. The corrected paragraph and final hash were checked. All seven Lean source pins and five research/evidence pins match their referenced files.

The review independently derived the source-carrier symmetry, local-order identity, exact Gaussian orbit average, and finite Abel identities. It read the relevant source bodies and existing head reviews. No analytic function values, numerical zero data, evaluators, builds, or new finite certificates were generated.

## 1. Source carrier and true multiplicities

`Datum.zerosRectD` is a finite zero set from an analytic divisor, further filtered by the strict rectangle inequalities. It is not inherently invariant under reflection merely because of its containing ball. The author's choice of an auxiliary U>T resolves this correctly. Every nontrivial zero with |gamma|<=T has

    |rho-2| <= |beta-2|+|gamma| < 2+T < U+3 = RT(U)/2.

It lies strictly inside the rectangle at U as well. Conversely, `ZetaZeroSums.zerosRectD_zetaF_strip` identifies every member as an actual nontrivial zeta zero and xiF zero. The closed cutoff is applied only after the strict larger carrier has been obtained. Zeros exactly at +/-T are therefore included. No good-height assumption on U is needed for this finite-set construction.

The carrier weight is `(divB zetaF 2 (RT U) rho).toNat`. For the nonzero entire function zetaF, its divisor at such a point is its finite analytic order. `ExplicitFormula.divB_eq_of_mem` and the source equal-order transport in `WeilBridge` make the weight independent of the chosen containing ball. `WeilBridge.analyticOrderAt_xiF_eq:38` applies throughout the strict critical strip; its nonvanishing local multiplier is s GammaR(s). Thus an order identity for xiF is the required identity for the actual Gaussian explicit-formula weights.

For J(rho)=1-conj(rho), source `Xi.xiF_one_sub:24` and `XiPartial.xiF_conj:669` give, locally in the complex increment w,

    xiF(J(rho)+w) = conjugate(xiF(rho-conjugate(w))).

If `xiF(rho+w)=sum a_n w^n`, the expansion at J(rho) is `sum (-1)^n conjugate(a_n) w^n`. Its first nonzero coefficient has exactly the same degree. Conjugation alone similarly replaces a_n by its conjugate. This proves order preservation, not merely preservation of the zero equation. It does not assume simplicity or even multiplicity on the critical line.

J preserves the positive ordinate and every band defined by gamma. It is therefore an involution of the complete finite positive-ordinate band carrier. Conjugation matches positive and negative carriers with equal orders. For an arbitrary subset, only enlargement of a nonnegative majorant to this full carrier is justified; the author states this restriction explicitly.

The real axis is handled before division by |gamma|. A real nontrivial zero lies within the assumed RH head and would have to equal 1/2, contradicting source `xiF_half_ne_zero:104`. The points 0 and 1 are not added zeros. Thus the subsequent positive/negative splitting has no omitted zero term.

## 2. Exact Gaussian average

The source `GaussSmooth.Mg`, `norm_cexp_gauss`, and `norm_intExp_le'` give the endpoint majorant

    exp(L(beta-1)) exp(q(beta^2-gamma^2))
      * (exp(a beta)+exp(b beta))/|rho|,
    q=delta^2/2.

Replacing each denominator separately by |gamma| is valid. It is necessary to do this before claiming an ordinate-only common weight: in general |rho| and |J(rho)| are unequal.

Writing u=beta-1/2, the exponent for one endpoint e, after extracting `exp(-L/2) exp(-q gamma^2)/|gamma|`, is

    e/2 + q/4 + q*u^2 + u*(L+e+q).

The involution average is therefore exactly

    exp(e/2+q/4) exp(q*u^2) cosh(u*(L+e+q)).

For |u|<=h this is bounded by the stated B_h(e). This uses q>=0 and evenness/monotonicity of cosh in absolute argument. It imposes no sign restriction on L+e+q, and works for either sign of the upper Gaussian endpoint a. In particular the lower endpoint b is not replaced by an unexplained factor two.

The weighted identity `sum mF=(1/2)sum m(F+F o J)` follows by finite reindexing. Fixed points beta=1/2 contribute correctly to this identity; they are not counted twice or removed. Adding the a and b endpoint contributions and then both ordinate signs proves formula (2). The optional simpler cosh(hL) bound (6) is also sound under its explicit b<=0 and h<=1/2 hypotheses, by bounding the Gaussian and endpoint factors uniformly before averaging exp(Lu).

## 3. Damped Abel identities and head subtraction

For `f_q(t)=exp(-q*t^2)/t`, direct differentiation gives

    -f_q'(t)=exp(-q*t^2)*(t^(-2)+2q) >= 0.

The closed count N(t) and the half-open band u<gamma<=v yield

    J_q(u,v)=f_q(v)N(v)-f_q(u)N(u)
             + integral_u^v (-f_q')N.

This can be proved with the finitely many zero ordinates up to v and indicator integrals. A zero at u is subtracted; a zero at v is included. Single endpoint values do not affect the integral. No sum/integral interchange over infinitely many zeros is required.

Replacing N by C in the integral and, if necessary, at the upper endpoint, then integrating by parts gives precisely formulas (8) and (9). With both exact endpoint counts the term `-f_q(v)(C(v)-n_v)` must be retained. With only the lower exact count the upper C endpoint cancels into the integral of f_q C'. The author has neither omitted the upper boundary term nor silently set a count defect to zero.

For the actual analytic majorant in (10), C' is positive on t>=1500. Its growth is logarithmic, while f_q is Gaussian-decaying for q>0. Thus the scalar integral converges to infinity and `f_q(R)C(R)` tends to zero. Replacing a finite upper limit by infinity only enlarges the nonnegative scalar estimate. It does not apply a finite strip to zeros outside its certified height. For q=0 the note correctly retains finite upper limits.

The head estimate is `H_A=1.668+1069/1500`, obtained by dropping damping only on the accepted finite head. In formula (12) the tail still contains `f_q(A)(C(A)-1069)`. This is the correct combination. Replacing H_A by `Q_A+1069*f_q(A)` would be invalid without a further argument; the note explicitly rejects this shortcut. The derivative factor `exp(-q*t^2)(1+2q*t^2)` is not always at most one.

The optional A-to-B-to-T formula (13) has the same correct endpoint signs. It is used for T>=B (in particular the selected T=60343058); it is not needed in the selected dependency chain.

## 4. Selected evidence and scope

The selected formula (12) uses the accepted head count/Q review and the distinct RH1500 sign-saturation review. A count alone would not prove the required localization. The actual head evidence supplies N(1500)=1069 and Q1500<1.668; its separate sign-saturation argument supplies finite RH on the closed head. Neither new zero data nor simplicity is assumed by the symmetry inequality.

The selected remaining band is now explicitly

    1500 < |gamma| <= 60343058,
    .445 <= beta <= .555.

Its lower real-part bound follows from the shared upper .555 assertion and principal symmetry at unchanged height. That shared assertion remains a finite certificate obligation. The optional RH2000 review was read and does support the alternative formula, but it is not a dependency of the selected formula (12).

Source `ZetaZeroSums.lean` contains `rh_upto_1e8` with a PlattGRH binder near the unconditional carrier theorem. That theorem is not used here. The Gaussian endpoint bound, xi identities, local multiplicity transport, and finite summation by parts do not import its conclusion. This is a source-level dependency check, not an elaborated axiom-closure claim.

The new estimate is strong enough in form to replace the extra narrow-strip input if the separate scalar and Gaussian-sandwich assembly succeeds. This review does not certify that success. Both sandwich signs, their denominators, vertical error, high zeros beyond the shared height, and the finite prime range must still be accounted for in their respective reviewed tasks. The global seven-eighths provider is unnecessary for the finite symmetry lemma and remains necessary in the separate high-zero argument.

No correction to the mathematical formulas is required. The accepted final pin includes the author's correction of the selected cutoff from one million to the full shared height. All Lean implementation, formal finite-data replay, and remaining original Goldbach obligations retain their existing status.
