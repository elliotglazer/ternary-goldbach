# Minimal integer tilt at the admitted theta128 time length

This is a conditional parameter and cost refinement of the accepted whole-small-conductor inventory. For each of its 7,499 conductors and four closed-grid scenarios, choose the smallest integer theta in [64,128] that admits the theta128 time-FFT length. All 130 cohort/tilt parameter sets and all 29,996 choices pass exact rational checks. Every selected length equals the old theta128 length; every named local arithmetic tolerance is at least as large. No analytic function, prime candidate, zero, or transform was evaluated.

The improvement is precision at unchanged loop counts. It is not a measured speedup, a successful sign certificate, or permission to use the old numerical boxes for new intermediate values. Some conductors still require theta128, so the maximum Gaussian seed requirement remains 404 fractional bits.

## 1. Fixed inputs and output identity

The source and normalization contracts are those of `WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md`, sections 1--4, and its independent review. They include the actual tilted theta transform, both required parity channels, primitive character selection, fixed root-number convention, Hermitian frequency reuse within each character, and the positive rescaling back to the same normalized Hardy function Y. None is changed here.

The active conductors are odd c from 3 through 9,999 and multiples of four through 10,000. There are 18,477,108 primitive labels. The principal conductor is excluded. The three one-parity cases are c=3,4,12; all other active conductors use both parity transforms. CRT dimensions and label counts are recomputed from the integer factorization of c only.

For completeness, the retained endpoint is

`H(c)=ceil(200+max(f, (3927/1250)*u*d))`,

where odd c uses f=240, d=531600/c, and u=21,20,39/2,96/5 on the half-open bands c<100, 100<=c<1000, 1000<=c<10000, c>=10000. Even c uses f=255, d=1063200/c and u=113/5,211/10,201/10,191/10 on the same bands. These are the already accepted combined height formulas, not newly weakened spectral requirements.

For e in {0,167,320,640}, put m=ceil(64H/5)+e, V=5m/64, Delta=5/64, and retain all m+1 outputs from height zero through V inclusive. The extensions remain planning scenarios, not established successful Turing allowances. The requested absolute Y error is tau=2^-80. The tilt is b=pi/4-theta/V. Changing theta changes the tilted samples, their transform and rescaling factors, but not the exact Y being approximated.

The previous universal height argument gives cV<40,000,000 for odd c and <80,000,000 for even c, including e=640. Thus W=cV/theta can be replaced by the respective rational upper bound Wbar. Every selected row also checks V>=2theta and 1<=W<=Wbar directly. This retains all domains of the prior analytic tail and elementary circuit proofs.

## 2. Independent admission of all integer tilts

Keep X=10, C=44, n0=8192, B=3^11, M=B+1, and Bpref=2*3^33. For each parity cohort and each integer theta from 64 to 128, set

`epsilon=tau/(4*3^theta)`.

Choose the least positive integers K,L satisfying

`32 Wbar^2 (3/8)^K < epsilon/4`,

`12 Wbar (3/8)^L < epsilon/4`.

The finite checker then verifies, independently for every choice,

`(8/3)^20 >= Wbar*(20+L)`.

For the Gaussian truncation put v0=3n0^2/Wbar and z0=3(2n0+1)/Wbar-1/n0. It checks v0>=2, z0>0, and

`C*2n0*(1+1/z0)*(3/8)^floor(v0) < epsilon/8`.

These are the full rational sufficient inequalities from the accepted backend, including the polynomial prefactor of the Gaussian tail. Checking only K or the final transform size would not suffice. No monotonic interpolation in theta is used. The theta64 and theta128 parameter records are checked against the frozen earlier receipt.

For seed rounding, choose the least nonnegative p with

`6*2^-p <= epsilon/(32 C Bpref n0^4)`.

Let delta=2^-p, epref=epsilon/[64 C(n0^2+2)], D=min(delta/16,1/Wbar), and

`sigma=min(1/4, D/(64M^4), epref/(16M^3), 1/(16n0))`.

The checker explicitly verifies 15M^4 sigma<D, 7M^3 sigma<epref and 4n0 sigma<=1/4. These retain the full shared radial/prefactor and outer-exponential error allocations. In particular, counting an outer exponential does not remove the cost of its inner radial argument, phase reduction, or a certified pi enclosure.

## 3. Minimality and unchanged work geometry

For a row with grid index m and a candidate theta,K, let N(theta) be the least power of two at least eight with

`N >= ceil(2mK/theta)`,

`N >= ceil((5m+128K)/5)`,

`N >= ceil(384/5)`.

Equivalently N Delta >= max(2VK/theta,V+2K,6). First compute N128. Exhaustively test all 65 theta values, and select the first with N(theta)<=N128. The checker verifies every earlier integer fails and verifies N(selected)=N128. This last equality is a checked result, not an assumption that intermediate choices cannot produce a smaller length.

Consequently the retained frequency count R=ceil(5NX/384)+1, radial update count J=R-1, Gaussian work envelope T=ceil(n0*(1+5N/192)+R), output count m+1, and all character/time tensor dimensions are unchanged. It also checks R-1<N/2 and m+1<=N. The same-N theta64 subset therefore stays at theta64.

| Extra grid nodes | Chosen theta64 | Chosen theta65--127 | Chosen theta128 |
|---:|---:|---:|---:|
|0|3876|3613|10|
|167|3866|3624|9|
|320|3853|3637|9|
|640|3830|3658|11|

Every integer theta from 64 through 128 occurs in the main scenario. The receipt stores each scenario's entire list in increasing active-conductor order and its complete histogram, so the choices are not hidden behind aggregate totals.

For the main scenario, the following six totals are independently compared with the earlier theta128 receipt:

| Category | Unchanged count |
|---|---:|
|Gaussian unit-gate upper envelope|8,542,028,172,242|
|Outer complex exponentials|2,605,203,866|
|Main character butterflies|128,941,391,789,290|
|Main character extra products|25,399,177,848,072|
|Time butterflies|89,858,217,607,168|
|Primitive grid outputs|1,775,431,871,117|

All other loop categories in the earlier schedule are also unchanged by their formulas: both parity transforms, bucket additions, Bluestein inverse scales, root/kernel setup, radial and prefactor updates, output rescaling and storage indices depend only on these dimensions and c. Their numerical operands generally change. Shared-grid bucket accumulation remains exact as in the retained schedule; if instead rounded, its extra error must be allocated.

## 4. Complete local precision comparison

Let v=phi(c), S be the sum of the accepted axis error constants, and smax the largest axis safety denominator. With J=R-1, set

`dr=sigma/[4B max(1,J)]`,

`kappa0=min(dr/16,sigma/(16384c^2))`, `eta=sigma/256`,

`uchar=min(1/smax,1/(2S),epsilon/[128 C Bpref v S(n0^2+2)])`,

`ugauss=min(1/smax,1/(2S),eta/(256vS))`.

With k=log2 N, the time gate and scale allocations are

`utime=min(1/(2k),epsilon Delta/[56(2k+4)(2Wbar^2+2)])`,

`escale=tau/[4(2Wbar^2+1)]`,

`ds=escale/[8*3^theta*max(1,m)]`.

The finite checker verifies Jdr<=1/2, kappa0<=eta/(8c), 3kappa0<=eta/(32v), and m ds<1/2. The pre-existing transform proof supplies the meaning of the axis constants, including the nonunit Bluestein kernel and its setup error. It is not replaced by a unit-root-only error model.

Each of the eight named positive tolerances delta, sigma, dr, kappa0, uchar, ugauss, utime, ds is recomputed at the selected theta and at 128 with the same row dimensions. All 239,968 exact rational comparisons selected>=old pass. The receipt additionally records the least nonnegative binary fractional-bit requirement for each. These comparisons do not rely on rounding the tolerances to bit counts.

| Allocation | Selected fractional-bit range | Uniform theta128 range |
|---|---:|---:|
|Gaussian seed delta|302--404|404--404|
|Shared elementary sigma|382--484|484--484|
|Radial seed dr|417--523|519--531|
|Root/phase setup kappa0|422--527|523--535|
|Main character gate uchar|279--411|381--415|
|Gauss transform gate ugauss|402--534|504--538|
|Time gate utime|238--340|338--340|
|Positive-scale recurrence ds|242--347|341--356|

The ranges are the same across the four scenarios, though the assigned precision of individual conductors can differ. These are fractional precision requirements under sufficient error allocations, not total signed word widths or claims of optimal precision.

For a reproducible indication of where the changes occur, the main scenario has sum(weight*(old_bits-new_bits)) equal to 738,985,241,801,004 at the 8,542,028,172,242 Gaussian unit-gate weights; 11,253,109,380,100,470 at the 128,941,391,789,290 character-butterfly weights; and 7,672,767,368,921,088 at the 89,858,217,607,168 time-butterfly weights. These are descriptive weighted precision differences. They are not bit-operation counts, proof bytes, or elapsed-time estimates. In particular, a butterfly contains several operations and the seed tolerance is not by itself a priced complete unit-gate proof.

## 5. What this does and does not reduce

Under a fixed implementation whose cost is nondecreasing in required fractional precision, this gives a componentwise local precision improvement at the same nominal loop counts as theta128. It removes the need to pay theta128 precision uniformly merely to obtain its transform lengths. It does not prove that these tilts minimize actual arithmetic cost: argument-dependent elementary work, stage-specific widths and improved actual enclosures can change a priced optimum.

A cross-conductor cache may still require the finest tolerance of all its consumers. Thus a relaxed local root request does not automatically shrink a globally shared root table. The remaining theta128 rows also keep the maximum seed precision at 404. Storage, signed temporaries, raw products and range reduction retain their separate magnitude bounds. Different tilts require newly certified numerical data; neither the previous boxes nor successful signs can be transported merely from this parameter comparison.

No principal or large-conductor requirement is reduced. The primitive labels, endpoint heights, closed grid and requested Y accuracy remain fixed. Actual elementary certificates, transform arithmetic proofs, phase conventions, central/real-zero treatment, strict sign data and closed zero counts remain to be produced. This paper/metadata refinement neither validates Lean/MM0 acceptance nor estimates production or checking time.

## 6. Frozen evidence and dependencies

`small_family_minimal_theta_20261111.py` uses only integer factor metadata and exact rational arithmetic. It imports no earlier evaluator or generator. It checks its three frozen inputs, all selectors, each minimal choice, all local tolerance comparisons, and the six aggregate equalities per scenario: 690,590 checks, status `PASS_ALL_130_SELECTORS_AND_29996_MINIMAL_CHOICES`. The row digest is a reproducibility aid, not a substitute for proof of the rows.

| Artifact | SHA256 |
|---|---|
|small_family_minimal_theta_20261111.py|0B0656A46461D397B9A459BEFEFC9686640FDCBC4EA5C6CD73E19BB2C3B1C5E0|
|small_family_minimal_theta_20261111.json|25E4BF80119B05A5C0FF25BDB7AECACEBC7495B5A00097B991E11C3DBF77D422|
|WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md|74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE|
|small_family_theta_inventory_final_20261111.json|26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69|
|../audit/REVIEW_WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md|34FB45C1CEBFF34A49C7C450BF1C78223593AB188EFEFC7C3EE7FE7658CB0AFE|

The retained analytic sources, pinned in that inventory, are the backend `NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md` (6AA4F11AD9103A1176F24BDF045CDF798193B726B1B3A925B8540476E6823043), the shared elementary circuit (A8AC4A3B594C8671476FCC92C67A45DCF42EFF0060F522023F929BA440835A4B) and its review (4642186F50141A6918D80F662C5550DF4E3B481A3CE1D9CCD3035CB7A59009C8). The odd/even height inputs remain C4EE2B2F674F6376D987C778FC7886A03A93BC81E61C0BC56D0B1C25E2E4A14D and D3408AA27763D7E3C475E7B27DB124FDE9C16EDC916CEE061563B31D9A2DD88B. No frozen dependency was modified. Independent review of this refinement remains separate.
