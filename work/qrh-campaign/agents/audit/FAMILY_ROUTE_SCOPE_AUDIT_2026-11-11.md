# Scope audit: elementary Turing, Fourier signs, and the selected finite strip

2026-11-11. **Verdict: the reviewed certificate rules are sound as sufficient rules, but neither the elementary Turing theorem nor convergent Fourier evaluation proves that the full sign-production scheme terminates for every instance of the selected beta<=.555 target.** The frozen production plan correctly calls its sign route stronger than that target and rejects unresolved cases. That distinction must survive any synthesis.

No Lean build, spectral scan, canonical source edit, dependency change, or frozen-package mutation was performed. This is an end-to-end scope review, not another proof of every Fourier estimate. Zero_sum independently identified the same termination obstruction and is developing the fallback; that new fallback is not treated here as already reviewed or implemented.

## 1. Exact source roots remain unchanged

I read the actual definitions in `TernaryGoldbach/Statement.lean` and the consumers in `MainTheorems.lean` and `Helfgott/Main.lean` at target commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

* `IsSumOfThreePrimes n` means three natural primes p,q,r with p+q+r=n. Distinctness is not required.
* `TernaryGoldbachFrom (10^27)` means every odd natural n with 10^27<=n has that representation, with the threshold included.
* `Statement` means every odd natural n with 5<n has that representation.
* `BinaryGoldbachInput` is the original binary assertion for every even natural n with 4<=n<=4*10^18.

The intended new large root has **no mathematical hypothesis**. The intended full root retains **only the original BinaryGoldbachInput**. Finite spectral assertions, QRH, interval-checker correctness, Turing bounds, convergence, multiplicity facts, and character manifests are internal obligations, not additional permitted assumptions of either root. This note freezes no declarations or approved dependency graph.

The current source still takes PlattGRH in its large theorem and both PlattGRH and BinaryGoldbachInput in its full wrapper. The new finite family does not imply that old PlattGRH predicate: its real-part conclusion, conductor range, and heights differ. One cannot restore the old instance by renaming a `.555` certificate. All consumer replacements and their eventual type/axiom checks remain necessary.

## 2. Selected mathematical target versus stronger certificates

The inspected selected strategy requires, for every active primitive character, every actual nontrivial zero rho with |Im rho|<=Hcert(c) to satisfy Re rho<=111/200. The active conductors are odd c<=150000 and c divisible by4 with c<=300000; the manifest includes conductor1 and all inverse characters. It has 150000 conductor slots and the recorded 5,543,640,188 primitive-character total. These counts do not by themselves prove the manifest's enumeration or any spectral assertion.

The height is exactly

```
qt(c)=2c for odd c, and c otherwise,
D_c=1200000/qt(c),
Hp_old(c)=ceil(200+max(1000,(704/7)*D_c)),
Hcert(c)=min(Hp_old(c),10^8/c).
```

The inequalities are closed in height and real part. The selected principal height is60,343,058. The separate principal moment additionally needs the accepted critical-line head through1500 and the still-unproved strip [.4968,.5032] for1500<|gamma|<=10^6. The `.555` family target alone cannot supply that narrower principal strip.

For c>1 the current Turing and Gaussian machinery applies to actual primitive nonprincipal characters of either parity. Conductor1 is outside those theorems: its pole and theta constant terms cannot be suppressed. The separate principal route remains required. All nonprincipal selected cutoffs exceed50 (indeed 10^8/c>=1000/3 on the active range, and Hp_old>=1200), so a main height T>=Hcert fits the elementary Turing domain.

The production plan offers two certificate kinds:

| Kind | What successful checking proves | What it does not establish automatically |
| --- | --- | --- |
| Critical-line signs plus a strict total-count saturation test | Finite RH through the closed main height, with simplicity of each noncentral zero accounted for by one sign interval | Existence of such a certificate from the weaker `.555` target |
| Zero-free right-rectangle boundary plus zero winding | No zero in the enclosed prohibited region | Treatment of a zero on the vertical boundary Re=.555, or termination without a strict margin/boundary adapter |

Both can be valid sufficient methods for the final strip theorem. Neither should be described as logically equivalent to that theorem without the qualifications below.

## 3. What the new analytic and numerical components really supply

The elementary Turing assembly proves on paper

```
|integral_(t1)^(t2) S_chi(t) dt|
 < 42+(693/100)*log(c*t2/(2*pi)),  50<t1<t2,
```

with the canonical Euler-normalized S. It uses neither RH nor simplicity nor numerical zero data. The independent Littlewood review established arbitrary endpoint ordinates, including zero ordinates. This is a genuine improvement in analytic dependency scope, not a proof of family completeness.

The Gaussian Fourier identity supplies the actual positively scaled real Hardy function, with the required conductor scalar and fixed root phase. The alias and arbitrary-height parameter plans supply sufficient error bounds and finite parameter choices for an advertised positive tolerance. They do not certify a sign unless the resulting real interval excludes0, do not prove a zero count, and do not make an interval containing0 into an equality proof. The arbitrary-height plan removes the earlier cH<=10^8 restriction for auxiliary evaluation, but adds no sign or saturation guarantee.

The root-phase charts terminate under convergent primitive interval evaluation because one of two overlapping charts must apply. That is termination of phase selection only. The exact phase is fixed for a complete character channel. Independent phase changes by height or frequency would create false sign changes. Opposite-height reuse uses the proved inverse-character relation and its constant sign, including the positive exponential scaling in tilted numerical values. These requirements are retained in the reviewed notes.

Both complex characters and real characters need exact multiplicity accounting. Nonreal chi uses positive lists for chi and its inverse to account for both signs of ordinate. Real chi uses its positive list twice. The central contribution is counted once. A numerical imaginary interval containing0 does not prove real-valuedness; that comes from the functional equation and exact phase identity. A central real interval containing0 proves neither central vanishing nor its order.

## 4. Why sign saturation is stronger than the selected target

For disjoint strict sign-change intervals, continuity gives at least one zero in each interval. Each interval contributes only one to the lower count. If the strict total-count test proves equality with that lower count, each ordinary interval contains exactly one zero of multiplicity1 and there are no additional noncentral zeros. Exact central multiplicity records can be more general.

Consequently the following hypothetical spectral configurations satisfy the selected real-part target but defeat the ordinary sign-only lower count:

1. A pair of off-line zeros at real parts .54 and .46, paired by the actual functional equation, contributes to the total count but not to critical-line signs.
2. A double critical-line zero has no sign change and contributes multiplicity2 to the total count.
3. A critical-line zero of order3 contributes a sign change but the ordinary interval lower count records only1.
4. Real zeros away from1/2 are included in the closed total count but are not detected by a central-value test or positive-height sign scan.

These are logical countermodels to an inference about certificate termination, not claims that any particular Dirichlet L-function has those configurations. Successful saturation would rule them out. No simplicity or finite-RH hypothesis is present in the checking theorem; the danger would be treating the success of its producer as guaranteed by the weaker target.

Refining the numerical tolerance cannot repair these structural cases. Even at a fixed point, convergence of enclosures proves eventual strict sign only when the actual value is nonzero. A sample that is exactly a zero can remain unresolved forever. Adaptive grids can avoid isolated zeros when seeking nonzero samples, but cannot manufacture a sign change across an even-order zero.

## 5. Auxiliary signs and the larger allowance

For the closed count C(T), the a.e. count identity and integrated-S bounds give

```
C(T)<=U=(integral_T^(T+h) G - W + 2B)/h,
B=42+6.93*log(c*(T+h)/(2*pi)).
```

The weighted sign contribution W is a lower bound for the integral of the added-zero count, not necessarily an equality. More explicitly, before enclosure rounding,

```
h*(U-C(T))
 = 2B-integral(S_chi+S_inverse)
   + integral(added-zero count)-W.
```

Both deficits are nonnegative under the proved inequalities. Missing auxiliary off-line zeros, even-order zeros, or unresolved signs can leave a nonzero second deficit. Increasing h decreases a fixed allowance divided by h only after accounting for B's logarithmic growth; it can simultaneously increase the missing-zero contribution. Thus arbitrary-height Fourier parameters and h enlargement alone do not prove eventual `U<K_main+1`, even if all main-height zeros happened to be simple and on the line.

If one separately proved that all required auxiliary zeros were captured with sufficient weight accuracy, then the analytic deficit is at most4B and one could choose/refine a zone making the total deficit less than h. That is a sufficient conditional termination argument, not currently supplied spectral information. The actual strict rational saturation test must still be checked for every packet.

One alternative is to add weighted certified complex zero-cluster counts in the auxiliary zone, including off-line and multiple zeros. Each cluster with m zeros and ordinates bounded above by v<T+h contributes at least m*(T+h-v). Clusters must be disjoint or otherwise have a proved no-double-counting scheme. This broadens W without assuming line RH; it requires a new sound complex-count adapter, not a reinterpretation of sign intervals.

## 6. Endpoints and exact fallback scope

The closed-count addendum removes a separate top nonvanishing hypothesis from the Turing acceptance theorem. Zeros exactly at |gamma|=T are included in C(T); ordinary main intervals strictly below T do not count them. If they are unaccounted, saturation fails. Therefore successful ordinary saturation also excludes such top zeros, but the checker need not assume their absence. A top zero can instead be handled by an exact multiplicity record or by a separately checked larger main height. Values of S at auxiliary endpoint ordinates do not change the integral. Strictly signed sample endpoints must themselves be nonzero.

For the direct strip route, a rectangle with left edge Re=.555 and a boundary nonvanishing certificate cannot pass if an allowed zero lies exactly on that edge. This is a stronger boundary condition than the closed real-part target. Moving the edge to .555+epsilon leaves an unproved strip between the target and the new edge; it is not a valid repair by itself.

The following are precise sufficient alternatives:

* **Direct strict-margin exclusion:** prove nonvanishing on a whole-panel boundary enclosing the prohibited right region and prove zero winding. With a genuine strict spectral margin below.555 and complete convergent analytic enclosures, adaptive contour subdivision can eventually certify the boundary. Choose the top above Hcert with complete coverage; merely checking a critical-line sample at that height is insufficient.
* **Total count plus allowed clusters:** prove a total-count upper bound and produce disjoint complex clusters, all enclosed inside Re<=.555 and the required ordinate range, with certified argument-principle multiplicities summing to that upper bound. This accommodates multiple and off-line zeros; it does not require individual simplicity. Include real and central zeros.
* **Exact boundary handling:** if a zero has Re exactly.555, prove the needed equality/location and multiplicity or a suitable boundary-count theorem. Generic shrinking interval boxes alone do not establish exact equality to a rational line. The same issue applies to clusters whose top must coincide exactly with Hcert; using an independently checked slightly larger height can avoid an unnecessary ordinate equality.

Local finiteness and a strict spectral margin can justify the existence of favorable contours and sufficiently small cluster boxes. They do not follow in the required strict form merely from the non-strict `.555` target. The fallback may be a semidecision procedure under those conditions; an unconditional producer termination theorem is a separate result.

## 7. Present obligations and synthesis wording

The current notes generally keep the distinctions correct: the production plan calls sign RH stronger, the alias notes deny sign/count conclusions, the phase note isolates chart termination, and the Turing assembly denies saturation guarantees. The selected strategy remains a list of obligations. No frozen correction is requested on the basis of a discovered unsound theorem.

Future synthesis should say **“a sound sufficient certificate route for the selected finite strip”**, not “a terminating checker/producer for every true `.555` instance.” A checker terminating on a finite submitted record is different from a producer finding an accepting record. Likewise, “the Turing theorem has no RH hypothesis” is correct, while “the whole sign-production route needs no stronger spectral success condition” is not.

Still required internally are: complete actual-character enumeration and inverse labels; interval primitives and evaluator semantics; fixed exact phases; all finite sign/cluster/central evidence; canonical completed-count normalization and its a.e. adapter; strict saturation or complete direct exclusion for every active row; the separate principal row and narrow principal strip; the actual global7/8 provider and its source/axiom checks; and all analytic consumer replacements. The final exported roots must discharge these rather than accept them as hypotheses. The selected major/minor budget and original BinaryGoldbachInput are unchanged.

## Pinned evidence inventory

Paths below are relative to the workspace; agent paths abbreviate `work/qrh-campaign/agents/`.

| Inspected artifact | SHA256 |
| --- | --- |
| `work/qrh-blueprint/next-synthesis/SELECTED_STRATEGY.md` | `E07683A017B922BC309E26763A821E97CAC7AE79938A19CCBF843E9205CABBF7` |
| `integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md` | `72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C` |
| `zero-sum/FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md` | `740840E7576E988AF4C8F8053030BE59EB4EA18DE8C7E0D6B391BF7C9B1C5DEF` |
| `zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md` | `6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4` |
| `zero-sum/FAMILY_ROOT_PHASE_PROOF_PLAN_2026-11-11.md` | `27B8ED6864E51BECEFA5402CC49E85B8A11F7F3BA620E7A7D1E6A682BBDD8C68` |
| `zero-sum/FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md` | `5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41` |
| `zero-sum/FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md` | `E7D5CD24F5FAA6B75ED5E1167F3165EACBD7BCA7FEDF73D521C6B74BD04776EF` |
| `work/qrh-blueprint/turing-scalars/AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md` | `45E848935AC76C8450550DFE02279C697514BF227B37EA6FD25221B3F7C37F47` |
| Target `TernaryGoldbach/Statement.lean` | `3F61837D2C3A0DDE3A1997F05AF21C20C7FE6EE13E29891125495F6947596BF8` |
| Target `TernaryGoldbach/MainTheorems.lean` | `4B2BDB187A2D9AC485239611EEE99D1C716C5BC0F57F1946DAA32CBD22FECFFF` |
| Target `TernaryGoldbach/Helfgott/Main.lean` | `DD5E20E51EC7C699CAC00A497C34FEF687E7E5B4562D3B1D8B981ECE54F4261D` |

The selected-strategy file is a frozen research snapshot, not an assertion that every later analytic development has already been incorporated. This audit changes neither it nor the original root definitions.
