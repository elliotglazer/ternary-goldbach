# Reconstructing the upper horizontal-log bound for Turing's method

2026-11-11. Research proof plan with exact finite scalar verification. No Lean/Lake command, prime or zero scan, dependency change, or frozen-file edit was performed. This reconstructs the upper half of the source argument; it does not claim a full Turing proof or introduce an analytic premise into the final Goldbach theorem.

## Exact target and source

Let Q>1 be a natural conductor and chi a primitive complex Dirichlet character modulo Q, of either parity. Primitivity with Q>1 implies chi is nonprincipal. Write L for the actual analytically continued Dirichlet L-function, identified with the source Dirichlet series on Re(s)>1. For every real t>50 define

```
I_chi(t) = integral_(1/2)^infinity log |L(sigma+i*t,chi)| d sigma.
```

The intended conclusion is

```
I_chi(t) < 2.3288 + .15*log(Q*t/(2*pi)).                         (U)
```

The integral exists as an ordinary integrable real function even at heights of zeros; define any finite value at the finitely many zero abscissas. This convention is explained below. No height upper bound, conductor upper bound, RH, finite-zero certificate, simplicity assumption, or parity restriction is used.

Rumely's original upper argument is Theorem3, printed p430, equations10–12, available in the [full-text reproduction](https://paperzz.com/doc/8887603/numerical-computations-concerning-the-erh-%E2%80%94-all-q). The original page-image access limitation from the prior review remains. Actual primary corroboration is Trudgian, [arXiv:0903.1885v3](https://arxiv.org/pdf/0903.1885), Lemmas3.5–3.6, pp12–13. The inspected local PDF has SHA256 `E8D021A3C083D0F07427760661478E47390D446D06714257DEE702246FACC878`. The present reduction uses the fixed strip parameter b=5/4; it does not confuse that parameter with conductor Q.

## 1. The precise analytic growth leaf

The published Rademacher bound, specialized to b=5/4, is

```
|L(s,chi)| <= zeta(5/4) * (Q*|1+s|/(2*pi))^((5/4-sigma)/2),
                         -1/4 <= sigma=Re(s) <= 5/4.            (R)
```

Trudgian Lemma3.5 states this for all primitive characters of modulus Q>1 and 1<b<3/2, citing Rademacher Theorem3. This is an unresolved analytic theorem to prove, not a numerical hypothesis to accept. Rademacher's original article is *On the Phragmén–Lindelöf theorem and some applications*, Math. Z.72 (1959),192–204. I located its [bibliographic record](https://geodesic.mathdoc.fr/item/MZ_1959__72_183607/) but did not obtain its original PDF; the eudml request returned403. I do not claim to have reconstructed that entire proof.

A substantive formal proof of (R) must supply the primitive functional equation and unit-modulus root number for both parities, the appropriate complex Gamma-ratio bounds, and the weighted strip Phragmén–Lindelöf argument with its growth hypotheses. The right boundary uses the absolutely convergent Dirichlet series bound |L(5/4+it)|<=zeta(5/4). It is not sufficient to invoke the maximum-modulus principle without growth control, or to replace a Gamma ratio by its asymptotic value. In particular the exact |1+s| weight must survive the strip interpolation. Existing general strip theorems do not themselves prove this particular weighted estimate.

Everything after (R) is reduced below to elementary integration, Euler products, and explicit scalar certificates. This identifies a narrower proof task than importing (U) wholesale.

## 2. Integrating the compact strip

Fix t>50 and put Z=log(Q*t/(2*pi)). For 1/2<=sigma<=5/4, define alpha(sigma)=5/8-sigma/2. Then alpha>=0. Away from zeros, taking real logarithms in (R) gives

```
log|L(sigma+it)| <= log zeta(5/4)
                    +alpha(sigma)*(Z+log(|1+sigma+it|/t)).
```

Since 1+sigma<=9/4 and t>50,

```
log(|1+sigma+it|/t)
 = (1/2)*log(1+(1+sigma)^2/t^2)
 <= (1+sigma)^2/(2*t^2)
 < 81/80000 < .0011.                                           (1)
```

Here t is positive, so division by t and the logarithmic decomposition are valid. Multiplication by alpha preserves the upper direction. The two exact compact integrals are

```
integral_(1/2)^(5/4) 1 = 3/4,
integral_(1/2)^(5/4) alpha(sigma) = 9/64.
```

Thus

```
integral_(1/2)^(5/4) log|L(sigma+it)| d sigma
 <= (3/4)*log zeta(5/4) + (9/64)*Z + 729/5120000.                (2)
```

All inequalities may be integrated almost everywhere: the finitely many zeros on this compact segment do not obstruct the argument. No claim of zero-freeness on this segment is being made.

## 3. Euler-log tail and existence of I

For sigma>1, the canonical Euler logarithm is

```
ell_chi(s) = sum_(p prime) sum_(k>=1) chi(p)^k/(k*p^(k*s)).
```

Its absolutely convergent sum satisfies exp(ell_chi(s))=L(s,chi), tends to zero as sigma tends to infinity, and has

```
|ell_chi(s)| <= sum_p sum_(k>=1) 1/(k*p^(k*sigma)) = log zeta(sigma).
```

Taking real parts proves both `log|L(s)|<=log zeta(sigma)` and `|log|L(s)||<=log zeta(sigma)`. Consequently, with

```
J = integral_(5/4)^infinity log zeta(sigma) d sigma,
```

the tail of I is at most J and is absolutely integrable. Finiteness can already be proved without the sharp numerical estimate: log zeta(sigma)<=zeta(sigma)-1, so Tonelli gives

```
J <= sum_(n>=2) n^(-5/4)/log n
  <= (zeta(5/4)-1)/log2 < infinity.
```

On the compact segment, L is entire and not identically zero, as follows from nonprincipality and the Euler-product half-plane. Its zeros there are finite. At a zero sigma0+it, local analytic factorization gives

```
log|L(sigma+it)| = m*log|sigma-sigma0| + log|g(sigma+it)|
```

off sigma0, where m is a finite positive natural and g is nonzero nearby. The first term is locally integrable and the second continuous. A finite cover proves compact integrability, including at the left endpoint. Assigning zero or another finite value at a zero changes no integral. This argument is about actual analytic zeros, not a list assumed complete.

The normalized logarithm matters when later connecting I to S: S is the imaginary part of the horizontal continuation of ell_chi, divided by pi. The real quantity I itself needs no global log branch across zeros. A pointwise principal argument, a freely reset argument at2, or a root-number phase added to S cannot replace the canonical continuation. Local integrability here does not by itself prove Littlewood's identity or its a.e. endpoint adapter.

## 4. New finite certificate for zeta(5/4)

The old numerical leaf zeta(5/4)<4.596 can be replaced by a short elementary certificate. Strict decrease of x^(-5/4) gives

```
zeta(5/4) < sum_(n=1)^256 n^(-5/4) + integral_256^infinity x^(-5/4) dx
          = sum_(n=1)^256 n^(-5/4) + 1.
```

Set S=10^12 and, for each n=1,...,256, compute the integer r_n satisfying

```
0<r_n,   r_n^4 <= n*S^4 < (r_n+1)^4.
```

Then n^(-5/4)<=S/(n*r_n), so all operations in the following upper sum are rational:

```
1+sum_(n=1)^256 S/(n*r_n)
 < 4595599709731/10^12 < 1149/250 = 4.596.                       (3)
```

The certificate uses nested integer square roots only to propose r_n; every fourth-power bracket is then checked. The receipt contains all256 integers. No builtin zeta evaluation or prime sieve is used. A positive exponential Taylor sum of degrees0 through20 verifies exp(763/500)>1149/250. Monotonicity of exp/log therefore gives

```
log zeta(5/4) < 763/500 = 1.526.                               (4)
```

The analytic ingredients of this scalar bridge are the positive zeta Dirichlet series, monotone integral comparison, evaluation of a real power integral, monotonicity of fourth powers on nonnegative reals, and the positive exponential Taylor lower bound. They remain to be formally connected to the exact integer checks.

## 5. Closing the scalar reduction and the separate J certificate

The sharp scalar bound is J<148/125=1.184. The separate supplement `work/qrh-blueprint/turing-scalars/ZETA_LOG_INTEGRAL_2026-11-11.md` is now independently accepted at paper/external-interval scope. Its proof uses convexity of log zeta, explicit Euler–Maclaurin upper values at chord endpoints, and an analytic far-tail bound. The independent review is `work/qrh-campaign/agents/integration/REVIEW_ZETA_LOG_INTEGRAL_2026-11-11.md`, SHA256 `262ABBD71433135C1A3EC11703D28112E14DB2047B08303BA2A3829AB86B9DE2`.

The reviewer independently replayed all 2049 original endpoints and reproduced the original upper bound 1.18349673917994498. A separate computation with B=96, 3072 panels, right endpoint 36, and 224-bit interval arithmetic gives an upper bound below 1.183467944756<1.1836<1.184. Neither computation uses a builtin zeta evaluation. The analytic reduction and external interval certificate passed review; the Euler–Maclaurin, convexity, integration, and interval-checker bridges still require formal proof. This is not a Lean theorem or a new accepted premise of the final Goldbach root.

Supplement pins: note `66DCFC80712A8773682D23F2121BB05A2494CEE1AD7EB7A975EEAED7B399852E`; script `5BB356E9FF112ADFF19919CD946F2C60D6D621F78B17AED50A4E4B5FBC803FAD`; JSON `687344FFD5E44B52059B848867AE09C316A827EEE8108E6342316C41D9B0B5BC`.

Combining (2), the Euler tail, (4), and that leaf gives the stronger intermediate conclusion

```
I_chi(t) < 11922649/5120000 + (9/64)*Z
         = 2.3286423828125 + .140625*Z.                         (5)
```

Q>1 and t>50 imply Qt/(2*pi)>1, hence Z>0. Since 11922649/5120000<2.3288 and9/64<.15, (5) implies exactly (U). If the original source's looser .0011 is used in(1), the intercept is1490339/640000=2.3286546875, still below2.3288. There is no hidden conductor-size restriction in either calculation.

Exact scalar script `turing_horizontal_upper_scalars_20261111.py` SHA256 `D11D64A27AABC18B9261B984F0EE89B336DDFC24F80E8AD7B272962572C7A495`; JSON SHA256 `089B5BCE9509BE2431CD5C67558D298FE10DE9349B166D859245726729DB3983`. Exit zero. It checks every root bracket, the complete rational sum, the exponential comparison, and both final intercepts. It explicitly does not claim the analytic leaves proved.

## 6. Lean-facing work packages, without freezing declarations

The target carrier is the actual `DirichletCharacter.LFunction chi s`, not a surrogate bounded function. On the pinned Mathlib source, `LSeries/DirichletContinuation.lean` supplies `LFunction_eq_LSeries`, nonprincipal `differentiable_LFunction`, and the primitive completed functional equation. `EulerProduct/DirichletLSeries.lean` supplies Euler-product and exponential-log L-series identities; its real `log_riemannZeta_eq` is a relevant bridge. These names were source-located, not compiled here. Their exact hypotheses and convergence adapters must be checked when implementing.

The compact zero-singularity step has a particularly useful existing API, located by the independent prime reviewer and then read directly here: `Analysis/SpecialFunctions/Integrability/Log.lean:48`, `MeromorphicOn.intervalIntegrable_log_norm`. For a real-variable map into a real normed space, real meromorphicity on the unordered compact interval implies interval integrability of `log norm`. Apply it with codomain Complex to the horizontal restriction sigma↦L(sigma+it), after restricting scalars of the entire complex function and composing with the real affine map. This avoids reproving local logarithmic integrability. The scalar-restriction/meromorphicity adapters and actual-L-function identification remain to be instantiated; no compilation is claimed.

The remaining substantive proof order is:

1. Prove/port the fixed b=5/4 Rademacher estimate with all primitive/nonprincipal, Gamma, and strip-growth premises discharged. This is the main unresolved analytic leaf.
2. Prove the normalized Euler-log identity and its absolute majorant, then instantiate compact log-norm integrability and prove tail integrability. Source L-function equality is essential.
3. Kernel-replay(3)–(4), prove the monotone-tail comparison, and complete the independently reviewed J bound. The numerical files alone are not proofs.
4. Integrate the elementary bound and discharge Q,t positivity to obtain(U) with no extra final premise.
5. Separately reconstruct the lower horizontal bound and Littlewood identity/a.e. adapter before claiming the full absolute integrated-S theorem. This upper estimate does not prove that lower bound or family completeness.

The new result of this task is an exact end-to-end reduction of the upper estimate, explicit zero-height integrability handling, and removal of the zeta(5/4) numerical-source dependency by a small rational certificate. It does not close the full Turing analytic producer.
