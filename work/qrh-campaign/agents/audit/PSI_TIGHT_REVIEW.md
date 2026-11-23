# Sharper low-zero count and tight psi estimates

Status: no mathematical or source-level hypothesis defect found. Source-only independent review; no Lean compiler or axiom printer was run. The unchanged low-zero and fixed-gap providers retain the status in the prior reports.

## Exact snapshots

- ZeroSumStrip.lean: A774A98BD4FB23ECED6F848AE0D318CB97971DBC1433E1302A6BA4A6AD275CA7
- PsiFixedTightFormula.lean: 02570DF202D6AF73AF867052DC28C1A73E8BC5EF2BA0C1BF80C995773D28568F
- PsiFixedTightNumeric.lean: 4DAAF048A1764123FE565F96FF11878BD3C0BC6F0EBB663EA5DACA2DBFB4EF85
- PsiRange1Fixed.lean: 65625937E685F0F3B66EA939B3B82813B6588B1CC1D30E793093367B1A36BFDE
- PsiAsympFixedTight.lean: 95C083D6FEC6B7092E34B30309952459EAF77B0DD163391FDD972B3AD03B41D5

Original source pin remains23b2d68ca344203d4384e0aff7affa4ec034bef9. No frozen manifest was supplied. These are source comparisons, not approval of newly frozen declarations.

## Sharper count

sum_mult_zeta_low_sharp_le retains the exact old count inputs: a finite subset of zerosRectD zetaF T, real parts in[0,1], and |Im|<=1e8. Its conclusion is that the sum of the original multRectD multiplicities is<=3e10. There is no simple-zero premise and no relation required between T and1e8.

XiPartial.lean:49 states exactly

    log(BPz2(T)/.355)<=10.24+log(|T|+22)+9log(1.25(|T|+11)).

At T=1e8+3.48, the two positive logarithm arguments are100000025.48 and125000018.1. Both are<=1.3e8. The source exp_nat_ge'19 gives exp19>1.3e8, so both logarithms are<=19. The numerator is therefore<=200.24. The denominator log(10/2.7)>=.5 gives ZStrip<=400.48<=401; no inequality is reversed.

Jl(1e8)=floor(1e8/3.48)+1=28,735,633<=3e7. Thus the unchanged strip-count theorem gives at most2*3e7*401=2.406e10<=3e10. Both positive and negative height windows are accounted for in the factor2. The previous window geometry and multiplicity proof are unchanged.

## Unit Mellin bound and tighter formula

PsiFixedTightFormula replaces only the low-zero estimate in the prior audited formula. For every low zero, the unchanged unconditional height theorem gives |t|>=2.39 and PsiFixedAux gives

    ||Mg||*|t|<=2exp(delta^2/2+|a|).

The smoothing assumption bounds the exponent between0 and1e-6. The source exp_small_le gives exp(...)<=1.000002. Multiplying the height inequality by the nonnegative norm yields

    2.39||Mg||<=2.000004,

which implies||Mg||<=1. The margin2.39-2.000004=.389996 is substantial. No lower real-part gap or division by a possibly zero imaginary part is used. Combining the sharper multiplicity count and beta<=249/250 gives the low term3e10*x^(249/250).

The other four zero bins, their inclusive/strict endpoints, original multiplicities, the uniform-in-T bound, good-height limit, contour remainder, and real-sum conversion are unchanged from PSI_FIXED_REVIEW.md. The new formula imports PsiLarge, avoiding dependence on the downstream PsiAsymp consumer. No Platt/QRH premise was introduced.

## Relative absorption from exp20000

The exact bound(2.7182818283)^80>5e34 was independently verified using rational arithmetic. Since exp80 is larger than that rational power, L>=20000 gives

    exp(L/250)>=exp80>=5e34.

Multiplication by exp(249L/250)>0, followed by exponent addition, proves

    3e10*exp(249L/250)<=6e-25*expL,

because6e-25*5e34=3e10 exactly. The conversion to x^(249/250) assumes x>=exp20000>0 and uses the correct real-power identity. The inclusive endpoint is covered.

check_psi_tight_numeric.py independently replayed these inequalities and the count constants. It passed; results are saved in psi_tight_numeric_results.json. This is not Lean compilation evidence.

## Range1 consumer

PsiRange1Fixed.psi_range1_err_fixed preserves the exact original smoothing error budget, domain x>=exp20000, |a|<=1.26e-14, and log(1e10/x)<=a. Its fixed delta is1.4e-15 and Gamma is6.43e15. The proof derives b<=0 and delta^2/2+|a|<=1e-6, supplying every tight-formula premise.

The reused source helpers are unconditional:

- MidB_r1_le requires |a|<=1.3e-14 and logx>=20000, and bounds MidB by7.6e-15.
- MidB0_8_le requires delta^2/2+|a|<=1e-10 and logx>=20000, and gives1e-20.
- TailBG_r1_le requires |a|<=1.3e-14 and gives1e-17.
- Vg_le_gen requires0<delta<=1e-11, |a|<=1e-10, and x>=1e19, and gives2.54e-3/delta<=1.82e12.

All are discharged from the displayed assumptions; exp_20000_ge supplies x>=1e40. The sum of the low and middle relative constants is

    6e-25+1e-20+7.6e-15 <7.61e-15,

leaving9.9899994e-18 of relative slack. The added14990sqrt(x) is nonnegative slack, not an invoked critical-line bound. The tail and constant terms agree exactly with the original error budget.

psi_range1_of is unconditional and consumes that budget to give

    x>=exp20000 -> |psiR x-x|<=2.1e-14*x.

The original [Fact PlattGRH] annotations are scoped to psi_range1_err8 and psi_range1_8. Neither old theorem is invoked. The new psi_range1_fixed has the identical domain, function and conclusion, with no extra analytic input in its statement.

## Far-asymptotic consumer and remaining validation

PsiAsympFixedTight conservatively enlarges3e10 to1e24 and uses the already audited degree50 numeric helper at x>=exp35000. It preserves the old.2*x/log(x)^3 conclusion through the same psi_asymp_of budget. The tighter exp20000 numeric helper is not needed in that consumer.

No claim follows here about smaller x, the plateau range, or the Goldbach roots. Compile these exact sources and print final types and axioms before replacing production conditional declarations. Source imports and the absence of explicit Fact binders alone do not constitute a transitive axiom check.
