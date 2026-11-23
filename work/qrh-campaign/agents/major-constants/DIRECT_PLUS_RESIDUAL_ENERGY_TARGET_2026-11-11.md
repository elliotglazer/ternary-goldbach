# A direct aggregate target for the actual plus residual

Date: 2026-11-11. Status: proved paper implication and source comparison; the proposed aggregate bound is unproved. This note replaces one consumer hypothesis conditionally. It does not remove the selected spectral family, validate a provider, or claim a computational saving. No Lean declarations, builds, analytic evaluations, prime computations, or frozen-file changes were made.

## 1. The narrow replacement

Keep the original finite-RH route, the actual smoothing etaPlus, and the reviewed cutoff R=132900. Write qt(q)=q for even q and 2q for odd q. The proposed statement ranges over

* every real x >= 4.9*10^26;
* every integer q >= 1 with qt(q) <= 265800;
* every real delta with |delta| <= 1063200/qt(q).

Put beta=delta/x, v=phi(q), m=mu(q)/v, and

\[
 a_q(n)=1_{(n,q)=1}\Lambda(n)\eta_+(n/x),\quad
 S'_q(\alpha)=\sum_n a_q(n)e(n\alpha),\quad
 P=\widehat{\eta_+}(-\delta).
\]

These are the actual source functions, with complex coercions understood. The sums converge absolutely by `summable_cP` and coprime restriction. Define

\[
 E_q(x,\delta)=\frac1{v x^2}
 \sum_{\psi\ne1\pmod q}|\tau_q(\psi)|^2
 \left|\operatorname{Schar}(\psi^{-1},a_q,\delta/x)\right|^2. \tag{1}
\]

The character sum includes all nonprincipal characters modulo q, including imprimitive ones. It is not an unweighted primitive average. For c=cond(psi), the exact weight is

\[
 |\tau_q(\psi)|^2=c\,1_{q/c\text{ squarefree},\ (q/c,c)=1}. \tag{2}
\]

The inverse label in (1) comes from the source's positive character transform. Inversion preserves conductor, principal status, and the weight, but it must be applied consistently to the actual sums. No root-number convention is needed here.

**Sufficient new theorem:** throughout the displayed domain,

\[
 E_q(x,\delta)\le 7.02\cdot10^{-13}. \tag{T}
\]

Together with the retained principal-only estimate and unconditional coprime removal, (T) implies exactly the conclusion consumed from `MajorTotal.resid_plus`:

\[
 \sum_{b\in Bset(q)}
 \left|S_{\eta_+}(b/q+\beta,x)-mPx\right|^2
 \le 7.83\cdot10^{-13}x^2. \tag{3}
\]

This is a uniform continuum theorem, not an assertion on the retained Fourier grid. The q=1 nonprincipal sum is empty. The proposed theorem makes no beta-location assertion about individual zeros.

## 2. Proof of the consumer implication

The exact source Gauss/Parseval identity and the principal coefficient give

\[
 E_q=\sum_b|r_b|^2,\qquad
 r_b=S'_q(b/q+\beta)/x-mS'_q(\beta)/x.
\]

The Ramanujan identity is sum_b S'_q(b/q+beta)=mu(q)S'_q(beta), so sum_b r_b=0. Thus r is orthogonal to every constant vector. If e=S'_q(beta)/x-P, then

\[
 \sum_b|r_b+me|^2=E_q+\frac{\mu(q)^2}{v}|e|^2. \tag{4}
\]

This is stronger than applying the source's generic three-term factor-3 inequality. Keep its existing principal and removal bounds

\[
 |e|\le p_0=2.83\cdot10^{-7},\qquad
 |S_{\eta_+}(\alpha,x)/x-S'_q(\alpha)/x|\le d_0=10^{-15}.
\]

Minkowski in the finite Euclidean norm and (4) give

\[
 \left(\sum_b|S_{\eta_+}(b/q+\beta,x)/x-mP|^2\right)^{1/2}
 \le\sqrt{E_q+\mu(q)^2p_0^2/v}+\sqrt v\,d_0. \tag{5}
\]

An explicit q-dependent sufficient allocation is therefore

\[
 E_q\le
 \left(\sqrt{7.83\cdot10^{-13}}-\sqrt v\,d_0\right)^2
 -\frac{\mu(q)^2}{v}p_0^2, \tag{6}
\]

with the positive square-root difference understood. Formula (6) is the sufficient boundary for this error decomposition, not a necessary condition for the actual residual.

For the simple uniform (T), use v<=q<=265800<516^2 and mu(q)^2/v<=1. Exact rational arithmetic gives

\[
 7.02\cdot10^{-13}+p_0^2
 =7.82089\cdot10^{-13}<(8.844\cdot10^{-7})^2,
\]
\[
 (8.844\cdot10^{-7}+516\cdot10^{-15})^2
 <7.83\cdot10^{-13}<(8.85\cdot10^{-7})^2.
\]

Hence (3) holds, preserving the downstream rho=8.85*10^-7*x in `pointwise_bound` and `per_modulus`. The old aggregate allowance was (4.25*10^-7)^2=1.80625*10^-13. The ratio of the new to old allowance is exactly 5616/1445. This slack is due to orthogonal principal splitting; it is not evidence that (T) is true without finite RH.

The retained principal bound needs only the modulus-one estimate. Source `thm_7_1_4_one` obtains GRHUpTo at 10^8 from q=1 and calls `prop_9_4_2`. Here qt(q)>=2 implies |delta|<=531600<600000; q<=265800<300000 also preserves its coprime-removal domain. Refactoring the bundled `arc_chars` statement is required to expose this principal-only dependency. A blanket Fact PlattGRH cannot remain as the replacement theorem's hidden premise.

## 3. What this does and does not replace

This implication removes the nonprincipal characterwise step from the plus residual consumer if a new proof of (T) is supplied. The actual plus function, all Gauss weights, every reduced residue, and every arc parameter remain present.

The upper bound in `L2Major.Jq_bounds` separately uses the smaller allowance (4.25*10^-7*x)^2. It cannot inherit that bound from (T). One may instead target the stronger E_q<=1.80625*10^-13 to preserve both old plus-energy interfaces, or recompute the integrated upper-J budget. Neither is done here.

The lower half of `Jq_bounds` uses only the principal approximation, coprime removal, and nonnegativity of the nonprincipal residual. Its `A0lo` contains no `Cn`; the upper `A0hi` does. Splitting that conjunction is a valid dependency reduction without a new analytic estimate. It does not itself avoid any spectral work still required by other consumers.

`resid_star`, the pointwise etaStar base gap, and other explicitly retained original-RH consumers remain open replacements. The root's separate integrated cubic-error proposal may replace the pointwise star requirement for major arcs after paying the actual fourth moment; it is not proved by (T). No reduction in the production family is credited by this note alone.

## 4. Why the inspected unconditional tools do not close (T)

The exact finite identities already eliminate a need to materialize character outputs **once the actual smoothed prime residue sums are known**. They do not bound those sums. Direct evaluation of Lambda(n) etaPlus(n/x) on scales x>=4.9*10^26 is not the current small-conductor Fourier workload and has no cost advantage established here.

The source Montgomery--Vaughan large sieve gives, for a finite head of length H and q-separated additive points,

\[
 \sum_b\left|\sum_{n\le H}a_ne(n(b/q+\beta))\right|^2
 \le(H-1+q)\sum_{n\le H}|a_n|^2. \tag{7}
\]

Dividing by x^2 and discarding the nonnegative principal subtraction gives an upper bound for the centered finite-head residual. It is too coarse as a direct substitution. For H=x, even the hypothetical coefficient-energy upper bound sum|a_n|^2<=x would only deliver a right side near 1, rather than 7.02*10^-13. This compares sufficient bounds, not actual residuals; the infinite smoothed sum also needs its tail handled.

A finite countermodel makes the information gap precise. Let x be a positive integer divisible by 3, q=3, beta=0, and a_n=1 for 1<=n<=x with n congruent to 1 modulo 3, otherwise zero. Its coefficient square sum is x/3<=x, it is coprime-supported, and it satisfies the exact character identities. The single nonprincipal character sum is x/3 and its squared Gauss norm is 3. Its normalized E is therefore 1/6. Thus generic coefficient energy and orthogonality alone do not imply (T). This artificial sequence is not Lambda*etaPlus and is not claimed to satisfy the source's `PrimeSupported` hypothesis or principal approximation.

The prime-supported `prop_12_1_2` and `cor_12_2_5` control an **integral of total energy** over major arcs. They do not state a pointwise centered variance bound. The latter also retains Fact PlattGRH in its present interface. Its underlying principal prime-counting dependencies may be localized, but doing so does not turn the integrated assertion into (T). This is a bounded source inspection, not a claim that no other unconditional analytic route exists.

The explicit-formula route exposes the missing spectral information directly. `EtaPlusBound.norm_SsumG_fP_le` requires every zero with |Im rho|<=T0 and 0<Re rho<1 to have Re rho=1/2. Its low-zero contribution has size sqrt(x)*E1g before normalization. Removing that hypothesis leaves actual terms x^(rho-1) times the Mellin kernel. One cannot keep E1g/sqrt(x) by a type change or a character-sum identity. A replacement must bound the positive weighted squared sums of those actual contributions, including cross terms and Mellin phases, uniformly in x and delta. Generic zero counts or an unproved averaged cancellation assertion do not supply that bound.

The immediate quantitative gap is therefore (T), or an integrated variant with a separately proved consumer inequality. A useful next analytic result would establish such a weighted variance directly for the actual prime sums without first verifying each character's low zeros. Until that result includes an explicit constant and all ranges, there is no demonstrated reduction of character-output work.

## 5. Source and scalar pins

Paths below are relative to `work/ternary-goldbach/TernaryGoldbach`, source HEAD `23b2d68ca344203d4384e0aff7affa4ec034bef9`. These are source-level readings, not compilation claims.

| File | SHA256 | Relevant lines |
|---|---|---|
| MajorArcs/ArcChars.lean | 0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF | 28-30 actual coefficients; 314 removal; 347-465 bundled character bound and principal-only body |
| MajorArcs/MajorTotal.lean | 106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A | 95-154 exact centering; 166 generic factor3; 233 plus; 264 star; 760/808 consumers |
| MinorArcs/Bombieri.lean | F3236E24D824647816AB0370CB57FB958C642194643393F20E785096888D3C79 | 73/78 Schar and inverse transform; 135 Parseval; 152-184 exact weights |
| MajorArcs/L2Major.lean | 8C9424D92074ABB35DF00273D598F5A3F95C49A34F07F4146DD83FD2B6F3A5FC | 100-230 lower/upper energy split |
| MajorArcs/Thm714.lean | 7BBF8F06B1A0B703A0C00FF1E5E64997792C4E93629CED591FCB6A646301FD3F | 572-589 principal-only RH height |
| MajorArcs/Prop942.lean | 35B170971DBD0F1C6646CD86ECE8C3A86021085C1B07730141CD6311D9CA5716 | 28 actual smoothing adapter; 54-77 error and GRHUpTo premise |
| Explicit/EtaPlusBound.lean | 8A0D0BE027F1560321D3AB4088C49768D0DE3E18D92A074823679A71AD043695 | 153-172 actual low-zero premise and sqrt(x) term |
| Prelim/LargeSieveMV.lean | EAB57B36D93223872641C375E1ABF6BCC8A4754A2F552060DCC831C37628A284 | 26-43 generic finite large sieve |
| MinorArcs/LargeSieveProof.lean | FB71222C80D0377BDF6739529E527F4BE6A0C908286FF87F0EC19D67DDE9CAF1 | 295 generic prime-supported integral; 378-405 numerical integrated corollary |

Owned `direct_plus_residual_energy_scalars_20261111.py`, SHA256 `A983B94F0E5C514D8DFD2BABDB225DE30C7A8E07C6E31229D4157AC773AB0449`, ran eight Fraction-only checks. Its JSON SHA256 is `B5D6502589DCA7B735D2CBAB159E888C7497D217B02ED40C34E23DC92ACEB57E`. It checks the strict allocation, domains, ratio, and countermodel arithmetic; it does not check (T).

The preceding frozen global-bottleneck memo has a recorded inverse-conditioning erratum in independent review `27C5F38882FA77352882D57AB9FA46E1CFB0EFF846D1F1F728DE08D6D0381DD8`: an approximate inverse with residual norm at most r<1 forces norm at least (1-r)/min|L|, whereas 1/min|L| applies to the exact inverse. No such inverse argument is used here.
