# Scratch-helper mathematical review

Reviewer: independent worker 8. Date: 2026-11-10. No other worker's files were edited. This is a pre-compilation mathematical review, not a theorem-closure or frozen-statement audit.

The source APIs were checked at ternary-goldbach commit 23b2d68ca344203d4384e0aff7affa4ec034bef9.

## Reviewed snapshots

- prime-estimates/QrhPsiNumeric.lean: SHA256 8383D2138A4D40739C8F8C51884FCD115268A1C54B2E8F11FC453EF340834C93.
- prime-estimates/QrhPsiAux.lean after numerical lemmas were split out: SHA256 26B13DDE4C46281C4B05FBC96D7621FA225B561699F18E782D1A2FCC477A5ED4.
- prime-estimates/QrhPsiMid.lean: SHA256 825F05F329ACDC13F200E101466F191089B83188BE37C01BA9FEDE926CF8F6FE.
- zero-sum/ZeroSumStrip.lean: SHA256 32E56AE643A5336BFD284A000D3F29E297EB5AB20B19B8567471014F389A30B7.

Files changed during the review as the numerical lemmas were moved. The results below refer to the displayed split statements, with hashes recorded after reading. This is not an atomic manifest freeze.

## Verdict

No mathematical defect found in any displayed statement or argument. No compilation was run. Syntax, elaboration, imported theorem types, and axiom closure still require Lean verification. In particular this review does not certify that every nlinarith, simp, or field_simp invocation closes its goal.

No reviewed scratch file declares a Fact PlattGRH hypothesis, an axiom, or a sorry. Relevant source transform and numerical lemma declarations have no PlattGRH binder. Imported PsiAsymp contains a conditional theorem psi_asymp8, but importing it does not add an ambient hypothesis. None of the reviewed proofs applies psi_asymp8.

## Gaussian Mellin bound

Exact type, with a,b,delta real and s complex:

    b <= 0 ->
    1/8 <= Re(s) ->
    Re(s) <= 7/8 ->
    ||Mg a b delta s|| * max(1/8, |Im(s)|)
      <= 2 exp(delta^2/2 + |a|).

GaussSmooth.lean:108 defines Mg as exp(delta^2*s^2/2) times the oriented integral from b to a of exp(s*w). Lines 317-321 give the exact Gaussian norm formula. Lines 355-361 give the integral norm bound by (exp(a*Re(s))+exp(b*Re(s)))/||s|| for s!=0.

The strip implies s!=0, Re(s)^2<=1, and max(1/8,|Im(s)|)<=||s||. The Gaussian factor is at most exp(delta^2/2) for every real delta; delta>0 is not needed for this formula. Since 0<=Re(s)<=1, a*Re(s)<=|a|. Since b<=0, b*Re(s)<=0<=|a|. Thus the numerator is at most 2exp(|a|). Multiplication proves the displayed claim.

No premise b<=a is needed because the norm of the oriented integral obeys the source bound in either order. The lower strip bound 1/8 is a real input here. A caller must actually prove it; QRH's upper bound 7/8 alone does not supply it without an additional reflection argument.

## Exponential absorption

The exact numerical claim is

    35000 <= L ->
    1e24 exp(7L/8) <= 5e-5 exp(L)/L^3.

For L>0, this is equivalent to 2e28 L^3 <= exp(L/8). The degree-16 Taylor term gives exp(L/8)>=(L/8)^16/16!. The proof uses the valid rational inequality

    2e28 * 16! * 8^16 <= 35000^13 <= L^13.

Multiplying by L^3 and dividing by 16!*8^16 gives the desired lower bound. The first rational comparison has about a factor 1004 of slack; that approximate ratio was checked in JavaScript and is only a diagnostic. The Lean proof uses exact norm_num arithmetic for it.

The rpow corollary assumes exp(35000)<=x. Therefore x>0, log x>=35000, exp(log x)=x, and x^(7/8)=exp(7log(x)/8). Its translation of the first inequality is exact. Both results have only their stated numerical domain assumption.

The constant 1e24 is not proved to bound a zero sum by this lemma. The caller still needs that independent estimate.

## Midrange bound

The exact claim is

    delta^2/2 + |a| <= 1e-6 ->
    35000 <= log x ->
    MidB0 a delta 1e8 3e10 x <= 5e-5/(log x)^3.

PsiLarge.lean:64 defines the scalar expression MidB0. PsiAsymp.lean:542 has the same proof with final constant 1e-4. The reviewed proof keeps the prior intermediate bounds and tightens only the final rational comparison.

Its estimates give exp(delta^2/2+|a|)<=1.000003, a floor-window count <=6.8e9, Z3g BPz2 1e8<=210.6, and c3g 10 1e8<=3.66e-7. Its logarithmic estimate gives

    (log x)^3 * exp(-log x/(11log(3e10))) <= exp(-60) <= 1e-26.

The resulting scalar upper bound is

    2*1.000003/1e8 * 6.8e9 *
      (2*210.6 + 2*3.66e-7*6.8e9) * 1e-26,

approximately 7.3424e-21, well below 5e-5. The approximate evaluation is diagnostic; the last Lean step uses norm_num.

The explicit type does not say x>0. That is harmless for this scalar lemma because its x-dependence is entirely through Real.log x. Applications to prime-counting expressions must still provide the domain required by their own theorems.

## ZeroSumStrip spot check

The count_strip_windowG statement is the previously reviewed radius-2.7 extension, with the original zerosRectD and multRectD. Its geometry and count transfer are valid.

sum_mult_strip_le applies LineZeros.lean:83-88 sum_window_le with constant function 1 and derivative 0. The interval has length 2*J*3.48. Its factor 1/3.48 leaves exactly 2*J*ZStrip. Thus this use proves the claimed total multiplicity bound without a new zero-count premise.

For sum_mult_zeta_low_le, XiPartial.lean:62 supplies

    log(BPz2(T)/0.355) <= 37+2.6|T|.

At T=1e8+3.48 the numerator is below 5e8. The proof obtains log(10/2.7)>=1/2 from log(0.27)<=0.27-1. Hence ZStrip BPz2 1e8<=1e9. The exact Jl floor is <=1e8, so total multiplicity <=2e17<=1e18. These coarse constants are valid.

For sum_weight_zeta_low_le, nonnegative g and

    g(u)*max(1/8,|Im(u)|)<=C

imply g(u)<=8C. Multiplying by nonnegative natural multiplicities and using the preceding count gives <=8e18*C<=1e20*C for C>=0. The proof retains multiplicities and imposes no simple-zero assumption.

The generic norm_zero_sum_le_rpow_mul is valid for x>=1 and Re(u)<=theta by the triangle inequality and the positive-real-base complex-power norm identity.

## Remaining obligations

These are valid internal estimates, not root proofs. A completed application still needs the actual QRH strip theorem at every relevant zero, the Mellin and zero-sum composition, the explicit-formula limit, all other error terms, and the final numerical margin at the required threshold. Compile the narrow helpers and inspect exact theorem types and axioms before promoting any result.

