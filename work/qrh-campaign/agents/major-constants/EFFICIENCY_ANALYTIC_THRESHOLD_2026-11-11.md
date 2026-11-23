# Analytic threshold versus finite spectral and ladder work

2026-11-11. Research author: major-constants. This is a bounded source/paper and exact-integer/rational calculation. No Lean build, source edit, numerical L-function/zero/prime evaluation, or new certificate was produced. Existing frozen artifacts are unchanged.

**Verdict:** increasing the analytic threshold to `10^28` or `10^29` preserves the original analytic proof with unchanged spectral inputs, and lowers a precisely quantified nonprime allowance. It does **not** justify proportional reductions of the original finite-RH heights. A proposed uniform half-height reduction already violates an explicit etaPlus theorem hypothesis at an active conductor, independently of the analytic threshold. A tenfold reduction fails even the principal etaPlus endpoint. These are failures of those parameter substitutions in the existing estimates, not impossibility results for improved analysis.

There is no established reduction in spectral work from this packet. The larger finite range has an explicit additional coverage cost and exceeds the existing fixed-exponent ladder's primality domain. Thus neither threshold increase is ready for adoption as an end-to-end efficiency improvement. The useful outputs are the exact available final margin, a necessary height constraint, and a conditional finite-range design with honest existence obligations.

## 1. Original proof and quantities held fixed

I read `COMPUTE_FIRST_RESEARCH_AGENDA_2026-11-11.md` and `SPECTRAL_BASELINE_COST_COMPARISON_2026-11-11.md`. The comparison is against the original analytic route with its candidate restricted consumed finite-RH domain, not against every conductor in the broader `PlattGRH` declaration. The latter restriction remains subject to the complete consumer-domain audit and corresponding source refactoring.

The inspected target checkout is `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. In this note source paths are under `TernaryGoldbach/`.

Keep the original smoothing, `kappa=49`, `r0=150000`, arc parameter 8, and

`x=N/c0`, where `c0=2+9/(196*sqrt(2*pi))` and `0<c0<=2.02`.

`Helfgott/Inputs.lean:57–64` supplies `x>=.49*N` by the same denominator bound; consequently `y=x/49>=N/100`. The original major theorem gives `1.049*x^2/49`, the minor theorem costs at most `1.0376*x^2/49`, and the nonprime bound is `6.7e6*N^(3/2)*log N`. Their precise final joins are `Inputs:76–91,109–148` and `Main:30–75`.

Every old hypothesis `N>=10^27` follows from either proposed larger threshold. Thus the unchanged major, minor, base-gap, principal estimates, nonprime bound, and final positivity all remain available. This is a valid mathematical threshold change conditional on the same finite-RH and finite binary inputs. It saves no spectral checking by itself. The finite range below the new threshold needs an enlarged certificate; the old small-case theorem does not establish it.

No change of `r0` is included. It enters both major arcs and the minor base gap: `MinorArcs/BaseGap2.lean:185–227` keeps normalized phase ranges proportional to `r0/q`, not proportional to `N`. `MinorTotal.lean:79–85,323–325` also contains the fixed base level and its numerical consumer. Shrinking that level is a different mathematical task; it cannot be inferred from a decaying term in the major error.

## 2. Exact additional final margin

In units `x^2/49`, the nonprime cost is bounded by

`Cnp(N)=49*(2.02)^2*6.7e6*log(N)/sqrt(N)`.

The derivative of `log(t)/sqrt(t)` is `(1-log(t)/2)/t^(3/2)`, which is negative throughout the relevant range. Hence a bound at the left threshold is valid for every larger real `N`. The attached exact script proves `log(10)<2.303` by a positive degree-24 Taylor lower sum for `exp(2.303)>10`, and uses `isqrt(10^e)` as a rational lower bound for each square root. No transcendental value is numerically evaluated.

| Threshold | Uniform nonprime coefficient, strict upper bound | Sufficient major coefficient if minor stays 1.0376 |
|---|---:|---:|
| `10^27` | `.002634095` | `1.040234095` |
| `10^28` | `.000863825` | `1.038463825` |
| `10^29` | `.000282922` | `1.037882922` |

Each displayed major coefficient is rounded upward from `1.0376+Cnp(threshold)`, so it leaves a strict positive margin. These are sufficient **consumer targets**, not new estimates of the actual major integral. The original `1.049` is stronger in all three rows. Relative to the baseline, the extra normalized allowance is about `.00177027` at `10^28` and `.00235117` at `10^29`. Even taking `N` arbitrarily large can release at most the baseline nonprime allowance by this mechanism.

For orientation only, the existing primitive etaPlus error numerator `7.5e-8+7.7e6/sqrt(x)` becomes at most `4.22850543e-7`, `1.85e-7`, and `1.09785055e-7` at the three thresholds, respectively. These are upper bounds after multiplying the character error by `sqrt(q)`. The etaU square-root term `4.7e6/sqrt(y)` is at most `1.486270501e-6`, `4.7e-7`, and `1.48627051e-7`; its separate absolute `1e-17` term is still present in Corollary 7.1.3. This table does not assert that the character errors aggregate unchanged after reducing the verification height.

## 3. A failed height substitution independent of N

The exact etaPlus entry is `MajorArcs/Prop942.lean:76–99`. In addition to finite RH through `H`, it requires

`H >= 200 + max(10*pi*abs(delta),50)`.

At the allowed even primitive conductor `c=300000`, the selected normalized endpoint is `delta=1200000/c=4` and the original used height is

`Horig=max(100000000/c,200+75000000/c)=450`.

There are primitive characters at this conductor: its prime-power factors have nonempty primitive character sets. No claim about their zero locations is needed for this parameter test. The exact condition becomes

`H >= 200+40*pi > 325.6636`.

Therefore `Horig/2=225`, `Horig/10=45`, and `Horig/100=4.5` all fail. The inequality is unchanged when `N` is raised to `10^28`, `10^29`, or any larger threshold. For any **uniform multiplicative height reduction** `Hnew=lambda*Horig` preserving these arc endpoints and this estimate, a necessary condition is

`lambda > 814159/1125000 = .723696888...`.

This is only a necessary admissibility condition. It does not prove that this near-boundary height gives a sufficiently small error. It also is not a lower bound for a conductor-dependent certificate's weighted work, nor for every possible analytic method.

There is an even simpler failure for a uniform factor `1/10`: at conductor one the plus phase endpoint is `delta=600000`, so height `10^7` would need to exceed `200+6000000*pi`, already larger than `18,849,540`. The odd-conductor endpoint condition also fails for `10^7/c` throughout its range. The half-height substitution fails already at even conductor `100000`, where `500 < 200+120*pi`. These are actual consumed parameter ranges, not unused extremes of the broader declared Platt domain.

The source reason is visible before any numerical estimates. `Prop942.lean:50–59` writes the normalized error as

`E0/x + E1(H)/sqrt(x) + E2(H,delta) + V/(2*pi*x*sqrt(x))`.

The third term has no `x` factor. `Explicit/ZeroSumGen.lean:195–197` defines it from geometric tails. For etaPlus their starting point is `H-200`; `ZeroSumBound.lean:89–107` has

`EB(T)=.892*T*exp(-.1598*T)` and

`EA(T,delta)=.588*u^2*exp(-.1065*u^2)`, `u=T/(pi*abs(delta))` when `delta!=0`.

Thus the high-zero estimate is an absolute floor of the *available upper bound* as `x` grows. It is not a lower bound on the actual error. Increasing `N` cannot scale this contribution down by `N^(-1/2)`. `Thm714.lean:430–484` separately requires the E2 bound times `547.73` to be at most `6.9e-8`; that proof has already allocated its independent constant. Reusing its conclusion at a shorter height requires a new E2 proof, not just a stronger `x` hypothesis.

The minor base-gap use of etaU likewise needs its own shorter-height proof. `Cor713.lean:807–827` consumes the finite-RH estimate under `max(10*pi*abs(delta),50)<=H`. Its high-zero term is also independent of `y`. A new major coefficient alone therefore does not preserve every original consumer.

## 4. Finite-range price and a precise conditional ladder design

With binary cutoff `B=4*10^18`, one prime covers at most `(B-2)/2` odd integers via `4<=n-p<=B`. After the elementary range through `B+3`, there are `(N-B-4)/2` remaining odd integers below an even threshold `N`. Consequently any covering argument that uses only such single-prime intervals needs at least

`ceil((N-B-4)/(B-2))`

intervals. At the three thresholds this lower bound is `250,000,000`, `2,500,000,000`, and `25,000,000,000`. It is a bound on this representation of a finite cover, not a proof-verification time lower bound: sharing or proving many intervals at once can change checked work.

The existing ladder uses exponent `m=45`, step coefficient `S=111616`, and offsets `0<=t<2048`. `Ladder/Spec.lean:58–79` requires `S*i<2^45`, in order to use the prime-factor criterion below `(2^45+1)^2`. Its fixed design therefore does not extend to `10^28` by adding more rows. The simple sufficient range ceiling `2^90=1237940039285380274899124224` is already below `10^28`. No assertion that the old test remains a primality certificate above its proved domain is permissible.

A concrete **conditional** replacement geometry retains 2048 offsets but changes the power of two. For threshold `N`, choose `m` and `S` below. Require for every `1<=i<=I=floor((N-5)/(S*2^m))` a certified prime

`p_i=(S*i-t_i)*2^m+1`, with `0<=t_i<2048`.

| Threshold | `m` | `S` | Step `S*2^m` | Required rungs `I` | Ratio to old rung count |
|---|---:|---:|---:|---:|---:|
| `10^27` (existing) | 45 | 111616 | 3927138875067072512 | 254638308 | 1 |
| `10^28` | 47 | 26374 | 3711810517883420672 | 2694103039 | <10.580117 |
| `10^29` | 49 | 5058 | 2847400864404996096 | 35119747714 | <137.920127 |

All geometry is checked exactly in the script:

* `S>2047`, so the first candidate coefficient is positive.
* `(S+2047)*2^m<=B-4`, so adjacent possible prime locations leave a sufficiently small gap.
* `S*I<2^m`, so the generalized Proth/Pocklington argument has its required size bound.
* `N<2^(2m)`; the preceding integer exponent does not meet this simple size bound for either new threshold.

For an odd `n>B+3`, take `i=floor((n-5)/(S*2^m))`. Its upper prime endpoint is at most `n-4`. Its lower prime endpoint is at least `n-B` by the displayed step-plus-window inequality. The prime is odd, so `n-p_i` is an even integer in `[4,B]`. The small initial range uses `p=3` exactly as in `Helfgott/SmallCases.lean`. This proves the full finite-coverage implication **if the new prime certificates exist and pass**.

No such prime existence, search success, fallback design, or checked generalized ladder is supplied here. A fixed base need not succeed in every new window. The powers and loop bounds in the existing batched checker also need generalization; its recorded per-rung timings cannot be copied to these wider integers and changed schedules. The ratio table is a count ratio only. It is useful input to the independent finite-range study, not a standalone production recommendation.

## 5. All-consumer decision and remaining work

The safe original-analysis candidate is the unchanged spectral domain and estimates at a larger `N`. It satisfies every original analytic consumer by restriction, but has **zero demonstrated spectral work reduction** and a larger finite-range obligation. On current evidence it is dominated by keeping `10^27` for the same certificate architecture.

The tested proportional-height candidates fail an explicit source inequality; they are rejected without any spectral computation. This does not rule out a smaller height adjustment, a different conductor profile, changed smoothing, or a smaller arc cutoff. To turn the extra margin into a competitive route, the next calculation must simultaneously provide:

1. New uniform E1/E2 and contour/remainder estimates for both actual smoothings at the proposed heights, including principal and induced-character cases.
2. Their actual Gauss-weighted major aggregation and full cubic lower bound, with principal L2 lower/upper consumers kept distinct.
3. The pointwise minor base-gap estimate at the same proposed profile, plus the remaining minor numerical bound if arcs or smoothing change.
4. The nonprime comparison above and a complete enlarged finite cover with a checked binary input.

Until these exist, an apparent spectral-volume saving is not achieved work. For both Lean and MM0 the finite-cover enlargement adds certificate generation, verification, and serialization obligations. No operation-to-time conversion is made, and the MM0 analytic-library obligation remains separate. This note does not reuse any withdrawn forecast headline.

## 7. Reproduction and pins

The scalar-only script is `efficiency_analytic_threshold_20261111.py`; it imports only Python standard-library rational/integer and JSON utilities. Reproduce with `work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/major-constants/efficiency_analytic_threshold_20261111.py`. It writes only its adjacent JSON receipt. The decimal fields in that receipt are upward-rounded integers in units of `10^-15`.

Script SHA256: `099B8D4DF1DF78784303BD1319D48B78C3E1F6E0E8F2FB3F05ED7C5263B2102F`.

Receipt SHA256: `121415718A960F1668DF8687DB1A6CD6740D2509DD50003289581E452A594C52`.

Source hashes are appended below. The source conclusions remain conditional on their stated finite-RH and binary hypotheses; reading them does not discharge those hypotheses.

| Source under `TernaryGoldbach/` | SHA256 |
|---|---|
| `Helfgott/Defs.lean` | `4CE6EA7FB475024DF403775F9480D7D01B6336A798E0CF254BD61B5AFEC79DC7` |
| `Helfgott/Inputs.lean` | `5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83` |
| `Helfgott/Main.lean` | `DD5E20E51EC7C699CAC00A497C34FEF687E7E5B4562D3B1D8B981ECE54F4261D` |
| `Helfgott/Numerics.lean` | `059874D201ECC571583118A56BA6193D6D8B49016C227988CBC83FA0F34648DB` |
| `Helfgott/SmallCases.lean` | `61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359` |
| `MajorArcs/Prop942.lean` | `35B170971DBD0F1C6646CD86ECE8C3A86021085C1B07730141CD6311D9CA5716` |
| `MajorArcs/Thm714.lean` | `7BBF8F06B1A0B703A0C00FF1E5E64997792C4E93629CED591FCB6A646301FD3F` |
| `MajorArcs/Cor713.lean` | `11325BE6F77A7A762747542F30E2A9035782765A801C603F14107E84ED5D7433` |
| `MajorArcs/MajorTotal.lean` | `106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A` |
| `MinorArcs/BaseGap2.lean` | `AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E` |
| `MinorArcs/MinorTotal.lean` | `6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742` |
| `Explicit/ZeroSumGen.lean` | `9096C5D611A09FFCF5A4516BFDDC1E518B9917C52B5BC206216AF86A31A52389` |
| `Explicit/ZeroSumBound.lean` | `A1294627F676EC49BED1BD86407A9460DC569B77AF8CBE8D65F1F49129BF17D4` |
| `Ladder/Spec.lean` | `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F` |
| `Ladder/Main.lean` | `A68289240152DDF2D6ADBD98A0055B45284D924F4F64820D851C01CA6FA250E9` |
