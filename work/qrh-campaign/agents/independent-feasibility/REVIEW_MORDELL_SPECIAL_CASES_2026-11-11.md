# Independent review of the three Mordell special cases

2026-11-11. **PASS as a reconstructed paper proof of the parameter 1, 1/2, and 2 identities and the stated Ftilde representations.** I found no mathematical defect in the frozen note. The contour orientation, residue sign, Gaussian normalization, conjugation reversal, Jacobians, and removable interpretations agree. These identities do not need the general rational Mordell evaluation as an assumed source theorem.

This verdict does not establish a Lean theorem, the full Riemann–Siegel representation, or a K0 remainder. The later Gamma-ray integral, its principal-power factor, and the saddle-contour estimates remain separate leaves.

## Pins and independent evidence

Paths are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
|---|---|
| `moebius/MORDELL_SPECIAL_CASES_PROOF_PLAN_2026-11-11.md` | `7BA678E0C8D7A25B4598228066B44A0CFADF402606EEFE4F6EB52C1C9F6DB050` |
| `mellin/gabcke_1979_corrected_2015.pdf` | `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53` |
| `independent-feasibility/review_mordell_special_algebra_20261111.py` | `7348840351D6FD2954E36360A3DCC16D948E71DE9414705BEF98D4EFEC92E3EB` |
| Its JSON | `B2FF712A9E6EC4BAD6532AE1B67C0679752F275017EF859F2BEF9CB745C31919` |

I read the complete note, visually inspected the retained primary pages 61 and 66, and checked the primary extracted text on pages 62–64. The [corrected Gabcke thesis](https://d-nb.info/1072293277/34) defines the upward slope-one contour on p61 and gives the matching starting kernel of 4.1.6 on p66. Its 4.1.2–4.1.3 formulas agree with the derived parameter-2 and parameter-1/2 results. Gabcke cites a general rational evaluation; the reviewed note reconstructs only the three needed cases.

The independent script verifies nine exact identities in finite sums of `(a+b*sqrt(2))*exp(i*pi*(q0+q1*v+q2*v^2))`, with rational coefficients. It uses exponential addition, `exp(i*pi)=-1`, and `sqrt(2)^2=2`; there is no numerical sampling, contour integration, special-function evaluation, or native proof oracle. All nine checks pass, including the delicate equations (12), (13), and (14). The receipt does not claim to prove analytic convergence or the residue theorem.

One preliminary script version inadvertently allowed Python's negative integer power of -1 to create floating coefficients. I removed that by exact parity, added explicit rational-type assertions for all tested coefficients, and reran. Only the final pinned exact run is acceptance evidence. No producer or frozen artifact was edited; no Lean/build/dependency action occurred.

## Definition, convergence, and Gaussian constant

The note restricts tau to positive real values. This is sufficient for the three specializations; it makes no claim to reconstruct the full complex-tau theorem. The contour is explicitly `u=c+epsilon*t`, `epsilon=exp(i*pi/4)`, `0<c<1`, with t increasing along the entire real line and `du=epsilon*dt`.

For real b and t, direct expansion gives

`Re(i*pi*tau*(b+epsilon*t)^2)=-pi*tau*t^2-sqrt(2)*pi*tau*b*t`.

The stated Gaussian majorant follows using `|u|<=|b|+|t|` and `|x|<=M`. The denominator is nonzero on the central segment because the line meets the real axis only at noninteger c, and its zeros are precisely the real integers. On both tails the reverse triangle inequality gives the claimed uniform reciprocal bound. Multiplication by any fixed power of u preserves local-in-x integrable domination. Thus absolute convergence, holomorphy in x, and parameter differentiation are justified, rather than inferred from a formal contour notation.

Independence of c uses the same finite parallel-strip contour with intercepts both in `(0,1)`. It encloses no integer and its bounded-length horizontal connectors tend to zero by the Gaussian majorant. There is no hidden pole crossing in choosing c=1/2.

For the Gaussian integral, substitution gives quadratic coefficient `-pi*tau` and linear coefficient `2*pi*i*epsilon*(tau*c+x)`. The real-line Gaussian with complex linear coefficient follows from its real-coefficient identity by holomorphic uniqueness and a locally uniform Gaussian majorant. Its exponent contribution is `-i*pi*(tau*c+x)^2/tau`; this cancels all c-dependent terms. Including epsilon gives

`G_tau(x)=tau^(-1/2)*exp(i*pi/4-i*pi*x^2/tau)`.

The square root is positive real. No infinite Gaussian contour rotation or unspecified complex square-root branch is used.

## Shift relations and residue orientation

The first relation `Phi_tau(x+1)-Phi_tau(x)=G_tau(x)` follows directly by subtraction of absolutely convergent integrals and cancellation of the denominator. No contour moves.

For the second relation the four ordered vertices are

`c-epsilon*R`, `c+epsilon*R`, `c+1+epsilon*R`, `c+1-epsilon*R`.

The first edge has positive horizontal and vertical components and the second points east. Their determinant is negative, so the traversal is clockwise. The integer 1 is strictly inside: its real intercept lies between c and c+1 and its imaginary coordinate is zero between the horizontal connectors. No other integer is inside or on the boundary. This holds for all the stated R>=1.

At u=1 the residue is `exp(i*pi*tau+2*pi*i*x)/(2*pi*i)`. Clockwise orientation therefore yields original upward integral minus translated upward integral equal to `-exp(i*pi*tau+2*pi*i*x)` after the connectors vanish. Each connector has length one and satisfies the same uniform Gaussian bound with bounded real intercept. Translation `u=v+1` preserves orientation and contributes `exp(i*pi*tau+2*pi*i*x)`. Solving gives exactly

`Phi_tau(x+tau)=exp(-i*pi*tau-2*pi*i*x)*Phi_tau(x)+1`.

Both the plus one and the translated Gaussian phase are necessary. I found no missing limiting edge or orientation correction.

## Three eliminations and removable cases

For tau=1, compare the two unit shifts. For tau=1/2, apply the second relation twice: its multiplier becomes `exp(-4*pi*i*x)` and its added term is `i*exp(-2*pi*i*x)+1`. For tau=2, compare two first-relation steps with one second-relation step. These give equations (6)–(8), with the displayed Gaussian prefactors.

The independent algebra checker verifies the half-parameter recurrence and elimination, the parameter-1 kernel after `x=z+1/2`, and the parameter-2 reduction (12). Every quotient is derived away from its denominator's zeros, while its denominator-multiplied identity follows everywhere directly from the shifts. Since Phi is entire, the quotient agrees off those zeros with an entire function. This establishes its removable extension without treating totalized division as the desired value. No separate derivative limit at each exceptional integer or half-integer is required.

Equation (9) has the correct asymmetric numerator `exp(i*pi*z)-exp(-i*pi*z^2)` and denominator `exp(i*pi*z)-exp(-i*pi*z)`. Its exceptional integer z values are covered by the entire integral. The source comparison on printed p66 is exact.

## Conjugation, Ftilde, and the Gaussian/cosh form

For real p, conjugating the upward slope-one contour gives a northwest-to-southeast slope-minus-one contour. Conjugation also negates `exp(i*pi*u)-exp(-i*pi*u)`. Reversing the contour to southeast-to-northwest contributes the second minus sign. Equation (10) is therefore correct. Retaining the conjugate orientation without the sign would be wrong.

Under `u=(1+i*v/sqrt(pi))/2`, the reversed slope-minus-one direction maps to the upward slope-one direction. The new imaginary-axis intercept is `i*sqrt(pi)*(1-2c)`, lying strictly between the two nearest cosh poles. Direct calculation gives

`du/(exp(i*pi*u)-exp(-i*pi*u))=dv/(4*sqrt(pi)*cosh(sqrt(pi)*v/2))`.

The original substituted exponent has constant `i*pi*(2p-1/2)`, linear term qv, and quadratic term `i*v^2/2`. Adding the prefactor's constant gives `i*pi/8-i*q^2/2`, as claimed. The exact checker verifies this cancellation and the cleared-denominator conjugated reduction from (12) to (13), after writing q=`sqrt(pi)*v` as an algebraic change of variable.

The conjugation step is used only for real p/q. The new contour integral is entire in complex q by Gaussian domination; its cosh denominator does not vanish on the chosen line, and its reciprocal is uniformly bounded on tails and on compact central segments. Clearing `cos(sqrt(pi)*q)` and applying the identity theorem to the real interval extends (13) holomorphically. This is valid analytic continuation, not the false assertion that conjugation is holomorphic in a complex parameter.

For equation (14), the independent checker verifies the full half-parameter substitution and both real/imaginary numerators after clearing denominators. For equation (15), substitution `u=1/2+epsilon*v` leaves phase `-pi/8` before the Jacobian; the Jacobian epsilon contributes `pi/4`, leaving `pi/8`. The factor `1/sqrt(2)` and this sign agree with the primary p64 formula.

Splitting the absolutely convergent real integral and substituting v to -v in the negative half produces a cosine numerator. The entire identity `cos(epsilon*w)=cosh(conjugate(epsilon)*w)` holds for complex w, so equation (16) holds for every complex q. Its real-line denominator never vanishes: the real part of `pi*exp(-i*pi/4)*v` is nonzero for v!=0, and cosh(0)=1. Gaussian decay dominates the numerator's local exponential growth, supplying the convergence and holomorphy needed here. Taking real parts or conjugating for real q then gives the stated F conventions.

## Exact closure and remaining leaves

Within this special-case leaf, the note supplies a full paper proof from the real Gaussian integral, ordinary holomorphic uniqueness/dominated integration, and the finite residue theorem. It no longer relies on Gabcke's cited general rational Mordell formula, a modular transformation, or a Gauss-sum evaluation. The positive-real square roots and explicit affine Jacobians settle all branch choices used within this leaf.

The following are still outside this acceptance:

* Kernel formalization of the real-line contour wrappers, domination, finite residue/connector limits, Gaussian uniqueness, conjugation, and removable extensions.
* The rest of Gabcke 4.1.6 after the starting kernel: multiplying by a principal power, the ray at argument `3*pi/4`, absolute Fubini, its Gamma-ray evaluation and branch factor, and continuation in s.
* Saddle-contour endpoint indentation, later deformations, coefficient identities and four-range remainder bounds, or any complete K0/Riemann–Siegel theorem.

The source's general results can remain references for fidelity, but must not replace these unproved later leaves by assumptions. No required correction to the frozen special-case note was found.
