# Proof boundary for the exact principal-node interval evaluator

2026-11-11. This is a blueprint for replacing the trusted execution of the Python prototype with ordinary Lean proofs and kernel-checked finite arithmetic. It proposes mathematical interfaces in prose, not Lean declarations or approved anchors. No implementation, build, or source scan was performed.

The smallest useful target is a **principal P-node checker**, parametrized by a rational real node r and natural T>=1. Its independently fixed specification is

`eta=1/(T+1)`, `w=r+i*(pi/4-eta)`, and the actual source-normalized `P(w)`.

It need not begin as a checker for arbitrary analytic expressions, a general complex logarithm, or a spectral certificate. It must nevertheless support arbitrary finite modular words and finite Taylor lengths, since those are certificate choices rather than changes to the target function.

## 1. What is already evidence, and what is not proved in Lean

The completed external example is `R1OVER8_P_NODE_EXACT_2026-11-11.md`, hash `C11F586345B4C9F4C2FDD9A0B927902B323E53C9796AB06E509460454BA128A6`, with code `4EE532C9698CCD8B462D40A1D102CE6DAD35741173C7D43F911C3AE7B2F15286` and receipt `DDF8B38A52FEBB70F019E805068ED4480CB086C8A27A00A86DAA0D05882AF584`. Its independent review is `mellin/REVIEW_R1OVER8_P_NODE_EXACT_2026-11-11.md`, hash `3F6684C81A95E2ACC9A4BA7EEDC449E0D4D95F0375ABE5AE0A01346AB894C09A`.

That review supports the paper mathematics and the exact external computation, including a different 384-bit replay. It does not establish a Lean soundness theorem, kernel evaluation of the receipt, a verified parser, or a completed P definition/identity in the target repository. Source theorems cited below exist; the wrappers and composition theorems described here remain work to do.

## 2. Four proof layers and the final contract

Keep four layers separate:

1. **Exact arithmetic:** Boolean order/equality checks on finite integer/rational data imply the corresponding real statements; interval operations and rounding preserve containment.
2. **Elementary analysis:** finite rational Taylor/Machin certificates enclose the actual exp, sin, cos, and pi, on their checked domains.
3. **Theta and modular analysis:** actual theta functions obey the selected T/S identities and derivative transport, and finite Gaussian sums plus proved tails enclose their jets. The final expression equals the actual P kernel.
4. **Finite acceptance:** interpret a concrete certificate, run only the proved checks, and prove that the specified output encloses P at the independently fixed input parameters.

The desired generic acceptance statement is: **for every valid input specification and finite certificate, if the checker returns acceptance, then the exact P value lies in its reported rectangle (or disk)**. For a disk, the statement is `norm(P(w)-center)<=radius`. An additional checked strict separation can imply `P(w)!=0`.

The intermediate soundness theorem may quantify over real values satisfying certified input intervals. The public closed-node result must discharge those inputs by elementary certificates. It must not retain assumptions saying that the seed, theta coefficients, root phase, or numerical output are correct.

Python may choose the word, precision, truncation lengths, rational bounds, or a proposed proof term. Its execution is never an acceptance premise. A hash binds provenance; it does not prove any inequality or analytic identity.

## 3. Smallest certificate language

Use a fixed principal-node template with typed certificate components:

- Exact parameters r and T; the checker computes eta and fixes w and tau's mathematical meanings. A free-form seed-expression string has no authority.
- Elementary certificates enclosing `exp(2r)`, `cos(2eta)`, and `sin(2eta)`, with their products enclosing `tau=exp(2r)*(-cos(2eta)+i*sin(2eta))`. A proved Euler identity connects this to `i*exp(2w)`.
- A finite typed modular word, with interval witnesses for its points, principal-root formula nodes, and phase constants. All operand references are earlier indices. Distinct real/complex types, constants, and selected theta types are checked explicitly.
- Terminal theta type and finite Gaussian/Taylor parameters, then a deterministic interval evaluation of the terminal jet, reverse jet transport, and final P formula.
- A proposed final rectangle/disk and a checked containment or norm comparison.

The hybrid is intentional. The lossless word needs supplied narrow interval witnesses: recomputing it with a coarser generic interval algorithm can widen the path unnecessarily. The elementary finite sums and reverse transport can be computed deterministically by the checker, so they need not carry thousands of redundant intermediate JSON records. Their algorithms still need proved soundness and finite kernel evaluation.

A malformed reference, wrong selected theta type, failed domain, missing tail, negative radius, or false arithmetic comparison rejects. A failed necessary gate cannot be replaced by interval overlap or by an assertion about the intended point.

## 4. Exact arithmetic and representation contracts

For an initial implementation covering the reviewed node, rational endpoints suffice: its operative dyadic mantissas/exponents and Taylor intermediates are finite and modest. Give a rational wire value a signed numerator and strictly positive denominator. Prove cross-multiplication checks agree with rational/real order. Normalization is optional for semantics. Zero denominators are rejected; no division uses Lean's totalized value at zero.

An interval means its **closed** endpoint inequalities; a complex box means the Cartesian product. Required statements are:

- Certified rounded endpoints contain the exact arithmetic result. For grid `2^-p`, integer quotient/remainder proves floor/ceiling inequalities for both signs.
- Addition/subtraction and four-corner multiplication preserve containment for every pair of input values.
- Unary square uses its own exact range when the input crosses zero; it is not identified with multiplication of two independent interval variables.
- Division uses a denominator interval wholly on one side of zero and contains all four corner quotients.
- A nonnegative square-root interval is sound from nonnegative input, nonnegative output lower bound, and endpoint-square comparisons.
- Complex arithmetic follows the exact coordinate identities. A disk-to-box conversion preserves containment; box half-widths must not be called a Euclidean radius without a norm bound. The prototype uses the sum of coordinate errors as a safe norm bound.

For lossless center/radius input, verify `radius>=0`, `lo=mid-radius`, and `hi=mid+radius`. The demonstrated export defect makes this essential: an outward display of an internal Arb ball need not be a valid input operand for the next original operation.

The general huge-exponent backend is a separate refinement of these same semantics. `COMPACT_DYADIC_REPLAY_PLAN_2026-11-11.md` (`85651AA198E92AEBDB541C48A2C42AC666B0F5A72A7DDB728545A83F01AD19A8`), reviewed under `2BD81A05B6C84A27149C1BEE5827B4918DD4F7F454AB799B1DEA8E954398F9DC`, supplies the bit-length comparison, three-term sign, sticky rounding, and witness contracts. Its Lean implementation remains open. Do not execute expanding `toRat` or unguarded exponent-gap shifts on the huge-exponent historical receipts merely because their semantics are correct.

## 5. The extra arithmetic gate needed by the lossless word

The narrow recorded complex reciprocals require more than the coarse independent numerator/norm-denominator estimate. A reusable rectangle-inversion statement is sufficient:

**For any closed rational rectangle excluding the origin, a rectangle containing the values at all listed edge-extremum candidates contains its entire image under `z -> 1/z`.**

For the real coordinate `x/(x²+y²)`, the candidates are corners, y=0 on vertical edges, and x=±y on horizontal edges. For the imaginary coordinate `-y/(x²+y²)`, they are corners, x=0 on horizontal edges, and y=±x on vertical edges. Retain only candidates on the relevant edge segment. There is no interior critical point away from zero. All candidate coordinates and values are rational.

The proof needs continuity/compact extrema plus the explicit derivatives, and separate handling of a point or line rectangle; it must not assume nondegenerate sides. The checker excludes the origin first. A rectangle containing the origin rejects even if the intended point is believed nonzero. This lemma is a mathematical wrapper still to formalize, not an existing named Mathlib API claimed by this note.

The principal-root macro uses existing scalar gates to enclose `n=sqrt(x²+y²)`, `u=sqrt((n+x)/2)`, `v=y/(2u)` when x>0. Prove symbolically that `(u+iv)²=x+iy` and u>0; then it is the principal square root. Preserve the same x and y references throughout. This identity is not inferred by checking that the output box overlaps a root box.

## 6. Elementary-function soundness statements

Each statement is universal on its certified interval, not just at its midpoint.

**Pi.** Even/odd partial sums of atan at 1/5 and 1/239 enclose those actual values. The terms are positive, antitone, and geometrically summable. Machin's exact identity gives pi by the sign-correct linear combination. Only these fixed rational arguments are needed for the first checker; a generic arctangent function evaluator is unnecessary.

**Exp.** For `0<=t<=1/2` and natural N>0, the first N Taylor terms form a lower bound; the upper error may be `2^-N*(N+1)/(N!*N)`. A checked exact relation `x=2^k*t`, k natural, and k certified squarings give exp(x). For negative x, invert the positive exp(-x) enclosure. A closed input interval uses both endpoints and monotonicity. Every squaring/inversion must preserve positive-domain conditions. Length zero and an unproved range reduction reject.

**Sin/cos.** A certificate proposes an integer k; interval arithmetic must enclose `X-2k*pi` using a certified pi box. Check this reduced interval lies in `[-R,R]` and `R/(N+1)<=1/2`. The even/odd parts of the first N complex exponential terms have coordinate error at most `2R^N/N!`, by the source complex exponential bound. Their polynomial evaluator is proved by finite induction, including zero coefficients and correct factorial/parity indexing. Periodicity then covers every original input in X. No monotonicity of sin/cos is assumed.

**Complex exp.** Use the exact identity `exp(x+iy)=exp(x)*(cos(y)+i*sin(y))` and the previous interval rules. This suffices for finite Gaussian terms and the final `exp(w/2)`. No complex logarithm, Gamma evaluator, or complex-power branch checker is needed here.

Eighth-root phases can instead use exact axis constants and signed positive roots of 1/2. Their interpretation as `exp(pi*i*n/4)` is a proved finite residue-class identity, with n reduced modulo 8, not merely the equation `z^8=1`.

## 7. Terminal theta-jet certificate

For this checker, support derivative orders j=0,1,2 and classical types theta2/theta3/theta4. Their Gaussian series and locally uniform differentiated series must be connected to the source definitions first. The integer modes for theta3/theta4 include the constant 1 at derivative order zero; theta2 has only half-integer modes. The selected type is part of the checked modular state.

The minimal first acceptance mode may require terminal imaginary lower bound Y>=1. With u=N+1/2 for the first omitted half-integer mode and N>=0, a common theta2 tail bound is

`128*exp(-2Y*u²)`

for each j<=2. It follows from `pi<4`, `pi>3`, `a^4<=2exp(a²)`, and a geometric bound, exactly as in the reviewed node. A natural M with `M<=2Y*u²` allows the fully rational replacement `128*2^-M`, using `exp(1)>=2`. Integer-mode tails have their own first omitted index; their constant term is never hidden in a tail. Prove each type's indexing separately.

Finite Gaussian terms are evaluated with the elementary checker, including the coefficient `(pi*i*a²)^j` and both signs of a. The tail norm bound may be converted to equal coordinate enlargements, but subsequent error accounting must include the resulting box geometry. The r=1/8 instance uses four paired modes and `2^-357`; these are certificate data, not new analytic assumptions.

Requiring Y>=1 is a sound restricted acceptance domain, not a claim that every modular output exceeds 1. The original relaxed reduction only guarantees Y>2/5. General coverage later needs the reviewed general Gaussian-tail formula for that domain, or another certified evaluation method; do not silently strengthen the reduction theorem.

## 8. Modular identity and derivative transport

The analytic state consists of an actual upper-half-plane point, one selected classical theta type, and its value/first two derivatives. A T step at integer n changes the actual point by translation and updates the type/phase by the exact T identities. An S step changes it to `-1/t`, with the source principal `A(t)=1/sqrt(-i*t)`, and applies the three displayed jet formulas from the reviewed modular plan.

The correctness statement is that reverse evaluation of an accepted word equals the selected source theta jet at its original point. Prove it by induction on the finite word using **holomorphic identities** and chain rules. A pointwise numerical square-root identity alone does not prove A's derivatives; the branch must be the holomorphic principal branch on the whole upper half-plane. The interval root macro only certifies its value at the actual point after this analytic fact is established.

Every denominator excludes zero. Preserve each local A, rather than replacing a product by a chosen square root of a product. T phases are constant with respect to the variable and multiply all three jet entries. The exact selected type determines whether a phase is present at all.

Strict reduction/stopping guards may validate how a producer chose a word, but the core T/S identity theorem needs only the actual domain and point relation. The finite checker does not need to prove that the producer's nearest-integer search terminated. To support an automatic producer separately, the reviewed overlapping guards and positive imaginary growth supply its mathematical termination argument.

## 9. Source normalization and closed acceptance

The final wrapper must prove the actual identity

`P(w)=exp(w/2)*(6*tau*theta3'(tau)+4*tau²*theta3''(tau))`,

where `tau=i*exp(2w)` and `|Im(w)|<pi/4`. Here P is the differentiated Gaussian kernel of the **unhalved** `TernaryGoldbach.Explicit.xiF` Fourier formula. It is not a user-supplied function with this expression as an unproved property. The source-normalization bridge remains an explicit Lean obligation.

For T>=1, eta=1/(T+1)<=1/2 and pi>3 imply `0<pi/4-eta<pi/4`; rational r imposes no extra domain restriction. The seed identity, elementary certificates, accepted word, terminal theta certificate, and final arithmetic then produce a closed enclosure of this exact P(w).

A proposed center/radius is accepted only after a final exact rectangle-to-disk comparison. For example, the sum of coordinate errors bounds Euclidean norm. Nonvanishing additionally needs a checked strict separation; no procedure is promised to certify it at a zero or at every true nonzero point with a fixed precision budget.

## 10. Finite evaluation, parser boundary, and termination

The theorem `accepts -> correct enclosure` is only half the job. For the concrete node, acceptance itself must be proved by ordinary kernel-checked computation or an explicit checked proof of each finite comparison. An unchecked native result, an imported Python Boolean, a new axiom, or a fresh analytic premise is not an acceptable substitute. The final theorem's axiom closure must be audited after an actual build.

The smallest initial parser boundary is an untrusted converter from JSON to a typed Lean data value. The kernel-checked theorem is about that actual data value and independently fixed r,T; a converter cannot choose a different target formula or insert an unproved leaf. A separate verified byte parser is needed only if the theorem must certify the external file bytes themselves. File hashes alone do not provide that semantic link.

All acceptance loops recurse on finite lists or supplied natural lengths, with bounds-checked earlier references. Integer/rational operations, powers, factorials, and finite polynomial evaluation terminate structurally. Optional resource limits or fuel can reject large certificates without harming soundness. No analytic convergence search is run inside the checker.

Producer completeness is separate. Increasing Taylor length and precision yields convergence for fixed valid elementary inputs, but narrow source-box acceptance can require more precision and cancellation can enlarge the cost. A fixed finite word with nonzero denominators permits sufficiently precise evaluation; that is not a uniform runtime bound. The restricted Y>=1 tail mode is not an all-word completeness theorem. Neither checker termination nor one accepted node guarantees a terminating complete spectral search.

## 11. Exact source dependencies and implementation order

The existing source basis is Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`, target Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9`, and Lean v4.35.0. No new version compatibility claim is made here.

| Layer | Existing source and exact role |
|---|---|
| Square roots | `Analysis/Real/Sqrt.lean`: `Real.le_sqrt`, `sqrt_le_left`, `sqrt_le_iff`, `sq_sqrt`; sign hypotheses remain required. |
| Alternating pi bounds | `Analysis/SpecificLimits/Normed.lean`: the two `Antitone` even/odd partial-sum bounds; `SpecialFunctions/Complex/Arctan.lean`: `Real.hasSum_arctan`; `Trigonometric/Arctan.lean`: Machin identity. |
| Exponential tails | `Analysis/Complex/Exponential.lean:407,516,523`: `Complex.exp_bound'`, `Real.exp_bound`, `Real.exp_bound'`; positive partial-sum lower bounds and exp addition/negation provide the rescaling. File hash `564992EF54C295F97D4E00CA0D07A396C068F331D09EFD29B85E4863511986F0`. |
| Trig periodicity | `SpecialFunctions/Trigonometric/Basic.lean`: `Real.sin_add_int_mul_two_pi`, `cos_add_int_mul_two_pi`; reduced input uncertainty must still be propagated. |
| Pi constants | `Analysis/Real/Pi/Bounds.lean`: `pi_gt_three`, `pi_lt_four`; file hash `58E8B7A97645F6F1BD3CA1D08860CB27B8C705C394FA101E057542970F34B036`. |
| Source theta | `NumberTheory/ModularForms/JacobiTheta/OneVariable.lean` and `TwoVariable.lean`: source series, holomorphy, T-periodicities and `jacobiTheta₂_functional_equation`. Hashes `7C29B4B07AED2E46D40FE408362F2A707126BFBBF05C3B374420AA0EDDF06B5C`, `CC4E420DA8441AD20DDBE3709040C4CFBEBB530C6DDD8E101FF2FC1F0B6F8820`. Classical theta2/theta4 and their jets are wrappers to prove. |
| Actual xi/P bridge | Target `Explicit/Xi.lean` and the source Mellin/theta identities listed in the reviewed xi evaluator. Xi file hash `988EDFBCA182F1A7618C88A6EA9B253BFEFEBFA3DA86C3CDC74F5DAC19523D1F`. The P kernel and Fourier/derivative wrapper are not already packaged by these APIs. |

Implement in this dependency order: exact data/interval semantics and finite graph induction; arithmetic gates including reciprocal extrema/root macro; elementary certificate soundness; source classical theta and finite-tail wrappers; word/jet induction; actual P identity; closed checker acceptance; then the concrete r=1/8 receipt and its axiom audit. The compact huge-exponent backend can replace the arithmetic implementation through the same semantic interfaces, without changing the analytic theorem statements.

This order exposes the real remaining work. The reviewed Python node provides a concrete acceptance fixture and exact target, not a proof that those implementation tasks have already been completed.
