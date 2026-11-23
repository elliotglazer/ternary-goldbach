# Review of the complete large-character error contract

2026-11-11. PASS at conditional paper/source-composition scope. No author correction requested. The packet correctly separates the complete polynomial input allowance, intrinsic transform error and subsequent analytic consumers. It does not select an end-to-end tolerance, production precision or successful sign/count certificate.

The frozen author is `audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md`, SHA256 `96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D`. Its scalar script is `42C666E3C0F419FCE4795A21D54A22727FEBBF8D49B8EB7F8324ED550FBDE650`; its receipt is `86C2F5441C5E706DEEA1976AC00026E0F3E39FBB492CC31E524C4BC1636091C6`. All paths below are relative to `work/qrh-campaign/agents` unless stated otherwise. Frozen author artifacts were not changed or executed.

## The polynomial allowance is already complete

I read the variable-degree FD source `79F8EA3F`, especially sections 4–5, its review `F77403A3`, the matched Horner source `AEAB2BDC`, and the shorter-order proof `0EAED4F9` with review `B15D0C3B`. Their current alpha bound is

    A_alpha = T_K + S_shift + N_source + 633 E_eval < 2^-82.

The source and finite-translation numerical errors are in N_source. The analytic difference between finite translated coefficients and genuine fine-anchor derivatives is in S_shift. The chosen evaluator's coefficient conversion, state/operation and output errors are in E_eval. The old evaluation allowance is replaced, not retained as a second charge. Prefix restriction uses the actual positive weighted coefficient bounds; it does not assert a false uniform per-coefficient eta bound. Direct original-center conversion and conversion through an already rounded cache are distinct contracts.

The essential hypothesis for equation (L) is the direct operator inequality

    |c^-s T_chi(f_true - f_centers)| <= A_alpha.

The author's stronger sufficient construction, `c^-1/2 sum e_poly,a <= A_alpha`, is justified for the inspected current circuits: their Taylor, translation, source and evaluation bounds are positive pointwise envelopes, then amplified by `phi(c)/sqrt(c)<=633`. This does not infer a per-input radius by dividing an arbitrary operator bound by 633. A later producer with only the direct operator bound can use it directly. It need not reconstruct separate input balls. Conversely a different evaluator must supply its own matching bound and cannot borrow another circuit's smaller radius while retaining its cost.

Exact export to grid100 followed by embedding into a finer common dyadic grid adds no error and restores no accuracy. A new inexact representation step belongs in J. No second N_source, translation term, factor633 or propagated input-radius charge is warranted.

## Actual character operator and scaling

I checked the positive, unnormalized unit-group identity against `integration/UNIT_GROUP_CHARACTER_TRANSFORM_PLAN_2026-11-11.md`, SHA256 `DFA02789B3025A997F98E0500B001B3C5A7D983C400EEDC8F7B6DD4ADDAE4866`, sections 2–4. Its actual-character map, CRT coordinates, flattening and inverse permutation matter. A normalized inverse transform requires restoration of phi(c); a negative-sign transform requires label reversal. These changes are unrelated to c^-s. Primitive pruning does not dispense with the retained output's character identity. Conjugation at negative height does not identify two different nonreal positive-height channels.

At s=1/2+it the raw Hurwitz identity is away from the pole. The stored polynomial approximates the shifted Hurwitz part; the finite head is a separate input. Historical `int-l-func5.11.cpp:697–740` adds that head before the transform, consistent with the identity. This code is schedule evidence, not a proof of its arithmetic enclosures.

For q=c^-s, exact stored transform S and computed center Shat, the decomposition is

    q(T_true-S) + q(S-Shat) + (q-qhat)Shat.

The first term receives A_alpha+H+J, the second the already conductor-scaled intrinsic epsilon_T, and the third `|Shat| e_q`. Final multiplication/serialization contributes e_sc. This proves (L) without a further input-error/scaling-error cross term. Magnitude bounds must enclose the actual stored Shat. H is already conductor-scaled and is not the head radius-at-most-one used merely to bound stored magnitudes. Attaching the head after scaling through `q*(a/c)^-s=a^-s` is a valid different circuit, with replacement rather than duplicate head charges.

## Intrinsic precision and setup uncertainty

I checked the original mixed-radix precision supplement `4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4`, the magnitude source `9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2`, and the large-transform cost source/review `DAEA8130`/`1A0DE2B9`.

The transform theorem is applied to the exact stored centers. Its root/chirp radii, cached nonunit Bluestein kernel error and local rounding are already included in the intrinsic estimate. Their construction and binding remain required setup work, but their same error is not charged again outside that estimate. The later root-number phase epsilon_chi is a separate object.

The conservative coefficient is exactly

    2*633*202305920*2^14 = 4196258524692480.

Together with the two stated safety inequalities, exhaustive integer precision comparison gives minimal sufficient p=112,134,152 for intrinsic allowances 2^-60,2^-82,2^-100. These are minima of the displayed sufficient bounds only. In particular two separate allowances of 2^-82 sum to 2^-81, before head, scaling or phase costs. The head's coarse magnitude bound cannot be substituted for its required small accuracy radius.

A normalized-cache implementation needs its own proof of the same exact unnormalized transform of the same stored input and a valid new intrinsic estimate. The author correctly leaves this pending rather than transferring the old bound by notation.

## Sign proxy and interpolation are different consumers

The exact proxy theorem `06C9D3BF` fixes one root phase for the character and gives P=H cos(delta), with a strictly positive cosine for both parities. Thus the Binet phase discrepancy is not an additive error in the exact proxy. Only approximation of the specified proxy contributes numerical phase error. Splitting at the exact unit multiplier gives

    r_P = r_L + |Lhat|[e_eps*(1+f)+f] + e_P.

This charges coefficient uncertainty and the numerical cis error once, including their cross term. The norm of the computed coefficient need not equal one. A real-angle approximation contributes to f by the real-angle Lipschitz bound. Strict acceptance remains `|Phat|>r_P`; changing the phase branch between bracket endpoints would invalidate the sign argument.

I independently compared historical code lines 575–616 and 889–890 with the reviewed completion. The code multiplies its DFT by `c^-1/2 exp(-it log(c*pi)/2)`, its root phase and `Gamma(alpha+it/2) exp(pi*t/4)`. Relative to ordinary L this yields

    Y_src = exp(pi*t/4)|Gamma(alpha+it/2)| H.

The reviewed tilted function is `F_eta=pi^-alpha exp(pi*eta*t/4)|Gamma|H`. At eta=1 their ratio is pi^alpha; at other eta it also depends on t. Positivity preserves signs, not absolute sample radii or interpolation tails. A strict-tilt theorem cannot simply be applied at eta=1. This is a material remaining interpolation obligation, which the author states explicitly.

For a valid selected Y=AUL, the sample bound `r_Y<=Abar*r_L+|Lhat|e_m+e_Y` follows by splitting at the exact multiplier. For finite kernel interpolation, the product estimate is

    |K Y-Khat Yhat| <= (|Khat|+r_K)r_Y+|Yhat|r_K.

It contains one kernel/input cross term. Summation adds actual finite arithmetic error and both the Fourier and omitted-sample tails. Neither positive proxy equivalence nor a small transform radius supplies those tails. The coefficient of local transform error is exactly `(|Khat|+r_K)Abar`, summed over the actual dependency set. Padding, inverse-character guard values and low-height domains remain theorem-specific requirements.

## Count closure and what remains needed

I checked the endpoint addendum `6759192E`, elementary Turing assembly `72275B5C`, pair-deficit source `6E7CD152` and its independent review, together with the actual repository definition `work/ternary-goldbach/TernaryGoldbach/MajorArcs/GRH.lean:32`. That definition requires every actual zero with 0<Re(rho)<1 and closed |Im(rho)|<=T to lie on the line. Multiplicity is essential in the count argument, even though it is not a separate binder of GRHUpTo.

The closed count includes real zeros. Nonreal characters need their inverse positive channel to cover negative heights. For a real character the positive channel is doubled; a central contribution is not doubled. K must be a lower count of critical zeros with valid multiplicity and no duplicated evidence. The strict test

    h*(K+2)-Abar+W-2Bbar > 0

then rules out an off-line reflected pair, using the actual same-character order-preserving symmetry. It is sufficient for finite RH, not an exact zero list. Exact-count consumers retain their stronger saturation condition. Abar is a canonical phase-integral bound, not an integral of the sign proxy; W is certified interval/count evidence, not an approximate list of ordinates.

A complete precision choice therefore still needs actual input/head/scaling records, phase and magnitude enclosures, any chosen interpolation theorem and its parameters, strict output margins, and auxiliary/count evidence. The displayed conditional selection inequality is valid only with a positive remaining margin and the chosen circuit's current centers. Refining transform arithmetic alone cannot overcome a sufficient non-transform radius that already exhausts that margin. This says nothing about a lower bound for the true error, or whether the true value vanishes. No current p case is promoted to a complete sign or completeness guarantee.

## Independent evidence and scope

Owned checker `zero-sum/review_large_character_complete_error_contract_20261111.py` has SHA256 `C1F5CA7518791FCDD6046292C06691C6793B015046E0BD480F4A74038CE35F6A`. Its exclusive receipt has SHA256 `6B48C14FA0E07B8A1BCC537BD8DF9BB8EDF620D07DB86DDAA424752C5EAB392D`.

All 43 exact checks passed. They verify the three author artifacts and all 21 author source pins, independently search the sufficient integer precisions, and check five formal polynomial identities for the scaling, proxy, amplitude and interpolation decompositions. The receipt records 27 source/artifact pins including the additional operator, magnitude and precision sources. These algebra checks supplement the source arguments; they are not analytic function evaluations or a new transform inventory.

No author program, spectral evaluator, build or scan was run. No source or frozen artifact was changed. This review accepts the conditional error composition and its explicit missing interfaces. It does not establish an implemented checker, a numerical margin, full-family RH, an end-to-end price or formal axiom closure.
