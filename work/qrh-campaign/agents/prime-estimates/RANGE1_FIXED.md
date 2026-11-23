# Tight low-zero estimate and the exp(20000) extension

Status: complete scratch proof scripts, uncompiled. The original coarse fixed-gap and both QRH variants are preserved. No canonical source edit or new compiler process was made.

## One analytic proof, two consumers

`PsiFixedTightFormula.lean` imports only PsiLarge, PsiFixedAux, ZeroFreeFixedGap and ZeroSumStrip. It proves the complex and real smoothed-sum bounds with low-zero term

    3e10 * x^(249/250).

The rest of the explicit-formula bound is unchanged:

    x*(MidB0(a,delta,1e8,3e10,x) + MidBH(a,delta,3e10,Gamma,x))
    + x*TailBG(a,delta,Gamma) + x^(-1/2)*Vg(a,b,delta)/(2*pi).

The exact low-set carrier and natural multiplicities match the original explicit formula. ZeroSumStrip.sum_mult_zeta_low_sharp_le now bounds their sum by3e10. At each low zero, abs(im)>=2.39 and

    norm(Mg)*abs(im) <=2exp(delta^2/2+abs(a)) <=2.000004 <2.39,

so norm(Mg)<=1. The fixed zero-free gap gives Re(rho)<=249/250. No lower real-part gap is assumed.

The formula proof is independent of PsiRange1 and PsiAsymp. It should be the sole analytic assembly landed in production; the older coarse scratch copies are retained only for comparison and rollback.

## Exact adjacent-range budget

`PsiFixedTightNumeric.lean` proves

    3e10*x^(249/250) <=6e-25*x, x>=exp20000.

It uses5e34<=exp80 and log(x)/250>=80. The elementary exp_nat_ge'80 argument is inlined from Real.exp_one_gt_d9 and Real.exp_one_pow, so the file has narrow Mathlib imports instead of LogNumerics' full Mathlib import. No asymptotic or unspecified constant is used.

`PsiRange1Fixed.lean` applies the tight formula at delta=1.4e-15, Gamma=6.43e15, b=log(1e10/x), abs(a)<=1.26e-14. Existing unconditional source bounds give:

| Term | Bound |
| --- | --- |
| Low zeros | 6e-25*x |
| First middle bin | 1e-20*x |
| Remaining middle bins | 7.6e-15*x |
| Tail | 1e-17*x |
| Left contour | 1.82e12 |

Since6e-25+1e-20 <1e-17, these imply exactly the original error budget

    14990*sqrt(x) +7.61e-15*x +1e-17*x +1.82e12.

The sqrt term is not needed by this new estimate but remains in the unchanged public budget. `psi_range1_err_fixed` has the same hypotheses and conclusion as production psi_range1_err8, without Fact PlattGRH. Applying the existing unconditional psi_range1_of gives

    psi_range1_fixed {x} (exp20000<=x): abs(psiR(x)-x)<=2.1e-14*x.

`PsiAsympFixedTight.lean` reuses the same tight formula. It inflates the coefficient3e10 to1e24 by monotonicity and applies the existing fixed_low_rpow_absorb, giving the unchanged exp35000 and.2*x/log(x)^3 theorem. There is no duplicate analytic formula proof in these two consumer files.

## Minimal production integration

This extends the earlier PRODUCTION_INTEGRATION.md, whose retained-Range1 classification applied only to the coarse exp35000 result.

1. Land and compile the local zero lemmas, PsiFixedAux, PsiFixedTightFormula, PsiFixedTightNumeric and the existing fixed numeric/half-middle helpers under production module names.
2. PsiRange1 already imports PsiLarge. Add its upstream imports PsiFixedTightFormula and PsiFixedTightNumeric. Replace the body of psi_range1_err8 by psi_range1_err_fixed's proof and remove its local Fact binder. Remove the Fact binder from psi_range1_8 as well; its existing wrapper body can remain unchanged. Neither new imported file imports PsiRange1, so there is no cycle.
3. PsiAsymp already imports PsiRange1. Replace the final psi_asymp8 body by psi_asymp_fixed_tight's proof and remove its local Fact binder, as described previously. Keep psi_asymp_of in place.
4. ThetaExplicit's production calls remain unchanged. Its entire log(n)>=20000 part now uses unconditional results, but the full theta_explicit signature still needs Platt for the smaller branches. No full Mertens or Schoenfeld signature should be changed solely on this basis.

The exact public signatures that this extended tranche can remove Platt from, after compilation and audit, are psi_range1_err8, psi_range1_8, and psi_asymp8. The small-range tables, psi_plateau8, psi_two_sided, theta_mid and the full theta_explicit still require separate work.

## Focused build order and audit

After the project core and zero_sum local lemmas compile:

1. PsiFixedAux and PsiFixedTightFormula.
2. PsiFixedTightNumeric and PsiFixedNumeric, then the already drafted QrhPsiMid.
3. PsiRange1Fixed and PsiAsympFixedTight.
4. PsiFixedTightAudit prints the exact types and transitive axioms of both range1 declarations and the far-asymptotic declaration.

No theorem-completion claim is made before these checks.

Pre-compilation hashes:

- PsiFixedTightFormula:02570DF202D6AF73AF867052DC28C1A73E8BC5EF2BA0C1BF80C995773D28568F
- PsiFixedTightNumeric:0A023F266F7111267370FC16596350D628B1B9F1E222C5576B8022FF8E957112
- PsiRange1Fixed:65625937E685F0F3B66EA939B3B82813B6588B1CC1D30E793093367B1A36BFDE
- PsiAsympFixedTight:95C083D6FEC6B7092E34B30309952459EAF77B0DD163391FDD972B3AD03B41D5

Numerical validation attempt: the granted PsiFixedTightNumeric process (PID43944, exec session3705) was stopped by the parent/integration scheduler when system commit headroom fell below1GB. The authoritative session returned exit_code=-1 and LEAN_EXIT=-1. fixed-tight-numeric.log contains no diagnostics. This is a resource interruption before validation, not a proof failure or success. No restart will occur without a new safe slot.


