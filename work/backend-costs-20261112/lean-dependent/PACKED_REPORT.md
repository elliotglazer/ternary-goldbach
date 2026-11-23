# Stock Lean product-packing probe, 13 November 2026 UTC

The probe passes ordinary kernel checking, exact input comparisons, a corrupted
positive-claim rejection and fresh-process replay. Packing helps small batches
of nonnegative products by about 1.7 to 2.7 times in this experiment. It loses
at 64 products. This is useful but does not explain away the much larger
dependent-network gap between the current Lean and HOL4 implementations.

## Mathematical scope

Take the absolute values of the same input coordinates from the original
P343N64 fixture. For n products and radix B = 2^698, define

    left = sum_i a_i B^(n*i)
    right = sum_j b_j B^j
    mask = sum_i (B-1) B^((n+1)*i)
    expected = sum_i (a_i*b_i) B^((n+1)*i).

Every cross product fits in one field. The exponents n*i+j are distinct, so
the diagonal fields contain the desired products. Python checks this relation
and the original source values. The concrete Lean theorem proves

    Nat.land (left * right) mask = expected.

The scalar theorem instead proves all individual products equal their supplied
results. The generic Lean theorem relating the packed identity to those
individual products is NOT implemented. These are different formal conclusions,
and the measured ratio excludes that missing bridge and input-bound proofs.
Signed multiplication, rounding, network error propagation and roots are also
absent. This is a test of arithmetic representation, not a verified FFT or TG
certificate.

## Three fresh processes per case

Each process performs one untimed warmup and one timed strict-kernel replay.
The replay renames all three concrete declarations, including the numeric
helper, and rejects surviving references to the original theorem namespace.
Literal data and generic theory are imported. Times are kernel-loop elapsed
time on Windows, using one Lean thread.

| Products | Scalar median | Packed median | Scalar / packed |
|---:|---:|---:|---:|
| 8 | 1.151 ms | 0.420 ms | 2.74 |
| 16 | 0.967 ms | 0.558 ms | 1.73 |
| 32 | 1.580 ms | 1.472 ms | 1.07 |
| 64 | 2.772 ms | 4.296 ms | 0.65 |

The 8-product scalar samples vary from 0.686 to 1.160 ms. These small timings
are noisy; there is no claim of a precise optimal batch size. The sparse layout
uses quadratic space and multiplies many unwanted cross products. At 64,
the left operand has 2814689 bits, and the mask has 2859008 bits. The ordinary
scalar representation avoids that expansion. Denser or different packing
methods remain possible, but this particular large-batch design is not a win.

## Literal loading was a separate bottleneck

Compiling the raw hexadecimal data source at 32 products cost 38.266 CPU seconds.
The 64-product source exceeded the external 600-second wall limit and is a
failed build, not a valid timing sample. Its result remains recorded.

PackedLoader uses balanced parsing of the hexadecimal strings and constructs
ordinary Nat definitions through Lean's declaration interface. It adds no
arithmetic theorem. All numerical claims still use decide +kernel. The completed
64-product data build costs 9.750 CPU / 9.803 elapsed seconds, including imports
and binary provenance dumps. The proof-file build costs 7.250 CPU / 7.329 elapsed
seconds, and the fresh kernel replay itself has the 4.296 ms median above.
Those are separate phases. A faster parser does not make the kernel's numerical
work disappear, and a millisecond replay excludes the seconds of cold input work.

The audit reads the actual imported declaration bodies, recognizes Lean's
OfNat literal encoding, checks that no high bits were omitted, and dumps their
values in a balanced little-endian format. Python compares all four values at
all four sizes exactly against the JSON and against the original fixture
construction. This comparison is data provenance, not a proof of the missing
generic packing theorem. No hash is used as a mathematical assumption.

An earlier decimal-dump experiment was explicitly stopped after 169 elapsed
seconds. The first imported-body audit also failed because it expected a raw
literal rather than Lean's OfNat expression. Both failures remain recorded.
The corrected imported-value audit and all exact comparisons pass.

## Trust, evidence and next decision

All eight packed/scalar concrete theorems depend only on propext. The low-bit
corruption is rejected by a strict kernel check. The replay uses trust zero,
and the setup does not use native_decide or rebuild shared dependencies.
PACKED_RESULTS.json requires every successful build, exact axiom set, imported
payload comparison, rejection control and all 24 replay processes. It also
records source hashes, memory, artifact sizes and the failed raw-literal build.

Keep the balanced input loader as an implementation lesson. Retain small-batch
packing as a possible local optimization, with its missing mathematical bridge
explicit. Do not spend more on this sparse large-batch layout before testing
a complete numerical block with certified source values and coefficients.
No whole-TG estimate is discounted by the packing ratio.
