# Replacing the explicit ladder by a principal finite-RH prime-gap theorem

2026-11-11. Bounded primary-source research and exact scalar arithmetic. No prime search, zero or special-function evaluation, Lean/MM0 build, source modification, or production certificate was performed. This is a proposed proof construction, not a completed formal proof or a timing forecast.

There are two concrete sufficient routes through N=10^27. For B=10^16, Johnston's finite-RH theorem applies with the conservative height H=9*10^12 and leaves strict room in the prime-gap inequality. For B=2*10^16, the corrected Cully-Hugill–Lee interval theorem, with the exact published height H=3,000,175,332,800 and its additional inputs, covers the whole required range. Neither route needs an explicit array of ladder primes. Neither route removes binary Goldbach up to B or the nonprincipal spectral family needed for the large-number analysis.

An older Kadiri–Lumley route also deserves comparison: B=6*10^17 can remove the ladder with a published H=3.061*10^10 input, subject to its distinct analytic and parameter certificates. The main decision is whether the added principal RH certificate plus the interval theorem costs less to generate and formally check than the mixed ladder. Counting only conductors would conceal this trade: even one conductor can involve a large zero population.

## 1. Exact consumer and endpoint conversion

The actual target source is `work/ternary-goldbach/TernaryGoldbach/Helfgott/SmallCases.lean`, lines 20–45. Its finite reduction only needs, for every odd n with B+3<n<=N, an odd prime p satisfying

`n-B <= p <= n-4`.

Then 4<=n-p<=B is even and the binary certificate applies. For odd 7<=n<=B+3, use p=3. The existing source fixes B=4*10^18; specializing it to another certified B and replacing its `Ladder.ladder_prime` call are new formalization tasks, not changes made here.

Set x=n-4, y=n-B and h=x-y=B-4. A positive difference of ordinary theta at x,y gives a prime in (y,x]. A positive difference of the half-weight endpoint convention theta* gives a prime in the CLOSED interval [y,x], which is already sufficient. This avoids silently changing Büthe's convention or requiring a right-limit neighborhood beyond the terminal height. All weights are nonnegative; if no prime belonged to [y,x], the difference would be zero. Since n>B+3 and B is even, y>=5 and every such prime is odd.

For a theta estimate available only above 599, there is no missing small numerical ladder. If y<=599, then theta*(y)<=599 log599<4193. In our uses x>=B+1 and theta*(x)>x-E(x)>4193. If y>599, apply the two endpoint bounds. This deliberately includes equality y=599 in the elementary patch: Büthe's theorem uses x>599, whereas Johnston states x>=599.

## 2. Primary finite-RH statements

**Büthe, Theorem 2.** RH for 0<Im(rho)<=T gives the theta* bound E(x)=sqrt(x)log²(x)/(8pi), for x>599 subject to 4.92 sqrt(x/log x)<=T. The proof uses a smoothed explicit formula and finite low-range checks; those checks and its low-zero reciprocal-sum input must be formalized or replaced. We do not turn its published numerical subproofs into kernel theorems by citation. [Büthe, arXiv:1410.7015v4, Theorem 2, pp. 13–15](https://arxiv.org/pdf/1410.7015v4).

**Johnston, Theorem 3.2.** The same error is valid for x>=599 when

`J(x) = 9.06 sqrt(x/log x) / loglog x <= T`.

Section 2 explicitly permits the standard counting convention for the main results; the closed-interval argument above also works directly with the normalized convention. Its proof bootstraps from the already established finite-RH computation through 3*10^12. Thus the printed parameter T must not be mistaken for the entire proof dependency when proposing T below that baseline. [Johnston, Theorem 3.2 and its proof](https://link.springer.com/content/pdf/10.1007/s11139-022-00616-x.pdf).

**Cully-Hugill–Lee, corrected v3.** Theorem 1/Table 2 gives a prime in (x(1-1/Delta),x] for all x>=x0. We use only the rows `(log x0,Delta)=(55,10288400000)` and `(60,76918400000)`. Their proof uses H=3,000,175,332,800, explicit zero-density/free-region bounds, prime-power corrections, and N0=260000000, S0=21.98308 at T0=104537615. The table's parameter inequalities were numerically optimized; exact directed certification is still required. The obsolete much larger Delta values visible in some search summaries are not used. [Corrected arXiv:2103.05986v3, §§2–5, Table 2](https://arxiv.org/pdf/2103.05986v3).

These statements give actual primes through theta, not merely a positive psi increment that might count prime powers. A full-RH short-interval theorem cannot simply be truncated at an invented height: its omitted-zero estimate must be supplied. Ramaré–Saouter's general smoothed criterion offers another finite-height route, but no new parameter certificate for it was constructed here. [Ramaré–Saouter, Theorem 4](https://ramare-olivier.github.io/Maths/gap.pdf).

## 3. Route A: B=10^16 and H=9*10^12

Let N=10^27. Elementary bounds sufficient for our calculation are

`62<log N<62.2`, `loglog N>4.1`, `sqrt N<3163*10^10`, `pi>3.14`.

For x>=599, J(x) is increasing: its derivative with respect to log x has logarithmic factor `1/2-1/(2 log x)-1/(log x loglog x)>0`. It is enough to check x=N. Squaring positive quantities reduces the height condition to the exact comparison

`(9.06)^2*N / (62*(4.1)^2) < (9*10^12)^2`.

Also E increases, and the two endpoint error has the rational upper bound

`2 E(N) < (3163*10^10)*(62.2)^2/(4*3.14)`

`=1529642615000000000/157 < 9.75*10^15 < B-4`.

Consequently theta*(x)-theta*(y)>h-E(x)-E(y)>0 whenever y>599. The elementary patch in §1 handles y<=599 because E(x)<4.875*10^15. This proves the entire required interval-prime proposition, conditional on the finite RH certificate and the formalized primary theorem, including n=N when that endpoint is relevant.

The simpler Büthe condition also works with H=2*10^13. It trades extra spectral verification for avoiding Johnston's iterative improvement. The height 9*10^12 is sufficient, not asserted minimal. No global QRH is used in this deduction.

## 4. Route B: B=2*10^16 at the published height

Use the exact published H*=3,000,175,332,800. The following rational breakpoints eliminate ambiguity about exponential thresholds:

| x=n-4 range | Input | Maximum interval length used |
|---|---|---|
| B+1<=x<=10^24 | Büthe with T=3*10^12<=H* | two theta errors, <10^12*56²/(4*3.14) |
| 10^24<=x<=1.2*10^26 | corrected CHL row55 | <=300000000000000000000/25721 |
| 1.2*10^26<=x<=10^27 | corrected CHL row60 | <=312500000000000000000/24037 |

Each displayed length is strictly below B-4. The first row uses `48<log(10^24)<56`; its Büthe height comparison is much smaller than (3*10^12)^2. Its small-y case is covered by §1. For the second and third rows, `exp55<10^24` and `exp60<1.2*10^26`, so the table's threshold hypotheses hold throughout. A prime greater than x-x/Delta is greater than x-(B-4)=n-B and at most x=n-4. The rows overlap at both joins.

This is a genuine whole-range implication of the published results. It is not a claim that their computational leaves have already been accepted in Lean or MM0. In particular, RH through the rounded-down 3*10^12 must not be substituted for H* inside the CHL table computation without rechecking that computation.

The same row60 does not settle B=10^16 at the top: N/76918400000>10^16. It could still replace a lower portion of that ladder, or be improved by a separately certified parameter choice. This report does not claim either improvement.

## 5. Coefficient/height tradeoff and its bootstrap trap

Johnston's Theorem 4.1 uses a different condition, `K sqrt(x/log³x)<=T`, with error `a sqrt(x)log²x`. Its printed table begins with (a,K)=(1,1.19), followed by a=10,100,... . It does not give an intermediate a near0.08. [Johnston, Theorem 4.1/Table 2 and proof](https://link.springer.com/content/pdf/10.1007/s11139-022-00616-x.pdf).

At N=10^27, that a=1 condition is satisfied by T=8*10^10 and the two-error allowance is below 2.5*10^17. This suggests a different B=2.5*10^17 frontier point at the level of scalar hypotheses. It is NOT presently an 8*10^10 verification-cost route: the published proof initializes its iteration with Corollary 3.3, itself obtained from RH through 3*10^12. A new base-range proof must remove that dependency before pricing the smaller height.

For B=2*10^16, a hypothetical intermediate coefficient must satisfy `2a sqrt(N)log²N < B-4`; the conservative scalar envelope here requires `a < (B-4)/(2*(3163*10^10)*(62.2)^2)`. Neither linear interpolation of the table nor choosing a new smoothing parameter proves the needed theorem. This is a focused analytic research question: certify the explicit error inequality and all lower-range joins from scratch, then compare its actual maximum consumed RH height with H*. Major-constants is investigating that separate proof, not an assumption used here.

## 6. Older, lower-height frontier

Kadiri–Lumley's Theorem 1.1/Table 2 uses H=3.061*10^10. Select `(log x0,Delta)=(46,148306019)` and `(59,1946282821)`. Its general input list includes R0=5.69693, explicit counting and density bounds, and initially T0=1132491, N0=2001052, S0=11.637732363. Section 3.3 selects count bounds rather than inverse-ordinate sums. [Kadiri–Lumley, arXiv:1407.7902v1, Theorems 1.1/3.2, §3.3 and Table 2](https://arxiv.org/pdf/1407.7902v1).

Here is an additional all-range construction, with B=6*10^17 and the same N:

* For B+1<=x<=10^20 use Büthe with T=3*10^10. The height follows from log(10^20)>40. The same endpoint patch applies.
* For 10^20<=x<=5*10^25 use the row46, since exp46<10^20 and `(5*10^25)/148306019 < B-4`.
* For 5*10^25<=x<=10^27 use row59, since exp59<5*10^25 and `10^27/1946282821 < B-4`.

The source's strict x>x0 condition holds at our rational breakpoints; its open prime interval is more than sufficient. Five additional integer/fraction checks of these threshold/height/gap comparisons passed in a read-only command; they are not included in the25-check JSON. The top length is about5.138*10^17, so B=6*10^17 is a deliberately loose candidate, not an optimum. This construction does not use the paper's already-computed prime gaps through4*10^18 to fill its lower range.

There is a concrete certificate simplification. Write C=4F0/(exp(u/2)+1). The two valid low-zero count bounds are C*N0 and C*(N(T1)-N0). Adding them gives C*N(T1), and then the analytic upper count bound can replace N(T1). No numerical N0 or S0 is needed for this direct combined bound. The reciprocal sums in the paper's demonstration that these branches are optimal need not be proved to justify choosing them. The table parameters still need an exact recheck using this expression and all remaining terms. That is a mathematical simplification of the chosen proof, not a claim that the whole table has been certified here.

The older Ramaré–Saouter row at log x0=60 gives Delta209267308, using a3.3*10^9 verified-height input; at N its gap exceeds4*10^18. Thus its printed row does not improve the original B while eliminating the entire ladder. It remains relevant for a lower analytic prefix or a re-optimized criterion. Selecting a newer theorem solely because its gap is smallest would overlook the principal-height and library tradeoff.

## 7. Standard-axioms cost comparison

Platt–Trudgian prove their exact H* result by rigorous interval sign detection and Turing completeness, reporting 12,363,153,437,138 positive zeros and approximately7.5 million core-hours on their hardware. They did not preserve every zero to high precision; existence/sign data plus complete counts were sufficient. These are published computational facts, not Lean/MM0 performance measurements or an independently replayed certificate in this workspace. [Platt–Trudgian, Theorem 1 and §2](https://arxiv.org/pdf/2004.09765).

At fixed B the comparison is

`added principal certificate generation + checking + gap-theorem formalization`

versus

`mixed-ladder generation + primality/coverage checking + its remaining checker formalization`.

Reuse already accepted principal certificates instead of charging them twice. The original-analysis principal domain was through10^8; a newly proved higher principal RH result can replace that input, but it does not replace the nonprincipal family. If comparing different B, include the entire change in certified binary coverage, source sieve, anchor certificates, exceptions and assembly.

The current mixed candidates have181029996372 rungs for B=10^16 and90804183483 for B=2*10^16. A principal sign-count certificate can have much larger event count despite one conductor. Conversely, FFT/interpolation shares substantial work across its events, and a theorem quantified over every x removes the ladder instance array entirely. Neither event count nor conductor count determines the winner.

For Lean, acceptance must prove the interval algorithms and their analytic remainder/completeness theorems and evaluate the actual certificate using trusted kernel-supported reductions or an explicitly justified checking path. Native Arb success is not a kernel theorem. For ordinary MM0, elementary interval arithmetic, transforms, multiplicity/count arguments and final analytic implication need PA-compatible proof/library constructions; an arithmetic accelerator is a separate verified-checker boundary and must be costed as such. Common arithmetic DAGs and streaming can reduce repeated work and materialization, but cannot erase the soundness obligations.

The new analytic library is material. Route A needs the Büthe/Johnston smoothing and bootstrap subproofs. Route B adds the selected zero-density/free-region machinery and exact certification of the table parameters and low-zero weighted sum. Existing global7/8 QRH could support a different tail proof, but substituting it into these constants without rederivation is not valid. No assumption that it automatically yields square-root-scale prime gaps is made.

## 8. Concrete next decisions

1. **Certify selected parameter rows, including the older low-height alternative.** Compare the two KL rows with their direct count branch against the two CHL rows and their actual selected low-zero branch. Reproduce the strict inequalities with exact directed arithmetic and inventory every analytic dependency. A failing margin or an expensive new library is a falsifiable reason to prefer another frontier point. Optimizer agreement alone is not acceptance.
2. **Compare one complete principal sign/count block with one complete mixed ladder block at matched trust.** Include shared transforms, exceptional cells, arithmetic proof size, memory and completeness. Use the measured components to extrapolate only after verifying the operand/height regime; do not reuse the old rung timing for a changed checker.
3. **Test a fresh intermediate-a or QRH-tail theorem against the actual consumed maximum H.** Require a full uniform-x proof and a base range not secretly using H*. This is the plausible way to reduce both the ladder and new spectral workload; its feasibility remains open.

The immediate conclusion is structural: published prime-gap results already support a finite-RH-only replacement at B=10^16 with an additional9*10^12 height target, and the corrected published smoothing result supports B=2*10^16 at H*. Whether either minimizes eventual Lean/MM0 total time is not established.

## 9. Exact evidence and limits

The new scalar script uses only integers, fractions and factorials. Its25 checks include elementary e brackets from a finite positive series/geometric tail; integer-power deductions of the required log/exponential comparisons; height inequalities squared on positive quantities; the endpoint patch; and both rational CHL interval lengths. The pi lower bound uses the classical Archimedean223/71 bound. It does not check the CHL/KL optimized parameter inequality, prove a finite RH statement, or evaluate zeta, primes or intervals numerically.

SHA256 pins:

| Artifact | SHA256 |
|---|---|
| `principal_finite_rh_ladder_scalars_20261111.py` | `DE7D2030BC195F9887D265409506C909C1F0D6DA4F3D9E0F403232B978C0CD63` |
| same-stem `.json` | `F03043BF58FC5E0F6F94405FC5FE262BE4863C0EABEFF969F064AF77909670BB` |
| target `Helfgott/SmallCases.lean` | `61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359` |
| target `Helfgott/Inputs.lean` | `5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83` |
| prior owned `EFFICIENCY_MIXED_LADDER_2026-11-11.md` | `9AACAF7FC0B5DCD9145AB3006D40248A2C7D57319677C57600890D21E5F75783` |

Primary PDFs were read through the web source tool, including visual inspection of corrected CHL Table2. They are identified by DOI/version above rather than represented as locally byte-pinned downloads. No claim of a current-world-record survey, full proof audit of those papers, implementation, or completed standard-axioms certification is made.
