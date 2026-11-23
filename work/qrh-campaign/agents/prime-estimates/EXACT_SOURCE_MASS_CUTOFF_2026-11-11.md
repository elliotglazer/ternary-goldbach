# Existing finite mass checkpoints permit R=132900

2026-11-11. Source/paper and exact rational-scalar research. This keeps the original finite-RH joint-final-margin recipe and N0=989*10^24 unchanged, replacing only its deliberately coarse logarithmic mass loss. No prime, factor, zero or analytic-function values were computed; no Lean build or source edit was made. The scalar script uses finite rational log/root enclosures already present in the accepted recipe.

## Result

The source already contains exact lower checkpoints for the needed finite sum. They remove the need for a new tail certificate in this bounded search. Using the source checkpoint at 132000, monotonicity alone proves a sufficient mass lower bound at **R=132900**. All nine finite scale-cell budgets, the asymptotic budget and every retained domain/sign/base-gap guard pass. The exact final normalized coefficient is

    17454234627055702473150105611895106422794893597
    /12867056213564954145112500000000000000000000000000
      > .0013565.

This is a conditional paper improvement from the reviewed R135000 recipe, not an adopted cutoff or a proved finite-RH input. It reduces the permitted conductor indices while leaving their required heights and the principal inputs unchanged. It does not preserve the old separately rounded minor bound1.0376; the accepted joint major-minus-minor-minus-nonprime argument remains the final consumer.

## 1. Actual finite sum and exact tail identity

Write m(q)=(if Squarefree q then1 else0)/phi(q), the actual `MajorArcs/SumMuPhi.mPhi:20`. `moebius_sq_eq:22` identifies its numerator with mu(q)^2. For natural R>=1 put

    S(R)=sum_(1<=q<=R, q odd) m(q),
    M(R)=sum_(q in Qset(R:real)) m(q).

`SmallMuPhi.S:160` is exactly S. `LargeSieveArcs.Qset:34` uses floor(2R) and q-tilde<=2R, not every modulus below2R. Generalizing the existing proof `SumMuPhi.sum_Qset_mPhi:69--106` from150000 to natural R gives

    M(R)=2S(R).

The odd part of Qset is the odd q<=R. The even part is the injective image q=2k with1<=k<=R. `mPhi_two_mul:49--66` gives m(2k)=m(k) for odd k and zero otherwise. Natural-to-real casts give floor(2R)=2R. This proof does not require R even, although all tested cutoffs are even.

For U=150000 and R<=U, splitting the finite interval therefore gives the exact identity

    M(R)=M(U)-2*sum_(R<q<=U, q odd) mu(q)^2/phi(q).

The lower endpoint is strict. A certified **upper** tail can be subtracted from the existing **lower** full mass13.597558. Subtracting two lower masses is not an upper-tail proof. This establishes the requested tail interface, but the direct checkpoint route below is both stronger and smaller here.

## 2. Reuse the actual source certificates

`SmallMuPhi.Lt:102` is the integer sum of floor(10^18/phi(q)) over the odd squarefree q<=K. `S_approx:163--202` proves for every K

    Lt(K) <= 10^18*S(K) <= Lt(K)+K.

The same file's `phiTD_spec:35--98` proves the finite trial-division result under its no-smaller-prime-factor invariant; `walkS_spec:128--157` proves each state transition. The closed w_k declarations use `decide +kernel`; c_k then identifies Lt(1000k) with its stated integer. This is evidence of existing proof source, not a fresh build/axiom audit in this task.

The only checkpoint integers used in the selected search are:

| K | Lt(K) | source declaration/line |
|---:|---:|---|
|132000|6734875660393277758|c_132:485|
|133000|6738638775247437262|c_133:486|
|134000|6742390657824783779|c_134:487|
|135000|6746060703792373515|c_135:488|

At a coarse cutoff R these imply M(R)>=2Lt(R)/10^18. At the one refinement R132900, use S(132000)<=S(132900), since the extra terms are nonnegative and the filtered finite sets are nested. Thus no new 900-step walk is needed:

    M(132900) >= 2Lt(132000)/10^18
       =3367437830196638879/250000000000000000.

This is intentionally weaker than the unknown exact mass at132900. The needed new monotonicity adapter is a finite sum inclusion with nonnegative terms, not a new numerical premise. q=0 is absent; for every included q, phi(q)>0. The floor/cast identity and the generic Qset pairing are the remaining formal adapters.

For comparison, an upper tail could also be obtained without new factors as

    2*(Lt(150000)-Lt(K)+150000)/10^18,

using both sides of S_approx. The direct lower checkpoint avoids losing the precision of the rounded full lower mass. Neither source reuse automatically changes any mass **upper** bound used elsewhere.

## 3. Unchanged analytical and numerical consumption

The scalar engine is copied from the accepted `original_rh_joint_cutoff_20261111.py`. A run-time source check verifies its original hash and verifies that the entire copied function/parameter region differs only in the mass-assignment line. The nine cells are parsed from their bounded source declaration regions, with the same expected Y list and source hashes as the accepted engine. The new mass line is

    mass=2*Lt(1000*floor(R/1000))/10^18.

Everything else stays:

    jfull=.638108*mass-.00108,
    j=(jfull-100001*8e-11)/1.00001,
    singular=2*(.6606*(1-1/199)-22.1/R),
    major=.800689*singular-original_major_error,
    Ucell=G_Y(R)*(cl0*sD-j)+sD*old_chain+old_tail,
    minorcell=1.0005*Ucell+2001*22.75*8e-11.

The original major-error expression,13.59756 upper mass,8.79 upper energy,300000 cardinal bound, original sig, all large-sieve chain and tail terms remain. The singular Rankin loss22.1/R is a different sum and is not replaced by the mass calculation.

The accepted uniform nonprime allowance is still

    20618162523/7784250095800 < .002648703,

and the final passing predicate is positive `major-minor-nonprime` for all nine cells and the asymptotic branch. It retains positive mass/J/I/singular/major, positive `cl0*sD-j` in every finite cell, the positive asymptotic base coefficient, and basegap<.014<.03<ghat. Rechecking the coefficient signs matters: increasing j is helpful only after the multiplication by an upper enclosure for G has the right sign.

At R132900 the lower I bound is

    537129254732779210450233/62500625000000000000000,

and the base-gap upper is44867959657/3322500000000<.0135043. Cell0 controls. The other eight finite margins exceed .02317, and the asymptotic margin exceeds .2729. These are bounds from the retained recipe, not evaluations of the actual integrals.

## 4. Bounded search and failure retention

The search began at135000, decreased by1000 and stopped at the first failure132000. It then evaluated **exactly one** refinement,132900, using the preceding132000 checkpoint. No additional factor metadata or fine cutoff search was generated.

| R | mass checkpoint | final margin interval | result |
|---:|---:|---|---|
|135000|135000|(.0069671,.0069672)|pass|
|134000|134000|(.0044440,.0044441)|pass|
|133000|133000|(.0018882,.0018883)|pass|
|132000|132000|(-.0006967,-.0006966)|fail|
|132900|132000|(.0013565,.0013566)|pass|

Intervals enclose the exact rational margins. The failed row is retained. It fails the controlling final scalar budget, not the underlying Goldbach statement or every possible sharper proof.132900 is the smallest demonstrated cutoff in this bounded test, not an optimum.

The inherited threshold argument gives x>4.9e26 for N>=N0=989*10^24, including N=N0. The finite cells cover the same full x-domain, and the final representation extraction and finite/analytic overlap remain unchanged. There is no new prime ladder or increased binary threshold hidden in this parameter change.

The localized original finite-RH family becomes primitive characters with odd c<=132900 or4|c<=265800, at the same original inclusive heights1e8/c and max(1e8/c,200+7.5e7/c), respectively. Inverses and principal inputs remain as before. This removes2100 eligible nonprincipal conductor indices compared with R135000; it is not a count of characters, zeros or runtime. The actual spectrum still has to be certified, and the localized arc/source interfaces still require formal implementation.

## 5. Certificate cost and why no new tail computation is selected

This result consumes existing c_132..c_135 and S_approx. The selected refinement uses monotonicity, so it adds no numerical walk. Current SmallMuPhi imports Mathlib and contains the full state chain. In its file order all150 closed w_i computations precede the c_i chain, so truncating the file at c_132 would not avoid the later w_i computations. Reuse avoids new discovery/data, but compiling or importing the existing proof closure is not cost-free or newly timed here.

If a later refinement really needs a new tail certificate, a compact alternative at R132900 would cover exactly8550 odd positions R<q<=150000. With D=2^64, a squarefree position of totient t can supply the exact ceiling n_q=ceil(2D/t), checked by `(n_q-1)*t<2D<=n_q*t`; a nonsquarefree position supplies a square-divisor witness. The sum of n_q divided by D is an upper tail, with rounding excess at most8550/D<2^-50. Every position, factor/squarefree assertion and totient must be proved. An external factorizer label alone is not enough.

The source phiTD alternative checks odd trial divisors through387, with at most193 possible odd divisibility tests per input before the square-root bound terminates. For the tail this is at most1,650,150 such tests as a coarse work count, not a kernel time. Values q,t have at most18 bits; a crude n_q bound has66 bits and the positive raw products at most84 bits. Summing8550 such ceilings needs at most79 bits. These bounds are cheap compared with unbounded rational common denominators, but no such new certificate was produced because the existing checkpoint already suffices.

## Frozen evidence

* New script `source_mass_joint_cutoff_20261111.py`: F243DD01285D8FA78F72A38AFFF1F2842436D4110F1E7B616B2111DB6712488A.
* New receipt `source_mass_joint_cutoff_20261111.json`:67F6C3BAE93EDE7BD93C49A4EC8B442671A921D9E71B5AEC4925031261984FC9.
* Existing joint engine:3B0656B83852FAA44D7943FE432C5DEE81730E5535C75AD295E4396463330171.
* Existing joint note:838F651558DF63A1AE44128A2A5B3F44FD64D4470871A5FC044355CE2BB174C5; independent review:E838CE3DD41415A29840E32C9B568792986A3A5D3E91DDDD6ED1F296170D796D.
* `Prelim/SmallMuPhi.lean`:7ECE1D48D9679ECF529A5566C79D06FADB3CA70CCAF057ADAA020D6AA390BADF.
* `MajorArcs/SumMuPhi.lean`:7AC4662598355DDA40720B43956223BD3C5456D503B206A77D48E4569ADE18A4.
* Parallel source-interface audit `integration/EXACT_MASS_TAIL_SOURCE_JOIN_2026-11-11.md`:7BCBA7142E2B069ABEFB3F1FD6490DE00F3BFCEC0E4D6FAC1140DB88F048DE8E.

The receipt records the source NumericsCells hash and each parsed declaration section. All finite source and spectral claims remain at their existing proof status; this task supplies a source-faithful scalar improvement and its exact remaining adapters, not a kernel-validated end theorem.
