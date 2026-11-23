# Finite-RH demands after the direct B bound

2026-11-11. Bounded source and paper audit. No builds, declarations, source edits, numerical analytic evaluations or spectral computations. This is a conditional demand map, not a claim that the finite certificates exist or that RH is logically necessary for Goldbach.

The current reduced-plus certificate already implies every retained base-gap and star-A spectral condition. Consequently eliminating the star-B certificate and restricting star-A to squarefree conductors produces no additional saving in the shared finite-RH certificate while that plus proof is retained. These are useful reductions in what the star proof must establish, but they are not reductions in the union of current certificate demands.

## Exact domains and demand matrix

Fix R=132900, x>=4.9e26, y=x/49. Let qt(c)=2c for odd c and qt(c)=c for even c, and D_c=1063200/qt(c). The current reviewed plus height is

    Hplus(c)=ceil(200+max(260,3.1416*u(c)*D_c)),
    u(c)=23.3 for odd c and even c<=60000,
    u(c)=19.89 for even c>60000.

The reduced base-gap height is Hbase(c)=ceil(27000000/c) for odd c and ceil(54000000/c) for 4|c. The optional star-A spectral construction uses Hstar(c)=ceil(max(300,(704/343)*D_c)). An alternative direct proof of A requires no star finite-RH premise.

All rows concern actual primitive characters, with inverse labels included, actual nontrivial zeros, their true multiplicities, both signs of the ordinate, and closed height endpoints. Ordinary finite RH includes nontrivial real zeros; it is not a statement about only the zeros found on the critical line.

| Primitive conductor class | Current plus recipe | Current base-gap recipe | Star-A spectral route | Direct star-B route | Combined current requirement |
|---|---|---|---|---|---|
| c=1 | Retained principal analytic input | Retained principal analytic input | Principal/removal part treated separately | Principal theta/sieve inputs | Principal RH through 10^8, plus retained finite/head arithmetic |
| Odd squarefree 1<c<=R | Ordinary RH through Hplus | Ordinary RH through Hbase | A weighted low-zero condition through Hstar; reviewed beta<=.5075 route already suffices for A<4e-12 | No nonprincipal finite-RH input | Ordinary RH through Hplus |
| Odd nonsquarefree 1<c<=R | Ordinary RH through Hplus | Ordinary RH through Hbase | No contribution to A | No nonprincipal finite-RH input | Ordinary RH through Hplus |
| 4|c, c<=2R | Ordinary RH through Hplus | Ordinary RH through Hbase | No contribution to A | No nonprincipal finite-RH input | Ordinary RH through Hplus |
| c congruent to 2 modulo 4 | No primitive characters at that exact conductor | Same | Same | Same | No primitive certificate, but ambient moduli in this class remain in all applicable sums |
| Other c | No demand in these three localized nonprincipal consumers | Same | Same | Same | No such demand; unbounded arithmetic parameters in other consumers must still be preserved |

The new author-only A profile beta<=.5357 through Hstar, `WSTAR_A_ONLY_REALLOCATION_PROFILE`, is not independently accepted by this report. Even if accepted, it leaves the last column unchanged. The older reviewed squarefree .5075 profile already yields a stronger A bound than the new A<=1e-10 budget needs.

Here "combined current requirement" means the strongest sufficient input in the selected finite-RH proof recipes. It is not a lower bound on all possible analytic methods. The direct aggregate plus and base-gap targets could replace their own finite-RH recipes if proved by other means.

## Why the conductor support is exact

`LargeSieveWeights.qt:26` and `LargeSieveArcs.Qset:34` give odd ambient q<=R and even ambient q<=2R. `Bombieri.norm_sq_gaussSum:135` states that a character of conductor c has squared Gauss norm c exactly when c|q, q/c is squarefree and gcd(c,q/c)=1; otherwise its weight is zero. Inversion preserves c.

The A definition contains a_q^2=mu(q)^2/phi(q)^2. A nonzero term therefore requires squarefree ambient q. Every divisor c of that q is squarefree. A squarefree even conductor has exact 2-adic valuation one and cannot be primitive: the unit group modulo 2d for odd d is isomorphic to the unit group modulo d, so every such character descends. Hence A sees only odd squarefree primitive conductors.

This argument does not delete nonsquarefree q from B, plus or base-gap. Nor does it delete the imprimitive ambient characters induced from eligible c. At q=c each existing primitive character has q/c=1 and positive Gauss square c. Therefore every eligible odd or 4-divisible primitive conductor has a nonzero structural coefficient in the plus target. The same holds in the universally quantified base-gap energy at original modulus m=c. No further conductor deletion follows from a zero Gauss weight. This is a support statement, not an assertion that a particular analytic character sum is nonzero.

The source `ArcChars.arc_chars:347`, especially its nonprincipal proof at lines 379-440, uses the primitive ancestor of the inverse character and pays the coprime removal before bounding its Gauss-weighted value. Odd c induced into even q satisfies 2c<=q. This explains why the odd conductor cap is R, rather than 2R. The ambient q=2d rows are not deleted when primitive conductor 2d is removed.

## Base-gap geometry and domination

`BaseGap2.gap_point:185-227` contains stronger parity information in its proof than in its present common conclusion. Retaining that information gives, for the original character modulus m,

    odd m: 4R/(49m)<=|d|<4R/m,
    even m: 8R/(49m)<=|d|<8R/m.

`S_etaStar_eq_expTsum:229` identifies the actual coefficient sequence Lambda(n)*etaU(n/y) and phase d/y. The reduced denominator m/gcd(m,2) is not the character modulus. For an odd primitive ancestor of an even m, m>=2c. Thus the primitive auxiliary twist bounds are 531600/c for odd c and 1063200/c for 4|c. The reviewed base-gap proof covers these closed auxiliary ranges and reaches the actual .03* y envelope, rather than the obsolete sufficient .014 guard.

The height domination needs no enumeration. Since u(c)>=19.89,

    19.89*3*531600 =31720572>27000000.

The even comparison is twice this inequality. Monotonicity of ceiling therefore gives Hbase<=Hplus for every eligible c. Also the real expression defining Hplus is at least 460>300, and 19.89*3>704/343, so Hstar<=Hplus. Ordinary RH through Hplus implies any weaker upper strip condition beta<=b with b>=1/2 through Hstar. This compares both heights and real-part strength, not heights alone.

The factor 49 remains essential. The star major-arc twist is delta/49, whereas the base-gap primitive auxiliary twist is as large as D_c. The star floor cannot replace the base-gap height proof. Domination by the separately proved plus certificate is what makes the union small.

## What has and has not become removable

The reviewed direct coefficient/sieve argument supplies B<1915 conditional on its principal theta, finite arithmetic, coprime-removal and localized source inputs. It has no nonprincipal zero-location premise. With the new cubic allocation, A<=1e-10 suffices. Thus the old nonsquarefree beta<=.62 star condition and the star-B low-zero statistic can be removed from this proof route. A requires only the squarefree weighted low-zero condition or a direct analytic A estimate.

The finite plus recipe is still a genuine nonprincipal demand. Its preserved Eplus<=1.80625e-13 supplies rho=5.12e-7 and the full mixed-error budget. A direct proof of B does not prove Eplus, and the A weight cannot be applied to Eplus. The base-gap condition is also a genuine independent consumer, although its finite-RH certificate is covered by the plus certificate. Removing plus someday would expose the base-gap demand again.

The principal certificate through 10^8 is retained across the principal residual, theta/psi, prime coefficient energy, totient/sieve and nonprime inputs. No nonprincipal support argument lowers that height. Head moments and finite arithmetic are not replaced merely by having a location certificate. The prior three-target source audit found no additional genuinely nonprincipal consumer after the listed localized refactors, but it did not validate the complete transitive Lean closure. Broad Fact PlattGRH accessors must still be replaced, not imported unchanged.

The full target remains unconditional TernaryGoldbachFrom(10^27), with only the original inclusive BinaryGoldbachInput for the full Statement. Aggregate estimates and finite spectra are internal proof obligations, not new final premises. Nothing here restricts the unbounded real scale or unbounded auxiliary arithmetic moduli of the remaining source estimates.

## Avoiding double-counted savings

For a given character, the union uses the maximum required height at each real-part strength, not the sum of separate heights. The current maximum is Hplus. Therefore one cannot add a star-floor saving, a base-gap-height saving and a plus-height saving computed against the same older certificate. The A-only conductor/label count is a star subproblem count, not the remaining full family.

Similarly, a shared sample grid, cached coefficient prefix or auxiliary Turing range is counted once in its chosen producer schedule. A decrease in mathematical height does not imply the same proportional decrease in grid length, transforms, setup, witness bytes or checked arithmetic. Auxiliary heights and count-completeness evidence remain separate from the desired main closed endpoint. No new production count is computed here.

The rho=5.12e-7 allocation cannot be combined with a future larger plus error without rerunning the joint cubic inequality. Likewise a smaller Hplus formula cannot be substituted into the old finite-RH proof merely because it dominates Hbase and Hstar: all low, tail, vertical and removal terms must still be paid.

## One concrete joint relaxation to investigate

There is an exact way to allow a weaker even-family plus estimate while preserving the current rho and A/B allocation. Let J_q be the nonprincipal characters with nonzero Gauss weight. Finite character counting gives

    |J_q|/phi(q)=product_(p^2|q)(1-1/p)-1_(q squarefree)/phi(q).

For p^a with a>=2, support requires full local conductor p^a, with phi(p^a)-phi(p^(a-1)) characters. At exponent one all local characters have nonzero Gauss weight. CRT multiplies the counts; the principal label is removed precisely at squarefree q. This is the same support factor already derived in the modulus-weighted report.

When 4|q, every supported c has 4|c and |J_q|/phi(q)<=1/2. When 4 does not divide q, no even primitive c occurs. Consequently the following altered per-character targets still imply exactly Eplus<=1.80625e-13:

    odd primitive c:  |tau|*|Schar(coprime)|/x <=4.25e-7;
    4|c:             |tau|*|Schar(coprime)|/x <=sqrt(2)*4.25e-7.

Indeed the even ambient energy is at most (|J_q|/phi(q))*2*(4.25e-7)^2. The odd target is unchanged. For a primitive unrestricted estimate, the bound must include the ambient coprime removal before this inequality is applied. This does not justify multiplying only the analytic part by sqrt(2) and forgetting the removal.

This is promising because all even primitive conductors are absent from A, yet remain a large plus/base-gap family. A fresh even-height proof could spend the exact factor-two energy allowance and stop no lower than Hbase, unless the base-gap proof is also improved. The old star-A floor imposes no even-conductor floor. No new height, runtime or spectral success is claimed. The freshly communicated all-conductor plus-error reallocation is a different pending candidate; it must receive its own joint-budget and source review rather than be combined automatically with this unchanged-rho proposal.

## Pins and review scope

| Evidence | SHA256 |
|---|---|
| Plus finite-RH height author | 3F91F39B485607833A5FADD061BEC7602B1DCC02C77B8FB82CA10B6C076FA6A0 |
| Plus height independent review | 55690D3DE67252888EB84C29F40674CAA126E3C5B4E43F4D56CB3AD20421A4E9 |
| Base-gap height author | 776CD34413ECC389D10CE510913C694C6D6C34E8555FFE0D66702582B3A23898 |
| Base-gap height independent review | 2E902497CE7445F78CEF7A2F229D0A9042FAF4FB573AB1A01B79D05331635076 |
| Star lower-floor/squarefree author | E1D58C8EC2EDB7FD8F3BF77F1D3833F3E400200D14AD30B396F59FA8CB5EE794 |
| Star lower-floor independent review | 422940369A04ED695A45EF28F20F154349932CEBC0242EEEE15FF3373D5CE6A4 |
| Cubic reallocation independent review | AD993398C6E41DCCE3A9826C0FA5BF6DA89A3B0139672429D7BD61E797DE9F0E |
| EtaU coefficient independent review | 91057A3117C6E469E633F532206E783FBC4BCAC1620384E09756AB4E3C7AB6E4 |
| Three-target source sufficiency audit | 78119012C8BA40AFC93AB523B84DD441CD19D3FBC76F12418C41DD081B3C9F28 |
| Modulus-weighted plus/star support report | A86643A179B34576117DF2F9125E78B7029696A367D5057EAA8531769B30DE1A |
| MinorArcs/Bombieri.lean | F3236E24D824647816AB0370CB57FB958C642194643393F20E785096888D3C79 |
| MinorArcs/LargeSieveWeights.lean | 4577368FF4AD237E00D04259B813AFE2755ED165766070711CA33FB75E6F2304 |
| MinorArcs/LargeSieveArcs.lean | 0794C8853D9B1AA91EFEC3C9D91F5F1EFCECB98B484C701C360DD8EF5AC592BF |
| MajorArcs/ArcChars.lean | 0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF |
| MinorArcs/BaseGap2.lean | AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E |

Reports are under `work/qrh-campaign/agents` in their named author/reviewer directories; Lean paths are under `work/ternary-goldbach/TernaryGoldbach`. This audit establishes source-level support and implication relationships. It neither repeats the full analytic proofs of reviewed inputs nor upgrades them to kernel-validated theorems.
