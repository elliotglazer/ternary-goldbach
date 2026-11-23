# Independent review of the elementary Turing assembly

2026-11-11. Verdict: PASS as an assembly of the reviewed paper proofs and external scalar evidence. No mathematical correction is requested. This accepts the bound and its stated conditional use in the existing family completeness test; it does not accept a Lean theorem, a spectral packet, or a completed Goldbach proof.

The reviewed assembly is `integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md`, SHA256 `72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C`. All paths in this report are relative to `work/qrh-campaign/agents/` unless stated otherwise. No Lean/Lake command, dependency edit, spectral scan, canonical declaration, producer mutation, or frozen-snapshot edit occurred.

## Evidence checked and independence scope

I read the four pinned mathematical components: the root elementary upper note, the local lower note, canonical Littlewood, and the root zeta-log integral note. I also read their pinned independent reviews, the actual family production plan and endpoint addendum, and their independent count-normalization review. I checked the displayed declaration and proof of `norm_LFunction_le` in the actual `Explicit/LGrowth.lean` source. The assembly's thirteen input/source pins, including its own pin, match the files before and after the calculation.

The canonical Littlewood component was authored by this reviewer. Its independent acceptance is supplied by `audit/REVIEW_LITTLEWOOD_CANONICAL_LOG_PROOF_PLAN_2026-11-11.md`, SHA256 `1F477AC1CC894AFAD6D4714143B3C4DEC3C0E91330F16F2E1FA27106C56D84EB`. This assembly review is not presented as a second independent derivation of that component. Its purpose is to check all joins and the unchanged family consumer, using the independent component reviews as recorded.

The reviewer-owned exact check is `review_elementary_turing_assembly_20261111.py`, SHA256 `7D72E7DD53BF5691E35C1A4E7213D5EE7D9A348191B62354E394BFC7BA1E9594`. Its receipt is `review_elementary_turing_assembly_20261111.json`, SHA256 `C0B52736D583175F0F3637A7C6B26BD206ACF639D71E11E2885043893DE81BC1`. The script returned exit 0 with `PASS_EXACT_ASSEMBLY_ARITHMETIC_AND_13_PINS checks=16`. It uses Python rational arithmetic, imports no producer code, and checks difference inequalities as coefficient identities rather than sampled heights. It writes only its own receipt.

I did not rerun the zeta-log Arb computation. Its analytic reduction was checked here, and its existing independent direct-grid and alternate-grid replay remains the external evidence for J<1.184. That distinction is preserved by the assembly.

## The common carrier and the horizontal bounds

All components use the same actual entire `DirichletCharacter.LFunction chi` for primitive nonprincipal chi of conductor Q>1. Both parities are included. No component substitutes a completed function, a finite approximation, or a numerical zero model into I. The growth theorem's actual conclusion is `(Q+1)*norm(s)/Re(s)` under chi!=1 and Re(s)>0. The checked source proof obtains this from periodic character sums, integration, and analytic continuation; the review is source inspection, not a fresh build or transitive axiom audit.

The upper derivation uses this bound on [1/2,5/4], a length-3/4 interval, and the same Euler-log tail J. Its exact result is

    I(t) < 1717/500 + (3/4) Z(t),
    Z(t)=log(Q*t/(2*pi)).

The older upper note also discusses a conditional smaller Turing allowance based on a historical lower bound. The assembly correctly consumes only its elementary horizontal estimate. It does not import that unfinished historical lower estimate or its smaller allowance.

The local lower proof uses a disk centered at 3/2+it with outer radius 7/5 and inner radius 6/5. I rechecked the decisive joint estimate. Removing every inner zero with its actual multiplicity gives nonnegative harmonic center budget h(0) and zero count N satisfying h(0)+N/7<=U. The horizontal losses are at most 11h(0)+3N, which is at most 21U since the difference from 21(h(0)+N/7) is 10h(0)>=0. Thus the final coefficient is 21, not the preliminary separate-budget coefficient 32. Inner-boundary zeros are removed; zeros on the outer circle do not obstruct maximum modulus.

The resulting compact lower estimate and Euler tail give I(t)>-127.184-21Z(t), and rounding the intercept up gives the bound actually consumed, I(t)>-128-21Z(t). This applies at every t>50. The historical Gamma/Hadamard/Booker discussion in that note is not an input to this local proof.

For J, convexity is proved for actual log zeta by its positive Dirichlet series and a variance identity. Positive trapezoid weights allow the endpoint values to be replaced by the explicit Euler–Maclaurin upper values. The B2 correction and the full absolute remainder are both included, giving coefficient s/(6B). The infinite tail is separately bounded. Thus the external scalar evidence has the correct upper direction. Its analytic and proved-arithmetic replay remains unimplemented, as the assembly states.

## Canonical S, the Littlewood sign, and exceptional endpoints

The assembly retains the logarithm fixed by the absolutely convergent Euler prime-power series. Its imaginary value at 2 can be nonzero for a nonreal character and is not reset. Horizontal continuation gives S; taking the principal argument of the final value or adding a root-number phase would change the function. Neither error occurs.

The independently reviewed Littlewood result is exactly

    pi * integral_(t1)^(t2) S(t) dt = I(t2)-I(t1).

Its sign agrees with the finite-width Cauchy–Riemann identity I_R'=pi*S-Im ell(R+it). Actual finite-order zeros yield Lipschitz integrated logarithmic potentials and only jumps in the derivative. There is no jump of I and no omitted endpoint mass. The Euler bound 3*2^(-R) removes the right edge. Consequently the identity holds at arbitrary endpoints 50<t1<t2, including zero ordinates, with locally bounded measurable S and absolutely integrable horizontal log norm. The upper and lower estimates have exactly this all-endpoint I domain.

Assigning finite values to S at exceptional ordinates leaves its integral unchanged. The family count identity is only asserted almost everywhere, so those assignments cannot introduce a mismatch. The proof does not require a zero-free top height or a finite numerical inventory.

## Exact rounding to 42+6.93 Z

Since Q>=2 and t1>50, 0<Z1<Z2. Subtracting the lower bound at one endpoint from the upper at the other gives the two separate inequalities

    I(t2)-I(t1) < 65717/500 + (3/4) Z2 + 21 Z1,
    I(t1)-I(t2) < 65717/500 + (3/4) Z1 + 21 Z2.

Both are bounded by 65717/500+(87/4)Z2. The exact slacks are 21(Z2-Z1) and (3/4)(Z2-Z1). Thus both signs are controlled without reversing an endpoint comparison or assuming I itself is positive.

The exact rational checks are

    42*(157/50)-65717/500 = 223/500 > 0,
    (693/100)*(157/50)-87/4 = 51/5000 > 0.

Together with pi>157/50 and Z2>0, these prove

    abs(integral_(t1)^(t2) S_chi(t) dt)
      < 42+(693/100)*log(Q*t2/(2*pi)).

The bound holds separately for chi and its inverse, which have the same conductor, primitivity, and parity. There is no root-phase compatibility assumption in the integrated-S bound. Its mathematical hypotheses contain no RH, simplicity, or finite spectral certificate.

## The actual closed-count consumer

The pinned family review derives the convention-fixed identity

    C_chi(t)=G(t)+S_chi(t)+S_inverse(t),
    G(t)=2*theta_a(t)/pi,

almost everywhere, with C counting all nontrivial completed-function zeros through |gamma|<=t, with actual multiplicity and including real zeros. This is a nonprincipal count: it has no zeta-style +1 correction. The canonical S in the assembly is the same S in this identity. The holomorphic Gamma-log normalization in theta_a remains a separate count-proof obligation; local logarithms from the horizontal estimates do not replace it.

For t>T, closed counts satisfy exactly

    C_chi(t)=C_chi(T)+A_chi(T,t]+A_inverse(T,t].

Zeros at T are already in the base count. A zero at T+h contributes zero area to the added-count integral. Integrating the almost-everywhere identity gives

    h*C_chi(T)=integral G + integral S_chi + integral S_inverse
               - integral (A_chi+A_inverse).

Each disjoint strict sign interval (u_j,v_j) inside (T,T+h) supplies at least one root and contributes at least T+h-v_j to the final added-count integral. Therefore the subtracted quantity is at least W, and the inequality direction is

    C_chi(T) <= [integral G-W+2B(Q,T+h)]/h.

There is no additional factor 1/pi on W or B. For a real character, the identical positive sign list represents positive and negative ordinates and is counted twice in W. Its S allowance is also counted twice. For a nonreal pair, each positive channel is used once. The exact central contribution in the main lower count is counted once, not twice. Unaccounted off-critical real zeros remain in C.

The strict test U<K_main+1, together with integer K_main<=C_chi(T)<=U, forces equality. That equality excludes extra roots, excess multiplicity, unaccounted real zeros, and boundary zeros at T. Main intervals remain strictly below T. No endpoint nonvanishing assertion is inferred from a single critical-line sample. The same argument covers inclusive Hcert once the checked T is at least Hcert. Conductor one remains on its separate principal route.

## What has and has not been closed

The mathematical paper argument for the integrated-S allowance is assembled correctly, with the reviewed external J evidence. The sufficient family completeness implication is also correctly instantiated. This is not an assertion that its inequality has been satisfied for any new character packet.

Compared with the historical allowance 1.8397+.1242Z, the new allowance costs an additional 40.1603+6.8058Z per channel. For fixed T,h,W and Gamma integral, the upper count expression increases by twice that quantity divided by h. Those exact coefficients were independently checked. Existing saturation margins must therefore be recomputed; neither a previous PASS nor a larger chosen h proves the new test. Enlarging h requires new sign enclosures, weights and Gamma-integral evidence on the enlarged range.

Still open are the analytic Lean implementations and exported axiom/type checks; the actual-L Euler-log bridges; finite analytic factorization and Blaschke removal; harmonic, integration and limit wrappers; formal replay of J; the completed-function count and conjugation/multiplicity adapters; certified character manifests, phases and main/auxiliary/central data; and strict integer saturation for the full selected family. The assembly lists these obligations and creates no allowed root premise or approved frozen declaration.

No correction to the frozen assembly is requested. Its claim of paper closure is justified within the explicitly stated external scalar-evidence scope. Formal closure and actual family saturation remain unproved.
