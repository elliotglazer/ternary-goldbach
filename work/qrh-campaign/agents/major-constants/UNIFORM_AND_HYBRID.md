# Uniform primitive errors and finite-certificate sensitivity

All error quantities in this note are primitive Schar errors BEFORE Gauss/phi reconstruction. The earlier LOW_ZEROS.md profile E_c<=C*x^(7/8)/sqrt(c) is a separate, unproved stronger profile. It was motivated by the exploratory sqrt(T_c) Sobolev estimate with T_c approximately1e8/c, not by generic QRH. It is not a source theorem. No conductor suppression is counted twice below.

The scripts uniform_conductor_model.py and hybrid_certificate_model.py reproduce these calculations. Their output files contain every dyadic bin. These are conditional numerical models, not certified analytic bounds or zero certificates. No Lean compiler was run.

## Exact uniform-error weights

Let E_c(chi,delta) be the primitive-character error after subtracting the principal main term when c=1. Induction to modulus q requires the already identified coprime/Euler corrections. For simplicity the following displayed model assumes these have been included in the error bound. Suppose

    |E_c(chi,delta)| <= C_c*x^(7/8).

Aplus has an extra mu(q)^2 factor, so only squarefree q contribute. Such q occur as paired moduli r,2r with r odd squarefree, r<=150000, equal phi, and equal delta radius600000/r. A primitive conductor dividing squarefree q must itself be squarefree. There are no primitive characters of even squarefree conductor: the count contains the factor2-2=0. Put nprim(c)=product_(p|c)(p-2) for odd squarefree c, with nprim(1)=1.

Applying |tau_q(psi)|^2=c exactly once, the model gives

    Aplus <= x^(-1/4) * sum_(odd squarefree c<=150000) W_c*C_c^2,

    W_c=2*c*nprim(c) * sum_(odd squarefree r<=150000,c|r) I_r/phi(r)^3,
    I_r=integral_|delta|<=600000/r |FU(-delta/49)|^2 ddelta.

This formula is for Aplus alone, not Cross or V. Nonsquarefree q and even primitive conductors still occur in those other quantities.

With I_r replaced by1, the total weight is13.5975583462471. Independently, the sum over q of mu(q)^2/phi(q) gives13.5975583462470. The equality follows from sum_(c|r)c*nprim(c)=phi(r)^2 for squarefree odd r. The principal conductor1 weight is2.300961544674; the nonprincipal total is11.296596801573.

Selected dyadic conductor bins, geometric weights (I=1):

| c range | Weight |
| --- | ---: |
| 1 only (principal) | 2.30096154467 |
| [2,4) | .766987181509 |
| [4,8) | .902113955075 |
| [8,16) | .594869756181 |
| [16,32) | .657378355848 |
| [32,64) | .715992332781 |
| [64,128) | .712336443264 |
| [128,256) | .705024119776 |
| [256,512) | .692189663487 |
| [512,1024) | .686161156676 |
| [1024,2048) | .694070571830 |
| [2048,4096) | .694099944159 |
| [4096,8192) | .692476338120 |
| [8192,16384) | .691488669545 |
| [16384,32768) | .688116843633 |
| [32768,65536) | .658435212672 |
| [65536,131072) | .623511916002 |
| [131072,150001) | .121344341016 |

Thus generic uniform primitive errors do not have the rapidly decreasing large-conductor weight of the optional1/sqrt(c) model.

Source MajorTotal.lean:469,475 supplies

    I_r <= min(381.22, (1200000/r)*1.2534^2).

Using these upper envelopes gives total W=4251.481473763, principal877.172555472, nonprincipal3374.308918291. With J=8.79, A_cap=.011670451^2/(4*34.99053338496), a uniform C needs C<.03281608191 to certify the whole Aplus budget by this route. Replacing381.22 by the UNCERTIFIED full-line quadrature52.11714704834 gives W=674.085246356 and C<.08241370932. For C_c=C*log(2c), the source-envelope total is132863.469212953 and the C-prefactor cap is.005870215954.

## Hybrid beta certificate: the precise conditional model

A useful finite certificate would assert, for every relevant primitive chi of conductor c<=Qc,

    LFunction chi s != 0 whenever 3/4<=Re(s)<1 and |Im(s)|<=T.

For c=1 use xiF, or account explicitly for the zeta pole. Combining this with QRH gives beta<=3/4 below T and beta<=7/8 above T. It is a zero-free RIGHT rectangle, weaker than checking all low zeros lie on the critical line. It is different from the full-strip first-zero gap in LOW_ZEROS.md.

The sensitivity calculations additionally posit the following strong transform/zero-count estimates, which are NOT currently proved:

    total absolute Mellin zero envelope <= C_c,
    absolute envelope restricted to |gamma|>T <= C_c*exp(-a(delta)*T),
    a(delta)=min(.005,.28/(1+|delta|)).

The actual source has a much larger prefactor and may require a bandwidth shift in the usable decay. These benchmark premises are deliberately explicit; the numbers C_c=.1,1,log(2c) are not asserted to be realistic achieved constants.

Let r=x^(-1/8)=.0004610260758643493 at the threshold. Under the two envelope premises, the normalized error coefficient for certified conductors is at most

    C_c * [r+(1-r)*exp(-a(delta)*T)].

For the joint model allocate A_cap/4 to c>Qc, A_cap/4 to |delta|>D, and A_cap/2 to the certified interior. The tail of the Fourier weight is bounded by

    integral_|delta|>D |FU(-delta/49)|^2
      <= 2*1.016^2*49^4/(3D^3).

This uses the source Fourier decay, not quadrature. The resulting sufficient pairs in this CONDITIONAL model are:

| Envelope profile C_c | Qc | T, rounded upward | D, approximately |
| --- | ---: | ---: | ---: |
| .1 | 13803 | 408 | 77.83 |
| .25 | 57263 | 1227 | 143.35 |
| .5 | 106763 | 2514 | 227.55 |
| 1 | 136219 | 4894 | 361.22 |
| 2 | 146299 | 9225 | 573.39 |
| .01 log(2c) | 16763 | 185 | 60.93 |
| .03 log(2c) | 86109 | 902 | 126.72 |
| .1 log(2c) | 140979 | 3236 | 282.77 |
| log(2c) | 149901 | 26278 | 1312.49 |

The displayed Qc values are floating-point threshold outputs, not certified minimal integers. Small safety margins would be needed before formal use. They illustrate that a small-conductor-only certificate helps only when the already-proved Mellin/zero constants are exceptionally sharp. A more realistic high-conductor treatment should use an actual average, rather than impose the same absolute C_c on every character.

Even an infinite-height beta<=3/4 certificate for every contributing conductor permits only C<71.18053 under the source Fourier envelope, or C<178.76149 under the uncertified quadrature envelope. A prefactor as large as the current generic Sobolev bound remains insufficient. This is failure of these estimates, not impossibility of the desired theorem.

## Reviewed-direction budgets for J=9 or10

relaxed_j_budget.py checks these safe decimals and transfer inequalities with exact Fraction arithmetic:

| J | Safe full Aplus cap | Safe full V cap | Safe Astar+Cross cap |
| --- | ---: | ---: | ---: |
| 9 | 9.61574237407e-7 | 3.78331740398e-6 | 1.89165870199e-6 |
| 10 | 9.10167633416e-7 | 3.40498566358e-6 | 1.70249283179e-6 |

Every displayed cap is strictly below its exact equal-half allocation. These arithmetic checks do not prove J or any spectral inequality.

Using the full-S transfer with a=1.01, bp=3.03e-23, bs=3.03e-17, it suffices at J<=9 to prove coprime Aplus'<=9.49e-7 and Astar'+Cross'<=1.83e-6. At J<=10, sufficient coprime targets are9e-7 and1.65e-6. The integral Eplus upper bound is refreshed to57, valid for both J<=9 andJ<=10, instead of the old53. Exact fractions of the resulting full errors are in relaxed_j_results.json.
