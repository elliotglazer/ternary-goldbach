# A finite spectral certificate with explicit QRH tails

Research derivation, 2026-11-11, against ternary-goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean process, canonical edit, axiom, or admitted proof. The accompanying `hybrid_tail_check_2026_11_11.py` passed its exact integer/Fraction comparisons. Analytic deductions below remain paper results.

The major/mixed problem can be reduced to finite weighted zero data without requiring exact critical-line membership. I give explicit height cutoffs and a uniform mixed high-zero-tail norm below `6e-9`. The finite weighted aggregate, the other explicit-formula remainder bounds in the required norm, and all certificate-checker proofs remain obligations. No finite spectral dataset has been certified by this task.

## 1. Certificate domain and what can be omitted

Use the actual major moduli Qset(150000), with odd q<=150000 and even q<=300000, and `Dq=1200000/qt(q)`, where qt(q)=2q for odd q and q for even q. A primitive conductor c that induces a character with nonzero Gauss weight has `q=cr`, r squarefree and coprime to c. Thus c belongs to the finite active conductor family and `Dq<=Dc=1200000/qt(c)`. Characters at a conductor with 2-adic valuation one contribute no primitive characters; enumerate primitive characters rather than treating these as additional numerical cases.

For each active primitive character, certify counts with multiplicity in a finite partition of the QRH strip and a bounded height interval. Different partitions and real-part endpoints are permitted for different conductors. Cells may have count zero, a positive upper count, or a more precise zero enclosure. Exact ordinates, simplicity, and beta=1/2 are not required if the eventual weighted bound succeeds with the enclosures.

No cutoff excluding all c>C with C<300000 is justified by the current estimates. In the mixed norm the conductor concentration is material. The new factor-25 operator reduction does not turn high conductors into a negligible tail. Until a proved family estimate bounds the omitted conductors, the safe finite domain is the whole active family. This is a limitation on the present certificate design, not a necessity theorem for every possible proof.

## 2. Actual etaU tail from the Gaussian source theorem

Write `F_U(s,d)=Mellin(etaU(t)e(dt))(s)`. Swapping the source multiplicative convolution gives

```text
F_U(s,d) = integral_(1/4)^1 eta2(v) v^s Gr(s,dv,0) dv/v.
```

Here Gr is the source Mellin transform of `t^2 exp(-t^2/2)e(dt)`. There is no shift s+2 in this formula. Absolute integrability follows from compact v support and Gaussian decay; it must be supplied in the formal Fubini/change-of-variable proof.

For `1/8<=beta<=7/8`,

```text
integral_(1/4)^1 eta2(v)v^(beta-1)dv
  =4((1-2^(-beta))/beta)^2 <=4(log 2)^2 <2.
```

For all |d|<=D, apply `ZeroSumBound.norm_G_tail` or its floor form to `Gr(s,dv,0)`. The real part beta is inside its required [-1,1]. Since 0<v<=1, the largest absolute twist is D. For a base height H>=max(10pi D,50), the result is

```text
|F_U(s,d)| <=2[EB(H) rhoB^k + EA(H,D) rhoA(D)^k],
k=floor((|Im s|-H)/4.4),   |Im s|>H.
```

Monotonicity of `u^2 exp(-.1065u^2)` for u>=10 handles EA as |dv| decreases; the twist-zero branch is zero. `rhoA(dv)<=rhoA(D)` handles the geometric factor. There is no bandlimit-200 shift for etaU. The etaPlus source `EtaPlusMellin.norm_mellin_fP_tail` has the analogous formula with H-200 inside EB/EA and prefactor `Cg*(2aH)<=129.24` from `EtaPlusCg.cA_le`.

## 3. Sufficient finite heights and explicit high tails

Use the following rational, integer cutoffs. They deliberately leave considerable slack and are not claimed minimal:

```text
Hplus(c)=ceil(200+max(1000,(704/7)Dc)),
Hstar(c)=ceil(max(1000,(704/343)Dc)).
```

Since pi<22/7, these imply `Hplus-200>=32pi Dc` and `Hstar>=32pi Dc/49`. All plus heights are below 61 million, and all star heights below 1.3 million.

| c | Hplus(c) | Hstar(c) |
|---:|---:|---:|
| 1 | 60,343,058 | 1,231,487 |
| 3 | 20,114,486 | 410,496 |
| 100 | 1,207,058 | 24,630 |
| 1000 | 120,886 | 2463 |
| 10000 | 12269 | 1000 |
| 149999 | 1200 | 1000 |
| 300000 | 1200 | 1000 |

One shared certificate may simply cover the larger height; the star cutoff records which data its kernel actually needs.

The source tail-window lemma counts multiplicity over both signs. For a primitive nonprincipal character it uses `PolyDatum L (BP c) 11`; zeta uses `PolyDatum zetaF BPz2 10`. At these heights one has

```text
Z3g(B,H)<400,       c3g(kappa,H)<53/H.
```

For the first assertion use the explicit BP polynomial and the bounds `log1400<8`, `log(c+1)<13`, `log(H+22)<19`, `log(1.25(H+11))<19`, `-log(.355)<2`, and `log(10/3)>1`. The numerator is below 349. The zeta polynomial is smaller by the source `XiPartial.log_BPz2_le'`. The count-growth coefficient uses kappa<=12. These are valid finite-carrier inequalities before any infinite limit.

Let `G=1+(600001)/2.7`. From `1/(1-exp(-a))<=1+1/a`, the source rho values satisfy

```text
1/(1-rhoA(D))<=G,  1/(1-rhoB)<3<G,
800G+.106G^2 <1e10.
```

Here D<=600000, all counting heights are at least1000, and `.106=2*53/1000`. Therefore both geometric window sums in `ZeroSumGen.E2g` are below 1e10. The endpoint Gaussian estimates are

```text
EA(base,D)<1e-44,    EB(base)<1e-65,
```

using base/D>=32pi and base>=1000, with monotonicity above those endpoints. The script proves the exponential comparisons by positive Taylor lower sums of degrees 500 and 600. Bounding both smoothing prefactors by1000 gives the deliberately loose common tail coefficient

```text
epsilon_tail =1000*1e10*(1e-44+1e-65) <1e-30.
```

Under a proved global 7/8 strip, the normalized primitive zero tails consequently satisfy, uniformly in their relevant twists and x>=x0=4.9e26, y=x/49,

```text
|tail_plus(chi,delta)| <=1e-30*x^(-1/8),
|tail_star(chi,delta)| <=1e-30*y^(-1/8).
```

This uses only the nontrivial zeros. Trivial zeros, zero at s=0, poles, and vertical integrals are not silently put into this estimate. The source tail counts already include multiplicity and require no critical-line equality. Bounds uniform in the source finite rectangles justify the tail limit by absolute convergence or Fatou after identifying the actual explicit-formula sequence.

## 4. Quantitative mixed-tail transport

Let l+, l* be the finite nontrivial-zero sums at the cutoffs, and t+, t* their tails. Cover the finite strip with unit-height windows. Radius3 disks centered at real part2 contain each such window, so the same bound400 gives at most

```text
2*(61000000+1)*400 <1e11
```

zeros counted with multiplicity for any active primitive character. The source etaPlus uniform transform bound is below106000. Also `|F_U|<4`: the eta2 moment is below2, and the absolute Gaussian moment is below2, by splitting at t=1 and comparing with t and t^2. Hence the crude bounds

```text
|l+| <=2e16*x^(-1/8),   |l*| <=1e12*y^(-1/8)
```

hold without any favorable finite zero information. They are used only to multiply the extremely small high tails.

The product difference satisfies

```text
|(l++t+)(l*+t*)-l+l*| <3e-14*(xy)^(-1/8).
```

In the exact mixed direct-sum Hilbert space, the total measure of character pairs and twists is at most

```text
300000 *1200000 *300000^2 <(2e11)^2.
```

Indeed `w(q,psi)<=q`, there are phi(q) characters, and each interval has length at most1200000; retain the two factors 1/phi(q) in the measure. Induced primitive sums repeat here exactly as in the target. Since x0*y0>1e48, their product scale is below1e-6. Thus the high-height contribution to the mixed Hilbert norm is below

```text
2e11 *3e-14 *1e-6 =6e-9.
```

The bound holds for every x>=x0. It is a bound on the norm, not directly on Cross. The same pointwise tails give negligible second-moment tails by the corresponding single-character measure. Full/coprime removal and the nonzero explicit-formula terms still need their separate transfers; this calculation does not assert a bound for them.

## 5. Finite aggregates and uniform x

For principal upper energy, the new Mellin result `mellin/RESUME_PRINCIPAL_2026-11-11.md` improves the earlier .64 proposal: beta<=2/3 through height4e7 suffices for the proposed Ep bound, using 45 zeros per translated window and Gram row bound2600. More generally its sufficient finite condition is

```text
sum_low m_rho*x0^(2beta_rho-2) <= .009^2/(14*2600).
```

For example its common-beta diagnostic permits about49259 zeros at beta=.75 but only .01047 at beta=.875. Thus a finite right-edge exclusion or weighted count profile suffices; exact RH is stronger than this criterion. The stated certificate and density profile remain unproved. This principal criterion does not supply the mixed or nonprincipal estimates.

For the mixed target use the new primitive operator reduction in `zero-sum/RESUME_MIXED_2026-11-11.md`. Define `W_c,+=(c/phi(c))*sum_primitive_chi |l_chi,+|^2`, and similarly W_c,*. With the actual induction support and arc projection,

```text
Cross_low <=25 I_low,
I_low=integral ||W_+(delta)||_2 ||W_*(delta)||_2 ddelta.
```

If actual Astar<=2.5e-7, `I_low<=2.79e-8`, and the total mixed remainder norm R<=1e-6, then `Cross_actual<7e-7`. Exact arithmetic gives `(sqrt(25*2.79e-8)+1e-6)^2<7e-7`. The high-zero estimate spends less than6e-9 of R. The remaining contour/zero-at-zero/induction errors must be proved within the balance; the operator reduction does not absorb them automatically. The zero-sum worker separately reports a much smaller Euler-removal estimate conditional on J<=10.

There are two sound ways to verify the finite part uniformly:

* For each beta/height cell, certify a multiplicity upper count and a uniform transform envelope. Insert these into the explicit cell bound with `S_A=sum_c[((c/phi(c))*M_c*N_c(A))^2]` and the actual joint kernel `J_AB`. All nonnegative x factors decrease when x grows. The conductor square in S_A preserves clustering; a count summed over all conductors is insufficient by itself.
* Certify an operator norm for the finite Gram matrix, uniformly over all enclosed zero locations. For Cross this is the **product basis**, indexed by both character indices and both zero indices, with multiplicity product `m_rho*m_sigma` and the actual q-dependent arc measure. Separate per-leg L2 Gram matrices do not bound this fourth moment. Expand multiplicity as repeated indices, or use the equivalent square-root-weighted product Gram matrix. Normalize amplitudes at x0,y0. At x=r*x0 and y=r*y0, r>=1, a product coefficient receives `r^(beta_rho+beta_sigma-2)*exp(i(gamma_rho+gamma_sigma)log r)`, whose modulus is at most1. An operator norm for all product-space coefficient vectors handles every such phase. Sampling the signed residual at x0 does not.

Each twist cell needs a continuum enclosure, not point samples. The existing Gaussian/eta2 integral formulas, analytic Taylor remainder bounds, and exact arc endpoints can provide these. A rational positive-semidefinite domination or an absolute row-sum bound can certify the Gram operator with all enclosure errors included. Finite interval arithmetic without a proved kernel/replay interface remains external numerical evidence.

No finite mixed aggregate meeting `2.79e-8`, no Astar cap, and no full nonprincipal upper-energy estimate has been supplied. Those are now finite quantitative tasks plus the remaining explicit-formula transfers, rather than unspecified high-height tails.

The major-constants worker has also proposed a targeted conductor-3 certificate: beta<=16/25 through height14 million, together with a translated mass window count below39 and Gram row bound2200, would control the complete induced conductor-3 Aplus block below8e-8. Its scalar/tail checks were still being finalized when this note was written. This is a useful second candidate after zeta, not certified spectral data or a replacement for the remaining conductor blocks.

## 6. Completeness, characters, and analytic objects

An argument-principle certificate must prove that the exact analytic function is nonzero on each contour and that its winding number gives the zero count including multiplicity. Disjoint cells plus boundary checks must cover every zero in the selected strip/height window. If a zero lies on a proposed cell edge, change the rational edge or certify that boundary contribution explicitly. Merely finding many zeros, or failing to find off-line zeros, proves no upper count.

Turing completeness is an alternative when certifying critical-line roots. Certified disjoint sign changes give distinct roots; a matching total zero count rules out omitted and multiple roots. For nonreal characters, negative-height and reflection identities involve the conjugate character. Do not place a real-character quartet inside each complex character independently. The finite character enumeration and induction map require mathematical coverage proofs.

For zeta, use the source's entire `zetaF`, defined by updating `(s-1)*riemannZeta(s)` at s=1 to value1. The literal pointwise product is not that continuation at the pole. A right-edge contour extending to real part2 must use this corrected function. On nontrivial-zero cells strictly inside 0<Re(s)<1, prove zero and multiplicity correspondence with zeta. For primitive nonprincipal characters the source L-function is entire; trivial and central real zeros still need the correct domain/count treatment. QRH's lower strip bound also requires the functional-equation bridge with its character transformation.

A direct weighted contour certificate is another admissible format, provided its theorem controls the actual positive weighted zero functional. The usual argument principle alone supplies counts, not an automatic upper bound for a nonholomorphic weight such as x^(2Re rho-2) or an absolute Gram kernel. Cell counts plus proved supremum bounds avoid that gap.

## 7. Comparison with proving the existing finite-RH input

Proving the exact `PlattGRH` proposition would discharge the original analytic consumers through an actual theorem. It would remove an external premise but would use more finite spectral information than the hybrid requires. The historical computation covers primitive characters through400000, using parity-dependent heights and Turing completeness; its published interval computation is not a kernel-checked certificate available in this repository. [Platt, Numerical Computations Concerning the GRH](https://arxiv.org/pdf/1305.3087).

The hybrid keeps QRH as the proved global input and only asks finite cells for the weighted information needed by each residual. It avoids exact critical-line membership where weaker real-part bounds suffice. It does not yet establish a smaller conductor workload, and the conservative1000/1200 height floors can exceed the historical requested heights at large conductors. Thus these explicit cutoffs are a sufficient tail architecture, not a claim that the resulting certificate is cheaper than reproving PlattGRH.

The first useful certificate prototype is the zeta right-edge task through4e7, or an equivalent weighted finite count meeting the displayed principal moment. The mixed path should next produce one independently enclosed conductor/beta/height kernel block, preserving factor25 and the actual two twists, and show how the uncomputed finite blocks are budgeted. Only after that calculation can one select a reduced conductor set or claim that the hybrid has less computation as well as less required spectral precision.

Independent review subsequently passed the etaU/high-tail transport and mixed-measure argument in `mellin/RESUME_HYBRID_REVIEW_2026-11-11.md`, SHA256 `ED23082F7F8BC5C19CBB94B47EC47663EEAB4CBF6C4EA7B0E6CED82D9E100694`. The reviewed version of this note had SHA256 `AF3F6FF51A58C36E18F5C77F67BA2F92C8601882F24E5A262DA1D668E111E511`. The present amendment makes the review's product-Gram interpretation explicit in Section5 and records this history. It changes no tail estimate or numerical bound. The exact arithmetic replay and paper review do not replace Lean validation or supply the missing finite spectral data.
