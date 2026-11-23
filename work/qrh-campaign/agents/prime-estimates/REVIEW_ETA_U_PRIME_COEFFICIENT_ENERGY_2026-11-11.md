# Independent review of the etaU coefficient energy

2026-11-11. **PASS for the stated conditional paper derivation. No correction requested.** This review does not prove the new theorem in Lean, validate the existing imported proof closure, or establish an aggregate character-energy bound. No prime, zero, L-function, numerical integral or transform was evaluated. Only exact rational checks and source hashes were computed; author scripts were not imported or executed.

Reviewed author: `audit/ETA_U_PRIME_COEFFICIENT_ENERGY_2026-11-11.md`, SHA256 `0B97BC320F7BEEA4B7CC9D8144FBB70CFC19A4AF756602BDA4DCBD1239399D5C`.

## Actual smoothing and source assumptions

I read `MajorArcs/Cor933.lean:49` and its proof, `Eta2Moments.lean:18–54,130–178`, the actual `phi`, `eta2`, `kappa` and `etaStar` definitions, and the relevant theta/Lambda interfaces. Cor933 uses `phiPos`, not an unrestricted Gaussian at negative arguments. For t>0 and r in [1/4,1] it is exactly g(t/r)=(t/r)^2 exp(-(t/r)^2/2). Eta2 vanishes off that interval and is nonnegative. Thus the positive measure dmu=eta2(r)dr/r and the author's mixture are correct. There is no etaPlus substitution. Since kappa=49, coefficients Lambda(n)etaStar(n/x) become Lambda(n)etaU(n/y) at y=x/49, with no additional scale factor in the coefficient itself.

The moments consumed from the source are integral eta2=1, integral eta2/sqrt(r)<=1.37259, and integral eta2/r<=1.92182. The latter is the total mass of mu, not integral eta2. This distinction is preserved in the bounds.

`Prelim/ThetaExplicit.theta_explicit:512` is an integer statement for n>=10^12. Its `epl_le:31` is unconditional arithmetic, but the theta statement has `Fact PlattGRH`. `LambdaMu.sum_vonMangoldt_lt:337` and `sum_vonMangoldt_nonprime_lt:761` both cover every positive real argument and retain that bundled Fact. Their finite floor sums start at 1. I checked the displayed proof branches and the theta module's calls to psi_two_sided, psi_plateau8, psi_range1_8 and psi_asymp8. The report correctly treats principal-only localization, its principal analytic inputs and finite certificates as remaining obligations. It does not extract a principal-only theorem merely from a comment or synthesize a broad Fact from principal RH.

I also read `MinorArcs/LargeSievePrimes.lean:35–37`: PrimeSupported requires both support on primes strictly greater than sqrt(x) and summability of the coefficient norms. The cutoff p>7sqrt(y) at x=49y matches exactly. Gaussian decay, the source mixture and Lambda(n)<=log n give the required summability for the retained component. The new coefficient bound does not itself supply the sieve's other hypotheses or weights.

## Gaussian moments and derivatives

Squaring the positive mixture yields r^-2 s^-2 t^4 exp(-Ct^2), C=(r^-2+s^-2)/2 in [1,16]. The Gamma integral formula has the correct power C^{-(5+j)/2}. Minkowski gives V<=1.37259^2*3sqrt(pi)/8<1.254. The source eta2 pieces have first moments (log2)/2-3/16 and 3/4-(log2)/2, totaling 9/16. Therefore integral U=sqrt(pi/2)>5/4 and integral tU=9/8. The test (3-t)_+ has squared norm 9 and dominates 3-t, yielding V>49/64. All uses of positivity are valid.

For each normalized mixture component, I2/I0=5/(2C)<=5/2. Jensen applied to log(t^2), after establishing absolute log integrability, gives J/V<=log(5/2)/2<1/2. The independent bound |log t|<=t+1/t and I1/I0<=2, I_-1/I0<=4 gives |J|<=6V; no integrability assumption is hidden in Jensen.

The derivative estimate t|w_rs'|<=w_rs(4+2Ct^2) yields D0<=9V. Writing g0=Gamma(5/2)>1, the D1 ratio is exactly (20/sqrt(C)+8sqrt(C))/g0<=52. For the four powers j=1,0,-1,-2, the ratios are bounded by 20,9,32,75, respectively; the last is 14C/3<=224/3. Consequently the half-weighted derivative bounds 41V and 136V and the integral w/sqrt(t)<=5V are valid. The factors r^-2s^-2 cancel in these normalized ratios. These estimates extend through the mixture by Tonelli and domination.

The uniform source bounds U<=32t^2 exp(-t^2/2) and |U'|<=(64t+512t^3)exp(-t^2/2) follow from mu mass<2 and 1/4<=r<=1. They provide all needed improper-integral domination, including logarithmic factors at zero, and the boundary vanishing for partial summation. At t<=1/4 the sharper |U'|<=96t gives |w'|<=6144t^3 as used later.

## Prime measure, floor and low-range error

For v>=A=10^12, n=floor(v) is still at least A. The theta error is bounded by n/(log n)^3+4.92e-7 n plus v-n<=1. Since log n>27 and v>=A, the relative error is less than 52e-6. Below A, thetaR>=0 and thetaR<2v give absolute error <=v, also for v<1 where the floor sum is zero.

Stieltjes summation against thetaR assigns mass log p at every prime p. With f(v)=log(v)w(v/y), this produces exactly (log p)^2w(p/y), rather than a prime-power or von Mangoldt square sum. The Lebesgue main term divided by y is VL+J. Taking absolute derivatives gives epsilon[V+LD0+D1]. The additional low-range integral is safely overcounted even though epsilon was already used there.

The low integral to a=A/y is exactly bounded by a^5[(6144/5)(L-log a)+11264/25]. Since log A>0, this is at most a^5[(12288/5)L+11264/25]. Both y^-5 and y^-5 log y decrease on y>=10^25; log(10^25)<75 then gives the strict 2e-60 endpoint bound. Thus the result is uniform, not an endpoint-only numerical test.

## Disjoint small support and final constants

The small-prime sum includes p=7sqrt(y) when equality occurs. Bounding its terms by all integers n<=z, z=7sqrt(y), and using sum n^4<=z^5 proves the displayed y^-5/2 bound. Its logarithmic factor is (2+L/2)^2 because log7<2. The whole expression decreases throughout the stated range and its endpoint upper is <1e-50.

For the nonprime part, Lambda(n)^2<=Lambda(n)log n for every positive integer, with n=1 contributing zero. Partial summation against the actual nonprime Lambda counting function therefore gives the factor 1.4262/sqrt(y). The derivative integral initially starts at t=1/y, where log(yt)>=0; only its nonnegative majorant is extended to zero. The constants combine as 41L+136+5=41L+141. This expression divided by sqrt(y) decreases for L>=25log10. The source norm bound gives 1.4262V<1.8 and the endpoint result <2e-9. Thus esmall<2.1e-9 is valid with room for the small-prime contribution.

Finally epsilon*9=.000468 and .5+epsilon*53=.502756 give

    tlarge(y)<1.254(1.000468 log y+.502756)+2e-60

for every real y>=10^25. The real coefficient sequence has the same squared norm when embedded in C. The two supports are disjoint, so their squared energies add without a cross term. No totient, Gauss-sum, character or principal-subtraction normalization is introduced here. Those belong to the later operator argument. In particular, this review does not claim B<2000 or any other aggregate target; that requires a separately proved weighted-sieve/consumer composition.

## Exact checks and pins

The author's script and receipt pins were verified as `FAABDFFBB8F70AD1EAD2927C31187FDC13C8A16C24901A83C1A2AD23D739DD91` and `D581F36A158A194EA067C77475FBA576B11F10BA974BDC1F3E5C66DF4C24E8A8`. All seven source hashes in the author's table match. The additional PrimeSupported source hash is `B701BA5355E6ECEAEEF466015BDE4EC477C570BCF6B76A5D95A7043B7804C836`.

Owned independent script: `prime-estimates/review_eta_u_energy_scalars_20261111.py`, SHA256 `8912238AF5D58F5E579203C6A790EE7609E537E9468FDC38A4C2C98D8FB3D3CD`.

Owned receipt: `prime-estimates/review_eta_u_energy_scalars_20261111.json`, SHA256 `4FBC1578872F975F1E580071A7E0D233C438D6CE8619114FED4FC4A62343B334`.

All 26 independent exact rational comparisons pass. They include alternative finite exponential-series comparisons for the elementary log bounds, moment constants, real-floor conversion, both low-support endpoints and the final affine coefficients. The receipt stores all eight source pins. These arithmetic checks support the paper argument; they do not replace its integral proofs or any future kernel check. No frozen author artifact was modified.
