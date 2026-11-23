# Packed-convolution coverage experiment

2026-11-10. The algebraic encoding passes independent numerical checks on all three actual-prime fixtures. It reduces the final numerical coverage check to one multiplication, one addition and one bitwise AND, followed by equality. It is **not faster in the measured native arithmetic** than a same-fixture shift/OR calculation. Whether it wins in Lean depends on measured kernel reduction overhead, literal handling and the semantic proof.

No PA/MM0 or Lean proof is emitted here. `packed_fixtures.json` supplies exact operands to the Lean worker.

## Identity and coefficient bound

Let P_j in {0,1} be the actual source bitmap, with finite support. Let the distinct selected offsets be s_1,...,s_m and S=max(s_i). Choose radix B=2^k and h=B/2. For compatibility with both tests below this experiment chooses m<h. Define

    P' = sum_j P_j B^j,
    A  = sum_i B^(S-s_i).

Before any radix carrying, the coefficient at exponent t is

    c_t = sum_i P_(t-S+s_i),

where source bits outside its support are zero. Therefore 0<=c_t<=m<B. The correct bound is **at most m**, not strictly less than m. There is no multiplication carry at any exponent. In particular,

    c_(S+j) = sum_i P_(j+s_i)

is exactly the number of anchors covering target bit j. Thus all W target bits are covered if and only if each target coefficient is positive.

Define L=sum_(j<W) B^j, H=hL, and K=H-L. Let

    C = ((P'*A) >> (k*S)) & (B^W-1).

The original zero test is `(((C | H)-L)&H)==H`. It is valid because c_j<h and each digit c_j|h=c_j+h is at least h, so subtracting one in each digit causes no interdigit borrow. Its resulting high bit is set precisely when c_j>0.

The simpler additive test is `((C+K)&H)==H`. Each resulting digit is c_j+h-1, below B, and its high bit is set precisely when c_j>0. For this additive test alone, m<=h suffices; our existing fixtures use the stronger m<h so that both tests are valid.

Finally put Hs=H<<(k*S) and Ks=K<<(k*S). Then the direct test is

    ((P'*A + Ks) & Hs) == Hs.

There are no addition carries: target digits are at most m+h-1<B, and non-target digits are unchanged and below B. Consequently no extraction or shift is needed in the final expression. This is the preferred exported expression.

The prime semantics remain separate. The numerical encoding shows every target is covered by at least one set source bit. A formal Goldbach theorem must also prove that each source bit denotes a prime, that every listed anchor is prime, and that the corresponding addition has the correct target value.

## Exact actual-prime fixtures

The source is `lean_fixtures.json`, derived from actual high-end prime windows and the nearest-anchor pool. No random bitmap is used.

| Target width W | Selected anchors m | k | S | Source bits |
|---:|---:|---:|---:|---:|
| 1,024 | 110 | 8 | 2,260 | 3,284 |
| 16,384 | 168 | 9 | 3,541 | 19,925 |
| 65,536 | 168 | 9 | 3,541 | 69,077 |

`packed_cover.py` independently accumulates **every product coefficient** in a NumPy array by shifting the original 0/1 source and adding once per anchor. It decodes every base-B digit of the integer product and checks exact equality with this array. It also checks the extracted interval and all three positivity expressions. As a negative control, it changes one target coefficient to zero and verifies that the direct test fails.

The exporter asserts that the selected offsets are distinct. Its implementation first builds a 0/1 anchor bitmap and then expands each bit into a radix-B digit, so distinctness is necessary for that particular implementation. The abstract coefficient bound would also hold for repeated offsets if A were constructed with the appropriate multiplicities.

The exported JSON includes `p_expanded_hex`, `anchor_poly_hex`, `k`, `S`, `width`, `H_hex`, `L_hex`, `K_hex`, `Hs_hex`, `Ks_hex`, `C_hex`, count extrema and validation flags. In particular, the Lean numerical test can use only `p_expanded_hex`, `anchor_poly_hex`, `Ks_hex` and `Hs_hex`.

## Arithmetic timings

The timing loop keeps prepared operands in memory. It excludes source expansion, decimal/hex parsing, independent coefficient checks and any formal proof. Each row is the median of three timed trials; raw repetition counts and CPU/wall seconds are saved in `packed_timings.json` and `packed_shift_or_timings.json`.

The same-fixture shift/OR baseline computes `u |= source >> s` for every selected offset and tests `(u & target_mask)==target_mask` once at the end. It avoids an unnecessary per-anchor final-width mask and uses the original unexpanded source. Both methods evaluate exactly the same selected cover.

| W | Python packed test, us | Python shift/OR, us | FLINT packed test, us | FLINT shift/OR, us |
|---:|---:|---:|---:|---:|
| 1,024 | 227 | 16.6 | 26.0 | 17.9 |
| 16,384 | 2,604 | 126 | 258 | 103 |
| 65,536 | 8,590 | 483 | 786 | 194 |

Separate larger actual-prime fixtures were then generated near the high end of the small-prime range. They do not overwrite the initial fixtures:

| W | m | k | S | FLINT packed test, us | FLINT shift/OR, us |
|---:|---:|---:|---:|---:|---:|
| 262,144 | 188 | 9 | 3,789 | 3,015 | 608 |
| 1,048,576 | 250 | 9 | 5,056 | 18,375 | 3,107 |

Every product coefficient of these larger fixtures was also independently checked. The operands are in `packed_large_fixtures.json`, their original prime-bit sources in `large_lean_fixtures.json`, and their raw timings in `packed_large_timings.json`. The corresponding script is `packed_large.py`. The native arithmetic penalty of packing remains approximately five to six times at these sizes.

FLINT multiplication alone measured approximately 24.7, 255.6 and 858.8 microseconds. Its full-test time is slightly lower than multiply-only at the largest width in this run, which is ordinary measurement variation; the extra operations do not have a negative cost. These are native arithmetic library calls made through Python, not Lean kernel timings.

At W=65,536, the packed source has roughly nine times as many bits as the original source, and the anchor polynomial is a multi-kilobit integer. Replacing 168 shifts and unions with one multiplication therefore does not guarantee a native speedup. The measured FLINT comparison is about four times slower for the packed route at that width. The possible benefit is fewer kernel reduction nodes and a simpler final arithmetic expression, which must be checked experimentally rather than inferred from operation count alone.

## Reproduce

Run with the existing interval environment:

    work/qrh-campaign/interval-env/Scripts/python.exe work/formal-goldbach-bench/prime-cover/packed_cover.py
    work/qrh-campaign/interval-env/Scripts/python.exe work/formal-goldbach-bench/prime-cover/packed_compare.py

The results are deterministic apart from timings. Script and source hashes are included in the timing metadata. The actual source's prime provenance and the generic radix argument still require formal proofs in the target system. No execution trace or external library result is being imported as an axiom.
