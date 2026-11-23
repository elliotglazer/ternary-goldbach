# Independent review: finite-U Hardy normalization

2026-11-11. **PASS for the paper derivation and conditional finite-arithmetic interface. No correction requested.** The unshifted elementary phase gives a real proxy with exactly the Hardy signs, for either parity and every real height. This is stronger for sign production than an additive approximation to Hardy values. It does not replace the canonical Gamma phase in a count formula.

This review binds `prime-estimates/FINITE_U_HARDY_NORMALIZATION_2026-11-11.md`, SHA-256 `06C9D3BF785BB183339D8EC64BE0B5AAD05331184C35356F575A8C126ADB724E`, and its scalar script/receipt pins below. I read the complete author note, the accepted arbitrary-height finite-U allocation, the normalized Binet construction and periodic-cubic conversion, and the fixed-root-phase plan. I also checked the actual source Gamma factor, completion, functional equation and nonprincipal growth interfaces. No Gamma/L/phase values, sign arrays, scans or Lean builds were run.

## Source normalization

For a primitive nonprincipal character chi of conductor c>1 and parity a, the source completion is `chi.completedLFunction`. Multiplying it by `c^((s+a)/2)` gives the entire conductor-completed Lambda used here. The source relation is initially stated as L=completed/gammaFactor. On the critical line the Gamma factor is nonzero: its argument is s for even parity, s+1 for odd parity, both with positive real part. Thus division can be rearranged there without using a totalized product at a Gamma pole.

With alpha=(2a+1)/4 and v=t/2, the resulting positive amplitude is exactly

\[
A(t)=(c/\pi)^\alpha|\Gamma(\alpha+iv)|,
\]

and the phase is `theta=v log(c/pi)+Im ell_Gamma(alpha+iv)`. There is no extra factor c^(1/4), 2, or pi in the unit-normalized H. The source root number uses the positive standard additive character and division by i^a sqrt(c). The fixed unit epsilon satisfies epsilon^2 W=1. Functional equation plus conjugation then makes epsilon Lambda(1/2+it) real. Since A>0, H is real too.

This uses the same phase once for the entire character channel. It does not infer realness from an interval with small imaginary part, or from a rounded root number of nearly unit norm. The previous tilted Fourier function is `c^(-alpha) exp(bt) Z`; these positive factors preserve signs but not numerical values or error radii. Conductor one is explicitly excluded.

## Independent phase calculation

The accepted periodic-polynomial conversion is valid for every Re w>0, not merely for large positive imaginary part:

\[
\ell_\Gamma(w)=(w-1/2)\operatorname{Log}w-w+\frac1{12w}+E(w)-H(1),
\quad E(w)=-\frac13\int_0^\infty\frac{P_3(\{x\})}{(w+x)^3}\,dx.
\]

Here H(1) is real, and `|P3|<=1/8`. For Re w=alpha>0,

\[
|E(w)|\le\frac1{24}\int_0^\infty(\alpha+x)^{-3}\,dx
=\frac1{48\alpha^2}.
\]

This is an absolutely convergent estimate for all real t, including zero and negative t. It does not invoke the earlier positive-height split bound. Since w is in the right half-plane, `arg(w)=atan(v/alpha)` has a single continuous branch. Expanding the imaginary part independently gives

\[
\phi_0=v\log(c/\pi)+\frac v2\log(\alpha^2+v^2)
 +(\alpha-1/2)\arctan(v/\alpha)-v
 -\frac{v}{12(\alpha^2+v^2)}.
\]

The last sign is negative. The real normalization constant contributes nothing, so theta-phi0=Im E exactly. This yields phase errors 1/3 and 1/27. The inequality `cos x>=1-x^2/2` yields 17/18 and 1457/1458, both strictly positive.

Because H is exactly real,

\[
P=\Re(\epsilon e^{i\phi_0}L)=H\cos(\phi_0-\theta).
\]

Consequently P and H have the same strict signs and zero set. There is no additive `|L|/3` error to pay. For zero-order language, the formulas supply real-analytic local factors with nonzero cosine and nonzero amplitude; preservation of finite order follows from these factors, not from continuity alone. Only continuity is needed for the intermediate-value sign-change argument. That argument supplies at least one interior critical-line zero, not simplicity, uniqueness, or completeness.

## Complete finite-U and arithmetic error

The finite-U extension supplies the actual uncompleted L, including the entire pole difference and every half/Bernoulli correction. Its target disks have radius 1/16 about real parts in [111/200,2]. A direct center at 111/200+it reaches 1/2+it since 11/200<1/16. Its shared grid also works: `(3/50)^2+(1/64)^2<(1/16)^2`. Work height must cover the chosen center, including any upward grid rounding. These are disk/domain obligations; one cannot simply evaluate the old .555-center coefficient at an arbitrary off-disk point.

The accepted extension's complete norm error is below `173/240` times its requested tolerance, with its conditional circuit checks. Thus using p_L=p+5 and even allowing an additional 3/2 coordinate-to-norm factor safely gives `e_L<=3 tau/64<tau/16`. The growth source `|L(s)|<=(c+1)|s|/Re s` gives `|L(1/2+it)|<=B0=2(c+1)(V+1)`. Since tau<=1, `|Lhat|<=B0+1=B` follows. This step requires the actual finite-U arithmetic certificate; the integer p_L alone proves no enclosure.

Set eta=tau/(64B). For errors eta in the fixed epsilon, real phase phi0 and exponential of the approximate phase, the multiplier error is bounded by

\[
\eta(1+\eta)+\eta+\eta\le4\eta.
\]

The first term uses the stored exponential's norm <=1+eta; the other two use a unit exponential and the real-angle Lipschitz bound. Splitting at `Lhat` pays `|Lhat|`, not an unproved unit bound on a rounded multiplier. Including the allowed final real-product/serialization error tau/16 gives

\[
|P-\widehat P|<\tau/16+4B\eta+\tau/16=3\tau/16<\tau/4.
\]

Strict exclusion of zero from `[Phat-tau/4,Phat+tau/4]` is therefore a sufficient sign test. Failure proves no sign. If P is zero, arbitrary precision need not decide it.

For the three log centers and one atan center, the sum of absolute coefficients is at most `(5V+1)/4`. Accuracy `eta/[4(V+1)]` each spends less than eta/2; the remaining eta/2 is available for phase assembly. The reciprocal term has a positive rational denominator. Enclosing log(pi) must include the input pi enclosure. All stated rectangle errors need their own Euclidean conversion; none can be silently reused as a norm radius.

## Optional shifted phase and inverse channels

The optional Gamma-log recurrence is valid on the connected right half-plane. Its exponential follows from Gamma recurrence; the possible integer multiple of 2pi i is constant and vanishes on the positive real axis. Therefore the finite shift formula has exactly the author’s signs and leaves only `1/[48(alpha+J)^2]` error.

The proposed cap J=ceil(2B/tau) is sufficient: alpha+J>J>=2B/tau, and `tau<=1<=3B` makes `tau^2/(192B^2)<=tau/(64B)`. This is only a finite existence bound, potentially very wasteful. The shifted phase's absolute coefficient sum is <=`2(V+J+1)`. Adding one analytic eta to the multiplier allowance gives 5eta and total error `13tau/64<tau/4`. This approximates H, not the unscaled source Z. The minimal sign route does not need this recurrence or growing J.

Conjugation preserves conductor and parity. Both phases are odd in t. Writing `kappa=epsilon_chi epsilon_inverse`, the valid exact relations are `H_chi(-t)=kappa H_inverse(t)` and the same identity for P. Independently chosen phases require kappa to be identified as +1 or -1. A deliberately conjugate phase for a nonreal partner makes it +1. In a real channel there is only one phase; kappa=epsilon^2=W can be -1 under the general algebraic hypotheses. No forced conjugate-phase identification is made in that case.

The central point is included, but a box containing zero proves neither exact central vanishing nor its order. Off-critical real zeros remain in the full count. The canonical count term is still `2theta/pi`. Substituting phi0 there without an integral error would be invalid. The note correctly limits the new proxy to the sign-value producer and retains all complete-count, boundary and saturation obligations.

## Independent exact checks and scope

The reviewer’s script `review_finite_u_hardy_normalization_20261111.py` imports no producer and uses only integers, rational arithmetic, hashes and saved JSON. All 86 checks passed: three producer pins, all four recorded phase/cosine rows, disk geometry, all four complete allocation records, shift-cap tests for both parities and coefficient-sum bounds. It writes no files and evaluates no analytic function. Its stdout is a scalar diagnostic, not independent function-value evidence.

The normalized Binet construction and the finite-U algorithm remain reviewed paper proofs and future formal/circuit obligations. The result is not a new axiom, completed family scan, historical-GRH import, executable-performance claim or authorization to run a producer. Subject to those explicit inherited obligations, the mathematical sign interface and the complete finite-arithmetic allowance are sound.

## Pins

| Artifact | SHA-256 |
|---|---|
| `work/qrh-campaign/agents/prime-estimates/FINITE_U_HARDY_NORMALIZATION_2026-11-11.md` | `06C9D3BF785BB183339D8EC64BE0B5AAD05331184C35356F575A8C126ADB724E` |
| `work/qrh-campaign/agents/prime-estimates/finite_u_hardy_normalization_20261111.py` | `03C27E09FD35195A8765263B0C9BEF63D41FAFE25E90DF2AD2EA425B79D63272` |
| `work/qrh-campaign/agents/prime-estimates/finite_u_hardy_normalization_20261111.json` | `DD5C2BC8A872A3308476CF8781582FCC9FC74B6CF96BCFF9C5D1F1E9DB9D7421` |
| `work/qrh-campaign/agents/zero-sum/review_finite_u_hardy_normalization_20261111.py` | `A025F62FB1A4D8A69873C651EE22A6891852F66179178082BF1F4184AF6B81D3` |
| `work/qrh-campaign/agents/prime-estimates/FINITE_U_AUXILIARY_EXTENSION_2026-11-11.md` | `F96610CCC7D7F1B094DB3B9D3D287858AD7C0C38D819AB9B39AFA89946A6B855` |
| `work/qrh-blueprint/REVIEW_FINITE_U_AUXILIARY_EXTENSION_2026-11-11.md` | `CB10FD297B823A9F08454D5E054D8080AE9AE08DE01953ADB9F4DEF93C2AE265` |
| `work/qrh-campaign/agents/prime-estimates/COARSE_GAMMA_PHASE_FOR_GABCKE_2026-11-11.md` | `C7B701CF5B02D34142E30F38D1FFE573AE30167A561B9A759FD9964F41FC6E79` |
| `work/qrh-campaign/agents/independent-feasibility/REVIEW_COARSE_GAMMA_PHASE_FOR_GABCKE_2026-11-11.md` | `DE019E48942C1999785FA8F14BC4CD65CAD7C4423038965FA0DEF96DD8BC75D0` |
| `work/qrh-campaign/agents/moebius/PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md` | `0A2F4766FCB77668C5461E8A63B97327EF2E6F595E66F805544A7EFA49A4A028` |
| `work/qrh-campaign/agents/integration/REVIEW_PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md` | `A4401782284FFF48DFFBA27BB9DE2EFAF20E6BECB09A4F3737BDD220EA739547` |
| `work/qrh-campaign/agents/zero-sum/FAMILY_ROOT_PHASE_PROOF_PLAN_2026-11-11.md` | `27B8ED6864E51BECEFA5402CC49E85B8A11F7F3BA620E7A7D1E6A682BBDD8C68` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/LGrowth.lean` | `5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341` |
| `work/ternary-goldbach/TernaryGoldbach/Explicit/LGrowthLeft.lean` | `59B0B227CC2D9472C6389231E8CC3998698F1F3E59139A8D110F32FF64F2F3D4` |
| `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/NumberTheory/LSeries/DirichletContinuation.lean` | `ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1` |
| `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/Gamma/Deligne.lean` | `C49C714067E797E8DD0F40CCBF39593C754C1DF3AD5A54C7A6F17188F97C7F45` |
