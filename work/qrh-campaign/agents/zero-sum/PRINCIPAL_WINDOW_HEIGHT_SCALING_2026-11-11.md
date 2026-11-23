# Principal window verification: height scaling and its limits

2026-11-11. Paper/source research and exact scalar work only. No zeta, Gamma, zero or prime values, transforms, builds or production certificates were evaluated. This report gives a cost model for a conditional principal RH certificate. It does not establish that a candidate height proves a prime-gap theorem, or that signs/counts succeed there.

The fixed-window architecture has a coefficient component proportional to the integral of sqrt(t), and a different transform component proportional to the number of windows. Their unknown relative costs prevent inferring one runtime exponent from the published total. Wider windows can amortize coefficient construction, but their truncation parameters must change together. Neither H log H nor H^(3/2) is established here as the total cost of an optimized, fully checked computation.

## 1. Primary source boundary

Platt's 2017 experiment uses N=2^15, B=5476, h=176431/2048, J=104000, K=44 and 300-bit arithmetic, with later upsampling to 2^20. Its Appendix A/B bounds govern parameter changes. This is an isolation experiment; its final ordinate accuracy is unnecessary for a sign/count certificate. [Platt, sections 3–5 and appendices](https://research-information.bris.ac.uk/ws/files/78836669/platt_zeta_submitted.pdf).

The later Platt–Trudgian computation reaches H*=3000175332800. It reports 7.5 million core-hours, changes the arithmetic library and retunes the algorithm, without publishing the new full parameter tuple. It omits high-precision isolation and uses approximately .01 initial sampling spacing. The aggregate timing supplies no component breakdown. [Platt–Trudgian, section 2](https://arxiv.org/pdf/2004.09765).

The pinned implementation reference below is FLINT v3.6.0, not a claim about the exact historical executable. Its local-zero selector uses heuristic parameter formulas. Those formulas generate candidates; the error inequalities and complete zero count still decide acceptance. [Selector source](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/platt_local_hardy_z_zeros.c).

## 2. Literal arithmetic schedule

Let t denote a window center, h its Gaussian scale, B its full period, U its usable core width, A its sample density, N=AB a power of two, J its Dirichlet truncation, K its Taylor length, and p its arithmetic precision. U is not automatically B: enough overlap and interpolation guard samples must remain. A convenient conditional schedule has U proportional to h and B=r h.

The source constructs binned coefficient moments, a Gamma-weighted polynomial table, padded convolutions and a final inverse transform. It applies the final normalized inverse with factor A and then removes the Gaussian. [FLINT multieval source, functions `_platt_smk`, `do_convolutions`, `_acb_dirichlet_platt_multieval`](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/platt_multieval.c).

Counting that schedule, rather than assigning a unit cost to a special function, gives the following independent operation inventory per window:

- J logarithm/root/phase constructions and O(JK) coefficient-moment updates.
- N Gamma/exponential base nodes and O(NK) polynomial-row operations.
- K forward transforms of length N, 3K transforms of length 2N for padded convolution, and one inverse transform of length N.
- 2NK complex point products for the padded convolutions, row assembly/scaling, all analytic error bounds, and output/interpolation work.

For an explicitly chosen radix-two implementation, the transform inventory has exactly

    F(N,K) = (K+1)(N/2)log2(N) + 3KN log2(2N)

butterflies. This counts that implementation, not the internal optimizations of every FLINT transform. The two dense K-by-N tables require 2KN complex entries before work arrays. Streaming can reduce retained storage, but changes the replay schedule.

Let M(p) be the checked cost of a p-bit multiplication, E(p,t,J) the checked elementary phase cost, G(p,t) the checked scaled-Gamma node cost, and V the cost of interpolation, repairs, completeness and I/O. A usable model is the actual sum

    W = sum_windows [ J E + c1 JK M(p) + N G
                      + c2 NK M(p) + c3 F(N,K) M(p) ] + V.

The constants describe a selected arithmetic circuit. For a slowly varying schedule the corresponding work density divides each bracket by U(t). This division is the mechanism by which wider windows can help. It does not eliminate the cost of generating or checking the larger table.

Uniform Fourier-coordinate error e_F contributes at most A e_F after the normalized final inverse. Retaining a core |offset|<=U/2 bounds Gaussian-removal amplification by exp(U^2/(8h^2)). The actual full-grid removal instead permits exp(B^2/(8h^2)); it cannot be omitted from a claimed output error. Keeping a positive Gaussian in a sign proxy could avoid removal, but requires its own explicit normalization adapter. Every final multiplication and rounding is charged.

## 3. Parameter coupling that rules out a free wider window

Write C_sigma(t,h)=C(sigma,t,h,0) from Appendix A.3, with odd sigma>=3 and sigma+1/2<=t. The sufficient omitted-Dirichlet-tail bound is

    E_J = C_sigma(t,h) exp((2sigma-1)^2/(8h^2))
          pi^((1-2sigma)/4) J^(1-sigma)/(sigma-1).

For K=2k and xi=1/(2B), the B.2 Taylor bound simplifies algebraically to

    E_K = 2^(5/2) sqrt(pi) h [pi^2 h^2/(2B^2)]^k / k!.

The full coefficient sum multiplies E_K by 2sqrt(J)-1. These are Fourier-coordinate errors, before the preceding inverse/output factors. [Platt, A.3/B.1/B.2](https://research-information.bris.ac.uk/ws/files/78836669/platt_zeta_submitted.pdf), [independent pinned B.2 implementation](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dirichlet/platt_lemma_B2.c).

Here is the new scaling deduction. Fix sigma and consider h=o(t). The finite polynomial-Gaussian terms in A.3 bound C_sigma by O_sigma(h t^((sigma-1)/2)); the terms with additional h/t factors are smaller. Consequently solving the displayed E_J condition at a fixed Fourier tolerance gives the sufficient scale

    J ~ sqrt(t) (h/e_F)^(1/(sigma-1)),

with sigma-dependent constants and the displayed exponential also retained. This is a deduction about that sufficient bound, not a necessary lower bound on any evaluator. Increasing h while retaining the same J/sqrt(t) is therefore not justified by this proof.

Put nu=1/(sigma-1), U~h and B=rh. If K,A,r,e_F and arithmetic costs were held fixed, the two main work densities would have the forms

    coefficient: K sqrt(t) h^(nu-1),
    transforms:  K A r log(A r h).

Balancing their derivatives gives, up to the different circuit constants,

    h^(1-nu) ~ (1-nu) sqrt(t)/(Ar).

Thus the formal balance has h growing like t^((sigma-1)/(2(sigma-2))), not exactly sqrt(t) at fixed sigma. This calculation is conditional algebra. A,K,r,e_F,p also change in a real accepted schedule. Letting sigma grow might reduce the extra exponent, but the A.3 constants and every other error condition must then be bounded uniformly. No optimized asymptotic theorem follows from this balance alone.

The following constraints remain mandatory in any parameter selector:

- A.5 requires B>h sqrt(k) for every derivative index used; its Gaussian tail also contains polynomial factors in B.
- Binning must retain every integer nearest B log(j sqrt(pi))/(2pi). A conservative sufficient layout condition is A>log(J sqrt(pi))/pi+1/B, placing those nonnegative bins below N/2 before padded convolution. This is a sufficient schedule choice, not the weakest source condition.
- A.7 and A.9 contain frequency decay, the same C factors, and pole residues. The latter include exp(-t^2/(2h^2)). Large h cannot be declared harmless by examining B.2 alone.
- A.11 requires beta h^2/t<=B/2<=t, where beta=1/6+log(log(t))/log(t), and its error must fit the final budget. Interpolation adds its own finite-sample and alias bounds.

These source conditions can be checked by scalar inequalities without evaluating zeta. They have not been checked here for a newly proposed global schedule. In particular the Fourier tolerance e_F must tighten when A or the output amplification grows.

## 4. What the fixed-window model does justify

For fixed useful width and fixed or slowly changing A,K,p, a J proportional to sqrt(t) schedule has coefficient work proportional to

    integral_H0^H sqrt(t) dt = (2/3)(H^(3/2)-H0^(3/2)),

while its fixed-table work is proportional to H-H0. Freezing J at the maximum height within each campaign changes the constant, not the leading H^(3/2) comparison between separately tuned campaigns. Neither statement says other algorithms must pay this cost. Allowing omitted logarithmic factors to vary also changes the literal ratios.

For an arithmetic-only sensitivity comparison take H0=10^8 and reference 3*10^12. The scalar companion encloses the ratios for linear work, the coefficient integral above, and the illustrative integral of log(t). The last column is not an established production law. Displayed values below are lower endpoints; add .001 for a strict upper enclosure.

| Q | H=4*10^10 Q | Linear reduction | Coefficient reduction | Integral-log reduction |
|---:|---:|---:|---:|---:|
| 1 | 40000000000 | 75.185 | 649.600 | 88.994 |
| 2 | 80000000000 | 37.545 | 229.649 | 43.176 |
| 4 | 160000000000 | 18.761 | 81.191 | 20.975 |
| 8 | 320000000000 | 9.377 | 28.705 | 10.200 |
| 16 | 640000000000 | 4.688 | 10.148 | 4.964 |
| 32 | 1280000000000 | 2.343 | 3.588 | 2.418 |
| 47 | 1880000000000 | 1.595 | 2.015 | 1.623 |
| 48 | 1920000000000 | 1.562 | 1.953 | 1.588 |
| 50 | 2000000000000 | 1.500 | 1.837 | 1.522 |

The companion also uses the exact reference H*=3000175332800. Subtracting H0 here cancels a common certification obligation; it does not assert that its certificate has already been produced.

For integration's linear screen let s be the fraction of reference cost attributable to the coefficient integral, with the rest linear. Define L=(Href-H0)/(H-H0) and

    r = [(H^(3/2)-H0^(3/2))/(Href^(3/2)-H0^(3/2))] L.

Then the target/reference cost is ((1-s)+s r)/L. The relative-to-linear multiplier is kappa=(1-s)+s r, and the total reduction is L/kappa. At Q1, r is between .115741 and .115742. The reductions for s=1/4,1/2,3/4 are respectively 96.523–96.524, 134.772–134.773, and 223.230–223.231. At Q47, r is .791638–.791639, so the scaling uncertainty in this two-component model is much smaller.

These are scenario identities. Unknown changes in parameters, precision, repairs, hardware and checking can put actual kappa outside this interval. The historical aggregate supplies no value of s. In particular this source analysis does not establish a 1000-fold reduction at Q1, or even a 100-fold reduction. It explains the missing information that decides the comparison.

## 5. Precision, completeness and proof cost

An input log error is multiplied by t in a phase. Producing p useful phase bits therefore needs roughly p+ceil(log2(t)) input bits, before summation and conditioning allowances. Sums and transforms add their own log(J), log(N) and magnitude terms. Raw derivative rows can be large; normalizing their powers can help, but requires a new complete error accounting. Exponent storage is not the same as mantissa precision or rational denominator size.

Use a modest shared window precision, then refine only unresolved outputs through certified interpolation or direct evaluation. All failed native attempts count in generation cost. The successful retained arithmetic circuit must still be checked, including elementary/controlled-Gamma leaves, all transform stages, rounding and tail inequalities. Native Arb acceptance is not a Lean/MM0 proof of those leaves. A compact receipt can regenerate a circuit, but cannot omit its arithmetic cost.

No universal spacing or sign margin is assumed. Even RH alone does not ensure that sign changes count multiple critical zeros with their multiplicities. Acceptance needs a proved principal Turing/count bound and a matching set of disjoint sign intervals, including auxiliary ranges, seams and the closed final height. A nonzero endpoint or a strictly larger certified top must handle inclusive H. Local repairs can succeed without rerunning every output, but their number and required precision are unpriced here. The principal count includes its pole contribution; family nonprincipal formulas cannot simply be reused.

The certificate through H concerns conductor one only. The remaining reduced nonprincipal family work is common to the compared routes. This report does not establish any prime-gap theorem's auxiliary hypotheses. It also makes no conversion from native core-hours to Lean/MM0 time or proof bytes.

## 6. Consequential next step and reproducibility

Before choosing a height exponent in the break-even screen, obtain either the historical retuned parameter/run breakdown or a newly certified parameter schedule. The next bounded research step is a scalar-only parameter selector at a few height regimes, followed, only under separate authorization, by one fully checked window that separates coefficient, Gamma, transform, interpolation, repair and checker costs. That would estimate a component share and validate output conditioning. Replacing this missing measurement with H log H is unjustified.

The companion `principal_height_scaling_ratios_20261111.py` uses only integers, Fractions, integer square roots and a positive atanh-series bound for logarithms of integer heights. It writes `principal_height_scaling_ratios_20261111.json`, with both reference heights and five mixture shares. It does not import an evaluator or use historical runtime as a fitted datum. Its status refers only to exact enclosures of the specified scalar models.

Related frozen reports are `PRINCIPAL_EXTENSION_VERSUS_LADDER_COST_2026-11-11.md` (CE5139A66022791E362117330291F8FA3DA670B778355EA61B2CF9737CF813E2) and `../integration/EFFICIENCY_LADDER_ZETA_BREAK_EVEN_SCREEN_2026-11-11.md` (A0400AF43EC88FED3756F2C05AF24EEC20308E716DC422CF2B9D9AA525266BDA). This report refines their scaling input without changing their conditional analytic or certificate status.
