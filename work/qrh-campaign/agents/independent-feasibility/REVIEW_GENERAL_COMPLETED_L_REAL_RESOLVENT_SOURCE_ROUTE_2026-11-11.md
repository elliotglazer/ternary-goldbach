# Review of the completed-L real resolvent route

2026-11-11. PASS at bounded source/paper scope, with the harmless radius-zero strictness qualification below. The argument supplies the finite approximation premise (F) required by the moderate Turing note. It is not an exported Lean theorem, transitive axiom audit, numerical count certificate or a claim that the full moderate allowance has been independently reviewed here.

Reviewed author `prime-estimates/GENERAL_COMPLETED_L_REAL_RESOLVENT_SOURCE_ROUTE_2026-11-11.md`, SHA256 `45B41467F5C57AB991088874D32B1163211709CAE4D9577D300E363F37D7317B`.

## 1. Actual completion and zero carrier

The function is f(s)=q^((s+e)/2) completedLFunction(chi,s), for primitive nonprincipal chi, q>1 and its actual parity e. The positive-base power is an entire nonzero exponential. Mathlib's completed L-function is entire for chi!=1. Its relation to the usual L-function gives the displayed Gamma product only in the positive half-plane, where Gamma is analytic and nonzero. The author does not define the completion by a totalized Gamma product at a pole.

The conductor exponent is correct. Multiplying the source equation completedL(1-s)=q^(s-1/2) W completedL_inv(s) by q^((1-s+e)/2) gives f(1-s)=W f_inv(s). Conjugation of the absolutely convergent series and analytic uniqueness, with equal parity, then give f(1-conj(s))=W conj(f(s)). Differentiating the conjugated local power series gives h(1-conj(s))=-conj(h(s)) off zeros. There is no leftover conductor logarithm in this normalized identity.

The source nonvanishing theorem applies to nonprincipal L at Re(s)>=1, including s=1. Thus f is nonzero there, in particular at 2. Reflection transfers this to Re(s)<=0. Every zero of f is in the open critical strip and has the same analytic order as the actual L-function there. A possible uncompleted trivial zero at 0 is not silently put into this carrier.

The author's local formula at the reflected zero proves exact order preservation, including central fixed points. It uses the analytic function obtained by conjugating power-series coefficients; the antiholomorphic map itself is not incorrectly passed to a holomorphic composition theorem. No same-character invariance under gamma -> -gamma is assumed for nonreal chi.

## 2. Polynomial growth and boundary control

The proposed BP datum is a genuine replacement of the growth fields, not a claim that the existing exponential BT datum already has logarithmic contour growth. The actual `norm_L_le_BP` has primitive/nonprincipal hypotheses and a radius-10 disk centered at 2+iT. Its proof splits at Re(w)=1/4, using the existing polynomial left bound or the positive-half-plane L bound. The report preserves these as source inputs.

All remaining LDatum fields are available from the old character datum: entire L, the .355 center lower bound, left-strip/right nonvanishing and the line-3/2 derivative bound. The center upper bound can be replaced directly using the Euler upper estimate and BP>=1400. For D_q=log(BP(q,0)/.355), positivity follows from BP>=1400. The displayed logarithmic factorization proves its linear field with coefficient 21/22<2.6; monotonicity in |T| is exactly `BP_mono`.

More explicitly, at k+1 the logarithmic budget is at most D_q+11 log(k+2), since each of 1+(k+1)/22 and 1+(k+1)/11 is at most k+2. HkD is a fixed positive quadratic polynomial in that budget. Therefore HkD=O_q(log(k+2)^2), and the proposed M_q(k)/k tends to zero. This is a fixed-q limit; no uniform effective threshold over all natural conductors is claimed or needed for (F). A finite selected family can take a maximum if a later consumer needs one.

The actual good_heightD theorem chooses both signs at once for the same function. Its body takes the union of the positive and reflected negative zero-ordinate sets before choosing a distant height. It does not require intersecting two independently selected good-height sets.

On the right half of the square, points with real part at most 3/2 lie on the two good horizontal segments. At larger real part, the von Mangoldt series bound extends the existing line argument by n^(-sigma)<=n^(-3/2). The n=0 term is zero, and n=1 has Lambda=0, so no endpoint exception is introduced. For the Gamma contribution, u=z+e has Re(u)>=1/2, |u|>=8 and |u|<=2k+4. These are the exact domain conditions of `norm_digamma_half_le`. Its half coefficient gives 2+8log(2k+6), as claimed. Reflection controls the left half and preserves the square. Consequently the entire boundary is zero-free for f and has |h|<=M_q(k).

## 3. Finite residue identity and exact orders

The actual `rectInt_logDeriv_inv_sub` requires an entire f, a nonzero anchor, a zero-free rectangular boundary and containment in the open half-radius ball. It returns h(s) plus the finite sum m/(rho-s). With anchor 2, outer radius 8T and T>=8, the whole closed square satisfies |z-2|<=2T+3/2<4T. Thus every source hypothesis is met. The source proof factors finitely, applies rectangle residues, and filters the interior; it does not assume a Hadamard identity.

Using the same containing ball for both evaluation points makes the finite set and weights identical in the two formulas. Divisor-at-a-point identifies every weight with the exact finite analytic order. The square, rather than the containing ball, is reflection invariant. Both reflected points still lie in the same containing ball, and intrinsic order equality proves equality of their weights. This checks the apparent non-invariance of the anchor at 2. It is precisely why central zeros are harmless here.

For s,v in the radius-M disk about 1/2 with M<=T/2, each boundary distance is at least T/2. The difference of inverse kernels is bounded by 4|s-v|/T^2. Perimeter 8T and normalization 1/(2pi) give contour norm at most 16 M_q(k)|s-v|/(pi T). Subtracting the source formulas has the sign stated in author equation (3).

Take v=1-conj(s). The finite resolvent F_T satisfies F_T(v)=-conj(F_T(s)), while h obeys the same relation. Hence the right side of the difference formula is exactly 2 Re(h(s)-F_T(s)), not a different paired-character sum. Dividing by two and using |s-v|<=2M gives

    |Re h(s)-Re F_T(s)| <= 16 M_q(k) M/(pi T).

There is no minimum-modulus denominator depending on interior s. The residual bound is therefore uniform over every nonzero point of the compact disk, including points arbitrarily close to a zero.

Minor qualification: the final displayed strict comparison with 6 M_q(k)M/T in author equation (4) is not strict when M=0. Use the non-strict comparison, or work with radius max(M,1). Both prove the stated approximation for every compact disk. The author agreed to this qualification; frozen bytes are preserved. All horizontal-segment applications already have positive radius.

Taking k sufficiently large, including T>2M if needed, gives (F) with all compact-disk zeros in the complete finite square carrier and their exact orders. This establishes the quantified premise, not merely pointwise convergence at a selected s.

## 4. Finite log integration and the moderate consumer

The source `factor_ball` removes all zeros in the half-radius ball with their exact divisor orders. Splitting that finite polynomial into the zeros inside and outside the square leaves a quotient analytic and nonzero on a neighborhood of the target compact segment. The excluded zeros lie outside the square and hence outside the chosen interior compact disk. This supplies g_T without a central nonvanishing assumption.

Off the finitely many zeros, Re(g_T'/g_T) is the residual just bounded. Continuity extends this bound through the removed zeros. The real derivative of log norm and the fundamental theorem of calculus give a log-norm difference error at most epsilon on each unit horizontal shift. Integration over a unit sigma interval still costs at most epsilon. Almost-everywhere finite log-product additivity is sufficient; the isolated logarithmic singularities are integrable, including endpoint zeros.

For each zero beta+i gamma the polynomial contribution is -J(3/2-beta,t-gamma) after changing variables in the two integrals. It is not a pointwise symmetric-offset identity. Since 0<beta<1, the independently reviewed J<=4a/(a^2+y^2) applies to every actual term with positive exact weight. At s*=3/2+it the same approximation gives S_T<=Re h(s*)+epsilon. Therefore

    I_f(t) >= -4 S_T-epsilon >= -4 Re h(s*)-5epsilon.

Letting epsilon tend to zero gives the required finite ratio inequality for every real t. A nested sequence of good squares also proves the optional absolutely convergent real resolvent identity: its terms are nonnegative for Re(s)>1 and its partial sums converge by the uniform residual bound. The J sum is then dominated termwise by four times that positive sum. No assertion of absolute convergence of the unsymmetrized complex inverse-zero series is needed. The finite moderate-allowance consumer does not require this optional infinite-series export.

The precise premise (F) in `major-constants/TURING_MODERATE_ALLOWANCE_PROOF_PATH_2026-11-11.md`, SHA256 `A480D72440F4A5D2C2BF539EB6D3C152428772060A7BFAF35582BCCDB525707D`, is therefore closed at paper/source scope by this producer. Its separate Gamma/Euler/J numerical ledger and canonical count composition remain the subject of their own review. This verdict does not independently certify b18, supply an actual passing guard, or remove formal implementation work.

## 5. Evidence and retained proof cut

All eleven source-table hashes in the author were independently recomputed and matched. The checked sources are under `work/ternary-goldbach/TernaryGoldbach/Explicit`, with Mathlib under the author's pinned local z-in-q tree.

| Source | SHA256 |
|---|---|
| XiPartial.lean | 8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770 |
| ZeroSums.lean | 3E5CD828CC6ADD2AF6D17F03F97E65F15720AEAF907826847EF191DEA8BCB72D |
| ZeroSumBound.lean | A1294627F676EC49BED1BD86407A9460DC569B77AF8CBE8D65F1F49129BF17D4 |
| Datum.lean | 42F14B373106D5508F73080BEC1E57992FDCBCB7A0460182AD396534463ACDDE |
| RectResidue2.lean | EC15FAFCAA6A472BFEABF71B1C79DFFD96F6CBF890EA80D77FAEE6F47427780B |
| Landau.lean | 6D2A7B97640A49ECBC61F7406006214DB798E9989D8F25740DF3E42600520656 |
| WeilBridge.lean | 285F825F4916B8D8F40256090F56E773140AB2FC2C48E3F057F68A838E17C73E |
| ExplicitFormula.lean | 8CDDDBE6934871CA37260E435BE639A49AC33F4A8D92CBB2E33AB9D330869C35 |
| Mathlib NumberTheory/LSeries/DirichletContinuation.lean | ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1 |
| Mathlib NumberTheory/LSeries/Nonvanishing.lean | 97D125ED132D6E39E61A6D9A8532E3460800FCE77569F5D621FC2B24E808B776 |
| Mathlib NumberTheory/MulChar/Lemmas.lean | 8B72DD4496B40E0E4F5B9ED09E47FCC1777B597960F70FF14B6C43E8B5E0FF81 |

Relevant bodies inspected include Datum:19,37,251,258 and 698; ZeroSums:18-74; ZeroSumBound:228-266; XiPartial:205,270 and the square/partial-approximation interfaces at 361,479,776; the full finite residue proof and Landau factor_ball; WeilBridge:55; ExplicitFormula:726-765; and the completed-function/nonvanishing source interfaces. The ratio input is author `D315AE5C7B98C8A8E1042FE548B7A5FB704CEB200CFA48E36509A5A23910DB1B` and independent review `B42C970619E291A81BCFD1B3FBB39498CA471FB07F7DDC47B9DB8D52BAC8D3D4`.

This bounded review accepts the new derivation from these source inputs. It does not recursively revalidate the underlying continuation, Gamma bounds, polynomial-growth proof, Jensen/Landau, nonvanishing or residue library. The new BP datum, conjugation/order adapters, generic real contour approximation, finite log integration and exported consumer must still be implemented and checked. No RH, QRH, finite-zero evidence, simplicity or central-nonvanishing premise is introduced. No source import, build, analytic evaluation or old-report mutation occurred.
