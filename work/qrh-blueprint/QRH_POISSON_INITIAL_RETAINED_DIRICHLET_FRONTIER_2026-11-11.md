# QRH Poisson, scalar, initial-sieve, retained-window and Dirichlet frontier

2026-11-11. This advances the [quadratic, retained-source, residue and radial frontier](QRH_QUADRATIC_RETAINED_RESIDUE_RADIAL_FRONTIER_2026-11-11.md). Five further bounded mathematical/source audits are consolidated here. None is a compiled proof, a transitive axiom verdict, full QRH validation or finite spectral certification. PlattGRH remains in the target development.

## Original trace-normalized Poisson

The [author audit](../qrh-campaign/agents/integration/QRH_ORIGINAL_POISSON_ANALYTIC_AUDIT_2026-11-11.md) and [independent review](../qrh-campaign/agents/moebius/REVIEW_QRH_ORIGINAL_POISSON_ANALYTIC_AUDIT_2026-11-11.md) reconstruct the original radial Poisson identity and its consumption by the masked pair, original energy and physical-frequency limit.

The two-dimensional identity is derived from one-dimensional Schwartz Poisson with three genuine summability witnesses: the original lattice function, its Fourier transform and the intermediate partial transform. Product Cauchy-weight decay supplies the needed rearrangements. The affine lattice map has inverse Jacobian 2/(sqrt(3)*|c|^2), with c nonzero. Its inverse-adjoint frequencies are reindexed bijectively onto the full Eisenstein lattice, preserving zero.

The actual paper Fourier transform includes 2/sqrt(3) and the conjugated frequency (2i/sqrt(3))*conjugate(u). It absorbs the covolume factor, leaving 1/|c|^2. Positive radial scaling K contributes the real Jacobian K. Thus the actual trace formula has prefactor K/|c|^2, finite coefficient sum_r P(r)*psi(h*r), and radial argument K*|h|^2/|c|^2. The standard frequency's factor 4/3 is already inside the paper radial transform and is not inserted again.

Finite Gauss transformation does not itself require division by the Gauss sum or a norm-one claim. The canonical multiplicative characters must satisfy the stated nontriviality conditions. Mask dilation retains exactly one divisor norm-square denominator. Changing a chosen modulus generator by a unit is justified after reindexing the whole radial frequency sum; the normalized Gauss constants need not agree pointwise before that transport.

The original squared-row expansion retains all common and residual supports, with summability before moving finite sums through the lattice sum. Its extra normalization is exactly Z^(-D), obtained from the squared modulus of Z^(-D/2), for Z>0. Separate mode summability supplies HasSum before the zero/nonzero split and all-finite-subset estimate. Every prime pool is finite; no limit over prime pools or uniform summability over all moduli is claimed.

This advances the original-Poisson dependency named by earlier audits. Its remaining foundations include the general one-dimensional Fourier/Poisson and Haar-measure theorems, actual local finite-field character/Gauss identities, and the deeper Eisenstein coordinate and ray-conversion arithmetic. It does not settle the distinct specialized quadratic principal/middle/error estimates.

## Selected quadratic scalar majorant

The [author audit](../qrh-campaign/agents/independent-feasibility/QRH_QUADRATIC_SCALAR_MAJORANT_AUDIT_2026-11-11.md) and [independent review](../qrh-campaign/agents/audit/REVIEW_QRH_QUADRATIC_SCALAR_MAJORANT_AUDIT_2026-11-11.md) reconstruct the selected scalar bound and its finite analytic interfaces.

Write P=M*X, T=C*P^eta, K=T*X^2/M, N=X/q and Norm(G)=B*q. The theorem fixes an old quadratic sieve exponent alpha with 1/2<=alpha<=2, 0<eta<=1, derivative orders satisfying eta*l,eta*A>=4, a Schwartz profile and the listed nonnegative seminorm constants, and B,C1>=1. Its output constant precedes the varying scales, q and G. The domain includes M,X>=1, 1<=q<=X, 4<=C, B<=C<=C1, G nonzero and explicitly K>=1. The last condition is not inferred from M,X>=1.

The actual majorant contains nine positive terms. Their numerical allowances sum to 99921, below 262144. Each term has degree at most eight in the unit-budget factors; each factor is bounded by a product of at most eight quantities controlled by H*P^(4eta). This gives H^64*P^(256eta). The selected shape contributes P^(3eta), giving exactly the 259eta loss with shape

    M + X + X^(2alpha-1)*M^(1-alpha).

The negative exponent is handled through exact positive-scale identities. The high-tail estimate treats t below and above one together, using C>=B and q>=1; it does not assume a large-t regime. The additional divisor loss in the annular consumer gives 260eta. Its large-gcd branch remains present.

The coefficient dependence is exactly quadratic and covers zero energy without division. The infinite dual split is by squarefree-part norm, with summability before the closed-low/strict-high partition. The separate high-square-part argument uses injectivity on a fixed square-part fiber, contractive masks and the old sieve exponent only at valid descendant scales.

The scalar theorem permits arbitrary nonnegative constants; it does not prove that they are valid analytic bounds. The actual masked-Poisson consumer additionally requires admissible same-ray columns, coprimality, the prescribed bad-prime content, scale conditions and W(0)=0. Specialized principal truncation, middle and error producers, radial-tail bounds and remaining arithmetic identities are still substantive inputs.

## Initial cubic sieve and convergence

The [author audit](../qrh-campaign/agents/prime-estimates/QRH_INITIAL_CUBIC_SIEVE_AUDIT_2026-11-11.md) and [independent review](../qrh-campaign/agents/independent-feasibility/REVIEW_QRH_INITIAL_CUBIC_SIEVE_AUDIT_2026-11-11.md) reconstruct the initial finite energy bound with a fixed positive constant C0:

    sum_(z in R) |sum_(I in F) a(I)*idealSexticRow(I,z)^2|^2
      <= C0*(M+N^2)*sum_(I in F)|a(I)|^2.

Here N is a natural number at least one, M>=1, the finite column ideals are nonzero and squarefree with the stated good-prime restriction and norm<=N, and every row has squared embedding norm<=M. The unit ideal and zero row are allowed. Coefficients are arbitrary complex numbers. The constant depends on the fixed smoothing cutoff through its seminorms; no numerical value is supplied.

The Gram pair uses actual sextic powers four and two on the symmetric difference, and a common coprimality mask. Off the diagonal, nonempty active support makes the dual row vanish at zero. The normalized Gauss magnitude and scale-uniform nonzero-lattice bound give a bound proportional to the modulus norm. Common-mask subset multiplicity is paid by its ideal norm, yielding an off-diagonal bound proportional to N. The diagonal retains zero and is bounded separately. A finite ideal count at most128N completes the energy bound.

The lattice estimate has distinct small- and large-scale arguments. At large scale it requires the exclusion of zero; at small scale it follows from a product of one-dimensional Cauchy-weight sums. The actual Fourier profile is bounded through finitely many source Schwartz seminorms. Neither a later improved cubic exponent nor the QRH conclusion enters this mechanism.

The ideal-row and full-element-row adapters are distinct and both give C0*(M+ceil(N)^2). This supplies initial exponent two. Separately, for M>0 and N>=1 the dyadic majorant is bounded by a finite constant times (1/4)^j, using the initial bound only at row scale 2^j>=1. Its constant may grow without bound as M approaches zero; no uniform convergence in M is inferred. The author's317-module header check is supporting dependency evidence, not inspection of317 proof bodies.

The original trace-Poisson identity is now reviewed at the bounded scope above. Exact primitive-trace/Gauss magnitude and local cubic nontriviality, deeper arithmetic identities and general library Fourier/integration foundations remain separately identified inputs.

## Retained-window assembly

The [author audit](../qrh-campaign/agents/integration/QRH_RETAINED_WINDOW_ANALYTIC_AUDIT_2026-11-11.md) and [independent review](../qrh-campaign/agents/moebius/REVIEW_QRH_RETAINED_WINDOW_ANALYTIC_AUDIT_2026-11-11.md) reconstruct `Inversion/InitialRetainedWindow.retained_window_bound`. It bounds the actual finite physical block by C*Z^(m+15eta+piLoss+eps), multiplied by the stated polynomial modulation factors. piLoss is a positive loss parameter, not the circle constant. The degree, pool multiplier and clipping threshold precede q; C and Z0 may depend on q but precede the source, exponents and modulations.

The actual support cutoffs delete only zero-coefficient terms. In the nonzero-block branch they imply a clipping correction 0<=delta<=3eta. The full puncture has nonzero norm exactly Z^Q, obtained from its actual ideal product; a radical norm is not substituted. Window geometry supplies admissible labels, sign-closed nonzero rows and both canonical margins. The original theorem keeps its precise parent margins, support and slot conditions, eta>=0 with eta<=gap/50 and tau<=gap/50; it does not separately require tau>0. The subsequent aggregate theorem chooses positive eta,tau.

Two normalization costs produce4eta: transporting back from the enlarged label exponent costs2eta, and the available energy bound already has that enlarged exponent. The physical exponent identity gives m+5eta+2delta+piLoss+e, hence m+11eta+piLoss+e. Substitution of e=eps+4eta gives15eta. The supplied energy constant remains linear.

The source projection pays divisor fibers; opposite-child transport uses the sign-closed rows. Quotient mass, all subset pairs, six unit sectors and ray coefficients are retained. A weighted-integrable actual family density is supplied before bounding its integral. Four lower-rank moment calls precede the successor conclusion; the initial retained-window result is not assumed inside its own rank input. The final finite window count adds its own loss, with the physical frequency cutoff chosen after the uniform constants.

One terminology clarification from the independent review is adopted: `CanonicalRankMoments` is a quantified bound predicate on `normalizedColumnEnergy`, not the definition of that energy. No formula changes. The arithmetic fiber/mass, exact row, clipping and common-measure dependencies, and the deeper short/two-pass estimates remain at their separately reviewed boundaries. This is a finite-window estimate; the zero mode and infinite-frequency passage use the distinct reviewed arguments.

## Transfer to ordinary Dirichlet L-functions

The [author audit](../qrh-campaign/agents/zero-sum/QRH_DIRICHLET_FAMILY_BRIDGE_AUDIT_2026-11-11.md) and [independent review](../qrh-campaign/agents/major-constants/REVIEW_QRH_DIRICHLET_FAMILY_BRIDGE_AUDIT_2026-11-11.md) reconstruct the exact export for every positive modulus, without a primitivity or finite-height restriction, subject to the principal pole exclusion.

The ordinary character is pulled back by the ideal norm to the actual Eisenstein family. Quotient descent, vanishing on nonunits and triviality on global units are proved for that construction. A summable six-to-one generator reindexing identifies the continued lattice function divided by six with its ideal series. The zero ideal is handled separately, including at modulus one.

The product identity is

    L_Hecke(norm-pullback chi,s) = L(chi,s)*L(psi,s),

where psi is chi lifted to level3q times the quadratic character chi_-3 lifted to level3q. It is not an inverse or complex conjugate of chi. Split, inert, ramified and level-dividing primes retain their actual Euler factors, including imprimitive characters. The common inverse series is proved nonzero before cancellation. Analytic continuation extends the identity from Re(s)>1 to the connected domain excluding0 and1.

The final implication uses ordinary known nonvanishing when Re(s)>=1. Only in7/8<Re(s)<1 does it apply the punctured product identity and the all-family Hecke assertion. It therefore needs no false claim that norm pullback preserves nonprincipality. The exact export excludes the principal pair chi=1,s=1. Its separate zeta value at one is a statement about the library's totalized value, not removal of the classical pole.

The primitive-only probe reaches the all-family assertion through actual finite Euler deletion and same-point zero transport. The local principal residue handles the pole guard without assuming the desired7/8 bound. The substantive common-probe and certified-energy production still need their own validation. This review establishes their bridge to the ordinary export, not those producers. The inspected cached Mathlib endpoint theorem is from a different revision than the provider manifest; compatibility and compiled axioms remain open.

## Verification and remaining work

The coordinator read all ten reports and inspected the exact export/continuation split, radial scale and trace formula, selected scalar theorem body, initial finite theorem and geometric convergence, and retained normalization/consumer bodies. All ten report hashes below match. The150 Lean source-table entries, original-Poisson manifest pin and12 retained supporting packets match current bytes. Separate receipt checks covered18 original-Poisson entries,44 retained source/report entries plus2 extra source files, and22 scalar-review source entries plus3 artifact pins. Counts include repetition and do not measure proof coverage. Exact scalar bookkeeping separately confirms the nine allowances and259/260 loss arithmetic; no analytic value was evaluated.

The remaining-obligations inventory is under independent review. Its current priorities include the distinct positive-band producer, specialized quadratic analytic producers, actual local character/Gauss arithmetic and substantive detector/source-moment inputs. Standard library foundations should not be relabeled as missing new theorems merely because this campaign has not reproved them; their compatible kernel validation is still required. No complete global provider or new Goldbach theorem has been compiled. The selected finite spectral family, formal principal-head and prime-data replay, revised consumer proofs and final assembly remain unfinished.

## Evidence pins

| Artifact | SHA256 |
|---|---|
| Original Poisson author | DE7237156824F7503A51F36A9E4A777F57647F2FC98F82D624D000E5D5C12AFA |
| Original Poisson review | 9516B5144F691A5D5203C93D737B943E69EFE4A0E4BA4F399A164F833AF75407 |
| Scalar author | 8E0B2679F9122C0F97C42A85896EAA867CFB5FB905E83482F8E38C3977168279 |
| Scalar review | 8046E570600491B3F4F4894D357428F73BF674768994B306023FF6A6077473A9 |
| Initial cubic author | 169F69528A8D47F61E0EBE4340456ED8521EA2BDF7F2495EB7F0551B35C1636A |
| Initial cubic review | FD2CF5675DE5B544E370447912C57DEB576B22AAB11A9D3ADF1AF8166AC83229 |
| Retained-window author | 994D7AE2F9A63CD1151268E8735D93C7A6E70F505C96714AB442FB77C4FFC58B |
| Retained-window review | 5E836AD71ECE6CEDC4332B0B68ACBA31A864536B87734D973280EC36280EBCAE |
| Dirichlet-bridge author | C55361E7134C70D82E9B8CBECF296E3D2072D5CE98F0E0E583050C732019CF0D |
| Dirichlet-bridge review | F0F28145AA2232CB9ED5B76BA1C48485763725A0841FD077C0A1E3030DAA07E5 |

Receipt hashes: original Poisson941FD75E93083431826B090BCF6F58E9937DB0E1A3D7B079977F6614B3AB2DBB; retained window871A799CA6AEB22F2284DD19CE61E85AA318DA4A079FE99AD37A9DAA835252B9; scalar review882E851A12C15D1A8A569B17383C08EFF57BF1B94F97705D1FD98911FB6F5E1A.

No selected final premise, spectral requirement or numerical reserve changed. No Lean declaration, source edit, build, dependency change or analytic evaluation was made for this consolidation.

DRAFT_ANCHORS: 0 created
UNREGISTERED_SORRIES: 0 introduced
DRAFT_IMPORT_VIOLATIONS: 0 introduced
SEALED_THIS_TURN: 0
