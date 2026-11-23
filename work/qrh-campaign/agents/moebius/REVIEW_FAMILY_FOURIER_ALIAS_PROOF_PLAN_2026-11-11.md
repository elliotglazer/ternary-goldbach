# Independent review of family Fourier alias bounds

2026-11-11. **PASS for the mathematical alias identities, tail bounds, and stated conditional scalar protocol.** No blocking normalization, sign, convergence, indexing, or scalar error was found. This review proves no implementation correct and certifies no Fourier data, signs, zeros, or family height. No Lean build, full-family run, canonical edit, or producer-file edit was made.

## Frozen inputs and independent checks

The reviewed producer files are in `agents/zero-sum/`:

| File | SHA256 |
|---|---|
| `FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md` | `E7D5CD24F5FAA6B75ED5E1167F3165EACBD7BCA7FEDF73D521C6B74BD04776EF` |
| `family_fourier_alias_scalar_20261111.py` | `A64EE1ED4DA92033C45B6A4254ECF43EBA34775744707B1474EEB064722FA6C8` |
| `family_fourier_alias_scalar_20261111.json` | `89B0E22CC7B3EE0447556664C39D493C2851399CB043ABA119CB04D43593C31A` |

The accepted upstream transform is `FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md`, SHA256 `5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41`. Its independent integration review has SHA256 `098171B14232E392AAA0C4BDD083C0E737D459315E23039F624C862B8E06C577`. Both were read for this review. The current proof inherits their primitive, nonprincipal, conductor-c>1 domain and their fixed root-phase convention.

I independently reconstructed all nine exact rational claims from the scalar receipt, without executing the author script or writing its output. The new script `review_family_fourier_alias_20261111.py` also checks eight subsidiary rational reductions and 64 bounded centered-index examples. It exited 0. Its script SHA256 is `DF764841A433CE06834AC1C8CE6C0BE469E3A8190D747DEF3DD830C7EC201338`; its receipt `review_family_fourier_alias_20261111.json` has SHA256 `B013E72843884709CDA72F79223B68576445C039FB0241E20DD634D09E50B388`.

The finite index examples are consistency checks only. The universal index identity is proved algebraically below. No numerical character, Gaussian coefficient, FFT output, or sign was generated. All three author hashes were checked before and after the independent arithmetic run and remained unchanged.

## Normalization and the exact sampled object

The actual input is

    F(t)=epsilon*exp(b*t)*c^(i*t/2)*completedLFunction_chi(1/2+i*t),
    b=pi*eta/4, eta real, |eta|<1.

Its accepted transform is G(x)=(1/(2*pi))*integral F(t)*exp(−i*x*t) dt=h(x+i*b), with inverse F(t)=integral G(x)*exp(i*x*t) dx. The completion's conductor phase c^(i*t/2) is retained. Relative to the real completed Z_chi, F is multiplied by the positive real scalar c^(−k/2)*exp(b*t), k=a+1/2. Thus sign transfer is valid after the fixed epsilon phase has itself been correctly supplied.

I independently checked the scale in the Poisson argument. For

    omega=2*pi/P,
    g(y)=omega*G(omega*y)*exp(i*omega*t*y),

the negative-exponent, ordinary-frequency Fourier transform of g at integer r is F(t−r*P). Unit-lattice Poisson and reindexing r give

    omega*sum_n G(n*omega)*exp(i*n*omega*t)=sum_r F(t+r*P).

There is no missing 2*pi or reciprocal period factor. The upstream strip bounds and derivative estimates give Schwartz regularity, so Poisson applies. The explicit new bounds also give absolute convergence on both sides, which justifies regrouping.

For even N, the centered set J_N={−N/2,...,N/2−1} is a complete residue system. Every integer has a unique representation n=j+ell*N with j in J_N. At t_m=m*P/N, m an integer,

    n*omega*t_m−2*pi*j*m/N=2*pi*ell*m.

Therefore the exact folded coefficients C_j=sum_ell G((j+ell*N)*omega) satisfy

    omega*sum_j C_j*exp(2*pi*i*j*m/N)=sum_r F(t_m+r*P).

This is a **positive-exponent, unnormalized** finite sum. Mathlib's inverse DFT includes 1/N, so the same output is omega*N times that inverse DFT. This was checked directly in pinned `Mathlib/Analysis/Fourier/ZMod.lean:87,106,114`, including `dft_apply` and `invDFT_apply`. Centered indices must be converted to residues without introducing an extra phase. This identity is a grid-point statement; it supplies no interpolation theorem between grid points.

## Kernel envelopes and signed time decay

The two Gaussian comparisons in producer section 2 are valid for all v>0:

    sum exp(−v*n^2) <= sqrt(pi)/(2*sqrt(v)),
    sum n*exp(−v*n^2) <= 1/v.

For the second, integrating 2*t*exp(−v*t^2) over [n−1,n] gives a lower bound (2*n−1)*exp(−v*n^2), which is at least n*exp(−v*n^2), including n=1. No false assertion that t*exp(−v*t^2) decreases everywhere is used.

Writing C_y=cos(2*y)>0, the resulting constants are exactly

    A_even=c^(1/4)/sqrt(C_y),
    A_odd=2*c^(1/4)/(pi*C_y).

For positive real frequency coordinate the exponent reduces to −v/2 in both parities. For negative coordinate the primitive theta equation changes chi to its inverse, sends w to −w, and contributes exp(−2*k*Re(w)); this again gives exp(−|v|/2). The modulus-one root number introduces no additional loss.

Extracting exp(−D/2) from each term exp(−D*n^2), and applying the same comparisons to D/2, gives the producer's stronger envelope Q. The factors sqrt(2) for even parity and 2 for odd parity are correct. Its derivative is negative for nonnegative coordinate; more strongly, its ratio along a fixed positive step decreases.

Integrating the weaker envelope gives ||h(.-/+i*R)||_1<=4*A_a(R,c). Shifting the **untilted** inverse transform to +R for positive t and −R for negative t gives decay exp(−R*|t|). Multiplication by exp(b*t) then yields the two rates R−b and R+b. The producer keeps these different rates in the time-alias formula. It does not accidentally reuse the weaker positive-height rate with the wrong sign of the tilt.

## The two alias tails and their endpoints

For |t|<=T<P, every positive time copy t+r*P, r>=1, is positive, and every negative copy t−r*P is negative. Summing their geometric bounds gives exactly

    M_R*[exp(−lambda_plus*(P+t))/(1−exp(−lambda_plus*P))
        +exp(−lambda_minus*(P−t))/(1−exp(−lambda_minus*P))].

Both signed channels occur even for a nonreal character. Replacing P+t and P−t by P−T yields a uniform upper bound; both denominators are strictly positive.

Retaining ell between −L and L includes precisely the contiguous integer indices

    −(L+1/2)*N through (L+1/2)*N−1.

Thus if X=(L+1/2)*N*omega, the omitted positive side starts at X and the omitted negative side starts at X+omega. Bounding both by the progression starting at X overcounts a boundary term but does not drop the Nyquist endpoint.

The ratio of successive Q values is bounded by

    exp(−omega/2−(d/2)*exp(2*X)*(exp(2*omega)−1))<1.

The omitted normalized sum is therefore at most 2*omega*Q(X) divided by one minus this ratio. The factor omega is already the inverse-transform scale; another unexplained alias multiplier would be wrong. Finally

    1/(1−exp(−z)) <= 1+1/z,
    exp(2*omega)−1 >= 2*omega

give the stable upper bound in producer equation (11). The weaker fallback follows by the same argument with ratio exp(−omega/2). All these estimates are uniform in the grid index because the exact DFT phases have modulus 1.

## Conjugate-character evaluation and finite input errors

For x<0 the exact transformed expression is

    G(x)=2*epsilon_chi*W_chi*c^(−k/2)*exp(−k*w)
          *sum n^a*conj(chi(n))*exp(−pi*n^2*exp(−2*w)/c),
    w=x+i*b.

This follows directly from theta_chi(exp(2*w))=W_chi*exp(−2*k*w)*theta_inverse(exp(−2*w)). The logarithm identity holds because |Im(w)|<pi/4. In particular, the reciprocal argument has imaginary part −b. It would be incorrect to substitute an independently stored inverse-character epsilon without a phase adapter, or to retain +b in the reciprocal argument. The producer makes neither substitution.

On either side the Gaussian absolute parameter is d*exp(2*|x|), and the prefactor modulus is 2*c^(−k/2)*exp(k*|x|). The finite-series tail ratio is correct for both parities. Ratios of the positive majorants decrease with n; character zeros do not affect this majorization argument. When d*(M+1)^2>=k/2, differentiation of the logarithm of the numerator gives k−2*d*(M+1)^2*exp(2*|x|)<=0. The geometric denominator improves at larger |x|. This proves that the x=0 tail bounds all retained frequencies.

The input perturbation bound is the triangle inequality with the exact omega normalization. Each retained G value occurs once after folding, so it contributes omega times its series and rounding radii. The finite-DFT error is a separate quantity and must include phase evaluation and the final multiplier. The producer correctly leaves these numerical enclosures as future obligations. Structural real-valuedness permits projection to a real-part interval for sign testing; an interval that includes zero gives no sign certificate.

## All-Hcert scalar protocol

The selected profile is T=min(Hp_old(c),10^8/c). The active conductors satisfy c<=300000, and the original Hp formula is ceil(200+max(1000,(704/7)*D_c)), hence Hp>=1200. Therefore T>=1000/3>1 and c*T<=10^8. The author uses only the weaker T>=1 and product cap, so the protocol is valid throughout the selected nonprincipal domain without assuming any spectral statement at those heights.

For eta=1−1/T, R=pi*(1+eta)/8, P=257*T, N=2*ceil(2*P), and L=0, I checked each reduction:

- The sine chord inequality gives cos(pi*eta/2)>=1/T and cos(2*R)>=1/(2*T). Both arguments lie in [0,1] after rescaling. The pinned `Real.le_sin_mul` in `Trigonometric/Bounds.lean:69` has exactly this domain.
- A<=10^8 follows in even parity from c^(1/4)*sqrt(T)<=c*T, and in odd parity from (2/pi)*c^(1/4)*T<c*T. The outer M_R<=8*c^(1/4)*T holds in both parities, and hence M_R<=8*10^8.
- Both rates are at least 3/(8*T). Since P−T=256*T, each exponential is less than exp(−96). Each geometric denominator exceeds 1/2. This gives the stated time error below 10^(−30).
- N>=4*P implies X>=4*pi>12, while omega<1. The checked lower bound (3/(2*10^8))*(8/3)^24>200 proves d*exp(2*X)/2>200. Taking K<=2, A<=10^8, and the conservative factor omega+1/(1/2+d*exp(2*X))<3 proves the frequency error below 10^(−75).
- At M=100000, the exact inequalities give d*(M+1)^2>300 and d*(2*M+3)−1/(M+1)>1/200. Since log(1+1/(M+1))<=1/(M+1), both parity ratios are at most exp(−1/200). The reciprocal denominator is at most 201. The uniform series error is less than 402*100001*exp(−300)<10^(−119).
- N<4*P+2 and pi<22/7 imply omega*N<(44/7)*(4+2/257)<26. Thus the summed series contribution is below 10^(−117), and a future per-coefficient rounding radius 10^(−50) contributes less than 26*10^(−50).

The strict lower bound exp(1)>8/3 follows from its terms through degree 3 and a strictly positive remaining term. This justifies replacing exp(m) by (8/3)^m in all integer-exponent scalar checks. The independent receipt reproduces the author's exact fractions, not rounded decimal comparisons.

The total below 2*10^(−30) remains **conditional on actual numerical coefficient rounding radii <=10^(−50) and actual normalized DFT error <=10^(−40)**. These are not inferred from the arithmetic checks. Nor is this an error bound on interpolated values or on samples in an auxiliary Turing interval above T. The latter requires a new target height and a bound on its larger conductor-height product. The note states these limits correctly.

## Verdict and remaining work

No correction to the frozen producer files is required for their stated scope. The reviewed work supplies mathematical acceptance rules for sampling and both alias errors, with a uniform conservative choice of finite parameters. It does not import a historical computation, require a zero-free premise, or change Hcert.

Still open are the Lean adapters for these integral and discrete identities; exact character and root-phase data; certified transcendental input rounding; actual finite transform arithmetic; any off-grid interpolation; every actual sign packet and unresolved sample; and the independent count-completeness proof. The principal conductor-one row remains outside this theorem. A small analytic error budget does not prove that any sign search succeeds.

Reproduction of this review's bounded arithmetic is:

    python work/qrh-campaign/agents/moebius/review_family_fourier_alias_20261111.py

Only the review's own adjacent JSON is written. The producer note, script, receipt, canonical Lean sources, and frozen packages remain untouched.
