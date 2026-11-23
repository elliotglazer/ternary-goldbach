# Independent review of the nonprincipal aggregate base-gap target

2026-11-11. PASS at source/paper scope. The proposed pointwise energy contracts imply the stated bounds with the correct character, Gauss and scale normalizations. Neither contract is established for the actual prime sums. Principal finite RH, source localization and the natural-cutoff consumer adapters remain explicit obligations.

Reviewed [author report](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/zero-sum/AGGREGATE_NONPRINCIPAL_BASE_GAP_TARGET_2026-11-11.md), SHA256 `CFDA417AFFF112EBDF7BBB822FE7C884F3F8FCB4307BBC2F5AAC3B6856D5D264`. No correction to its mathematical conclusions is required. All twelve artifact/source table pins match. No frozen artifact was changed.

This review read the actual source bodies and independently recomputed the rational budget fields without importing the author script. No prime, character, L-function, zero, transform or analytic integral was evaluated; no Lean build or source edit occurred.

## 1. Domain and actual-function identity

The application fixes `R=132900`, `x>=4.9e26`, `y=x/49>=1e25`. The parity information in `BaseGap2.gap_point:185` gives an original expansion modulus `m` and unit numerator with

    m odd:  m<=R,  4R/(49m)<=|d|<4R/m;
    m even: m<=2R, 8R/(49m)<=|d|<8R/m.

These stronger parity bounds follow from the two proof branches, even though the displayed source theorem exports a weakened common bound. The lower endpoint is included, the upper excluded, and both signs of `d` are required. An integer translate is handled by periodicity. For `q=m/gcd(m,2)`, these inequalities give `q<=R` and `8R/49<=2q|d|<8R`. This reduced denominator is not the character modulus.

The actual coefficient sequence is `b_y(n)=Lambda(n)etaU(n/y)`. The source equality at `BaseGap2:229` identifies its exponential sum with `S etaStar x`; the factor 49 is already accounted for by `y=x/49`. The character twist is exactly `d/y`. There is no further rescaling of `d`.

`BaseGap2.sum_noncoprime_le:41` and the explicit ceiling/log calculation ending at lines 391–396 bound the normalized removal by `d0=2e-9` for every `m<=300000` and every `y>=1e25`. Those calculations use absolute summability, smoothing bounds and elementary logarithmic estimates. They do not use the nonprincipal spectral theorem. The present moduli lie inside that domain.

The application is uniform in unbounded `y`, every admissible twist, and every unit numerator. Neither a finite twist grid nor an average over moduli supplies that quantifier strength.

## 2. Character normalization and the exact energy

Put `v=phi(m)` and `b'=coprimePart(m,b_y)`. The equality proved inside `BaseGap.totient_mul_norm_le:19` is

    S'(a/m+d/y)/y
      = (1/v) sum_psi psi(a^-1) tau(psi) r_psi,
    r_psi = Schar(psi^-1,b',d/y)/y.

Absolute summability and coprime support justify the source's finite-character/series exchange. On a unit numerator the character phases have modulus one. The principal contribution is exactly `mu(m) r_1/v`, because the principal Gauss sum is `mu(m)`. It is zero when the Mobius value vanishes; no division by that value is used.

For `Dnp` nonprincipal characters with nonzero Gauss sum and

    E_U = (1/v) sum_(psi!=1) |tau(psi)|^2 |r_psi|^2,

Cauchy-Schwarz gives

    |nonprincipal contribution|^2 <= (Dnp/v) E_U <= E_U.

This calculation has the required two powers of `v` before converting the weighted sum to `E_U`. Equivalently, character orthogonality gives

    sum_(a unit) |R_m(a)|^2 = E_U,

where `R_m` subtracts the actual coprime principal character component, not its Fourier approximation. Thus the energy is a sum over unit numerators. It is not their normalized average. For `m=1,2`, the nonprincipal family is empty and this energy is zero; the principal estimate still matters.

`Bombieri.norm_sq_gaussSum:152` identifies the weight as `c` precisely on `c=cond(psi)` with squarefree quotient `m/c` coprime to `c`, and as zero otherwise. `BaseGap.Schar_primitive:78` transfers to the primitive ancestor on the already coprime-supported coefficients. Inverting the labels is a conductor-preserving permutation. These facts prove equation (8) with all imprimitive ambient characters retained. Its inner sum depends on `m` through `b'`; deleting that dependence without a removal estimate would be incorrect.

The nonprincipal primitive conductors arising here fit the current original-analysis family: odd conductors are at most `R`, and even primitive conductors are divisible by four and at most `2R`. This is only a domain observation, not evidence for their finite RH.

## 3. Principal estimate and main term

The relevant principal input is the unrestricted sum at conductor one. `Cor933.cor_9_3_3:490` has an explicit `GRHUpTo chi T0` premise and the condition `T0>=max(10*pi*|d|,50)`. With `T0=1e8`, the entire stated twist range is valid: `|d|<4R=531600<1.2e6`, and even the larger bound `10*pi*1.2e6<1e8` suffices.

`Cor713.err933Z_le:774` supplies `1e-17+4.7e6/sqrt(y)<2e-6`. The scalar lemma itself has no `PlattGRH` binder. Its blanket character wrapper does, so the report correctly calls for localization through `cor_9_3_3` rather than using that wrapper after silently dropping its premise. Principal RH through `1e8` is retained and is not supplied by this note.

Replacing the unrestricted principal sum by its coprime counterpart costs at most `d0`. Together with the outer removal and the exact energy calculation, this proves

    |S|/y <= d0 + |mu(m)|/v (|F(d)|+e1+d0) + sqrt(Dnp/v) sqrt(E_U).

No additional nonprincipal removal is needed in this formula because `E_U` already uses the exact coprime coefficients.

The Fourier bounds `|F|<=1.2534` and `d^2|F|<=1.016` imply

    |dF|^2 <= 1.2534*1.016 < 1.129^2.

The gap ensures `d!=0`. The elementary totient estimate `m/phi(m)<=30030/5760` follows from the finite prime-factor product identity and decreasing-factor exchange. Seven distinct prime divisors would force `m>=510510`; the first six primes give the stated ratio. `MertensProduct.div_totient_eq_prod:2129` and `exch:2156` have no `PlattGRH` premise, unlike some later global estimates in the same file. Thus this step need not restore nonprincipal RH.

Using the weaker common lower distance gives the exact upper

    (30030/5760)*1.129*49/(4R)
      = 55376321/102067200000 < .000544.

It is valid on the closed lower boundary and for both signs of `d`. The author deliberately does not use additional savings from the even branch or from zero Mobius values.

## 4. Alternative arrays and both removals

For unrestricted primitive sums `f_chi`, each removed inner sum has normalized error at most `d0`. The weighted triangle inequality therefore costs `(1+W_m)d0` in total, with one outer removal and

    W_m = (sum_psi |tau(psi)|)/v.

Parseval applied to the unit-modulus additive character gives `sum_psi |tau(psi)|^2=v^2`; hence `W_m<=sqrt(v)`. The report's further bound `sqrt(v)<=sqrt(q)<365` is valid. For odd `m`, `q=m` and `phi(m)<=m`; for even `m=2q`, all units are odd, so `phi(m)<=m/2=q`. This distinction is essential because `m` can exceed `132900`.

Grouping by conductor and applying Cauchy-Schwarz gives the first bound in (11). Applying it over the complete supported primitive family and removing the principal squared Gauss mass gives the second factor `sqrt(1-mu(m)^2/v^2)`. No unsupported primitive family is charged, and no positively weighted character is discarded.

For the weighted-energy conversion, form finite vectors with components `sqrt(c/v)` times the restricted or unrestricted primitive sums. Their difference has squared norm at most

    d0^2 * (1/v) sum_(nonprincipal support) c n(c) <= d0^2 v.

The triangle inequality proves (12). It is an upper conversion, not equality of the two energies. The coefficient counts and dimension losses in (9)–(12) are correct.

With the original nonprincipal finite-RH theorem reinstated, the range condition for conductor `c|m` is also satisfied: the gap has `|d|<8R/m<=1.2e6/c`. Its conductor-dependent error gives the reported conditional `L_m<1.5e-6`. That check demonstrates compatibility with the old sufficient assumptions; using it to produce the proposed new aggregate would restore the spectral obligation being targeted.

## 5. Budget and actual MinorTotal consumer

Independent rational arithmetic matched every budget field in the saved receipt. In particular:

| Input | Coprime energy route | Unrestricted primitive route |
|---|---|---|
| Square-root contribution at most `.013` | `.013546004 < .014` | `.013546732 < .014` |
| Square-root contribution at most `.029` | `.029546004 < .03` | `.029546732 < .03` |

The corresponding coprime energy thresholds are exactly `169/1000000` and `841/1000000`. The primitive route's larger removal is `366*2e-9`, while the coprime route charges only `4e-9` after bounding the principal coefficient by one.

The saved lower expression `435635673/13700000000` is strictly greater than `.03`. Its formula matches the previously independently reviewed R132900 elementary enclosure packet; this review recomputed the rational expression, without re-evaluating its analytic ingredients.

`MinorTotal.lean:395–403` uses the base-gap estimate only to establish the same pointwise `y*ghatY(y,R)` envelope. The old `.0121` source theorem and the newer `.014` scalar guard are sufficient intermediate estimates. The `.029` contract therefore reaches the actual envelope consumer while failing the stronger `.014` guard. This does not retroactively make a changed `.014` predicate pass in the old receipt. A new natural-R source assembly must consume the weaker direct implication explicitly.

No bound on integrated residual moments alone supplies this pointwise energy. The unconditional uniform source bound `22.75*y` is much too large. Nor does the proposed bound replace major-arc residuals, major-star mixed moments, the upper or lower major L2 estimates, the off-gap minor-arc argument, or the principal spectrum. These limitations are preserved in the author report.

## Pins and scope

All twelve rows in the author's artifact/source tables were independently hashed and matched, including the two scalar artifacts. Additional directly inspected source pins are:

| Source under `work/ternary-goldbach/TernaryGoldbach` | SHA256 |
|---|---|
| MajorArcs/Cor933.lean | 554F00DE4FA6F8F0B6B184F8E8535B8AC5C28C0DB47FA2A95119B6BA4899F66E |
| MinorArcs/PartIICited.lean | 0447F5A3D00DBB6B11CEA1A729FA4CCA2FEF993A8242574D2241A33195B14D30 |

Several author line pointers are approximate: the current Gauss-square theorem is at `Bombieri:152`, while the earlier `:135` names its Parseval consumer. The reviewed declarations and formulas above use the actual bodies. This is not a mathematical correction.

The accepted conclusion is a conditional all-scale implication from the new actual pointwise energy inputs and the retained principal estimate to the required base-gap envelope. No such energy input, finite spectral assertion, formal refactoring or kernel theorem has been proved by this packet. Final roots and original finite binary input remain unchanged.
