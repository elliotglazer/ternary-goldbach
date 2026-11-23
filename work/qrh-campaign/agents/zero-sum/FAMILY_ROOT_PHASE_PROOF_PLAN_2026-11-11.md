# Exact root phases and inverse-character sign channels

2026-11-11. This note gives an exact phase definition, a finite interval certificate for that definition, and the sign/multiplicity rules for inverse-character reuse. It does not compute family phases, signs or zero counts, and supplies no Lean implementation. Previously frozen packets are unchanged.

The inputs are actual primitive nonprincipal complex Dirichlet characters from the reviewed arithmetic manifest. The Gaussian identity and alias rules retain their reviewed normalization. In particular, for parity a in{0,1}, k=a+1/2, real eta with |eta|<1 and b=pi*eta/4,

\[
 F_{\eta,\chi}(t)=c^{-k/2}e^{bt}Z_\chi(t),\qquad
 Z_\chi(t)=\epsilon_\chi\Lambda_\chi(1/2+it),
\]

where Lambda is the source entire conductor-completed L-function. Equivalently F=epsilon*exp(bt)*c^(it/2)*source completedLFunction. The new task is to define and enclose epsilon, not to replace that function by a nearby one.

## 1. Exact root number and its finite enclosure

For c>1 and primitive chi of parity a, use

\[
 \tau_\chi=\sum_{r\bmod c}\chi(r)e^{2\pi i r/c},\qquad
 W_\chi=\frac{\tau_\chi}{i^a\sqrt c}.
\]

The source theorem proves |Wchi|=1. Write W=u+iv, so u^2+v^2=1 exactly. An interval whose norm is close to1 does not prove this identity; it is an analytic/arithmetic theorem attached to the exact primitive character.

The finite manifest fixes every chi(r) as an exact root of unity on units and0 elsewhere. A possible data producer evaluates the finite Gauss sum using certified root-of-unity rectangles, then divides by the exact i^a and positive sqrt(c). A rational enclosure0<l<=sqrt(c)<=h follows from l^2<=c<=h^2. Each root-of-unity rectangle must enclose the specified positive-exponent root, with a proved trigonometric or algebraic construction. A black-box complex exponential or an unidentified root of a cyclotomic polynomial is insufficient.

This yields a rational rectangle U+iV containing the exact W. Intersecting each coordinate interval with[-1,1] is sound because |W|=1. No assumption about the accuracy of an existing Gauss-sum computation is used here. The sound interval primitives and their finite inputs remain a producer obligation.

Conjugation gives an exact identity valid at composite as well as prime conductors. Directly conjugating the finite sum and changing r to-r gives

\[
 \overline{\tau_\chi}=(-1)^a\tau_{\bar\chi},\qquad
                 W_{\bar\chi}=\overline{W_\chi}.                         \tag{1}
\]

Here bar chi is the actual inverse character, with the same parity. The factor(-1)^a in the Gauss-sum identity cancels the conjugation of i^a. This proof uses a permutation of the finite ring ZMod c; it does not require ZMod c to be a field. A theorem stated only for finite fields cannot be substituted at a composite conductor.

## 2. Two phase formulas without a branch-cut search

Define two overlapping formulas on the unit circle.

If u>-1/2, set

\[
 r_+=\sqrt{(1+u)/2}>1/2,\qquad
 \epsilon_+(W)=r_+-i\frac{v}{2r_+}.                                     \tag{2}
\]

If u<1/2, set

\[
 r_-=\sqrt{(1-u)/2}>1/2,\qquad
 \epsilon_-(W)=-\frac{v}{2r_-}+i r_-.                                   \tag{3}
\]

The signs + and - name formulas, not arithmetic negation. Formula(2) chooses the root with positive real part; formula(3) chooses the root with positive imaginary part. Both are exact expressions in real square roots of positive numbers. Neither asks a numerical library to choose a complex square-root branch.

For(2), v^2/(4r_+^2)=(1-u)/2. Hence the squared norm is1 and the square is u-iv. For(3), v^2/(4r_-^2)=(1+u)/2, which gives the same two conclusions. Therefore either accepted formula satisfies

\[
 |\epsilon(W)|=1,\qquad \epsilon(W)^2=\bar W,
                      \qquad\epsilon(W)^2W=1.                           \tag{4}
\]

These are algebraic consequences of u^2+v^2=1 and the positive real square-root equations. They are not conclusions from small numerical residuals.

The certificate selects formula(2) if inf(U)>-1/2, or formula(3) if sup(U)<1/2. If the width of U is less than1, at least one of these strict tests must pass: failure of both would force inf(U)<=-1/2 and sup(U)>=1/2. Thus the overlap removes the usual branch-cut ambiguity at W=-1. At W=-1, formula(3) gives epsilon=i; at W=1, formula(2) gives epsilon=1. If both tests pass, a fixed tie rule chooses one. There is no continuity requirement as the discrete character label changes.

The phase is fixed once for the entire character channel. Selecting a different formula at each height or FFT frequency could replace the phase by its negative and fabricate sign changes. A phase identifier is therefore part of every dependent numerical record.

## 3. What the interval certificate proves

A phase record can contain these fields:

* The exact conductor and primitive-character label, parity, and root-of-unity convention from the arithmetic manifest.
* The finite Gauss-sum enclosure U+iV and references to its sound input enclosures.
* A formula tag, `positive_real` or `positive_imaginary`, and the corresponding strict rational inequality on U.
* Rational positive bounds rlo,rhi for the relevant real square root, checked by squaring against the corresponding radicand interval. One may require rlo>=1/2.
* A rational rectangle E obtained from(2) or(3) by sound interval addition, multiplication and division by the positive interval[2*rlo,2*rhi].

Acceptance proves that E contains the exact epsilon defined by the chosen formula. The generic phase lemma(4), applied to the exact W, proves the unit norm and square identity. The center of E is not asserted to be a unit or an exact square root.

All divisions stay away from0. A convergent interval evaluator for the finite Gauss sum eventually gives a real-part interval of width<1, so a formula can be selected. Subsequent rational square-root refinement and interval arithmetic can enclose that same formula to any requested positive accuracy. This is a termination argument for the phase-selection step, conditional on the sound convergent interval primitives. It is not a claim that those primitives or all family records already exist.

The phase enclosure can enter the Gaussian coefficient evaluations by interval multiplication. Its error is then included in the per-coefficient input bounds from the alias plan. It must not be replaced by an unproved point value and later justified by an imaginary interval containing0. Sharing the same phase across coefficients may permit a sharper correlated error bound, but the sum of independent absolute input errors remains a sound conservative bound.

## 4. Real Hardy values and preservation of zeros

The reviewed theta/Mellin proof gives

\[
 \Lambda_\chi(s)=W_\chi\Lambda_{\bar\chi}(1-s),\qquad
 \overline{\Lambda_\chi(s)}=\Lambda_{\bar\chi}(\bar s).
\]

On s=1/2+it, these imply Lambda_chi(s)=Wchi*conj(Lambda_chi(s)). Equation(4) and |epsilon|=1 imply epsilon*Wchi=conj(epsilon). Therefore

\[
 \overline{Z_\chi(t)}
 =\bar\epsilon_\chi\overline{\Lambda_\chi(s)}
 =\epsilon_\chi W_\chi\overline{\Lambda_\chi(s)}
 =Z_\chi(t).
\]

Thus Zchi(t) and F_eta,chi(t) are real for every real t. The factor c^(-k/2)exp(bt) is strictly positive. They have the same signs and real zeros, and each has the same zero multiplicities as L(s,chi) under s=1/2+it. Indeed the critical-line Gamma argument has real part1/4 or3/4; Gamma, the conductor exponential and epsilon are nonzero. The local variable change t to1/2+it has nonzero derivative i.

A computed real-part interval excluding0 therefore certifies the sign of this exact real function. An imaginary interval containing0 is only consistent with the theorem, and does not prove it. An interval containing0 in its real projection certifies no sign and no zero.

Continuity and opposite strict endpoint signs on a real interval give at least one critical-line zero in its interior. They do not prove that there is only one zero, that it is simple, or that all zeros have been found. Those conclusions require the separate complete count and integer-saturation argument.

## 5. Exact inverse-character reuse

The inverse-label map is an involution in the arithmetic manifest. For a nonreal two-element orbit, choose one representative by a fixed exact ordering, construct epsilon_chi once by(2) or(3), and define

\[
                    \epsilon_{\bar\chi}=\bar\epsilon_\chi.              \tag{5}
\]

Equation(1) proves that this is a valid phase for the inverse character. Its interval enclosure is the conjugate rectangle. The partner record is tagged `conjugate_of`, rather than claiming it necessarily equals the independently selected positive-real or positive-imaginary formula for its own root number.

More generally, if two channels already have independently defined valid phases, put

\[
                 \kappa=\epsilon_\chi\epsilon_{\bar\chi}.
\]

Equation(1) and(4) give kappa^2=1, so kappa is exactly+1 or-1. Conjugating the completed L-function and using the already proved real-valuedness gives

\[
 Z_\chi(-t)=\kappa Z_{\bar\chi}(t).                                    \tag{6}
\]

For the orbit convention(5), kappa=1. With independently stored phases, a rigorous interval for their product whose real part is strictly positive or strictly negative determines kappa, because the exact product is already known to belong to{+1,-1}. No phase matching should be inferred from approximate angles.

There is a concrete trap here. Applying the positive-real formula to both W and bar W gives kappa=1 when that formula is valid. Applying the positive-imaginary formula to both gives kappa=-1. For example epsilon=(5+12i)/13 has W=bar(epsilon^2)=(-119-120i)/169. Formula(3) for bar W selects(-5+12i)/13, which is minus the conjugate of epsilon; their product is-1. Both channels are valid real Hardy functions, but their opposite-height signs differ. This is why independent branch choices do not establish compatibility.

Including the tilt, equation(6) becomes

\[
 F_{\eta,\chi}(-t)=\kappa F_{-\eta,\bar\chi}(t)
              =\kappa e^{-2bt}F_{\eta,\bar\chi}(t).                     \tag{7}
\]

The exponential in the last identity is positive. Thus one may reuse a partner's positive-height sign for a negative-height sign, with the exact factor kappa. Reusing numerical values or absolute errors additionally requires the magnitude factor in(7). A positive-eta alias bound must not silently be substituted for a negative-eta bound without this scaling or an explicit new application of the alias theorem.

Conjugation preserves the height and multiplicity of the reflected zeros. This rule reduces duplicate computation; it does not erase the negative-ordinate contribution to the total zero count.

## 6. Self-conjugate characters and the central point

The manifest detects self-conjugacy exactly by2*r_i=0 modulo every coordinate order. For such a character, equation(1) gives W=bar W, hence W is+1 or-1. A rational enclosure separating these alternatives can identify the sign. This design does not assume a separate quadratic Gauss-sum theorem proving W=1 for real primitive Dirichlet characters; if such a theorem is later used, its precise source and hypotheses must be supplied.

There is only one channel in a self-conjugate orbit, so it cannot generally be assigned both epsilon and its conjugate. With its one chosen phase, kappa=epsilon^2=1/W=W, and

\[
                         Z_\chi(-t)=W_\chi Z_\chi(t).                    \tag{8}
\]

If W=1 the exact phase formulas give epsilon=1 and Z is even. If W=-1 they give epsilon=i and Z is odd. The second case would force a central zero by the functional equation. It is a sound conditional branch of this design, not an assertion that such a real primitive Dirichlet character actually occurs.

For central acceptance the simplest record proves Zchi(0) != 0 by a strict interval, giving central multiplicity0. If the central interval contains0, it remains unresolved. In particular, an interval containing a tiny value is not evidence for an exact zero. For a forced or otherwise exactly proved central zero, an exact multiplicity record needs vanishing of all derivatives below some r and a nonzero r-th derivative. The vanishing statements must be proved equalities, not interval overlaps with0. A strict derivative enclosure can prove the final nonvanishing. In the W=-1 self-conjugate branch, symmetry supplies the constant-term equality and all even derivative vanishings; a nonzero first derivative would establish order1. In the W=1 branch a central zero, if present, has even order. Neither symmetry alone determines its exact order.

One can apply analytic order to the entire function of a complex variable z given by epsilon*Lambda_chi(1/2+i*z). Its restriction to real z is Z. The nonzero completion factors and affine change of variable preserve order relative to L at1/2. The source analytic-order derivative criterion supplies the natural formal interface.

For a nonreal pair, the central multiplicities of chi and bar chi agree. In the closed count Cchi(T) of all zeros of chi with |Im rho|<=T, the sign lower count is

\[
 K_\chi^+ + K_{\bar\chi}^+ + r_\chi.
\]

The central multiplicity is included once, not twice. For a real character the lower count is2*Kchi^+ + rchi. Both formulas still leave possible off-critical real zeros to the complete count. A nonzero value at s=1/2 does not exclude real zeros at other beta.

## 7. Source interfaces and proof tasks

Source pins remain Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679` and Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The relevant inspected declarations are:

| Source | Role |
| --- | --- |
| `Mathlib/NumberTheory/DirichletCharacter/Basic.lean:404,532,535` | `conductor_inv` and the exact `Odd`/`Even` predicates. |
| `Mathlib/NumberTheory/MulChar/Lemmas.lean:61,73,79` | Pointwise conjugation, `star_eq_inv` and `star_apply'`. |
| Goldbach `Prelim/GaussInduced.lean:168,175` | `gaussSum_eq_sum_range` identifies the finite positive-exponent sum; `norm_sq_gaussSum_of_isPrimitive` gives its exact norm. |
| Goldbach `Explicit/LGrowthLeft.lean:221` | `norm_rootNumber` proves the actual source root number has norm1. |
| `Mathlib/NumberTheory/LSeries/DirichletContinuation.lean:249,258,271,283` | Entire nonprincipal completion, its Gamma relation, exact root-number definition and primitive functional equation. |
| `Mathlib/Analysis/Real/Sqrt.lean:177,285` | `Real.sq_sqrt` and `Real.sqrt_pos` supply the algebra of the positive real roots in(2)-(3). |
| `Mathlib/Analysis/Complex/Circle.lean:54` | `Circle` is the complex unit sphere, a possible carrier for the exact phase. A rectangle enclosure is separate data, not a Circle value. |
| `Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean:69` | `Gammaℝ_ne_zero_of_re_pos` proves nonvanishing of the Gamma factor on the critical line. |
| `Mathlib/Analysis/Analytic/Order.lean:92,472,524,588` | `AnalyticAt.analyticOrderAt_eq_natCast`; `analyticOrderAt_eq_nat_iff_iteratedDeriv_eq_zero`; order under multiplication; and order under composition with a nonzero derivative. These support central multiplicity and transfer, with their analyticity premises retained. |

The finite-sum proof of(1) should be packaged for arbitrary positive conductor, rather than using a convenient Gauss-sum identity whose binder requires a finite field. The new phase lemmas are elementary real/complex algebra with u^2+v^2=1 and the two chart inequalities. They can return a `Circle` value together with epsilon^2*W=1. A separate interval checker proves membership in the advertised rectangle using rational square inequalities and sound field operations.

Further new adapters are the actual-completion conjugation identity, real Hardy-value theorem, orbit phase assignment, the kappa sign rule, and zero-order transfer for the chosen entire completion. The reviewed theta/Mellin derivation supplies the conjugation identity on paper; this note does not claim a ready Lean implementation of that packaged result.

The proof obligations for interval trigonometric/root-of-unity evaluation, positive sqrt(c), and Gaussian/FFT numerical enclosures remain separate. A phase certificate does not establish any central derivative equality or any zero count. All data-dependent failures must remain unresolved until the relevant exact inequality or equality is provided.

## 8. Handoff

The two overlapping formulas remove a branch-cut obstruction while keeping the exact phase fixed per character. The orbit convention(5) gives direct inverse-character sign reuse; equations(6)-(8) handle independently chosen and self-conjugate phases without assuming compatibility. The central-count rules preserve multiplicity and both ordinate signs.

No special-function calls, finite scans, FFTs, Lean builds or source changes were made. Independent review is requested. The remaining implementation work is explicit, and no family spectral conclusion follows from this phase design alone.
