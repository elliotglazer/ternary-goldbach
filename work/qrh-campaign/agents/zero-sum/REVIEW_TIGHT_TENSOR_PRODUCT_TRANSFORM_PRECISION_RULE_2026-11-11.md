# Independent review of the tighter tensor-product factor

2026-11-11. Verdict: PASS at conditional paper/source and fixed-rational scope. No correction requested. The factor replacement and selector preserve the exact old complete p108 ceiling under the stated contracts. This review selects no precision assignment or production method and credits no operation or runtime saving.

## Frozen artifacts

Paths are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
|---|---|
| integration/TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md | DB2E3B9FF269E551901622B844AF579D7FCE12045F71B66D947CA392FD1A928C |
| integration/tight_tensor_product_precision_20261111.py | 61C0E6CA85D0A2B4902D5DE4634DFA8B53912FE7B71297C2E1A62A150D609BA9 |
| integration/tight_tensor_product_precision_20261111.json | 40D68D74CBC17CF42DB189B4D9B1D8BD49669724CD0D0771F442AF47DDC9F50A |
| zero-sum/review_tight_tensor_precision_20261111.py | 30312CF965DA94F0B4E8DAD5A092FD484E9BCC095C712A9BA5C05E7E870967AC |
| zero-sum/review_tight_tensor_precision_20261111.json | 534DCF9D55C9219BFF785B7B5378A5862EE0FD4DEEAA23EAB703860912CF2A7E |

The independent checker passed 43 assertions. It verified the three author hashes and all eight dependency hashes, the nine symbolic-selector coefficient identities, the exact complete radius and the retained magnitude/safety constants. It read only the named sources and small author receipt. It did not execute or import the author program, read an inventory, assign precisions, or evaluate any function/root/transform/zero value. No declaration, proof object or build was produced.

## Actual tensor computation

The inspected mixed-radix supplement section 5 gives the normalized intrinsic error for the actual unnormalized computation. The new note reconstructs that bridge rather than treating the stored arrays as normalized.

With N_i the product of preceding axis lengths, the actual intermediate satisfies norm at most N_i(M+e_i). Applying the next local theorem to each line and dividing only in the error statement gives an additional normalized error at most C_i*u*(M+e_i+1/N_i). The exact normalized next-axis map has sup norm at most one. Since N_i>=1 and V=M+1, this proves

    e_next <= e_i+C_i*u*(V+e_i).

Induction therefore gives e_final <= V*(product(1+C_i*u)-1). The argument uses the actual stored line inputs and a local theorem uniform in those inputs. Repeated outer axes remain repeated factors. The dependency-closed output pruning inherits the same full-circuit bound; it does not replace the group order by the primitive-label count.

Input analytic uncertainty is outside this intrinsic comparison. The exact transform transports it once. The complete alpha radius already includes its admitted source/shift/evaluation terms, so the new factor does not multiply that radius or introduce another source charge.

## Finite-product inequality

For nonnegative terms with partial sum t and new term a, where t+a<1, the denominator gap is

    (1-t)-(1+a)(1-t-a)=a*t+a^2 >= 0.

Positive denominators justify the induction product(1+x_i)<=1/(1-s), and subtraction gives the bound s/(1-s). This is a finite argument; no summability or limit assumption is hidden.

Here S<=202305920<2^28 and p>=100 imply s=S*2^-p<2^-72. Thus B=2^72/(2^72-1) is a sufficient upper bound for 1/(1-s), with 1<B<2. The claimed intrinsic bound B*S*V*2^-p follows. If S=0, nonnegativity gives every C_i=0, and the intrinsic bound is zero without dividing by S. Identity axes and the empty tensor product are covered.

The general q>28 statement is also correct with B_q=2^(q-28)/(2^(q-28)-1). In particular q80 requires the larger B_80. This algebra does not establish source-grid embedding below p100 or any of the other implementation interfaces. The selected rule correctly retains p>=100.

## Normalization and selector

The full unnormalized group factor is phi(c). On the critical line the exact conductor multiplier has magnitude 1/sqrt(c). Restoring both gives

    epsilon_B = B*phi(c)*S*2^14*2^-p/sqrt(c).

The approximation of that conductor multiplier remains separately charged. For c>0 and p in 100,...,108, comparison with C_g*2^-108, where C_g=1266*202305920*2^14, has nonnegative sides. Clearing positive factors and squaring is reversible. The resulting integer selector in the author is exact, including its power 2^(2*(108-p)) and its factor (Q-1) on the right side. No square-root approximation is involved.

The old factor-2 selector implies this selector because Q<2(Q-1). A separately proved smaller local coefficient also preserves the implication. There is no general guarantee of a one-bit reduction: replacing p_old by p_old-1 leaves the new-to-old allowance ratio B>1 if there is no other slack. The retained p108 fallback and least-p proposal are conditional on the same admitted rows and guards, not counts computed by this review.

The sharper normalized-cache coefficient was inspected through its accepted structural theorem. Its local and ordered CT bounds are tied to the rounded normalized-cache implementation and are bounded by the corresponding old mixed coefficients. This review consumes that theorem. It does not adopt a further leaf improvement or attach a sharper coefficient to an unnormalized or unproved cache.

## Complete radius and retained interfaces

Expanding the lower-precision allocation independently gives

    R_fixed = T+135*(2^-82+4*2^-63)
                +10*2^-54+93*2^-55+2^-51,
    R = R_fixed+135*epsilon_B.

The coefficient 93 combines the ten negative-adapter/formation terms after the interpolation factor with the 83 kernel terms. The factor 135 is 27 times 5. The exact kernel split retains both sample and kernel uncertainty. With epsilon_B<=C_g*2^-108, the ratio R/2^-45 is at most

    2804840254168152529/4294967296000000000
      <653052762/10^9<691/1024.

I also checked the ordered prerequisites used before these error multiplications: the pre-conductor-factor radius is below one, 516*4033<2^21, the L-center bound is below 2^12, and both direct and adapted sample bounds are below 2^17. These are inherited sufficient bounds at the exact old p108 ceiling. The note correctly substitutes epsilon_B into the sample-radius expressions instead of retaining an obsolete smaller intermediate radius.

Old local safety denominators, the old baseline sum guard, internal peaks and cached-kernel construction remain unchanged. The input condition M+1<=2^14 and exact grid100 embedding remain mandatory. The actual endpoint Y, m41/h159/500 window and all sample heights in [-7000,7000] are retained; the maximum guard height 26525/4 fits. The theorem produces no guard samples or interpolation queries.

Cache identities must still bind the actual plan, normalization, precision, chirps, rounding, enclosure and lifetime. Exact sums must use the new centers. This factor improvement constructs no cache and proves no reuse adapter. A future saved-data assignment and matched price fold must preserve these interfaces and all setup and downstream costs. Actual centers and strict sign/count results must be checked anew. No successful spectral closure or end-to-end cost conclusion follows.
