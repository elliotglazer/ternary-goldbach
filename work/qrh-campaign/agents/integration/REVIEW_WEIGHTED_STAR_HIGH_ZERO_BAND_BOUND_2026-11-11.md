# Independent review of the weighted high-zero star band bound

2026-11-11. **PASS at paper/source scope; no correction requested.** Reviewed `major-constants/WEIGHTED_STAR_HIGH_ZERO_BAND_BOUND_2026-11-11.md`, SHA256 **DDF6E8D4F568BA7E31DA1AE5F8857166F23BCD53E39CA3C593880FEAFA833AA1**. The finite-band estimate and summable bound are valid under the stated actual-function inputs. The closed allocation fails at the displayed conductor-3 test; this is a failure of that sufficient majorant, not a lower bound on actual spectral error. No cutoff or production saving is accepted.

## 1. Actual plus smoothing and Fourier decay

I checked `HHFourier.hH_eq_fourier:278–302`, the derivative-energy theorem at 194, and `HHBound.hP:191` against the actual etaPlus normalization. The frequency interval has length 200/pi. Differentiating its finite integral, applying Cauchy, and using Fourier differentiation/Plancherel gives

    |b^(j)|^2 <=(200/pi)||g^(j)||_2^2, j=1,2.

The factors 2pi are already in the differentiated Fourier transform. They are not additional factors in this inequality. The global cutoff g(u)=hBase(exp u) is C2: the polynomial has a third-order zero at t=2; its logarithmic derivatives decay at minus infinity. Integrability and the two derivative identities therefore follow without assuming a third derivative is continuous at the join.

Independent polynomial differentiation recovers P2=32t²−68t³+20t⁴+17t⁵−5t⁶−t⁷ and integral P2² dt/t=16128/715. The exp(3)<21 bound gives the stated energy, hence |b'|<40 and |b''|<180. The source sup bound safely gives |b|<4.

Direct differentiation of f(t)=t exp(-t²/2)b(log t) recovers both formulas (4). In particular the second derivative contains (b''+b')/t. The report correctly does not integrate that absolute bound through zero. For a=1/X, X>=1, it integrates the tail twice, with both boundary terms retained. Their estimates and the remaining integral give

    2 + 2/3 + 4/3 + 320/36 =116/9,
    220/36=55/9.

The tail estimate uses integral_1^infinity exp(-t²/2)/t <= integral_1^infinity t exp(-t²/2)<=1. Gaussian decay removes both boundaries at infinity. Thus (5) is a bound on actual etaPlus, not etaCirc. Its derivative has the sign of 55−2(116+55log X), so B decreases on [1,infinity). The actual full norm bound from `EtaPlusL2:113–150` supplies the separate low-twist L2 factor below one.

## 2. Full-strip adjustable-angle bound

The mixture substitution t=rv produces r^s and no additional 49 factor; only the twist is delta*r/49. Its dr/r mass is below 2. The source `MellinRotate.norm_Gr_le:359–387` requires Re(s)>−2, |theta|<pi/4 and theta*Im(s)>=0. A signed angle of magnitude at most 1/4 satisfies these for the entire closed beta interval [0,1] and either ordinate sign.

Using v^(beta+1)<=v+v², cos(2theta)>=1/2, and |sin theta|<=|theta| gives the completion-of-square bound with cost 80D²theta²/2401. The positive integral is 4+4sqrt(2pi)<16; the mixture contributes the factor 2. Consequently the coefficient 32 in (8) is correct.

Writing C=80D²/2401, the choice theta=min(1/4,H/(2C)) gives exponent at most −H/8 in the clipped case C<=2H and −H²/(4C) otherwise. This proves E=min(H/8,2401H²/(320D²)), without a restriction beta<=7/8 or a reference-beta kernel substitution. The proof requires H>0, as in the high-zero application, and handles both signs of delta.

## 3. Gram, windows and multiplicities

I read the pinned prior full-strip Gram review **85849ED642AEED600A71F41E56D4C7DC86ACAB23F338E19979CD15B58B8D60DE**. Replacing its local count 400 by a uniform bound L gives exactly eight central windows and two outer windows at each distance k*h, k>=4. Hence the Schur row constant is

    49*2L*(96+2904/(3h²)) <17500L, h=87/25.

The 49 comes from delta=49d in the unweighted Gram integral. The Mellin real part is beta+beta'−1 in [-1,1]; the imaginary part is the actual ordinate difference. Repeated zeros are repeated rows and must be included in L,N,S. The y phases remain arbitrary coefficients in the Schur inequality.

On the low-twist piece finite Cauchy bounds the zero sum by 32 exp(-E)sqrt(NS), and integral |P|²<1 finishes that piece. On the high-twist piece sup|P|<=B(D) multiplies the full Gram norm. Summing the two restricted norms proves (1), with all cross terms covered. For a finite consumer interval and D>=Dq, the high-twist piece really disappears; applying the low bound with Dq is then permitted. The global estimate can be needlessly weak here.

The new arbitrary-height count is legitimate. `ZeroSums.zero_count_poly:76–98` counts true analytic orders for a primitive nonprincipal L-function in a closed disk, with radius 3<10 and denominator log(10/3)>0. A strip window of height h fits because 4+(h/2)²<9. Windows that meet the band may use centers with |v|<=2H+h. BP monotonicity bounds all of them by L_c(H); irrelevant trivial zeros in the disk only enlarge the upper count. A partition of [-2H,2H] uses at most 4H/h+2 windows, and this is <=2H for H>=1024. No old finite-domain constant 400 is extrapolated.

## 4. Infinite tail and weighted consumer

For H>=1024, H>=48log H follows from the increasing function H−48log H and log 1024<10. The lower bound log 1024>5 and log H<=H also give 1<=D(H)<=H. Substitution yields E>=6log H. With N<=2HL and S<=N, the low term is 64L/H^5. The high coefficient is bounded by 17 because

    sqrt(35000)*1920/(9*2401)<188*1920/(9*2401)<17.

The BP factors at 2^jH grow by at most 2^(11j). Since log2/log(10/3)<1, L_c(2^jH)<=a+11j. Also log(2^jH)<=l+j. Expanding these polynomials and using the exact geometric moments (2,2,6,26) gives (14), including the terms 330 and 1430. No band orthogonality is assumed; Minkowski pays cross-band terms.

These bounds apply also to arbitrary finite submultisets in a band. Thus they prove a weighted-L2 Cauchy tail, including partially filled terminal bands, and not a default value of an unproved infinite sum. Identification with the actual explicit formula still uses the separately retained good-height formula, smoothing/admissibility and measurable residual transfer. This review accepts that as the named lower interface, not as a new proof of the complete explicit formula. The vertical integral, zero at zero and primitive-to-coprime removals are not included in E_c.

The consumer coefficient is mu(q)²*c/phi(q)³ for A, as in the reviewed exact Gauss/Parseval calculation. Summing over actual supported ambient moduli and all primitive labels gives (15); inversion is a permutation, not a reason to halve labels. B and the pointwise base gap are different targets. At c=3, the q=3 and q=6 terms already give omega_A>=3/4. The closed majorant at H0=10^6 exceeds 604044/10^9, and even half that exceeds 10^-6. This lower bound concerns the displayed upper-bound expression only. Sharper Dq restrictions, counts, Fourier bounds or actual beta information are not ruled out.

## Evidence and remaining boundary

The independent checker imports no author code and evaluates no analytic function. It uses dense polynomial differentiation and convolution, exact rational integration, and scalar comparisons; all ten source/report pins in the author table match. **38 exact checks passed.**

* `integration/review_weighted_star_band_20261111.py`: **0A4606CF25B15D5FF3696E728A627272E817CC2FD8A42AF531F2AB692BBA4506**.
* `integration/review_weighted_star_band_20261111.json`: **7FC63125969B0D1A6E38A0628107FB545CF42E249E772439E93ECDAD89C0822B**.

The exact source hashes are retained in that receipt. Existing Fourier, contour-rotation, Jensen/count, Gram and explicit-formula transfer theorems remain lower dependencies at their stated scopes. New formal adapters and actual remainder allocations are unimplemented. No Lean proof status, reduced carrier, or runtime saving follows from this review. Frozen author and source files were unchanged.
