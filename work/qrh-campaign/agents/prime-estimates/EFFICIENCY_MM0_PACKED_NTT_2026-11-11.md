# Exact NTT acceptance for large binary-coverage convolutions

2026-11-11. Paper proof schema and integer size calculations only. No prime, root, transform, modular value, sieve, proof stream or benchmark was generated. No Lean/MM0 build ran. This is an alternative acceptance design for the large coverage products, not for the 90-bit ladder certificates.

## Result and limits

One proved prime is enough: the original convolution has nonnegative coefficients at most the number of selected anchors, at most 512 in the example. It does not require a modulus larger than the millions-of-bits packed integer. A power-of-two NTT with suitable length and a checked primitive root recovers these coefficients uniquely. CRT is unnecessary for this representation.

The preferred acceptance form checks **three forward transforms**, including the claimed coefficient vector, and their pointwise product identity. DFT injectivity then proves the convolution. This eliminates the inverse transform's per-output scaling products, not the mathematical proof of invertibility. It also permits checking positive coefficients directly without constructing the packed product as a giant natural number.

This is not yet an implemented ordinary-PA library. Every modular butterfly, indexed operand and point product must have ordinary proofs, and the generic transform theorem must itself be proved. In the present template model NTT becomes a plausible candidate for the broad-halo geometry, but is already worse in product-only events than unbalanced Karatsuba in the narrow-span example. Direct residual word-OR remains a serious comparator. No runtime ordering follows.

## 1. Exact source geometry

The frozen `moebius/EFFICIENCY_BINARY_COVERAGE_2026-11-11.md`, sections 1--3, supplies the contract. A target tile has width W. For a nonempty selected anchor multiset I of size m, put u=min s_i, d=max s_i-u and e_i=s_i-u. The actual source bits are

    Q_j=P[a+u+j], 0<=j<W+d.
    A_v=#{i : d-e_i=v}, 0<=v<=d.

The source theorem proves every set bit denotes its specified prime, and every selected anchor is separately a proved prime. In particular Q_j is 0 or 1, A_v>=0, and sum A_v=m. Define the ordinary, zero-extended convolution

    C_l=sum_(j+v=l) Q_j A_v.

Then 0<=C_l<=m for every l, its support is l<W+2d, and C_(d+x)=sum_i P[a+x+s_i] for 0<=x<W. Repeated offsets are allowed by these multiplicities; a 0/1 anchor bitmap would instead require distinctness.

The residual R is the exact remaining target mask, not a freely chosen subset. Acceptance requires C_(d+x)>0 for every set bit x of R. The existing residual-tree induction then proves coverage. Any zero coefficient still required by R rejects this leaf. No transform can make a non-covering set of anchors cover it.

For the old packed form, choose k with m<=2^(k-1), b=2^k. Since C_l<b, sum C_l b^l equals Qpack*Apack without carrying. Adding 2^(k-1)-1 to each target lane also has no interlane carry and its high bit detects positivity. Thus the new coefficient check and the old packed terminal have the same mathematical obligation. Binary-to-lane dilation, lane access and source provenance remain explicit if the packed form is retained; the direct coefficient route avoids the dilation itself, not the input binding.

Do not replace this coefficient bound by the bound for an arbitrary base-256 integer multiplication. That other representation has coefficients as large as min(n_Q,n_A)*255^2 and may need larger moduli or CRT. The small bound here uses the specific binary/multiplicity convolution.

## 2. Checked NTT parameters and the nonwrapping proof

Let T=2^ell>=W+2d, ell>=1. The parameter packet supplies an odd prime p, p>m, a residue omega, and ordinary checked evidence

    0<=omega<p,  omega^(T/2) = -1 (mod p).

Over the proved field of residues modulo p this implies omega^T=1 and exact order T. Indeed its order divides T; a proper divisor of the power of two T divides T/2, contradicting -1!=1. It also implies T divides p-1 and T is invertible modulo p. These implications are theorems to prove, not unchecked parameter flags. For the displayed large T, the root condition already forces p>T>512; retain the explicit p>m guard in the generic checker.

Possible production: choose a Proth-form p=k0*2^h+1 with k0 odd, k0<2^h and h>=ell, prove it prime using a checked Proth/order certificate, then derive the needed root by checked powers. Alternatively use the existing general primality certificate path. No such parameter was evaluated here. In particular, the table's p<2^32 assumption is a conditional implementation size choice, not a newly certified 32-bit prime. Failure to supply it rejects that configuration. Parameter proofs can be reused for every tile with the same p,T; they are not free on first use.

Pad Q,A,C by zeros to length T and set

    F(v)_k=sum_(j<T) v_j omega^(jk) (mod p).

Prove the finite geometric-sum identity: sum_(k<T) omega^(k h) is T when T divides h and zero otherwise. For the nonzero case multiply by 1-omega^h, use telescoping and field cancellation. It proves both circular-convolution multiplication and injectivity of F. Because the unpadded supports have combined maximum degree W+2d-1<T, circular and ordinary convolutions agree; there is no wrap into the low coefficients. Equality at the endpoint T=W+2d is permitted.

The witness gives canonical coefficients 0<=C_l<=m for l<W+2d and zero afterwards. Check

    F(C)_k=F(Q)_k F(A)_k (mod p), all k<T.

Injectivity gives C congruent to the true ordinary convolution. Both are in [0,m] with m<p, so they agree as natural numbers. A single evaluation, a sampled subset of frequencies, or a hash of the vectors does not establish this implication. All T frequencies, all input indices and the zero padding must be covered.

The more familiar two-forward/one-inverse algorithm is also sound: inverse omega and T^-1 must be proved, and all T final scaling products checked. Forward verification uses the same three transform sizes but avoids those T products. Its generic correctness proof still uses the invertibility argument above; it is not an unproved cancellation trick.

## 3. Ordinary-PA arithmetic and circuit binding

Use canonical natural residues below p. For a modular product u v = p q+r, supply q,r and a nonnegative slack with r+slack+1=p. Since u,v<p, q<p. Ordinary multiplication and addition proofs establish these equalities; `eqdivmod` then gives the claimed remainder. No native word multiplication is an axiom.

For an addition, supply e in {0,1} and S<p with u+v=S+e p. For subtraction supply e in {0,1} and R<p with v+R=u+e p. These positive equations cover both signs without truncated-subtraction ambiguity. Bounds require at most one extra bit for u+v and u+p. Small-digit carry and comparison proofs remain necessary. The numeric gates use the same p everywhere.

A radix-2 decimation circuit at stage s, block length 2^s, uses the table entry omega^(j*T/2^s), 0<=j<2^(s-1), at every butterfly. Declare the exact bit-reversal/permutation convention and prove by induction that the circuit computes F. Every output is linked to the previous stage's actual indexed entries. A proof of isolated correct gates with unbound inputs is insufficient. A shared immutable array theorem, sequential fold invariant or explicit indexed proof object can provide the link; a bare array hash cannot.

Precompute the forward table omega^j for 0<=j<T/2 with a checked recurrence, including entry zero=1. This takes T/2-1 modular products after the first entry, and its index/range proof. All stage tables are views of this one table. A reused F(A) or F(Q) is legitimate only when its proof is bound to the same full coefficient vector and p,T, not merely the same length or an unauthenticated cache key.

The ordinary-PA mathematical layer needs finite-sequence encoding, finite-sum reindexing, modular-field cancellation, the geometric-sum lemma, circuit correctness, coefficient uniqueness and the coverage adapter. These can be proved from PA using encoded finite lists and induction; no new arithmetic axiom is required. They are nevertheless **new proof and implementation work**, not declarations verified by this note. The inspected `peano.mm1` supplies basic arithmetic/division/power/bit facts; no claim is made that it already implements this NTT layer.

Existing exact source interfaces include `eqdivmod` at peano.mm1:2693, `divmod`/`modlt` at 2700/2710, the `muladdmod*lt` lemmas at 2740--2743, `powadd`/`powmul` at 5024/5029, and the proved shift/bit interpretation beginning at 5056. The digit proof examples are peano_hex.mm1:418--508 and 526--587. Its hex coercion axioms cannot silently become the PA foundation: use the already proposed closed-natural-digit replacement and prove the radix laws.

## 4. Exact operation counts and costs still outside them

For one dense transform there are T*ell/2 butterflies, each with two modular additions/subtractions. Exactly T-1 butterflies have twiddle 1 under this schedule and can omit the product. With three forward transforms and T point products:

    M_NTT=3*(T*ell/2-(T-1))+T=(3ell/2-2)*T+3;
    A_NTT=3*T*ell.

An inverse-producing route adds T scaling products. Root/prime support and the T/2-1 table products are one-time costs per parameter set. Zero/special-root pruning, sparse inputs and shared transforms might reduce the dense count, but no such savings are assumed. Multiplication by -1 is not separately optimized here.

At p<2^32, a byte-radix modular product has n=4 digits. The existing proposed PA skeleton Q(n)=10n^2+10n+5 gives Q(4)=205 events, including the quotient-times-p proof. Its numerical products have up to 64 bits even though residues have 32 bits. Let J_32 be the separately implemented modular-add/subtract event cost. The bill is

    205 M_NTT + J_32 A_NTT + input/range/index/circuit/coverage costs,

plus amortized parameter proofs and table setup. This is a template model, not counted MMB opcodes or verifier time. A smaller certified p can reduce Q(ceil(bitlength(p)/8)); a 64-bit modulus increases it. Changing the prime size without rechecking root existence and coefficient bounds is not allowed.

The script evaluates only integer geometry and these recurrences:

| Geometry | T | modular products | modular adds/subtracts | product-only PA template events |
|---|---:|---:|---:|---:|
| W=262144,d=524288,m=512,k=10 | 2097152 | 61865987 | 132120576 | 12682527335 |
| W=262144,d=4096,m=512,k=10 | 524288 | 13893635 | 29884416 | 2848195175 |
| historical W=262144,d=3789,m=188,k=9 | 524288 | 13893635 | 29884416 | 2848195175 |
| historical W=1048576,d=5056,m=250,k=9 | 2097152 | 61865987 | 132120576 | 12682527335 |

The first two are hypothetical geometries; no anchor availability or coverage is assumed. The last two reuse only the integer metadata of the older packed experiment, not its native timings as a proof-cost estimate.

For T=2097152, a 32-bit forward-root table alone is 4 MiB; two residue buffers are 16 MiB. Three complete arrays at every stage occupy 528 MiB of raw residues. For T=524288 these figures are 1, 4 and 120 MiB. The claimed C vector in k-bit lanes is about 1.56 MiB for the full halo and 0.322 MiB for the narrow span. These figures exclude quotient witnesses, proofs, indices, object headers and allocator overhead. Streaming may avoid retaining all stages, but ordinary-MM0 liveness/reference management and independent replay still have to work. There is no evidence that the current verifier can retain the full naive trace within its limits.

## 5. Fair Karatsuba and OR comparisons

A packed multiplication is highly unequal in the narrow-span case. Do not pad both operands to the longer length and call that the only Karatsuba comparator. With byte lengths n_Q and n_A, split Q into chunks of n_A digits. For each chunk compute Q_j*A using the positive Karatsuba schema, add the previous carry, emit n_A low digits and keep the high carry. The invariant carry<A proves the next carry<A, since Q_j*A+carry < beta^(n_A)*A. The last carry is emitted exactly. This needs no unbounded carry column.

With r=ceil(n_Q/n_A), the conservative skeleton is r*(G(n_A)+A(2n_A)), plus split/encoding/binding costs, where

    G(n)=min(5n^2+2n+1,
             G(ceil(n/2))+G(floor(n/2))+G(ceil(n/2)+1)
             +12ceil(n/2)+8n+21), n>=4,

and n<=3 is a base case. This retains the third child's extra carry digit. The four table rows have chunked skeletons 77961219312, 1151716865, 947207308 and 4372215210 respectively, before their representation costs. Thus even before adding NTT's modular additions, three rows favor this existing arithmetic skeleton. The broad halo has room for NTT, but no winner is established until its new finite-field/circuit and representation work is charged. The companion JSON also records whole-operand padded and rectangular-schoolbook comparisons.

For direct dense 64-bit coverage, the first two rows have only 512*4096=2097152 word-anchor updates, with source extraction and actual proof costs per update. The historical rows have 770048 and 4096000. A sound residual method may need fewer actual updates; it must prove that omitted residual words are zero. Compare

    M_NTT*Q(n_p)+A_NTT*J(n_p)+D_NTT
        against r*(G(n_A)+A(2n_A))+D_K
        and against sum selected-word-updates*(E_extract+E_OR)+D_OR.

The three D terms are different, include input provenance/range assembly, and cannot be discarded. A native NTT, native Karatsuba and a schematic OR proof are not matched trust or cost measurements. For Lean kernel acceptance the NTT may replace a few optimized big-integer reductions with millions of smaller reductions; its advantage must be measured rather than assumed. `native_decide` or a verified-machine computation would be a separate trust/implementation comparison. Ordinary MM0 must receive proofs under its ordinary rules, not a trusted NTT opcode.

## 6. A bounded test specification, not a run request

First implement and prove the finite NTT/coverage adapter on a small dyadic length, with mutations for wrong twiddle index, omitted frequency, noncanonical residue, cyclic wrap, altered source bit, wrong anchor multiplicity and an uncovered required residual. Then use one identical genuine source/anchor leaf to compare complete OR, unbalanced Karatsuba and NTT acceptance, including parameter library creation and its amortization. Record generation, proof encoding, checking, bytes and peak memory separately. Do not begin with millions of gates before the indexed proof/liveness layer works.

A crossover study should vary actual span d at fixed W,m and record transform-size jumps, source packing cost, modular word size, and actual residual work. It must retain failed coverage/search attempts in generation cost. No present scalar result justifies a production scan or a fastest-backend claim.

## Pins and reproducibility

* Packed contract: `moebius/EFFICIENCY_BINARY_COVERAGE_2026-11-11.md`, SHA256 EEED5871CE2A7737F01D92CDBC0D362BA42307FF58D0A1192892989C4FBF8436.
* Historical metadata: `work/formal-goldbach-bench/prime-cover/PACKED_REPORT.md`, SHA256 B0C0E3431ECD29273D053115DCB2433FBC932FB29DFB85A0167164FB536182CA.
* PA square/Karatsuba schema: `prime-estimates/EFFICIENCY_MM0_SQUARE_KARATSUBA_2026-11-11.md`, SHA256 4ADB3C676ABA3A82128A8F27CBB91221B414689F94CDC5D60BA0FA75A8421FFA; independent review SHA256 767753AB7CE59C69922363DCF239C55B2D81C716194D62D977EE4CFE9F75A7B1.
* MM0 source snapshot revision 0d414c0bfdaaeb7fea571895127abc1fa5a3d956: `examples__peano.mm1` SHA256 13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079; `examples__peano_hex.mm1` SHA256 76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94.
* Companion `ntt_coverage_size_models_20261111.py` and JSON contain four geometry rows and 50 schedule-count identities. Only integer size/recurrence arithmetic was executed. No theorem above is thereby kernel-validated.
