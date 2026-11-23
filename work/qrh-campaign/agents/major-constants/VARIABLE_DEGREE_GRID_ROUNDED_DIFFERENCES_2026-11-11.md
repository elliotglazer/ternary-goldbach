# Variable degree and grid for rounded initial differences

2026-11-11. Paper proof and exact rational metadata only. Source generation, its twenty delivered centers, P27/P28, EM corrections, height recurrence and finite translation remain unchanged. No actual coefficient, function, prime or transform values, builds or source edits. This note offers new sufficient scalar evaluation contracts, not numerical certificates or a method winner.

The coordinate-nearest complex bound permits p=b+bitlength(S), without the old extra two bits, while staying below the old evaluation allowance at b100. Lower b requires the complete alpha test below. It cannot inherit the old internal u100/4 state-error promise.

## 1. Exact polynomial and integer initializer

Let 18<=K<=20, n=K-1, and let z_0,...,z_19 be the ORIGINAL delivered finite translated centers. Round the first K centers directly, coordinate by coordinate, to a common grid b, 93<=b<=100. Write z'_j=a_j*2^-b. Nearest ties-up rounding has each coordinate error at most half an ulp, so its complex norm is at most sqrt(2)/2 ulp, STRICTLY less than 3/4 ulp. This applies to every coefficient, initial-state and final-output conversion used here. Denote e_b=(3/4)2^-b.

For an actual nonempty ties-down bucket of length L<=260, set F=2D_out, v=2c, q0=F*a0-k*c and h_r=(q0+Fr)/v. All physical r=0,...,L-1 satisfy |h_r|<=1/4. F retains the OUTPUT normalization, including F16384 in the final source-D4096 band. Define

    P_b(h)=sum_(j=0)^n z'_j h^j,
    f(r)=P_b(h_r), d_j=Delta^j f(0), m=min(K,L).

Use an exact integer Newton initializer, not polynomial sampling. Its partial integer polynomial is

    J_i(r)=sum_(ell=0)^i a_(n-i+ell) v^(i-ell)(q0+Fr)^ell,
    J_i/(2^b v^i)=sum_(ell=0)^i z'_(n-i+ell) h_r^ell.

Thus I_j=Delta^j J_n(0) gives d_j=I_j/(2^b v^n). The index n-i+ell replaces 19-i+ell throughout. In particular z_0 enters only the last degree insertion at order zero. Old degree19 state widths or denominator v^19 must not be retained as if they were the new exact object.

For a normalized variant choose a proved common power 2^t dividing q0,F,v. Put q'=q0/2^t, F'=F/2^t, v'=v/2^t. Since F is a power of two, F'=2^delta. For each order set lambda_j=j*delta+nu2(j!). The normalized integer state is

    E_(i,j)=Delta^j J'_i(0)/2^lambda_j,
    d_j=E_(n,j)*2^lambda_j/(2^b v'^n).                (1)

This divisibility has a direct finite proof at every degree. Expand J'_i in r. Its coefficient of r^ell is divisible by F'^ell. Applying Delta^j at zero gives the integer factor j! S(ell,j), vanishing for ell<j. Hence every term contains j! F'^j. No c/F analytic guard is needed for this algebraic divisibility; a width bound still needs its own domain.

The partial recurrence after division by 2^lambda_j is the old one with n replacing19: the general term is (q'+jF')E_(i-1,j), the secondary term is oddpart(j)E_(i-1,j-1), and order zero inserts a_(n-i)v'^i. The top order has only its secondary term. Exact normalized traversal would add 2^(lambda_(j+1)-lambda_j)E_(j+1) to E_j. The rounded traversal below instead converts (1) to a COMMON dyadic grid first and then uses unshifted additions.

## 2. Rounded states, pruning and every live error

Let

    S_K(L)=sum_(j=0)^(m-1) binom(L-1,j),
    ell=bitlength(S_K(L)), p=b+ell+d, d in{0,1,2}.

S>=1 and S<2^ell. Round each of the m exact d_j to grid p, obtaining errors delta_j with |delta_j|<e_p=(3/4)2^-p. Store the resulting integer pairs M_j. At a physical advance update lower orders in ASCENDING order using exact integer addition. At position r retain only j<=min(n,L-1-r). No final round is fed back into this state.

Pascal's identity gives, at each retained state,

    2^-p M_j(r)-Delta^j f(r)
       =sum_(k=0)^min(r,n-j) binom(r,k)delta_(j+k).    (2)

All referenced j+k are below m: j+r<=L-1, and the degree restriction gives j+k<=n. Thus omitted initial high orders are never needed, even when L<K. Formula (2) is proved by induction with the ascending update order. Pruning only removes an order after its last dependency. It proves the uniform ALL-LIVE bound

    |error_j(r)| < beta_L := (3/4)2^-p S_K(L)
                             < (3/4)2^(-b-d).        (3)

This replaces the old u100/4 invariant. For example b93,d0 allows nearly96 u100, not u100/4. A raw sum of two live stored states needs the two true-state envelopes plus 2 beta_L. No old width may be reused just by changing its grid label.

At each required unit numerator, round M_0*2^-p to grid b, with complex error <e_b. Including the directly converted coefficients gives, relative to the original stored polynomial prefix,

    Eeval < e_b sum_(j<K)4^-j + beta_L + e_b
          =2^-b [1-4^-K +3/4 +(3/4)S_K(L)/2^(ell+d)]. (4)

This is an absolute triangle bound, requiring no independence of errors. For d0,1,2 the bracket is strictly below 5/2,17/8,31/16 respectively. In particular d0 at b100 is below8/3 u100. At smaller b only the full test in section4 authorizes evaluation. The analytic function is compared only at physical in-cell points. Any extra finite-polynomial support used to initialize differences carries no analytic accuracy claim.

## 3. Degree-dependent operation and capacity interface

There are n coefficient prescales per initializer and

    G_n(m)=sum_(i=1)^n min(i,m)=m(2n-m+1)/2

general complex products. The closed form also holds at m=n+1. With binary small-integer scaling, the initializer uses

    G_n(m)+sum_(j=1)^(m-1)(n-j+1)(popcount(j)-1) complex additions,
    sum_(j=1)^(m-1)(n-j+1)popcount(j) shifted operands.

Zero-distance operands remain typed references. Normalization changes scale factors and operand capacities, not these binary popcounts. Pruned traversal uses

    A_n(L)=sum_(r=0)^(L-2)min(n,L-1-r)
          = L(L-1)/2 if L<=K,
          = nL-n(n+1)/2 otherwise.

It visits ALL physical numerators, including nonunits. Only U actual unit outputs receive final rounds. Initialization requires m complex wide conversions. The K consumed coefficients need K direct complex conversions per distinct source/grid object; keeping a shared full converted twenty-slot cache costs twenty instead. Full source generation and twenty-slot delivery are unchanged in either case. No degree reduction is credited to source or translation work.

At L260 the metadata gives:

|K|n|bitlength S|General products|Initializer additions / shifted operands|Traversal additions|Initial complex rounds|
|---:|---:|---:|---:|---:|---:|---:|
|18|17|88|153|280 / 280|4267|18|
|19|18|92|171|317 / 317|4509|19|
|20|19|95|190|357 / 357|4750|20|

For widths, replace the old stagewise coefficient bounds by c_j=Z_j+e_b and use the actual tail c_(n-i),...,c_n. On retained all-cell supports an admissible true-state envelope is

    E_(i,j)=2^j sum_(ell=j)^i c_(n-i+ell)4^-ell.      (5)

Subtract the annihilated lower-degree polynomial before applying the alternating-binomial bound. For guarded support the accepted finite Stirling kernel gives instead

    E_(i,j)=sum_(ell=j)^i c_(n-i+ell)
               sum_(r=j)^ell binom(ell,r)4^(-(ell-r))sigma^r j! S(r,j),

with sigma=1/20 or1/40 under c>10F or c>20F. The positive kernel proof works for every i<=n<=19. General and secondary raw products have separate factors (1/4+j sigma)E_old,j and j sigma E_old,j-1. The all-cell versions retain factors1/4 and1/2 on the old envelopes, only where the retained supports are in-cell. Insertion uses its own c_(n-i), not a final global coefficient bound.

An exact normalized state has magnitude <2^b v'^i E_(i,j)/2^lambda_j. A rounded live state has magnitude <2^p(E_(n,j)+beta_L). A raw rounded update is bounded by 2^p(E_(n,j)+E_(n,j+1)+2beta_L). Assign strict signed power capacities from THESE rational bounds. Zero-capable cases require a zero proof rather than a negative digit count.

To perform initial conversion (1), its exact rational input is

    E_(n,j)*2^(p-b+lambda_j)/v'^n.                   (6)

Here p-b+lambda_j>=1. Cancel only an actually proved common power of two. The shifted numerator, rounded integer times the reduced denominator, residual and doubled residual all need separate capacities. A true initial difference bound E gives rounded numerator magnitude <2^p(E+e_p). The residual acceptance check is -D<=2(X-MD)<D. It requires the wide product and ordinary signed/range proofs m times, not U times. Normalization is not a license to price these at stored-state widths.

Final conversion has denominator2^(p-b), so it uses exact dyadic splitting and tie comparison rather than a general multiplication. A complete price model must retain source conversions, n prescales and power setup, general products at their partial widths, secondary shifts/additions, m wide conversions, A_n(L) narrow additions, U dyadic rounds, bindings, storage, cache lifetime and proof generation. The table is a count identity, not a runtime or total-cost comparison with Horner.

## 4. Complete alpha condition and bounded candidates

The accepted shorter-order source, independently reviewed at B15D0C3B, supplies

    T_K(V,D)=1266*((V+K)/(4D))^K/K!,
    S_first=1266*(15/16)^27/27!,
    S_final=1266*(5*7028/(8*4096))^28/28!,
    N_first=2532*2^-100+633*330*2^-110,
    N_final=844*2^-100.

The numerical N terms do NOT include the old1688u100 evaluation term. Replace that term by633 Eeval, rather than charging both. These are actual finite translated centers: true fine-derivative bias remains in S, and numerical source errors remain in N. Final per-coordinate eta already includes its delivered shift rounding. The first-four weighted error proof, rather than a false per-coordinate eta promise, is retained unchanged. Restricting to K coefficients only deletes nonnegative error terms.

The new admission test is

    T_K(V,D)+S_class+N_class+633 Eeval <2^-82.        (7)

The target remainder increases with |t|, so a band-top test covers the entire admitted absolute-height range, both signs and endpoints. All finite shifts keep their original bounds even when restricting the final requested height range. Nearest ties and clipped spatial endpoints remain inside the same Taylor segment. No off-domain height is admitted by metadata alone.

The receipt checks K18..20, b93..100 and d0..2, at all integer L1..260. It first computes the exact worst S/2^bitlength(S) over those260 lengths. For K18,19,20 the maxima are respectively262143/262144 atL19,524287/524288 atL20 and1048575/1048576 atL21. Thus each listed alpha test is uniform in L, not a successful sample atL260. The finite exhaustive maximum is not extrapolated to unbounded L.

Useful admissible rows are:

|Domain|V|D_out|K|b|d|Maximum p|Strict alpha ratio upper bound|
|---|---:|---:|---:|---:|---:|---:|---:|
|Band1|500|512|19|93|2|187|944694/10^6|
|Band1 alternative|500|512|20|93|0|188|884695/10^6|
|Band2|1000|1024|19|93|1|186|932496/10^6|
|Band3|2000|2048|19|93|1|186|905299/10^6|
|Band4|5000|4096|20|93|1|189|899465/10^6|
|Band5 declared|7000|8192|19|93|0|185|927744/10^6|
|Band5 actual requests|424195/64|8192|18|94|0|182|854224/10^6|

The last domain is84839*5/64 and includes the existing main/+167/+320/+640 endpoints. It does not replace the declared7000 contract for other consumers. At all six domains b100,d0 reproduces the old evaluation cap whenever the shorter-order target is admissible. Some K18/19 band-top tests fail for every bounded b,d because their sufficient Taylor bound is too large; no impossibility of a better approximation follows.

The choices trade degree, coefficient grid and initial grid. For example retaining K20 at the first band allows d0 rather than d2, but increases initializer/traversal work. No minimizer under a full arithmetic objective is claimed. This is not a new profile DP.

## 5. Grid100 export and shared objects

A final coordinate M/2^b is re-encoded exactly as (M*2^(100-b))/2^100. Charge two coordinate shifts per complex unit output, with sign, range, source label and consumer binding. A canonical dyadic representation can avoid materialization only with its own proved consumer interface and cost. Re-encoding contributes no rounding error and restores no lost accuracy. The accepted radius is (7), not the old computed center or the stronger old final .16*2^-82 radius. New sign tests and completeness data remain necessary.

Common source conversion can be shared only for the same directly converted ORIGINAL coefficient, target b, tie convention, normalization, source/height/anchor label and retained proof object. Uniform-b Horner can share that object. A nonuniform degree-grid Horner cannot be charged the same cache unless the individual grids match. Re-rounding an existing b100 center to b93 is not silently the direct original-center conversion: double rounding may change a tie and adds an error unless separately proved. A shared twenty-slot conversion cache is legitimate but costs twenty conversions per new object, even when this evaluator consumes K. An independently built prefix cache costs K and requires its own identity and lifetime. Conversions and storage do not vanish because the original source still delivers twenty entries.

For mixed evaluators, the per-cell bounds may be combined through the same absolute character weights. Only a valid common upper radius or the actual weighted sum may be used. Neither every cell's best cost nor every cell's smallest error can be selected independently of the actual bound circuit. Nonunits still participate in FD traversal, and unit-only output counts must remain actual metadata.

## 6. Evidence

Owned script variable_degree_rounded_fd_20261111.py, SHA256 E967C5E2FF96D907239A24C8A8D6A4205F1A89FA462A00B54E406C16B666457F; JSON82C2BDAC4E313A18A90799957DDA04E2BB96FBB9FE2B62208D4714E9FED1B143. It records780 length/count rows,432 uniform-length alpha candidates, their exact rational margins and54 least-b summaries. All17744 exact assertions pass. Only finite integers/rationals and source hashes are used; no coefficients or analytic functions are evaluated.

Eight complete pins are checked in the receipt. The primary shorter-order proof is0EAED4F9 and reviewB15D0C3B. The joint Horner alpha contract AEAB2BDC/review84B06243 supplies the matched finite-vector, error and grid100 comparison. Stagewise61A6DD47/reviewF8A063A5 supplies the positive finite kernels. Rounded initializationFB0B0F9A/reviewB493A996 supplies the original Pascal and ordinary conversion contracts, explicitly strengthened and re-instantiated here rather than inherited at their old errors or degree. Independent review is required before adoption; no concrete ordinary proof records, output values or global operation inventory are supplied.
