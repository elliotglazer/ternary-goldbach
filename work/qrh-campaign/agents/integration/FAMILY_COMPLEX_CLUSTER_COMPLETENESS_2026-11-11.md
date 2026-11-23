# Multiplicity-aware cluster inputs for family completeness

2026-11-11. New mathematical certificate interface, submitted for independent review. This replaces ordinary sign-only lower counts and auxiliary weights by counts in certified complex regions. It preserves the existing closed-count/Turing consumer and permits multiple, off-line, and real zeros. No Lean declaration, build, actual L-function scan, canonical edit, or frozen-package change is supplied.

The conclusion is a sound sufficient certificate rule. It is not a claim that a producer finds an accepting record for every instance of the non-strict beta<=111/200 target. Exact boundary cases and production completeness remain explicit below.

## Inputs and prior review boundary

All paths in this table are relative to `work/qrh-campaign/agents/`.

| Input | SHA256 |
| --- | --- |
| `integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md` | `72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C` |
| `mellin/REVIEW_ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md` | `2238E4C56B808F9034DCE86ECA834A785BA5DF4E09F2F68935C287BD9CA5AAE3` |
| `zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md` | `6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4` |
| `major-constants/REVIEW_FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md` | `3033D761A2FE3F1B140A750CD1261D640EF8D1E98FA81711A438EB899A8AFE58` |
| `audit/FAMILY_ROUTE_SCOPE_AUDIT_2026-11-11.md` | `BBE918AF20B0FB20E82A3BEA5EDB9F32EBA27B808D46EA0A9073091CCADA150A` |
| `zero-sum/FAMILY_WEAK_STRIP_SYNTHETIC_CHECK_2026-11-11.md` | `78CA1AD1AB4A2FFEC1BF6B45730EE97632BC4ADCA08A1F413A5CF43A7BFB26F4` |
| `audit/REVIEW_FAMILY_WEAK_STRIP_SYNTHETIC_CHECK_2026-11-11.md` | `960FF4B0508390C8F1FBB7E7A215D24383213740BF47D96648BD9218F0119BC5` |

The synthetic polynomial tests establish bounded method checks, not any Dirichlet spectral statement. They motivate the replacement: an exact contour count retains multiplicity when ordinary signs do not. The new implication below follows from finite zero-count arithmetic and the already reviewed count/Turing identities; it does not infer actual L-function behavior from those polynomials.

## Actual carrier and a cluster certificate

Fix an actual primitive complex Dirichlet character chi of conductor c>1, with inverse character chi_bar. Let f_chi(s)=DirichletCharacter.LFunction chi s at the target source pin `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib pin `56a005855ea17e0b0958f73ec801ae140b0a1679`.

The nontrivial-zero carrier is

```
Z_chi = {rho : f_chi(rho)=0 and 0<Re(rho)<1}.
```

Each rho has its actual finite positive analytic order ord_chi(rho). The function is entire and not identically zero; zero sets are locally finite. On this carrier the completed function has the same order, since its Gamma and exponential factors are analytic and nonzero. These are the carrier/order bridges required by the reviewed count theorem, not assumptions about a finite numerical list.

For a bounded support E, write mu_chi(E) for the finite sum of ord_chi(rho) over rho in Z_chi intersect E. A cluster certificate records a support E and a natural number m, and must prove

```
mu_chi(E)=m.                                                (A)
```

The support's open/closed convention is part of the record. A standard implementation is a rational rectangle interior whose closed rectangle lies in 0<Re(s)<1, together with a proof of nonvanishing on its entire boundary and a certified argument-principle winding m. Whole-panel enclosures and the exact polygon theorem can supply such evidence. The count includes every enclosed zero with its order; it does not require one zero, a simple zero, or a root location estimate.

No point sampling alone proves (A). If using raw L outside the open critical strip, a winding can include trivial zeros and is not automatically mu_chi. The minimal implementation here keeps those rectangles inside the strip. Other carriers require an explicit subtraction/transport proof. Conductor one requires its separate pole/zero normalization and is excluded from this interface.

Supports may instead be exact finite-point records or regions with a proved boundary-count convention, but they must prove (A) with the stated boundary semantics. A generic contour with a zero on its boundary does not meet the ordinary argument-principle interface.

## Universal main-cluster rule

Fix b=111/200 and T>=Hcert(c), with T>50. Define the closed-height target set

```
A_T = {rho in Z_chi : |Im(rho)|<=T},   C_chi(T)=mu_chi(A_T).
```

Supply finitely many main supports E_j with exact counts m_j. For every zero counted by a main support, prove both

```
|Im(rho)|<=T,                Re(rho)<=b.                    (M)
```

The simplest proof is geometric containment of the support in those inequalities. A separate localization theorem for its enclosed zeros also suffices. No exact location is needed when rational region bounds prove containment.

Require zero-disjointness: no actual target-character zero belongs to two distinct supports. Pairwise disjoint supports are a sufficient check. For standard rectangle interiors, disjoint interiors are enough; closures may touch because their boundaries have been certified zero-free. Positive-area overlapping interiors cannot be double counted. They need a separately proved partition, a count of the union, or another explicit no-double-counting proof.

Then

```
K=sum_j m_j = mu_chi(union_j E_j) <= C_chi(T).               (K)
```

The equality concerns zeros in the supports, so (M) remains sufficient even when a support itself extends outside A_T but has a separate proof that no counted zero does. If later C_chi(T)=K, positivity of every analytic order implies that every zero in A_T belongs to the union. Therefore every such zero has Re(rho)<=b. No simplicity conclusion is forced for a cluster with m_j>1.

## Two-channel implementation and central regions

The existing source conjugation identity, initially from the Dirichlet series and then by analytic continuation, is

```
f_chi(conj z)=conj(f_chi_bar(z)),
ord_chi(conj rho)=ord_chi_bar(rho).
```

It transports `mu_chi_bar(E)=m` to `mu_chi(conj E)=m`, preserving the real part and reversing the ordinate. Winding implementations must respect contour orientation under conjugation; the count transport is a theorem about orders, not permission to reuse an unoriented signed winding.

A practical main record can contain:

1. Positive-ordinate supports for chi, transported identically into Z_chi.
2. Positive-ordinate supports for chi_bar, transported by conjugation into the negative-ordinate part of Z_chi.
3. Direct supports for chi meeting or surrounding the real axis.

All transported supports must satisfy (M) and the same joint zero-disjointness rule. Add their counts once. Do not add the full-plane count for chi to the full-plane count for chi_bar: each already describes a complete two-sided carrier.

A central box crossing Im(s)=0 counts all enclosed zeros, including any nearby nonreal zeros. It is not a certificate that they are real. Its entire count is included once directly for chi. Positive and conjugated-negative supports must avoid double counting it. Several disjoint central boxes may cover central and off-central real zeros; there is no restriction to s=1/2. This handles possible real zeros elsewhere in 0<Re(s)<1 without requiring their exact coordinates.

For a real character, chi=chi_bar. A positive support can be reused by conjugation, so its count contributes twice. Its positive and negative copies are disjoint. Direct central-region counts still contribute once, even when the region contains symmetric nonreal pairs. One may also avoid all reuse and certify direct target-character supports throughout the plane; the universal rule (K) is the same.

Once the target-character conclusion is proved, conjugation gives it for the inverse character at the same T and b. The two-channel packet can therefore serve a nonreal pair after this exact transport, without doubling the final count again.

## Multiplicity-aware auxiliary weights

Let H=T+h with h>0. Supply finitely many auxiliary supports F_j for the target carrier, with counts n_j, jointly zero-disjoint. For every counted zero require

```
T < |Im(rho)| <= v_j <= H,                                (V)
```

where each v_j is a certified rational height bound. These supports need only lie in the nontrivial carrier; no bound Re(rho)<=b is imposed on auxiliary zeros. In particular off-line auxiliary zeros to the right of .555 can contribute valid weight.

Define

```
W=sum_j n_j*(H-v_j).                                       (W)
```

The exact integrated added-count formula is

```
L = integral_T^H (C_chi(t)-C_chi(T)) dt
  = sum_(rho in Z_chi, T<|Im(rho)|<=H)
      ord_chi(rho)*(H-|Im(rho)|).
```

This is a finite sum. Each zero begins contributing after its absolute ordinate, so the equality also holds with closed counts; a zero exactly at H has weight zero. Every summand is nonnegative. Conditions (A), (V), and zero-disjointness give W<=L by comparing each counted order with H-v_j and then discarding all unrepresented summands.

The inequality at the lower auxiliary endpoint is strict. A zero at |Im(rho)|=T already belongs to C_chi(T) and cannot earn positive added weight. A box straddling T cannot contribute its whole count unless separate localization proves (V), or its count is split soundly. For a standard positive open rectangle with lower edge at T and certified zero-free boundary, every enclosed zero has Im(rho)>T, so it is valid. A box with upper edge v_j<=H is also valid. Equality v_j=H gives a zero lower weight, which is sound but unhelpful.

The same positive chi/positive chi_bar transport produces auxiliary supports. Their weights are added once per transported support, or doubled for a real character's reused positive supports. Main and auxiliary counted zeros are automatically distinct by their height conditions. No complete auxiliary inventory is required; missing auxiliary zeros only reduce W and make saturation harder.

## Unchanged Turing saturation rule

Use the reviewed canonical count identity almost everywhere and the allowance

```
B(c,H)=42+(693/100)*log(c*H/(2*pi)).
```

The two-channel integrated identity gives

```
h*C_chi(T) = integral_T^H G(t)dt
              +integral_T^H (S_chi+S_chi_bar)(t)dt - L,
G=2*theta_a/pi.
```

If Abar is a certified upper enclosure of the Gamma integral and Bbar bounds B(c,H), then

```
C_chi(T) <= U=(Abar-W+2*Bbar)/h.
```

Combine this with (K). The strict rational comparison U<K+1 implies C_chi(T)=K because both counts are integers. Every nontrivial target zero of inclusive height <=T is then in a main cluster, so (M) proves Re(rho)<=111/200. Since T>=Hcert(c), the selected inclusive-height conclusion follows. There is no need to prove individual zeros simple or exactly on the critical line.

All the canonical phase, Gamma-integral, count/order, Turing, and inverse-character identities remain exactly those of the existing consumer. Only the lower-evidence interfaces K and W change. The root's original BinaryGoldbachInput and the no-new-mathematical-premise large theorem are unchanged. Each cluster assertion must be proved internally, not accepted as a root hypothesis.

## Boundary values and mixing certificate kinds

Ordinary zero-free-boundary rectangles whose supports are geometrically contained in Re(s)<=b cannot enclose a zero exactly at Re(s)=b in their interior. Likewise a main rectangle contained in |Im(s)|<=T cannot enclose a zero at that boundary unless a separate convention/localization proves its count. These are certificate-production limitations, not flaws in the abstract count rule.

Allowed remedies are an exact boundary-location/order certificate, a proved boundary-count theorem, or, for height only, a larger independently certified T. Moving the real edge to b+epsilon does not prove the requested bound b. A generic box crossing a boundary gives no license to classify all its zeros on the allowed side. Exact boundary records can coexist with ordinary clusters only when the joint no-double-counting condition is proved.

Existing sign evidence may also be mixed with clusters. A sign interval supplies a lower multiplicity count of one on its critical-line segment, not a claim of exact order one. If those supports and all cluster supports are zero-disjoint, their lower counts still sum to K<=C. The same modification works for auxiliary lower weights. Successful saturation forces all remaining inequalities tight enough for coverage; it need not split a multi-zero cluster into simple zeros. A sign interval overlapping a counted cluster cannot be added again without a partition proof.

## Conditional existence, not an unconditional producer guarantee

The replacement removes the structural inability of ordinary signs to count off-line or multiple zeros. A limited existence statement is possible under additional production conditions: suppose the actual main target has a strict real-part margin below b, local finiteness holds, and the evaluator/checker framework can certify contours avoiding zeros, analytic orders by winding, and arbitrarily accurate Gamma integrals and enclosures of B. These conditions are a conditional analysis of the producer, not extra assumptions allowed at the Goldbach root.

One can then choose T slightly above Hcert in an ordinate gap, preserving the strict main margin. Choose H=T+h away from zero ordinates with 4*B(c,H)/h<1/2. Finitely many disjoint main clusters inside the allowed region cover all main zeros, with their full orders. Finitely many auxiliary clusters cover all auxiliary zeros and can be made thin enough in ordinate that L-W<h/4. Make the combined numerical enclosure error (Abar-integral G)+2*(Bbar-B)<h/4 as well. Since the integrated S sum has absolute value below 2B, the exact deficit satisfies

```
U-C_chi(T) <= (4*B + (L-W) + (Abar-integral G) + 2*(Bbar-B))/h < 1.
```

With K=C_chi(T), saturation follows. This argument uses neither RH nor simplicity, but it presupposes the strict main margin and complete convergent contour-certification capabilities. It does not establish those capabilities or provide actual data. Fair exhaustive search for such finite records would need an additional effective-completeness proof. The non-strict beta<=b target alone does not supply the strict margin, so equality cases remain outside this conditional existence argument.

## Tiny exact bookkeeping fixtures

The new script `integration/family_complex_cluster_fixtures_20261111.py` uses stipulated finite multisets of rational points and natural orders. It evaluates no analytic function and proves no winding count. It checks only the channel and weight arithmetic described above.

In its nonreal fixture, positive chi clusters contribute 4, positive inverse clusters contribute 2, and a direct central cluster contributes 10, including both real and nonreal zeros. Thus K=C=16. Auxiliary cluster counts 6 and 3 give W=48, while the exact stipulated added-weight sum is 65. One auxiliary zero has real part .6, illustrating why the auxiliary interface has no .555 restriction.

In its real fixture, the positive main count is 4, reused negatively, and the direct central count is 6. Thus K=C=14. A positive auxiliary cluster of order 4 gives doubled weight W=56, below the stipulated total 64. The script rejects the arithmetic of doubling the central cluster or adding both full-plane counts as one target count.

The script exited 0. SHA256: `D200271D12F828507CA00EAA33C0AAEFD40EF5786204070C6503E802AF79EBCC`. Its JSON receipt has SHA256 `5ABF6AFE58F73E70146D6AA09BE9957D4D29FD430DE1655875C9B27E749BCF6F`. These fixtures are independent of the analytic proof and supply no actual Dirichlet evidence.

## Remaining implementation and review

Formal work is still needed for the finite order-count measure, precise support semantics, argument-principle certificates, conjugation/order transport, union/disjointness lemmas, finite integrated-count identity, and instantiation of the reviewed Turing consumer. Actual main and auxiliary contour packets, central/boundary records where needed, character identification, Gamma enclosures, and strict saturation must be produced for the selected family. Principal conductor one and its narrower strip obligation remain separate. No source theorem or final root has been modified by this note.
