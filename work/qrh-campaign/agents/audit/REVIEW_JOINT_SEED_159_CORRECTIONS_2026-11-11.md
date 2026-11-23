# Independent review of the Euclidean m159 seed refinement

2026-11-11. **PASS at conditional paper and exact-metadata scope. No correction requested.** The Euclidean rising-factor bound permits m159 at unchanged V7000, D4096, N1500 and P28. The inherited source, translated-output and isolated-alpha bounds remain valid. No actual function values, runtime result or kernel acceptance follow from this review.

## Frozen evidence

| Object | SHA256 |
|---|---|
| work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md | E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9 |
| work/qrh-blueprint/check_joint_seed_m159_20261111.py | 7F0B7BD1C597629D6DBD687730E767C5CB660286F6B5CBA57599EF24757E84A4 |
| work/qrh-blueprint/joint_seed_m159_20261111.json | EF16593CF667377CD68CA9D3C37343E3364ECA06CABACCC9B8465931E2D83D45 |
| m224 author / independent review | E438F4EF3AEC8352947B046E55C07418D9DA233B5E602B6FEF5CB402600F61F5 / 7A74329B1D51F9E0113ECB76DC68DC1DC7F4182EAF29209DE47CE068EF84D888 |
| Original joint author / independent review | AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F / 2F057C0F2507452AC959587E13FD1AE8F9117FC75CBC3BA1C6364E8C5BF0064A |

I read the full supplement and checker and compared their changes with the reviewed joint finite EM identity. All seven pins match. The independent script `work/qrh-campaign/agents/audit/review_joint_seed_m159_20261111.py`, SHA256 `08CC57F6F480FA3BF76AA4F2B85FEB3EE79F7C62C5E77E90EBEA9AC0F178BF33`, passed773 exact checks. Its same-stem receipt has SHA256 `7A021A9A6FEC6341DDAABBBC173A28A480DE98A6D93FFA42572D086F17E8BE7E`. It imports no producer or evaluator. No build, analytic evaluation or frozen-file edit occurred.

## Factor range and actual remainder

The actual scaled coefficient remains `(-1)^k(s)_k zeta(s+k,1+a)/(4096^k k!)`, with s=1/2+it, |t|<=7000, a in[0,1] and0<=k<=27. The two rising products combine into `(s)_(k+318)`. Its final factor index is k+317, at most344. Therefore every factor has real part at most344.5 and squared norm at most

`7000^2+(689/2)^2 < 7009^2`.

The independent check verifies the corresponding integer inequality for every factor index0 through344. This bound relies on the stated critical-line real part; it is not an assertion for arbitrary complex s. Separately, b in[1501,1502] implies sqrt(b)<39 because1502<1521.

The finite EM domain is unchanged: b>0, `Re(s+k)+318>1` and `|s+k-1|>=1/2`, including k=t=0. Thus its pole-type and half terms stay present. The all-order periodic-Bernoulli estimate gives exactly

`error_k <=156/(k+317.5) * (7009/(1501*4096))^k/k! * (7009/9006)^318`.

The scaled order factor is below one, and its factorial and denominator only improve the bound. Hence the common R is `(312/635)*(7009/9006)^318`. I verified every order and checked R<2^-116 by the integer comparison

`312*7009^318*2^116 < 635*9006^318`.

This is a finite remainder estimate. It uses neither a floating logarithm nor convergence of an infinite EM expansion.

## Inherited errors and exact output

The E recurrence ends at index344, and its last multiplicative factor is s+343. Both are covered by the stronger remainder-product bound. Since7009/9006<17/20, the previous E7u allowance is conservative; I also checked its finite error recurrence through every retained index. R8u and lambda2u do not change. The correction product error sum is now31*159u=4929u, below7936u. The same absolute geometric series controls correction magnitude. This does not assume that deleting signed terms decreases the norm of the actual finite sum.

The resulting inherited bound `10507delta+278753u+R` is below.107eta. Its translated numerical output bound `2e_seed+351*2^-110` is below.557eta. The intermediate perturbation bound and stored magnitude cap also pass. The two analytic Taylor bounds, Q8192 normalization, all28 source coefficients at every endpoint,16385 fine anchors and final P20 Horner evaluation are unchanged. Adding the analytic translation bias separately still gives the complete isolated-alpha bound below.16*2^-82.

New finite-EM and output centers may differ from their predecessors. The numerical coefficient radius is not claimed to absorb the analytic translation bias or to enclose old centers.

## Work and remaining obligations

The retained per-height counts are18239844 gamma products, the same number of gamma additions, and1409368 E stages. Against m256, the respective savings are11127452 and794818; against m224 they are7456540 and532610. The independent script checks both comparisons and records their multiples at all four current final-band heights. Gamma setup is truncated to159 constants through Bernoulli index318, leaving95 constants beyond the original64.

All other listed categories remain unchanged, including elementary arguments, state lifetimes, source slots, head work, output transformations and downstream transforms. The existing7049217-point union and6148097 final active states therefore retain their previous proof and cost conditions. Under the specified loop implementation these are genuine operation deletions, not multiplied percentage savings. The finite remainder proof changes, and its one-time implementation/acceptance work is not priced as zero.

The supplement does not establish global optimality, measured runtime, or an actual spectral certificate. Exact Bernoulli construction, elementary and arithmetic witnesses, actual output data, the analytic formalization and complete ordinary Lean/MM0 checking remain required. Prior immutable packets remain untouched.
