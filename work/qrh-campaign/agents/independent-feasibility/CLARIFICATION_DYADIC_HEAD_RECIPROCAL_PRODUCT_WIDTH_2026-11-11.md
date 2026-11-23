# Equality case in the reciprocal certificate product

2026-11-11. This corrects one width sentence in section4 of `DYADIC_HEAD_RECIPROCAL_REUSE_2026-11-11.md`, SHA256 `DB63BE813797CC0DA28F28EEBFEE394BFB2BCC34EFDFA2756F0F9718223F3FB9`. The original note, script and receipt remain unchanged.

The correct valid-product bound is

    A*v <= 2^142,

so a valid product can require143 magnitude bits. Equality is not confined to the separately handled x=1 entry. For example, A=8192=2^13 and v=2^129 correspond to x=A/4096=2 and give A*v=2^142. More generally equality holds exactly when A divides2^142, since v=floor(2^142/A). In the stated range4096<=A<=6148096, this includes every A=2^j for12<=j<=22.

The certificate condition was already correctly stated as `A*v<=2^142<A*(v+1)`. Its proof of downward reciprocal error is unchanged, including the zero-error cases just identified. The setup numerator was also already described correctly as a143-bit integer.

I checked the downstream width and cost claims against this correction:

* For nonunit entries, A>4096 still implies v<2^130. The130-bit numerator capacity and99840000-byte raw nonunit cache count remain valid.
* Bounded untrusted nonunit inputs still permit A of23 bits and v of130 bits. Their product must be checked in a153-bit capacity before the certificate is known. That precheck bound already covers the corrected143-bit valid product.
* The head product is U*v, not A*v. With |U|<2^123 and nonunit v<2^130 it still fits253 magnitude bits. The baseline quotient identity and its23-by123-bit product are unaffected.
* The radix256 product subcounts use operand capacities. The reciprocal certificate remains a3-by17-digit product. Neither this subtotal nor the separate rounding/term costs use the erroneous strict142-bit bound.
* Error propagation, all four prefix operation counts, and the at-most-one correction argument are unchanged. They require the non-strict downward certificate above and do not exclude exact reciprocal cases.

The source script `dyadic_head_reciprocal_bounds_20261111.py`, SHA256 `BCB29B2F2254051A9F22532C9576CFD59528AD5040D45454020A7AAA2FED568F`, checks the153-bit operand-capacity sum and does not assert the erroneous strict valid-product bound. Its receipt `513ABDAC87D274FB518B7E65B156199B832E52187BDE20BEA6824569F09E3D0A` is therefore not altered. This clarification supplies the corrected143-bit valid-product requirement for any implementation using the tighter bound. No table, function value or build was run.
