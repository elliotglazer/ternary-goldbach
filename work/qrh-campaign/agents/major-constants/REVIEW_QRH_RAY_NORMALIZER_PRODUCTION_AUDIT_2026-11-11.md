# Independent review of actual ray-normalizer production

Verdict: PASS within the bounded mathematical/source scope, with no correction requested. I read the frozen author report `zero-sum/QRH_RAY_NORMALIZER_PRODUCTION_AUDIT_2026-11-11.md`, SHA256 `693FA8013AC733DAE96CAD1C464912CF9F04DF5F09F9ACE6B3E7556F93443270`, and independently verified all 22 source hashes. This is not a Lean compilation result or validation of the complete QRH provider.

Source baseline: `work/openai-math`, HEAD `4eaee87548250b2682affda7d05d947c05554bae`. All source paths below are relative to `lean/OAI/NumberTheory/DirichletL/`. The review used source reads and hashes only: no builds, analytic evaluations or source edits.

## 1. Exact target, sign and parameter order

The target `PrimeRows/CubeNormalizer.lean:13–56` fixes a nonzero ray modulus M, a subgroup H containing the global-unit image, a finite excluded prime set S, positive scale exponents ell_j summing to 1/6, nonnegative nonzero smooth slot weights supported inside a positive annulus, and two nonnegative nonzero real-valued Schwartz source weights supported away from zero. For every fixed nu>0 it produces C>0 and an eventual statement in Z. The modulus, subgroup, exclusions, weights, number of slots and scale exponents precede that eventual quantifier.

The exact slot weight is `Detector/PrincipalResidueActual.lean:14–16`, and `PrincipalSignalComparison.lean:35` sums it over the actual finite prime-ideal pool. Writing that mass as m_j(Z), `Detector/Basic.lean:13–23` defines

\[
A(Z)=(-1)^K Z^{-(\sum_j\ell_j)/6}\prod_jm_j(Z)
     =(-1)^K Z^{-1/36}\prod_jm_j(Z).
\]

The outer normalizer is c_s A(Z), where the modulus used in c_s is the product of the excluded prime ideals. This product is nonzero by the stated exclusion hypotheses; it is not silently identified with the ray modulus M. The empty excluded product is the unit ideal, which is allowed.

The sign is retained exactly. `PrincipalSlotEstimate.lean:348–364` also expresses the unscaled complex scalar as the product of the negative masses. There is no sum of competing signs in this normalizer. Strictly positive masses make A nonzero even when K is odd. Conversely, this does not prove positivity or nonvanishing of any separate source integral approximated by the normalizer. The generic finite-product statements allow an empty slot set; the top condition sum ell_j=1/6 prevents that case in an actual top-level instance.

The constant chosen by the target proof is C=|c_s^{-1}|+1. The proof does not produce an effective numerical threshold, nor a threshold uniform as M, S, K, the source weights or the positive ell_j vary.

## 2. The PNT input uses line-one nonvanishing

I checked the bodies of `Hecke/RayPrimes.lean:16–48`, `Hecke/RayFamily.lean:16–35`, and `PrimeCounting/RayAsymptotic.lean:95–194,199–298`.

The analytic family consists of the actual Hecke L-functions of finite ray characters. Its required nonvanishing region is Re(s)>=1, except for the principal pole. The principal member is regularized by (s-1)L(s), with its nonzero residue inserted at s=1. Differentiating its logarithm subtracts exactly 1/(s-1). The subgroup-character injection preserves the principal character, so exactly one pole is subtracted from the quotient average. Consequently the continuous remainder on the closed right half-plane is

\[
\sum_n\Lambda_C(n)n^{-s}-\frac{1/h}{s-1},
\qquad h=\operatorname{classNumber}(M,H)>0.
\]

The source proves this equality first on Re(s)>1, where the series converges. `WienerIkeharaTheorem'` is then applied with nonnegative actual ideal-Mangoldt coefficients, their summability, and a Chebyshev bound. The conclusion is sum_{n<N} Lambda_C(n)/N -> 1/h. The positivity of h and exact indicator normalization are justified by `RayQuotient.lean:13–100`: character orthogonality includes zero ideals and nonunit residues, and changing an ideal generator is absorbed by H's global-unit inclusion.

I also read the boundary producer, rather than inferring noncircularity from imports. `Hecke/BoundaryIntegration.lean:11–74` separates Re(s)>1, handled by the Euler product (`Hecke/Euler.lean:25–33`), from Re(s)=1. The latter uses these two distinct arguments:

* `Hecke/Boundary.lean:16–219`: the local 3-4-1 expression has nth coefficient 2 a^n(1+Re(z^n))^2/n>=0. Summable logarithms give a product norm at least one. A hypothetical zero at 1+it gives O(u) for that factor as u decreases to zero; its fourth power, the principal O(u^-1) factor cubed, and the bounded doubled-frequency factor give O(u), a contradiction.
* At t=0 with a nonprincipal quadratic character, the doubled character could be principal, so that bounded-factor argument is not used. `Hecke/Boundary.lean:269–303,351–489` instead forms nonnegative ideal divisor-convolution coefficients. The norm-one coefficient is one. If L(1)=0, the entire function R(s) times the divided difference of L at 1 continues L(s) times the full ideal zeta. The source's entire-L-series positivity theorem makes it strictly positive at every real argument. At -2 it is zero because the explicitly constructed regularized ideal zeta R has a trivial zero. This contradiction supplies the missing quadratic endpoint.

The latter R is built from the ordinary principal zeta regularization and the nonprincipal quadratic Dirichlet companion. No desired 7/8 zero-free estimate, detector energy bound or ray-normalizer estimate occurs in these inspected proof bodies. Their deeper Euler, continuation and positivity foundations remain dependencies; this review does not recursively validate them.

## 3. Weighted prime mass, floors and fixed deletion

`PrimeCounting/IdealPrimeMass.lean:66–117` does not equate prime powers with primes. It bounds the nonnegative higher-power remainder by twice the ordinary nonprime von Mangoldt sequence. Summability after division by n makes its cumulative contribution o(N), preserving the ray density for actual primes.

I checked the full Abel/weight passage in `PrimeCounting/AnnularPrimeMass.lean:77–159,226–343,345–409`. With phi vanishing at the annular endpoints, finite Abel summation gives

\[
\frac1x\sum_{\lfloor ax\rfloor<n\le\lfloor bx\rfloor}
f(n)\phi(n/x)
=-\int_a^b\phi'(y)\frac{\sum_{n\le xy}f(n)}x\,dy.
\]

The cumulative function is explicitly the sum up to floor(xy), via `cumsum` at floor(xy)+1. Chebyshev gives a uniform integrable bound on the fixed compact interval; dominated convergence and integration by parts recover the limit. Removing the log(NP) weight has an error bounded by a constant times 1/log(ax), using the annular prime count bound. Taking phi(y)=W(y)y^(-5/6) yields

\[
\frac{\log x}{x^{1/6}}m_W(x)
\longrightarrow h^{-1}\int_{\mathbb R} W(y)y^{-5/6}\,dy=:L_W>0.
\]

The factor x^(1/6) follows from x times x^(-5/6), not from a different prime density.

The unrestricted-looking `finsum` has proved finite support (`AnnularPrimeMass.lean:452–486`), so the argument does not rely on a totalized sum's default value. Lines 503–541 prove that deleting the fixed finite set S is eventually exactly invisible: NP/x tends to zero for each excluded P, and W vanishes near zero. This would not establish the same result for S growing with x.

At lines 565–615, continuity, nonnegativity and an actual nonzero value establish L_W>0; mere nonnegativity would not suffice. The limit supplies m_W(x)>=(L_W/2)x^(1/6)/log x>0 eventually. `Detector/RaySlots.lean:14–83` transfers this to the finite subtype without multiplying or losing prime ideals. Its strict lower floor and inclusive upper floor match the Abel interval; the supported weight vanishes at the geometric endpoints.

## 4. Complete loss calculation and legitimate inversion

`Detector/RayNormalization.lean:13–108` proves the required small-power estimate, with a coefficient-one bound after choosing the eventual threshold. For fixed c,ell,d>0, log Z=o(Z^d) gives

\[
Z^{\ell/6-d}\le c\frac{(Z^\ell)^{1/6}}{\log(Z^\ell)}.
\]

For a finite set J choose d=nu/(|J|+1). Combining the mass lower bounds at the finitely many powers Z^(ell_j) gives

\[
|A(Z)|\ge Z^{-\sum_j\ell_j/6}
 Z^{\sum_j(\ell_j/6-d)}
=Z^{-d|J|}\ge Z^{-\mathrm{nu}}
\quad(Z\ge1).
\]

The last quantity is positive. Reciprocal monotonicity therefore applies to nonzero positive quantities and yields |A(Z)^(-1)|<=Z^nu. This is not an inference from a vacuous totalized inverse at zero. `Detector/RayPoolThresholds.lean:42–65` combines it with each mass's strict positivity.

The scale substitution requires ell_j>0 to ensure Z^(ell_j) tends to infinity; the source retains that hypothesis. There is no lower uniform bound on ell_j or resulting uniform threshold. For sum ell_j=1/6 the cancellation is precisely Z^(-1/36) against the product's Z^(1/36), before paying the d losses.

## 5. Why the oscillatory source factor is positive

`PrincipalMellinResidues.lean:379–381` defines

\[
c_s=M W_1(1)\,M(\operatorname{paperRadialFourier}W_0)(1/6)\,R_{M_S}^2/6.
\]

`Hecke/PrincipalResidue.lean:10–51` supplies a positive real R for the actual pole-removed L-function. Its coefficient sum is the cardinality of the finite coordinate kernel times the cardinality of quotient units; both are positive. The scale factors and 1/6 are positive, including at the unit ideal. The passage from `fixedPrincipalResidue` to `poleRemoved ... 1` is explicit in `Detector/PrincipalNormalizer.lean:20–24`, consistent with the separately reviewed principal-residue audit.

Crucially, the proof does not assert pointwise nonnegativity of the Fourier transform. I checked the Laplace/Gaussian/Mellin argument in `Detector/RadialMellin.lean:31–126,143–179,208–310` and its positive specialization at lines 312–386. If c=2pi/sqrt(3), then for 0<s<1

\[
M(\operatorname{paperRadialFourier}W)(s)
=c^{1-2s}\frac{\Gamma(s)}{\Gamma(1-s)}MW(1-s).
\]

The source includes the absolute-integrability step before interchanging the Laplace and Mellin integrals. Positive-support nonzero W has a positive real Mellin transform, by its nonempty open nonzero set and positive weight. At s=1/6 the Gamma factors and c^(2/3) are positive. Thus `Detector/PrincipalNormalizer.lean:13–58` proves c_s positive real and the signed normalizer nonzero. The final norm multiplication gives |(c_s A)^(-1)|<=(|c_s^(-1)|+1)Z^nu with no further exponent loss.

## 6. Bounded conclusion and remaining dependencies

The frozen report accurately reconstructs this chain and its quantifiers. I found no mathematical correction to request. The checked result is eventual production of the actual nonzero denominator with arbitrarily small positive power loss, for each fixed admissible data set.

This review retains the underlying ideal factorization/norm-fiber and Euler-series foundations; the actual Hecke analytic continuation and ordinary zeta identities; the entire-L-series positivity theorem used at the quadratic endpoint; the Wiener–Ikehara theorem; and standard Fourier/Gaussian/Mellin and integration theorems. Their uses and required hypotheses were inspected here, but their complete foundational proofs were not recursively revalidated. In particular, no effective PNT rate or uniform moving-modulus estimate is obtained. Separate estimates for the source integral and other detector/energy arguments remain separate obligations.

## Source pins

The 22 author pins were independently matched to disk. The table below additionally pins the exact source files used for this review. A matching hash is source identity, not a build result.

| File | SHA256 |
|---|---|
| PrimeRows/CubeNormalizer.lean | `B6808E221D9A1963FC56ABEF23B9DA5F357F25DFC066612B57ED757BCAA5CA55` |
| Detector/RayPoolThresholds.lean | `469D39943061C81000433FD5D1FFEC79DEE89DB47953809A173562542AF3101A` |
| Detector/PrincipalNormalizer.lean | `465F5CA2A1E64324254E7771A1C595B0A54A69CB9A1DC890538FB789B277DE27` |
| Detector/RayNormalization.lean | `F40F5EA33726752F2672315ACFD5315267E28797896E2C468E1E8BAF0219E09D` |
| Detector/RaySlots.lean | `3EF16C5521252DBB348B0EC0B5ECEEEC03889C71A66980AEC020010C4B868EFC` |
| Detector/Basic.lean | `00FC7D4219CC55F43A0C800648F4070EC6C5430F2D707631A6A4E66D06C79F81` |
| Detector/PrincipalResidueActual.lean | `1D8F97533254B0F6E4C704826634125B10C6562ED6C2E24B1D6800AAA3E2A25C` |
| PrincipalSignalComparison.lean | `FB59CCAED042EA0D445CA08B5333D0FD248B8DB8EE12E691F79A32A351E1B08D` |
| PrincipalMellinResidues.lean | `B0C7700B00073C0FDBADE385EF2C66F8A524EF90C044C26840664A6E8A8396D9` |
| RayPrimeNormalizer.lean | `5FA8667E99895FFE0D7B33C115CFEAB30D614DF8BFF946C8EFEC8288218E17D4` |
| RayQuotient.lean | `099C84E98F64B7035A831FA109EC63A91C1E8B3963152D6B30CEA59F65F8020B` |
| Hecke/RayPrimes.lean | `355B50F5FFEF3B46B39D28CA265D055BAF343C0960EA7D6E9F12CDA2EA0AE0A7` |
| Hecke/RayFamily.lean | `1A3C7B86DC7253DC0DB202BE32A8359893179EAC9F3F89AC9008100D7ECD78D5` |
| Hecke/LogDerivative.lean | `6F976319CAF6739E01ED21F71F4BF511DABAF643ADDB58242C8C3AB895D05895` |
| Hecke/BoundaryIntegration.lean | `F012B21C77D5D42A02FF83595781519C854F9216A7DC3B2D799F95EC41F0F2C0` |
| Hecke/Boundary.lean | `B0248FC7BEDCAB9F88A5F5D7BBF4908B75BDEA3E4AF9A2CEF47106A85A472599` |
| Hecke/PrincipalResidue.lean | `A1EB8F4D91501D0A83A71154F6FFB65C3C76D7F2102581988D95C200757C2ABA` |
| Detector/RadialMellin.lean | `7E48D9AF92641466920088D4C034675AF5C621F6F227974E232B5EBE148B1202` |
| PrimeCounting/RayAsymptotic.lean | `EB7C9650A1DD1EC5CA3F7BB38E0823BCB41646126158D6D58343FBE25CBB700F` |
| PrimeCounting/IdealPrimeMass.lean | `7722F12A5D7ED80F770B8552787C29A02FEAA6FA8A5C1D355A50A08174732683` |
| PrimeCounting/AnnularPrimeMass.lean | `F48BB4AB40177C033070AA129FE90946EA166A30BAAF8BD9BC3CA20FD2761E8A` |
| IdealMangoldt.lean | `3A2AEE46664BD41DA36B8CC8A9DE44B272FEFFCE0D3EDB676892AA7F050E9FB1` |
| Hecke/Euler.lean | `89E3AFA01E51EB5CEB4C5FC863BB9F2639F655BD5736E4B480498B65586FFFD8` |
| PrincipalSlotEstimate.lean | `E5B3C324742E2C611530C0E295940F443BE182E1CCBC14F0F730EA60AD244504` |
