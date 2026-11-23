# Joint character and Gaussian Fourier batching

2026-11-11. This is a paper derivation and source plan. The main construction applies to complex contour values at `111/200<=sigma<=2`, with epsilon=1 and a fixed holomorphic tilt. It does not assume Hardy realness. No L-value, Gaussian sample, production transform, contour, or spectral result was computed. No Lean build or source edit was made.

## 1. Inputs and the holomorphic output

The primitive nonprincipal family and its exact positive-exponent CRT character labels are those of `zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md`, SHA256 `53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54`. At conductor c>1 let v=phi(c), n_a be the number of primitive characters of parity a, n=n_0+n_1, and p be the number of parities with n_a>0. Only those p parity channels need evaluation. Nonprimitive transform outputs are discarded.

The accepted analytic inputs are:

- Gaussian theta/Mellin/Fourier identity: `FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md`, SHA256 `5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41`, reviewed at `098171B14232E392AAA0C4BDD083C0E737D459315E23039F624C862B8E06C577`.
- Off-critical identity: `OFF_CRITICAL_GAUSSIAN_FOURIER_PLAN_2026-11-11.md`, SHA256 `BA7A5D0517972FD9C93496E6166DEC471B36C18CA0B6BBA734985016ECD24B25`, reviewed at `F9431FA70E33B7FFA3A16B6C12CB254A14D590C8FEEF81CC86E328418A304D0F`.
- Extension to the full real range used here: `FULL_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md`, SHA256 `618FB579D8657C72F2003BE4D60C68E38648C2F30F266938CE40E2C8F5A5E771`, reviewed at `AE8F8F852F969B6505EE9AC60E5F4D67B7AF686E94F6A9B4E4FED54D8F9ED271`.
- Finite frequency folding and error separation: `FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md`, SHA256 `E7D5CD24F5FAA6B75ED5E1167F3165EACBD7BCA7FEDF73D521C6B74BD04776EF`, reviewed at `A1B71C24E818CD5628C7A5F5B24105E19BDF5FC4840CCFC47239CAB435A85B33`. Its critical-line numerical constants are not reused off criticality.

The source pins remain Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9` and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`. In the latter, `NumberTheory/LSeries/DirichletContinuation.lean:249` gives the entire nonprincipal completion, line 258 relates it to L through the gamma factor, line 271 defines the root number, and line 283 gives the primitive functional equation. These declarations were re-read. `Prelim/GaussInduced.lean:175` and `Explicit/LGrowthLeft.lean:221` provide the primitive Gauss norm and root-number norm interfaces identified by the accepted Gaussian note. No corresponding norm claim is applied to discarded imprimitive outputs.

Write a in {0,1} for the character's parity, lambda=sigma+a, mu=1+a-sigma, and

`Lambda_chi(s)=c^((s+a)/2)*completedLFunction_chi(s)`,

`W_chi=tau(chi)/(i^a*sqrt(c))`, with the positive additive Gauss exponential.

For a fixed real b with |b|<pi/4 define

`F_sigma,chi,b(t)=exp(bt)*c^(-(sigma+a)/2)*Lambda_chi(sigma+it)`
`=exp(bt)*c^(it/2)*completedLFunction_chi(sigma+it)`.

The angular Fourier convention is `G(x)=(1/(2*pi))*integral F(t)exp(-ixt)dt`, with inverse `F(t)=integral G(x)exp(ixt)dx`. In particular there is no inverse factor 1/(2*pi).

For a contour spanning different sigma, F_sigma is not itself the restriction of the desired holomorphic function. Use one fixed entire function

`K_b,chi(s)=exp(-ib*s)*Lambda_chi(s)`.

Its exact conversion at s=sigma+it is

`K_b,chi(s)=A_sigma,a*F_sigma,chi,b(t)`,
`A_sigma,a=exp(-ib*sigma)*c^((sigma+a)/2)`.

The phase exp(-ib*sigma) and the positive conductor factor are both required. The real tilt exp(bt) is already in F and is not applied a second time. All powers of positive c use the real logarithm. On the positive half-plane, the source gamma factor and these exponential factors are nonzero, so K and the actual L-function have the same zeros and multiplicities. This does not mean their polygon images are interchangeable without the stated function identity.

The pending companion `TILTED_RIGHT_SLAB_FOURIER_EVALUATOR_2026-11-11.md` at the version read, SHA256 `695BF1B9AE43BDDA950F111D8A484B35DE774578B6F5A14012763740E28848AE`, gives the same K identity. It was not treated as independently accepted input here. The normalization and bounds needed below are derived explicitly.

## 2. Finite residue buckets and positive character transform

Let `theta_chi(z)=sum_{m>=1} m^a chi(m)exp(-pi*m^2*z/c)`. For r>=0 put w=r+ib and choose a finite cutoff M. At each unit residue u modulo c form two possible buckets

`B_a,u(r)=sum_{1<=m<=M, m mod c=u} m^a exp(-pi*m^2*exp(2w)/c)`.

There is no m=0 term. The exponentials are common to both parities; the odd channel multiplies each term by m. They are also independent of sigma and of the character label. A common cutoff can be the maximum requested for all channels and real parts. If cutoffs differ, the exact cutoff is part of the cache key and conjugation reuse must match it.

For the manifest's unit coordinates x(u) in a product of cyclic groups of orders m_i, define the positive, unnormalized transform

`D_r(B)=sum_{u unit} B_u exp(2*pi*i*sum_i r_i*x_i(u)/m_i)`.

Here r_i denotes a character coordinate, unrelated to the nonnegative frequency magnitude r. Finite regrouping gives

`T_chi,a(r):=D_chi(B_a(r))`
`=sum_{m=1}^M m^a chi(m)exp(-pi*m^2*exp(2(r+ib))/c)`.

This finite identity holds for every character label. The infinite theta identity and the negative-side reciprocal formula are used only on primitive outputs of the matching parity. A negative-sign DFT returns the inverse label; a normalized inverse DFT must be multiplied by v. No coefficient array is indexed merely by the ordinary residue ordering unless the CRT permutation has been checked.

At x=r>=0 the finite Fourier coefficient is

`Gplus_sigma,chi(r)=2*c^(-lambda/2)*exp(lambda*(r+ib))*T_chi,a(r)`.       (P)

This replaces repeated per-character theta summation by p transforms of v buckets. It does not invoke a Hurwitz evaluator.

## 3. Negative frequencies and cache reuse

The accepted primitive theta law is

`theta_chi(z)=W_chi*z^(-(a+1/2))*theta_inverse(1/z)`.

At x=-r<0, with w=-r+ib, its exponent is lambda-2a-1=-mu. Therefore

`Gminus_sigma,chi(-r)`
`=2*W_chi*c^(-lambda/2)*exp(-mu*w)*theta_inverse(exp(-2w))`.            (N)

The coefficient of |r| is mu=1+a-sigma, not lambda. In the main range mu may be negative. There is no reason to replace it by a positive critical-line exponent.

For the finite buckets, real b and m imply the exact identities

`Bminus_a,u(r)=conj(B_a,u(r))`,

`D_inverse(conj(B_a(r)))=conj(D_chi(B_a(r)))`.

Thus the same positive-radius transform output gives the finite negative coefficient as

`Gminus_sigma,chi(-r)`
`=2*W_chi*c^(-lambda/2)*exp(mu*(r-ib))*conj(T_chi,a(r))`.             (NC)

This saves a second character transform and requires no epsilon choice. It is not the claim `G(-r)=conj(G(r))`. The root number and distinct exponent remain. The infinite identities give the same formula with the full theta value; finite tail errors are bounded separately for each sign.

The cached T arrays are independent of sigma. At fixed c, b, frequency grid and cutoff, all requested sigma values can reuse them. Changing b, the period/frequency grid, or the cutoff requires a new cache entry or a proved extension of the old finite sums. A coefficient at an approximately equal frequency is not an exact cache hit.

Root numbers can themselves be computed once per conductor by applying the same positive group transform to `u -> exp(2*pi*i*u/c)`, retaining primitive outputs tau(chi), and dividing by `i^a sqrt(c)`. The input and transform require certified errors. The actual W values are still essential in (N), even though no square-root root phase epsilon is needed. Unit norm of W comes from primitivity, not a rounded numerical test.

For one centered time-transform block N, or L folds on either side, the retained integer frequencies are `-J,...,J-1`, where `J=(L+1/2)N`. There are Nfreq=(2L+1)N=2J signed frequencies and R=J+1 distinct absolute frequencies. Cache r=j*omega for 0<=j<=J, including the magnitude of the unpaired negative Nyquist endpoint. Positive j=J is not retained, but its theta transform is still useful for the negative endpoint. The zero coefficient is evaluated once using (P).

Only as a separate critical-line corollary: at sigma=1/2, if a fixed epsilon_chi satisfies |epsilon|=1 and epsilon^2 W=1 and is included in F, then epsilon W=conj(epsilon). Equations (P) and (NC) give `G_chi(-r)=conj(G_chi(r))`. This corollary is not used by the off-critical contour producer.

## 4. Analytic bounds valid on the whole sigma range

The general theta/Mellin proof applies to every fixed real sigma, since the Gaussian bounds at both ends dominate any fixed exponential. For the compact range 111/200<=sigma<=2, the accepted split-Gaussian estimate can be made uniform as follows.

For |y|<pi/4 put d_y=pi*cos(2y)/c. The elementary estimates `S_0(v)<=sqrt(pi)/(2sqrt(v))` and `S_1(v)<=1/v`, applied after extracting half the Gaussian exponent, give

`|h_sigma(r+iy)| <= K_a A_sigma,a(y,c) exp((sigma-1)r-d_y exp(2r)/2)`,

`|h_sigma(-r+iy)| <= K_a A_sigma,a(y,c) exp(-sigma*r-d_y exp(2r)/2)`,

where r>=0, K_0=sqrt(2), K_1=2,

`A_sigma,0=c^((1-sigma)/2)/sqrt(cos(2y))`,
`A_sigma,1=2c^((1-sigma)/2)/(pi*cos(2y))`.

The negative bound uses the actual primitive inverse-character theta law. If rational 0<q_y<=cos(2y) and q_y<=1, both bounds imply the convenient common envelope

`Q_y(r)=(2c/q_y)*exp(r-(q_y/c)*exp(2r))`.                            (Q)

Indeed sigma-1 and -sigma are at most 1, `K_a A_sigma,a<=2c/q_y`, and pi/2>1. Substituting u=exp(r), then using 1<=u and log(u)<=u, proves

`integral |h_sigma(x+iy)| dx <= 2c^2/q_y^2`,
`integral |x*h_sigma(x+iy)| dx <= 2c^2/q_y^2`.                         (L1)

These are uniform in sigma and both parities. Choose |b|<R0<pi/4 and a rational q_R<=cos(2R0). Shifting to the two outer lines yields time decay with `M_R=2c^2/q_R^2` and rates `R0-b` and `R0+b`, exactly as in the accepted alias proof. Thus for |t|<P,

`Etime(t)<=M_R*(exp(-(R0-b)(P+t))/(1-exp(-(R0-b)P))`
`                 +exp(-(R0+b)(P-t))/(1-exp(-(R0+b)P)))`.

For omitted frequencies beginning at X=J*omega>=0, choose q_b<=cos(2b) and require `2(q_b/c)exp(2X)>1`. The ratio of Q_b along the positive progression is at most `exp(-omega*(2(q_b/c)exp(2X)-1))`. Both signed omitted tails are therefore bounded by

`Efreq <= 2 Q_b(X)*(omega+1/(2(q_b/c)exp(2X)-1))`.                    (A)

This safely starts the negative omitted tail one grid step early. It is an off-critical bound derived from (Q), not an imported critical-line numerical allowance.

For the theta cutoff M, let m0=M+1, v_r=d_b exp(2r) and

`ratio_a=((M+2)/(M+1))^a * exp(-v_r*(2M+3))`.

When ratio_a<1, the common raw theta tail is bounded by `m0^a exp(-v_r*m0^2)/(1-ratio_a)`. Multiply it by the exact modulus of the appropriate prefactor in (P) or (NC). The positive modulus is `2c^(-lambda/2)exp(lambda*r)` and the negative one is `2c^(-lambda/2)exp(mu*r)`. These are separate bounds, even when the same finite T cache is used. For a uniform cutoff search, lambda and mu are both at most 3 in the main domain; Gaussian decay dominates this growth. No multiplication of this direct theta-tail bound by phi(c) is needed.

The same domination justifies differentiation in sigma. Since `partial_sigma G=(x+ib-(log c)/2)G`, differentiating the K conversion cancels both constant terms and gives

`K_b,chi'(sigma+it)=A_sigma,a * integral x G_sigma,chi,b(x) exp(itx) dx`.

Equation (L1) and `|A|=c^(lambda/2)<=c^(3/2)<c^2` give the rational whole-slab derivative upper bound `2c^4/q_b^2`. This is available for a midpoint whole-panel enclosure once the point values are supplied. It does not imply a positive lower bound on K. The pending tilted companion derives sharper conditioning variants; its numerical parameter choices are not needed here.

## 5. Two transform errors and the final complex scale

For one parity and one nonnegative frequency, let hat B_u enclose the exact finite bucket B_u with norm error e_u. Let a certified character-transform implementation return hat T_chi with additional error e_char,chi measured against the exact unnormalized transform of the centers. Then

`|T_chi-hat T_chi| <= E_T:=sum_u e_u+e_char,chi`.

If the implementation produces a normalized transform, its error and output must first be multiplied by v. This is the place where the unit-array size enters input-error propagation.

Let p be the exact scalar prefactor in (P) or (NC), let hat p have norm error rho_p, and let hat G be the rounded product of hat p and hat T, or its conjugate as appropriate. If the multiplication rounding error is rho_mul, a valid finite numerical error is

`|p| E_T + rho_p*|hat T| + rho_mul`.

For (NC), rho_p includes the certified root-number error. Constants, frequencies, tilt, powers and exponentials all belong to the certified prefactor/bucket construction. The actual sampled frequency is j*(2*pi/P), not an unverified rational replacement. Add the sign-specific analytic theta tail to obtain a radius r_sigma,chi,j for each signed retained coefficient. Reusing pi, W, a bucket or a transform induces correlations, but deterministic triangle inequalities require no independence.

For centered index k, fold the retained values j=k+ell*N and add their radii, also adding any finite summation rounding. Let z_k be the resulting rational center and r_k its complete radius. At t_m=mP/N, the exact finite synthesis of centers is

`omega*sum_k z_k exp(2*pi*i*k*m/N)`
`=(omega*N)*ZMod.invDFT(z)_m`.

If the time-transform implementation, including this final scale, has error e_timeFFT,m against the exact synthesis of centers, the error in F is

`E_F,m <= Etime(t_m)+Efreq+omega*sum_k r_k+e_timeFFT,m`.               (E)

The propagated character-transform errors occur in r_k. They are not multiplied again by a time-butterfly stability factor; e_timeFFT is measured against the exact transform of the centers. If the same absolute-frequency cache supplies two signed coefficients, both sign-specific radii occur in the signed sum. The zero and unpaired Nyquist frequencies occur once each. Sharing work does not halve this error sum.

Finally compute a center hat A for `exp(-ib*sigma)c^(lambda/2)` with error rho_A, and form the complex output hat K with product rounding rho_out. Its error is at most

`c^(lambda/2)*E_F,m + rho_A*|hat F_m| + rho_out`.                     (Kerr)

This final scale must be included before comparing against a requested contour-value tolerance. A rational upper bound c^2 can replace c^(lambda/2), and (L1) bounds |F| when allocating the scale error. There is no root-phase assumption in (E) or (Kerr). A numerical contract for F alone is not a completed contract for K.

## 6. Finite reordering and schedules

The primary schedule builds each pair of parity buckets once per nonnegative frequency, applies the character transforms, caches primitive T values, and then for each requested sigma synthesizes both signed G arrays using (P) and (NC). It applies one time transform per primitive character and sigma on a common time lattice. This order shares the expensive theta construction across all characters and all sigma values.

A different exact schedule is possible, but it must retain two branches. For signed retained frequencies define B^+ at nonnegative x and B^- at negative x by their direct and reciprocal Gaussian buckets. Let p^+ and p^- be the respective prefactors with W removed, and form, for each unit u and parity a,

`U^+_a,u(t)=omega*sum_{x>=0 retained} p^+_sigma,a(x) B^+_a,u(x) exp(ixt)`,
`U^-_a,u(t)=omega*sum_{x<0 retained} p^-_sigma,a(x) B^-_a,u(x) exp(ixt)`.

Then the finite synthesis of F is exactly

`D_chi(U^+(t)) + W_chi*D_inverse(U^-(t))`.

All sums here are finite, so distributivity proves the reordering directly. The inverse label and the W diagonal prevent silently replacing this by one identical transform on a single merged channel. Each channel could be time-transformed first at every unit, then character-transformed at the requested output times. Errors for that implementation must be propagated in its actual order; formula (E) cannot be cited without showing that its final radii enclose the same exact finite synthesis.

The only infinite interchanges needed are those already supplied by the accepted Gaussian/Mellin and Poisson proofs, with their absolute majorants. No critically convergent Dirichlet series is interchanged with a Fourier integral. Regrouping infinitely many Gaussian terms by finitely many residues would also be valid by absolute convergence, but the implemented bucket identity here is finite.

Character batching does not assume every character's adaptive t requests coincide. It shares frequencies, not adaptive time nodes. On a fixed P,b,N grid, any subset of lattice values can be read after a time FFT. A new off-grid t may instead use the unfolded retained exponential sum with a certified direct summation error; Poisson and the omitted-tail estimate apply for every such t in the allowed time interval. Folded coefficients cannot be reused off grid by ignoring exp(i*ell*N*omega*t). A different period, tilt or new frequency grid needs its own exact cache key. Unsupported interpolation or a nonuniform FFT is not part of this proof.

For contours, use one fixed b and K function per slab. Adjacent slab records with different b can be combined through the already accepted closed-region coverage argument and the explicit nonzero-factor identity. Their raw image polygons must not be canceled as if they represented the same analytic function. Adaptive point requests, whole-panel derivative radii, shared vertices and zero counts remain required after the Fourier values are produced.

## 7. Conditional work and memory counts

Fix one conductor and one shared frequency cache. Let Ntheta be a uniform theta cutoff, Nfreq=2J the number of signed retained frequencies, R=J+1 their number of absolute magnitudes, v=phi(c), n the primitive count, p in {1,2} the nonempty parity count, S the number of requested real parts, and N the time-transform length. Let Cchar(c,precision) be the cost of one certified unnormalized product-group transform, and Ctime(N,precision) the cost of one certified time transform. These functions include their actual precision-dependent arithmetic, not a guessed unit time.

The primary schedule has the following counts before unsuccessful refinements:

- At most R*Ntheta Gaussian term evaluations. Both parity buckets reuse each term; the odd bucket additionally multiplies by its integer index. There are at most p*R*Ntheta bucket additions.
- p*R character transforms of v entries, retaining n*R primitive theta outputs. A separate once-per-conductor Gauss transform and certified division construct W if it is not already supplied by a checked cache.
- S*n*Nfreq scalar prefactor/conjugation combinations, with shared parity/scalar constants where possible; S*n time transforms of length N; and the requested final complex scales and output checks.

Thus a symbolic leading expression is

`R*ThetaCost(c,Ntheta,precision) + p*R*Cchar(c,precision)`
`+ S*n*(Nfreq*ScalarCost + Ctime(N,precision)) + OutputCost`.

The original per-character theta method would repeat roughly S*n*Nfreq*Ntheta term accumulations, unless it separately implemented the sharing derived here. This comparison does not assign speed ratios to different operations. Theta cutoffs and precisions may vary with frequency and requested error, in which case the actual sums replace the displayed uniform products.

For the time-first two-channel schedule, one direct count is 2*p*v time transforms per sigma and at most 2*p character transforms at each requested common lattice time, plus W and output combinations. It may waste work when only sparse, noncommon times are requested. It does not justify assuming a common adaptive mesh.

The cyclic-axis arithmetic may use the accepted tensor/Bluestein proof components after their exact normalization and interval contracts are attached. Otherwise the literal finite character DFT remains an available mathematical implementation. The operation proxies and all-family a/phi totals in `FAMILY_BATCH_WORKLOAD_MODEL_2026-11-11.md` remain symbolic inputs. A critical-line 36-stage cap or a fixed precision is not inferred for the new time or character transforms.

One frequency needs p*v bucket entries and transform work buffers. Caching all primitive theta outputs costs n*R complex entries, with precision and exponent storage additional. This can be sharded by frequency and written to exact intermediate records. Producing time transforms in character batches then requires rereading or transposing those records; that I/O is not free in the model. Caching all S real parts is unnecessary because T is sigma-independent, but each requested sigma still needs its own prefactors/time synthesis. Retaining both parity transforms for a conductor with only one primitive parity is unnecessary.

No count here bounds how many precision upgrades, new grids, distinct tilts or failed panels will occur. Actual nonvanishing margins and successful complete coverage are still unknown. Upper kernel/derivative bounds alone do not supply them.

## 8. Tiny exact diagnostics and status

`joint_character_fourier_algebra_20261111.py` uses rational complex pairs and actual modulo-5 character coordinates, with arbitrary rational test arrays in place of Gaussian data. Its 32 exact checks cover finite residue regrouping, inverse-label conjugation, the two-channel finite time/character reordering, the conditional critical-phase algebra, and zero/Nyquist multiplicities. It evaluates no exponential, Gaussian, Gauss sum, L-value or production FFT. These checks support the index conventions; the analytic proof is the derivation above and the cited accepted inputs.

- Script SHA256: `BADF7BBAE39D39E3676F284F13E934365D0350FFC633F66571BC171B0208E462`.
- Receipt `joint_character_fourier_algebra_20261111.json` SHA256: `DB9D5DEB34FCDF492719BABA442BAE4C7B1546F1F6EF10FC4DB03AB8004B5357`.

The remaining work includes the source-to-manifest character equivalence, certified bucket arithmetic and root numbers, checked transform traces and both normalizations, the off-critical K output adapter, actual complete contour data and the existing zero-count assembly. All are proof or data obligations, not new final hypotheses. This plan neither certifies a spectral rectangle nor claims that a full-family computation is practical.
