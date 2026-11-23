# Independent review of the m224 joint seed refinement

2026-11-11. **PASS for the conditional paper refinement and exact work ledger. No correction requested.** Reducing the joint construction from256 to224 corrections preserves the stated error interface at unchanged V7000, D4096, N1500 and P28. The specified loop schedule removes work without increasing another listed operation category. This does not establish generated coefficients, a runtime comparison between arbitrary implementations, or kernel acceptance.

## Frozen objects and method

| Object | SHA256 |
|---|---|
| work/qrh-blueprint/JOINT_SEED_224_CORRECTIONS_2026-11-11.md | E438F4EF3AEC8352947B046E55C07418D9DA233B5E602B6FEF5CB402600F61F5 |
| work/qrh-blueprint/check_joint_seed_m224_20261111.py | 516682375632EFEEAE27B7B7C46E8BBA29897C58D291FBB393502568E1043855 |
| work/qrh-blueprint/joint_seed_m224_20261111.json | AD11383DC11823F6D8178720EFF843424B8F0722AC7F6164B8A54E01896876BB |
| Predecessor joint construction | AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F |
| Independent predecessor review | 2F057C0F2507452AC959587E13FD1AE8F9117FC75CBC3BA1C6364E8C5BF0064A |

I read the complete proposal and checker and compared the changed formulas with the previously reviewed finite EM, rounding and output contracts. My independent `work/qrh-campaign/agents/audit/review_joint_seed_m224_20261111.py`, SHA256 `57B5EF3F32BEC5716B9CB800802B55C8CFC4C232BC890A4C206E6285B43CED61`, passed640 exact checks. Its same-stem JSON has SHA256 `843045293E8DB9B760F942866263FFCAADBA2DF563175107905C122C564089A0`. The checks include all six bound input hashes, all28 coefficient remainders, E-error propagation through the new maximum index, final errors and four prefix savings. No producer was imported or run, and no analytic value or build was evaluated. Frozen predecessors are unchanged.

## Finite EM semantics and the sharper remainder

The target is still the actual continued-Hurwitz coefficient `(-1)^k(s)_k zeta(s+k,1+a)/(4096^k k!)`, for s=1/2+it, |t|<=7000, a in[0,1] and0<=k<28. The finite EM identity is valid at every positive integer m under `Re(s+k)+2m>1`. At m224 the endpoint b remains in[1501,1502], and `|s+k-1|>=1/2`. The head, pole-type and half terms therefore retain both their values and their domain proofs.

The rising products in the coefficient and remainder join into `(s)_(k+448)`. W7480 bounds every factor. The actual rational contraction ratio is `7480/9006`, and the scaled order factor is `7480/(1501*4096)<1`. Consequently the common remainder is

`R=(12016/895)*(7480/9006)^448`.

The independent check proves R<2^-116 by the integer inequality

`12016*7480^448*2^116 < 895*9006^448`.

It also checks every k-dependent envelope before replacing its denominator and scaled factorial term by their common bounds. No floating logarithm or exponent estimate is used. At k0 the common bound is attained as an upper expression, so non-strict comparison there is correct.

Using17/20 before exponentiation is unnecessary and loses the margin. The new proof uses the sharper ratio only for the remainder; it legitimately retains17/20 as a simpler recurrence bound. This is a fresh remainder estimate for a different finite approximation, not an assertion that deleting signed correction terms reduces the actual error monotonically.

## Inherited rounding and output contracts

E now stops at index474, with final update index473. All retained factors satisfy the old contraction bound17/20, so the old7u E-error allowance remains valid. R and lambda are unchanged and retain8u and2u. Each rounded correction product still costs at most31u;224 terms cost6944u, below the retained7936u allowance.

The true correction norm is bounded by the same absolute geometric series. No claim that the norm of a shorter signed sum is below that of a longer signed sum is needed. Thus the old Z, F, endpoint and head bounds remain valid. With the newly proved R, the actual combined bound is still

`e_seed<=10507delta+278753u+R<.107eta`,

where delta=2^-118, u=2^-122 and eta=2^-100. I checked this value and the saved ratio to eta exactly. The full translated numerical radius `2e_seed+351*2^-110` remains below.557eta. The intermediate perturbation and magnitude checks also retain their previous slack.

The final Q8192 scaling, all28 right-endpoint source coefficients, three signed translations and16385 fine output anchors are unchanged. Therefore the previous exact finite-polynomial identity and error-injection proof apply. The two actual-function Taylor errors and final Horner error are unchanged; their sum with844eta and1688eta remains below.16*2^-82. The eta output radius is still relative to the finite translated polynomial, with its analytic bias charged separately. New centers are not asserted to equal or lie in old immutable enclosures.

## Work removed and remaining scope

There are114716 source slots and4097 coarse endpoints per final height. The deleted32 corrections remove3670912 gamma products and the same number of additions. Shortening each E recurrence by64 stages removes262208 stages. The retained per-height counts are25696384 gamma terms and1941978 E stages. All four prefix savings reproduce:

| Final heights | Gamma products or additions saved | E stages saved |
|---:|---:|---:|
|20199|74148751488|5296339392|
|20366|74761793792|5340128128|
|20519|75323443328|5380245952|
|20839|76498135168|5464152512|

Gamma constants1 through224 are the same exact targets as the corresponding prefix of the old table. Construction through Bernoulli index448 suffices, leaving160 new constants beyond the original64. The proof and representation costs of this construction remain real work. The refinement does not require new elementary arguments, phase initializations, precision, output translations or transforms. The7049217-point union and6148097 final active states retain the reviewed shrinking-grid lifetime contract.

The operation-deletion statement is valid for the specified direct finite-sum/recurrence implementation. It is not a universal runtime ordering, a proof that224 is optimal, or a price for the new analytic acceptance proof. All actual elementary, arithmetic and spectral certificates, source formalization and end-to-end ordinary Lean/MM0 checking remain outside this paper refinement.
