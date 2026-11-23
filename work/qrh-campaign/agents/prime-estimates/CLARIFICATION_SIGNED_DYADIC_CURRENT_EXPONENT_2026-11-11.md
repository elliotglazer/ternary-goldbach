# Normalize the current dyadic pair

This clarifies section 6 of `EFFICIENCY_PA_SIGNED_DYADIC_BRIDGE_2026-11-11.md`, SHA256 EBF10D893D5CF50E8B45FD6EB5A3EE54F44BB99389741961A09E299BD311ADBD. The original bytes are preserved. Independent reviewer statement_audit identified the need to distinguish the two branches of section 5.

Before canonical normalization, write the current value as `(-1)^s * R * 2^h`, where **R is a natural magnitude** and h is the current signed exponent.

* In the `k=g-e<=0` branch that retains the original dyadic without materializing a grid mantissa, take R=A and h=e.
* After rounding to the requested grid, take R=abs(M) and h=g, where M is the **signed** rounded integer from section 5. Choose the corresponding sign, canonicalizing zero if required.
* If the exact finer-grid branch instead explicitly forms its grid mantissa, its current pair also has h=g; the shift must be checked and paid for as stated in section 5.

At R=0, emit the unique canonical zero. At R>0, check `R=2^t*U` with t natural and U positive and odd. The normalized output is `(s,U,h+t)`. Thus `g+t` is correct only for a current pair already on grid exponent g. It is not the exponent for an unshifted original magnitude A retained with exponent e.

The linear `Split_b(n)` and normalization counts concern local proved macro applications at fixed radix. Together with the 14/14/22 sign-routing inventory they do not establish linear serialized proof bytes or wall time: repeated growing-numeral instantiation, sharing, binding, unification and storage remain separately charged. This is consistent with the original report's exclusions.

No arithmetic value, evaluator, build or proof stream was run for this clarification.
