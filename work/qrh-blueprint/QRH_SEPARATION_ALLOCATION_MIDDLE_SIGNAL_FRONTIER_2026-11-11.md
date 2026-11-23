# Separation, allocation, middle frequencies and signal recovery

2026-11-11. This synthesis reconciles four independently reviewed source implications. It advances the remaining-source inventory without asserting a complete QRH proof, compatible Lean elaboration, a transitive axiom check or any new finite spectral certificate.

## Evidence and scope

The provider source is `work/openai-math`, commit `4eaee87548250b2682affda7d05d947c05554bae`. The coordinator read all eight reports, inspected the core consumer and normalization bodies described below, and independently reconciled their source hashes. All verdicts remain bounded by the explicit lower inputs.

| Packet | Author and SHA256 | Independent review and SHA256 |
|---|---|---|
| Whole-product separation | [Author](../qrh-campaign/agents/independent-feasibility/QRH_WHOLE_PRODUCT_PAIR_SEPARATION_AUDIT_2026-11-11.md), `12DB7738EB0BA0DA10E64424785C6C6B62277976CC05FECC21F9CF2E86C93A6E` | [Review](../qrh-campaign/agents/major-constants/REVIEW_QRH_WHOLE_PRODUCT_PAIR_SEPARATION_AUDIT_2026-11-11.md), `34369ACB02CDA010DC918B5E96F9D9B2090E0E7E845D882BBBA2F92AF20543DB` |
| Live-allocation common energy | [Author](../qrh-campaign/agents/independent-feasibility/QRH_LIVE_ALLOCATION_COMMON_ENERGY_AUDIT_2026-11-11.md), `67B64EAE035944821BEA870E7B62972464B2E233DBF2BBF6569A17F9162A5C54` | [Review](../qrh-campaign/agents/major-constants/REVIEW_QRH_LIVE_ALLOCATION_COMMON_ENERGY_AUDIT_2026-11-11.md), `38A1C08D554CBCC09631164ECB604255C4BCFD44D691E89E524AF25B4953E74F` |
| Actual middle frequencies | [Author](../qrh-campaign/agents/integration/QRH_MIDDLE_FREQUENCY_ANALYTIC_AUDIT_2026-11-11.md), `1B4B178F58A8DE23573F978D0C302F2AD2D02FEC5D31474BD9DE81B264F1348B` | [Review](../qrh-campaign/agents/moebius/REVIEW_QRH_MIDDLE_FREQUENCY_ANALYTIC_AUDIT_2026-11-11.md), `8BA08F7386784679576438526E5E321E3F2A1444CB797CD6F0EB7002E8B78579` |
| Actual signal/Mellin recovery | [Author](../qrh-campaign/agents/zero-sum/QRH_ACTUAL_SIGNAL_MELLIN_AUDIT_2026-11-11.md), `BA06296484D1CC08BE3DA9AE4E5BEF064A2B03C39B1CA69912C8A8DF75A1F395` | [Review](../qrh-campaign/agents/prime-estimates/REVIEW_QRH_ACTUAL_SIGNAL_MELLIN_AUDIT_2026-11-11.md), `04563105E8D13B6D94402B7976EEF406235B008E9A7314D1603C00D9F507A9AA` |

The eight tables contain 75 matching Lean entries, including four cached Mathlib entries, and six supporting-report entries. Repetitions are retained. The reused radial audit's eight source pins and the three separately cited radial-author, radial-review and detector-contradiction report hashes also match. These are byte counts, not proof-coverage percentages.

The middle-frequency receipt contains 16 matching entries. Its SHA256 is `B4A9DF10BCF7E604A05079BE84532050A04E8B27F83326F9CC8FA6990BD235FE`; its writer's SHA256 is `19DC44C9321024B51BB673CBA725FA8EAD5EF553E506494BD96B8C4751C1AB6C`. The coordinator read and rehashed the receipt without rerunning its writer. No analytic values were computed.

## The whole-product consumer uses the existing radial estimate correctly

`Moments/Smooth.lean:14–135` applies the already accepted radial envelope to four windows with slopes 1,1,-1,-1. Its actual kernel contains `V2(u)/sqrt(exp(u))` and `V3(v)/sqrt(exp(v))`. These root factors retain their support and magnitude on both sides. The phases reproduce `rho+x-u-v`. In particular, the right finite coefficient is `conj(d_j)` times the negative-v phase, not the conjugate of a column with the same unaltered phase.

For each fixed profile, support box and derivative orders, one constant precedes every positive R. At each R, one Schwartz density precedes all finite index sets, coefficients and coordinates. The source proves integrability of each separated term using unit-modulus phases before exchanging the finite sums and integral. The equality adds no cardinality loss and handles empty sets and zero coefficients.

This is new coverage of the finite consumer, not a second claim of progress on the radial-envelope proof. It gives no measurable choice of density as R varies, no R=0 result, and no uniformity over arbitrary changing Schwartz profiles or support boxes.

## Live allocations pay both counts and retain the inverse norm

The actual common polynomial is a finite sum over extracted allocation labels. Original tuple multiplicities remain in each coefficient. Cauchy–Schwarz contributes one allocation count. Complementary frozen/live control products recover the parent control product exactly, so summing those products contributes a second count.

`Moments/FirstPhysicalSourceAllocationControl.lean:19–62` applies the allocation bound at exponent eps/2 and coordinate cap N+2, including the two plain factors, then squares it. Both counts therefore cost norm(C)^eps. The separate inverse norm comes from live support: a nonzero frozen coefficient forces

`norm(C) <= max(1,b)^N * rawReduction`.

The exact identity `childVolume * rawReduction = parentVolume`, with both volumes positive, then yields the normalized multiplier. Zero coefficients are treated separately rather than assigned unsupported window bounds. The final transfer is proportional to `norm(C)^(eps-1)` and still consumes the actual normalized energy bound of every nonzero frozen child.

The power extension in `FirstCommonSourcePowerBudget:17–47` uses nonnegative coefficients and exponents, b>=1 and the child-volume bound. Its constant precedes the number of powers. The separate linear-volume specialization gains another inverse norm. The sampled radial weights must be nonnegative. Empty auxiliary row fields in generic child data do not trivialize the actual lattice Gauss energy used here.

The divisor small-power argument uses fixed-field ideal factorization and finiteness, not a later sieve improvement. Full source-allocation arithmetic identities and the underlying Gauss/lattice summability remain named lower foundations. This transfer does not produce its child estimates or their admission conditions.

## Middle-frequency estimates preserve the dual scale

The original and dual kernels are the actual kernels in `Poisson/LatticeEnvelopes`. The dual kernel depends on both column norms; logarithmic separation handles that dependence without pulling it outside the sum. Conjugating the left coefficient twist gives the required positive Fourier phase. The lower column shell is needed for the dual log windows, while the original estimate needs only its stated upper bounds.

The frequency carrier excludes zero. A genuine scaled Cauchy-lattice sum gives `t*sum f <= L*C`; the large-t estimate uses the positive norm floor of a nonzero lattice point. Thus zero exclusion is essential, and summability precedes every use of the infinite sum.

For the original estimate, `t=sqrt(M/B)/(D1*D2)` cancels the corresponding outside factor. For the dual estimate,

`t=N*sqrt(F/(M*B))/(D1*D2)` and `r=M/(F*N)`.

The exact square-root identity gives an envelope numerator proportional to `t*r`. Summation cancels only t. The factor `M/(F*N)` remains. Fixed dominating coefficient vectors permit arbitrary frequency-dependent coefficients without an extra cardinality factor.

The existing `HasSieveExponent` witness pays the finite divisor-block cost through its reverse inequality at column scales N/D_i>=1. Its reversal constant stays inside the chosen bound. The subsequent square root restores one loss exponent. The original and dual gates give respectively `N+U*sqrt(M)*B^(alpha-1/2)` and `M/F+U*sqrt(M/F)*B^(alpha-1/2)`. This particular step adds no alpha>=1/2 assumption; later consumers retain their own restrictions. No sharp exponent is assumed to prove itself.

### The selected fixed-profile route needs no new witness bound

The middle-decay constants are chosen after W is fixed. Existence of some seminorm-controlled witness does not give the same upper bound for every classically chosen witness. The reports correctly retain that limitation.

The coordinator traced the actual selected consumer to resolve whether it needs that stronger conclusion. `QuadraticSieve/PoissonComparison.lean:317–345` retains the actual chosen constants inside its majorants. `PoissonConstants.lean:93–107` lists both exact middle-decay constants among `poissonPrimitiveConstants`. Lines 264–290 use a finite-list bound on those values. Finally `poissonComparisonMajorant_selected_power:562–596` fixes W before choosing Cfinal, using that finite list. Hence this current fixed-profile route needs no new uniform seminorm comparison for arbitrary choice witnesses. It does not establish a theorem uniform over varying W.

These two additional source checks are pinned here:

| Source relative to DirichletL | SHA256 |
|---|---|
| `QuadraticSieve/PoissonComparison.lean` | `428339EF45AACFAB07DE6594CE4BCC58945746C0B326DC1098910396A9F74925` |
| `QuadraticSieve/PoissonConstants.lean` | `E0914B906B537C1D987169FAC2943E49E47F62579F719E485A46C20117ACCFF2` |

The finite coprime divisor-block and quotient-operator inequalities remain separate lower inputs. Shared radial, Euler-derivative and Schwartz results retain their existing audit scopes and library-validation limits.

## Signal recovery supplies both Fourier-integrability premises

The actual signal is the Gaussian inverse Mellin transform of `H*reciprocal(chi)`, not an arbitrary function with an assumed transform. For Re(s)>=2, the absolutely summable ideal Möbius inverse series bounds the reciprocal. The strip contour shifts rightward from 2 to B>=2, where ordinary Euler-region nonvanishing suffices. Gaussian decay removes the horizontal edges. Choosing B for each exponent proves arbitrarily rapid decay at zero; constants may depend on that exponent.

The integrable line amplitude also yields continuity and local integrability on positive x. Recovering its Mellin transform additionally requires the caller's top-growth bound with exponent a<2. `ContinuationInversion.lean:11–112` transforms Mellin convergence into integrability of the logarithmic profile, identifies that profile with the inverse Fourier transform, and thereby proves integrability of the forward Fourier transform before applying inversion. Both integrability premises are present.

The resulting identity is on `2-2*pi*i*y`, with the correct reflection and normalization. At the principal pole the reciprocal is zero; no nonzero-amplitude assertion is made there. The nonzero analytic numerator is a separate consequence of the contraction bound on H. Actual construction of H, low/top probe estimates and approximation error remain detector obligations at this accepted cut. The new multiplier packet is outside this synthesis.

## Remaining source map

The reviewed [planning inventory](../qrh-campaign/agents/audit/QRH_REMAINING_SOURCE_OBLIGATIONS_2026-11-11.md) is updated only at these scoped implications. Do not reassign the whole-product consumer, two-count payment, four middle-frequency statements or signal recovery wholesale.

The distinct remaining work is actual amplified child-energy/admission; first-source remainder and high/zero recovery; the named source-allocation and specialized coprime-operator arithmetic; and actual detector low/top/approximation estimates. The new base-floor and multiplier pairs await coordinator reconciliation. Base-floor coverage does not imply high/zero recovery, and multiplier production does not imply a probe estimate. Ordinary library facts keep their hypotheses and compatible kernel-validation requirements without recursive source reproof.

The provider's requested Mathlib version differs from the cache used for the disclosed signature checks. Compatible elaboration, actual theorem types and transitive axioms remain open. The complete selected finite spectral family, formal principal-head and prime-data replay, revised Goldbach consumers and final assembly remain unfinished. `PlattGRH` is still present; the selected strategy, final premises and numerical reserve are unchanged.

No Lean declaration, draft anchor, sorry, source edit, dependency change, build, analytic evaluation or production spectral scan was introduced by this round.
