# Mixed-radix character transforms on the unchanged coarse grid

2026-11-11. Integer-only conductor, factor, index and operation inventory; no character values, FFT values, L-functions, zeros, analytic evaluations or builds. The previous reports are unchanged. This replaces their deliberately conservative whole-axis Bluestein circuit with a specified mixed-radix circuit. It does not claim an improvement over Platt's actual optimized executable or a measured runtime saving.

For the large-conductor schedule c>10000, the new circuit uses .621939–.621940 times the general complex multiplications and .550472–.550473 times the complex additions of the old circuit, after recognizing the same exact cheap roots in both. Every conductor, coarse height and transform output is retained. No saving below comes from primitive pruning, interpolation, lower precision or a smaller spectral domain.

## 1. Exact transformation and factor identity

The required character transform is positive and unnormalized. On one cyclic unit-group axis of length n write

    D_n(x)_k = sum_(j=0)^(n-1) x_j exp(2pi i jk/n).

For n=rm, use input j=a+r b with 0<=a<r, 0<=b<m and output k=v+m u with 0<=v<m, 0<=u<r. The exponent identity is

    jk/n = bv/m + au/r + av/n + bu.

Hence compute r length-m transforms, multiply their(a,v) outputs by exp(2pi i av/n), then compute m length-r transforms and place output(u,v) at v+m u. This proves the Cooley–Tukey step directly by finite distributivity. The cross factors are essential; factoring a cyclic axis is not the same as replacing it by a product-group transform without those factors.

Across the existing CRT unit-group axes, apply the axis transforms independently as in the accepted manifest. There are v/m_i lines of length m_i, where v=phi(c). That outer product decomposition has no new cross twiddles. It must preserve the manifest's coordinate order and positive character labels. A negative DFT returns the inverse label and is not substituted silently.

These are unnormalized transforms throughout. A library normalized positive transform would require multiplication by the axis length, and by v for the full character transform. The existing final L-function conductor/phase factors are unchanged. The finite identities do not depend on primitivity; all v outputs are computed before primitive filtering.

The source architecture is consistent with the pinned FLINT cyclic factor decomposition, its explicit cross-twiddle step, and its separate product-group routine. Our cost rules below are a separately specified circuit, not an instruction-level audit of those routines. [FLINT v3.6 cyclic setup](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dft/cyc.c), [factor step](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dft/step.c), [product group](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dft/prod.c).

## 2. Operation categories

Each count vector is(G,A,Q,N,S): general complex products, complex additions/subtractions, quarter-turn operations, sign negations, and exact dyadic scalings. A quarter turn exchanges real/imaginary coordinates with a sign. Its cost is not identified with a general product. Each complex addition contains two real additions; a schoolbook complex product contains four real products and two real additions, though a selected backend can choose another proved circuit. No category is assigned a time constant here.

For n=2^k>=2, a standard radix-two transform has

    A=nk,
    G=nk/2-3n/2+2,
    Q=n/2-1,
    N=S=0.                                                (1)

At each stage the butterfly adds and subtracts once. Of the nk/2 twiddles, n-1 are1 and n/2-1 are quarter turns; the rest are general. Subtraction already includes its sign, so it is not charged again as a separate negation. At n=1 all counts vanish. Both compared circuits use(1), so the comparison does not create savings merely by recognizing cheap radix-two roots in the new circuit. [Radix-two source pattern](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dft/rad2.c).

For an odd prime r<=11 use a direct transform. Its count is

    G=(r-1)^2, A=r(r-1), Q=N=S=0.                           (2)

The zero row and zero input column have coefficient1. Every other root is nontrivial and is conservatively charged as a general product. The special r=2 case is already(1). No optimized radix-three/five trigonometric circuit is assumed.

For a factor step n=rm, the nonidentity cross-twiddles are indexed by1<=a<r,1<=v<m. Their product av lies strictly between0 and n. The only cheap possibilities have av=n/4,n/2,3n/4. Count the first and third as Q, the second as N, and all remaining pairs as G. There is no addition in this multiplication step. Thus

    C_CT(n;r,m)=r C(m)+m C(r)+C_twiddle(r,m).              (3)

The companion counts the cheap solutions by exact divisibility, not by approximate angles.

For a Bluestein transform of length n, set P=nextPowerOfTwo(2n-1) and zeta=exp(pi i/n). The exact identity

    exp(2pi i jk/n)=zeta^(j^2) zeta^(k^2) zeta^(-(j-k)^2)

reduces the transform to a padded convolution. Cache the kernel transform once per n and precision. Each input then uses two length-P transforms, P general point products, and two length-n chirp multiplications. One inverse transform includes division by P, charged as P dyadic scalings. The kernel FFT is setup, not per-input work. [Bluestein source pattern](https://raw.githubusercontent.com/flintlib/flint/v3.6.0/src/acb_dft/bluestein.c).

For fair comparison, classify chirps cheaply in both circuits. The j-th chirp is a fourth root exactly when n divides2j^2. Put d=product_p p^ceil(v_p(n/gcd(n,2))/2). These j are exactly the multiples of d in[0,n). Their quarter-turn index is(2j^2/n) mod4. If g,q,z are respectively the general, quarter-turn and negative chirp counts, then the per-input count is

    C_Blue(n)=2 C_radix2(P)+(P+2g,0,2q,2z,P).             (4)

The unnormalized transform produced by(4) is exactly D_n. Only the internal convolution inverse divides by P; no extra 1/n appears.

## 3. Fixed selection rule and arithmetic proof obligations

The old schedule uses radix two for a power-of-two axis and Bluestein for every other whole axis. The new schedule is deterministic:

1. Retain radix two at powers of two.
2. Use(2) at prime lengths3,5,7,11; use Bluestein at larger prime lengths.
3. At a composite n, take its smallest prime factor r and m=n/r, use recursively selected children, and form(3).
4. Select that split only if neither G nor A exceeds the old whole-axis Bluestein count; otherwise retain Bluestein.

This is a componentwise-safe fixed rule for the two main categories, not a globally optimal schedule. It does not optimize all factor orders, Rader transforms, prime radices, coprime Good–Thomas permutations or all rounding costs. The metadata reports all five categories, including any change in the cheap ones. Its active trees use30625 composite splits,6472 Bluestein leaf lengths,16 radix-two lengths and four direct prime lengths.

Exact index identities are only the algebraic part of a checked implementation. It must also certify root boxes, products, sums, exact permutations, omitted identity roots and all rounding. For normalized transforms, a child input-error bound is nonexpansive in the sup norm, but twiddle approximation contributes its radius times the actual input magnitude. For unnormalized transforms, the corresponding factors r,m accumulate. The previous all-radix-two error formula cannot simply be copied onto this mixed circuit.

One sound route is outward dyadic gate checking with the finite identity as the refinement theorem. Another is a separately proved per-node error recurrence that retains child input error, twiddle error and arithmetic error. Either way, general-product counts alone do not prove sufficient precision. Bluestein's padded intermediate sums can have larger magnitudes than the final transform; changing the factorization changes this conditioning. This report performs no value or precision experiment.

## 4. Same family and same coarse data

The inventory uses precisely the preceding reduced original-RH domain: odd3<=c<=150000, and4|c<=300000. Heights are10^8/c for odd c and for even c<=125000; otherwise200+75000000/c. The nominal positive coarse grid is j*(5/64), with J_c=ceil(64H(c)/5)+1. All v outputs of each conductor transform are produced; the cost sum is

    sum_c J_c sum_i (phi(c)/m_i) C(m_i).                  (5)

The large-conductor portion c>10000 retains142500 conductors,5525163079 primitive labels,114223068442718 coarse residue inputs and75730502011007 coarse primitive output slots. These checks match the frozen earlier receipt. None is a count of proved zeros or of ordinary interpolated sign nodes.

| Large-conductor operation category | Whole-axis Bluestein baseline | Mixed schedule |
|---|---:|---:|
|General complex products|4890157406463512|3041383327064694|
|Complex additions/subtractions|11446911736111484|6301213142003526|
|Quarter turns|587381965694890|279797486233036|
|Sign negations|2976648965674|66590728284|
|Dyadic scalings|577076958982144|271405257746112|

The product ratio is in[.621939,.621940] and the addition ratio in[.550472,.550473]. The earlier report's butterfly baseline is recovered exactly: its5723455868055742 butterflies give11446911736111484 additions here. Its extra chirp/convolution products were conservatively all charged alike; equations(1)/(4) now split their exact cheap roots identically on both sides.

Across all149999 nonprincipal conductors, if the same coarse character-transform schedule is used even in the small-conductor range, G drops from5091240938712754 to3157484248352030 and A from11929051626767334 to6538134689270588. That is an alternative inventory only. The preceding hybrid design may instead use theta/time transforms below its selected conductor switch, so these all-conductor totals must not be added to that small-conductor cost.

## 5. Where the savings occur

| Conductor and unit axes | G old | G mixed | A old | A mixed |
|---|---:|---:|---:|---:|
|10007: [10006]|445996|418234|983040|927510|
|100003: [100002]|4394308|4182168|9437184|9012898|
|150000: [2,4,2,2500]|1520256|640000|3567872|880000|
|262144: [2,65536]|851972|851972|2228224|2228224|
|300000: [2,8,2,2500]|3060512|1300000|7215744|1840000|

Power-of-two axes were already inexpensive and do not improve. An axis containing a large residual prime gains less. Smooth composite axes avoid the padding and repeated convolution transforms of whole-axis Bluestein. This is a concrete circuit effect, separate from the declared-domain reduction and from the ratio of primitive to imprimitive outputs.

The cached Bluestein setup changes too. The old schedule needs13927 distinct non-power-of-two whole-axis kernels; the new schedule needs6472 residual kernels. Their aggregate padded kernel entries drop from2885817744 to382342624. The largest padded Bluestein length drops from524288 to262144. These are storage/circuit parameters, not a peak-RAM measurement or a guarantee that all kernels should coexist in memory.

The new cross-twiddle tables are not free. Materializing a full root table for every active composite node would have at most1436913503 entries, plus direct-prime roots and shared radix-two roots. This is a deliberately loose setup bound; only required phases need be generated, and roots can be shared or streamed. Any optimized root-generation method still needs its exact argument and rounding proof. Setup is repeated when a new precision requires tighter root enclosures. Ignoring cross-twiddle generation would overstate the gain from the smaller Bluestein cache.

Permutations and data movement are also required. Each factor step reads the same n complex inputs, reorders child lines and places n outputs. A simple gather/reorder implementation performs O(n) moves per step and uses a temporary array. The inventory does not price memory traffic or fuse stages. No argument here shows that the lowest G count minimizes wall time or checker memory.

## 6. Effect on the complete checker

The Hurwitz seed and alpha-contraction work, coarse input enclosures, root/Hardy normalization, primitive/inverse manifest, ordinary interpolation, exceptional repairs and Turing/count assembly are unchanged. Replacing the character circuit affects only its checked arithmetic and setup. If U denotes all other work, the correct comparison is

    [U + setup_mixed + cost(C_mixed)]
      / [U + setup_old + cost(C_old)].

It is not the general-product ratio alone. Actual integer operand sizes, guard precision, arithmetic backend and memory costs remain inputs to cost(C). This is especially relevant after selected-sign checking removes unnecessary interpolation outputs: the unchanged coarse source and character transforms may form a larger fraction of the retained proof DAG.

Every sign used by the certificate still needs the same source-function enclosure. There is no weaker acceptance threshold, assumed zero location, deletion of inverse channels, or change to inclusive heights. The deterministic factor schedule can be generated as untrusted metadata and checked with integer multiplication/divisibility and the finite transform refinement. Its coefficients and output values remain to be produced and checked in a future authorized implementation.

## 7. Reproducibility and scope of verification

`mixed_radix_character_inventory_20261111.py` uses an integer smallest-factor table to derive the conductor unit axes and circuit trees. It writes the same-named JSON. It imports no evaluator and performs no transform. The298 structural checks cover the exponent identity and cheap cross-twiddle counts at100 small factor pairs, and chirp classifications at98 lengths. They support the implementation; the general proof is the finite algebra and divisibility argument above.

The JSON contains every conductor-range total, selected examples, exact ratio enclosures, setup counts and a SHA256 of the deterministic active-plan serialization. The complete serialization can be regenerated from the script; the hash is an identity check, not mathematical evidence. No historical source executable or benchmark was run.

The unchanged input report is `REDUCED_NONPRINCIPAL_PLATT_COST_MODEL_2026-11-11.md`, SHA256 `B3718D22BE11EBE5503EB2124E0B690D49B428E0000D5CD763317367ADB60AFC`; its metadata receipt is `6F661E61A212D3F65C24625E6A211DCC0494853BDD3D875162E8521E306F296F`. This supplement demonstrates removable arithmetic in that explicit baseline. It does not supply a production spectral certificate, a formal FFT implementation, a runtime forecast, or proof of optimality.
