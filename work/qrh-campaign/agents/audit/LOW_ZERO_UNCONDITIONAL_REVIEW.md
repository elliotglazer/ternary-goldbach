# Unconditional low-zero source audit

Reviewed: agents/zero-sum/ZetaLowUnconditional.lean
SHA256: 7FA18BA1662B103599B81B36606A626FF1F0240861D369CB0A1B1464842E46AE
Source pin: calr3/ternary-goldbach, 23b2d68ca344203d4384e0aff7affa4ec034bef9.
Status: no mathematical defect found; source-only review. No compilation or axiom print performed by this reviewer. No frozen declaration manifest was supplied.

## Exact declarations and hypotheses

The first theorem, zetaF_ne_zero_of_half_le_re_of_abs_im_lt, assumes only 1/2 <= Re(s), Re(s) <= 1, and |Im(s)| < 2.39, and concludes zetaF(s) != 0.

The second theorem, abs_im_ge_of_nontrivial_zero, assumes only zeta(s)=0 and 0 < Re(s) < 1, and concludes 2.39 <= |Im(s)|. Neither declaration has a Fact PlattGRH, RHBelow, QRH, multiplicity, or height parameter. The proof uses no such hypothesis. This is a genuine removal of the RH assumption from the old height-floor auxiliary, subject to compilation.

## Identity, cancellation and constant

ZetaLowZeroFree.lean:224 states, for Re(s)>0,

    zetaF(s) = (s+1)/2 - s*(s-1)*(s+1)*Jzeta(s).

ZetaLowZeroFree.lean:58 bounds ||Jzeta(s)|| <= 1/(8*(Re(s)+1)), with exactly the same positivity hypothesis. Its source proves integrability of the scalar majorant and uses |P2| <= 1/8; no RH assumption enters.

Write sigma=Re(s), t=Im(s). Under the first theorem's assumptions, ||s+1||>0 and 8*(sigma+1)>0. A zero and the norm identity imply

    ||s||*||s-1|| >= 4*(sigma+1).

Only ||s+1|| is cancelled. The proof never divides by s-1, so Re(s)=1, including s=1, causes no invalid cancellation. zetaF is the regularized function: ZetaGrowth.lean:17 defines its value at 1 to be 1, and the identity applies there too.

AM-GM follows from (||s||-||s-1||)^2 >= 0 and the two norm-square identities:

    ||s||*||s-1|| <= sigma^2-sigma+1/2+t^2.

Combining gives

    t^2 >= 23/4 - (sigma-1/2)*(sigma-9/2) >= 23/4.

The product is nonpositive on [1/2,1]. But |t|<2.39 implies t^2<57121/10000<23/4; the exact gap is 379/10000. The proof's nlinarith conclusion matches these inequalities.

Pinned Mathlib Algebra/Order/GroupWithZero/Defs.lean:302 confirms mul_le_mul_iff_left_0 (Unicode subscript in source) cancels the common right factor: b*a <= c*a iff b<=c for a>0. The draft's cancellation API orientation is correct.

## Reflection and poles

In the right-half case, Re(s)<1 explicitly gives s!=1 before zetaF_of_ne converts zeta(s)=0 to zetaF(s)=0.

In the left-half case, r=1-s satisfies 0<Re(r)<1 and Re(r)>=1/2. Xi.lean:24 gives xiF(1-s)=xiF(s), and Xi.lean:56 gives xiF(s)=0 iff zeta(s)=0 only in the open strip. The draft supplies both open-strip hypotheses separately for s and r. It then derives r!=1 from Re(r)<1 before the second zetaF_of_ne conversion. Finally Im(r)=-Im(s), preserving the absolute-height hypothesis. No Gamma cancellation at a pole or boundary is used. No zero multiplicities are involved in these pointwise statements.

## Scope and next verification

The new second theorem can replace abs_im_ge_of_zeroH when only the lower imaginary-height bound is consumed. The original auxiliary takes RHBelow H and 2.39<=H; the new theorem does not need either.

This does not by itself remove RH from WeilLineSum.lean or MertensZeros.lean. The former separately calls hRH to place zeros on Re=1/2 and uses norm_Mg_line_gauss. The latter separately derives the critical-line equality for its low-zero sum and uses it in norm_Mg_div_le. Those additional uses remain substantive.

Minimal next target: compile this exact draft against the pinned source, print both theorem types and axioms, and retain source hash with the logs. Only then integrate the unconditional height-floor lemma and replace individual old auxiliary calls. No final Goldbach closure follows from this helper alone.
