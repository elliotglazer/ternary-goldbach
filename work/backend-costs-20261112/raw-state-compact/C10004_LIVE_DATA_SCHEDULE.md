# A physical schedule for the c10004 two-height block

13 November 2026. Source-only architecture design. No values, unit lists, roots,
proofs or timings were generated. This does not modify the frozen forecast.

The proposed checked computation initializes its numerical sources, produces
each height's 4800 residue inputs, runs the actual character transform, computes
all 2301 completed center-radius pairs, and tests their signs before exporting
compact statuses. Its internal arrays are not repeatedly printed as HOL
literals. This is a proposed implementation boundary, not a demonstrated
ability of the present HOL program to retain or reclaim those arrays.

The fixed instance is c=10004=4*41*61, with ordered axes 2,40,60 and positive
heights 5/64 and 5/32. Initialization is at height zero. Use source D=512,
N=220, m=64, P27, delivered P20, the saved K20/b94 degree grids, grid100 raw
assembly and runtime p81. Retain the 8828 error and 16384 width contracts and
their old safety guards. No p75, shorter polynomial, smaller magnitude or new
precision choice is included.

## The output contract changes explicitly

`ANALYTIC_BLOCK_PLAN.md` requests all 4602 numerical center-radius records.
This successor instead exports two ordered status vectors. Each entry is
`proved negative`, `proved positive`, or `inconclusive`. Inconclusive does not
mean zero. A fourth encoding can be reserved for malformed data and must never
occur in an accepted output. Fixed order is
`(height, 1, k41, k61)`, with k41=1..39 and k61=1..59.

The theorem must connect each non-inconclusive entry to the sign of the same
real completed Hardy function, with the actual conductor, character, height,
root-number phase and Gamma normalization. It must derive that sign from a
computed enclosure whose radius contains all source, transform and completion
errors. All 4602 enclosures and tests are still computed. Only their numerical
export is omitted. A theorem relating statuses merely to integer centers is
insufficient. Existing compact02 proves only such an integer-level mechanism.

Two bits per status require 9204 bits, or 1151 packed bytes for both heights.
Labels and row lengths are supplied by the fixed, proved ordering rather than
repeated in every record. This size excludes the HOL theorem, its parameters
and the status container representation. A block with all entries inconclusive
does not satisfy the planned successful-sign experiment. The predeclared
success criterion and charged refinement policy remain necessary.

Neither two signs nor this entire block prove a zero count. Interpolation,
disjoint brackets, endpoint treatment, multiplicities and Turing completeness
remain separate. A later repair consumer requiring actual enclosures must
either run before those values are discarded, retain a specified checkpoint,
or recompute them. It cannot recover them from the status vector for free.

## One initialization, then two sequential heights

1. Check the fixed parameter tuple, the actual CRT/character indexing
   certificate and root identities. Construct the index map and source pools
   internally. Prove source initialization and step enclosures. Compile/import
   the generic analytic and arithmetic library through ordinary HOL checking.
2. Advance both power pools once to height 5/64, preserving their accumulated
   errors. For each coarse anchor, generate its finite EM jet and immediately
   consume its even fine cell and shifted midpoint cell. Evaluate the P20
   polynomial only at that cell's unit residues. Add the raw head exactly on
   grid100, convert once to p81, and scatter into the transform input array.
3. Run the ordered 2,40,60 transform and pruning. Stream every primitive output
   through completion, its full radius calculation and a strict sign test.
   Retain the first 2301 statuses, not a second copy of the transform.
4. Advance the same source pools once more to height 5/32 and repeat steps 2–3.
   Reuse numerical buffers, roots, index map and conductor/character constants.
   Export the two status vectors and the theorem relating them to the exact
   functions. Record separately any repair or later consumer checkpoints.

This requires a theorem for the whole program, or compositional evaluator
theorems that preserve its internal representation. Applying a theorem at each
stage by first decoding an array and translating it back is not this schedule.
Logical subtheorems may have array terms without those terms being externally
serialized, but their construction, sharing, lifetimes and kernel memory still
have to be measured.

## Persistent numerical pools and indexing

Signed widths below include a sign bit. Packed bytes use independent
byte-rounded coordinates and exclude allocator/container overhead.

| Array | Exact cardinality and capacity | Packed bytes | Lifetime |
|---|---|---:|---|
| EM source B states and step centers | x=1+k/512, k=0..113152: 113153 arguments. Two complex arrays. State grid140, step grid142; reserve signed144 for every coordinate. | 8,147,016 | Initialize once; retain through both heights. |
| Raw integer B states and step centers | Integers 1..10004 inclusive: 10004 arguments. State grid120, step grid122; reserve signed124 for all four coordinates. | 640,256 | Initialize once; retain through both heights. |
| Unit/scatter map | 4800 records `(a, input_index, fine_cell)`, capacities 14,13,11 unsigned bits; reserve 8 bytes/record. | 38,400 | Both heights. |
| Fine-cell offsets into sorted map | 1026 prefix offsets, each <=4800; 2 bytes each. | 2,052 | Both heights. |
| Transform root centers and exact fixed-gate sums | Conservative full tables for lengths 2,3,5,10,15,20,30,40,60: 185 roots. Each has two signed83 coordinates and exact real sums c+d,d-c of signed84 bits. Four 11-byte fields. | 8,140 | Both heights and every line transform. |
| Output statuses | 4602 entries, 2 bits each. | 1,151 | Append height1 then height2; final export. |

The rational pool count follows `(N+1)D+1=221*512+1`, covering the 220 head
arguments and the endpoint for all 513 coarse anchors. It is a first-band
pool, not all five global source bands. This deliberately simple schedule
keeps it whole; a future rolling pool would be a different layout proof.

The raw integer pool deliberately includes nonunits. Its complete consecutive
domain avoids assuming an unproduced minimal source list. Actual residue work
still uses exactly 4800 units. Although some power arguments coincide between
the two pools, their grids and error contracts differ. No cross-pool saving is
counted. Each seed can be generated and checked one at a time before storing
its state/step; there is no required array of all log, inverse-root or cis
witnesses. Their peak individual working storage is not yet bounded here.

The 185-root choice is a conservative, explicit table schedule, not the number
of distinct exact angles. It covers each listed transform length without an
angle-union discovery pass. The producer must prove the sign convention and
exact root identity, then create the fixed-gate sums from those same stored
centers. Root generation, duplicate identities, table addressing and cache
construction are real costs. This instance has no Bluestein kernel.

The actual generators modulo 41 and 61 and the resulting CRT list are not
supplied in the saved parameter packet. The map above is a target allocation,
conditional on constructing and proving that bijection. Sort its records by
fine cell and retain the original transform input index. With G=1024, use
ties-down `k=floor((2*G*a+c-1)/(2*c))`, equivalent to
`(2k-1)c < 2Ga <= (2k+1)c`. Then
`h=512*a/c-k/2` satisfies |h|<=1/4. Verify the ordering, offsets, cell membership
and exactly-once input writes inside the checked computation. No unit list or
occupancy histogram has been computed for this note.

## Streaming the source and residue polynomial

For j=0..511 generate the P27 coarse jet at alpha=j/512, consume fine cell 2j,
translate the same finite polynomial by one half in scaled coordinates, then
consume cell 2j+1. At j=512 only the endpoint P20 delivery is needed. This
preserves the finite translated-polynomial semantics; it does not identify a
shifted numerical slot with an exact fine-center derivative.

Per height this produces `512*27+20=13844` independent source coefficients and
has `1025*20=20500` fine delivery slots. Neither is a live global delivery
array. Use separate coarse and shift work buffers so the coarse object is not
destroyed before its consumers finish. Generate one converted 20-slot Horner
coefficient vector per fine cell and reuse it for that cell's unit residues.
Do not repeat source coefficient conversion for each residue.

| Working array | Proposed reservation | Packed bytes |
|---|---|---:|
| R, head accumulator D, current head terms T, coarse U, midpoint work | Five complex vectors of 27 slots, signed139 coordinates on a grid122 storage carrier. A grid110 rounded midpoint embeds exactly into it. | 4,860 |
| Endpoint E | Indices 0..153 inclusive, 154 complex slots, same capacity. | 5,544 |
| Converted P20 coefficients | 20 complex slots, conservatively same capacity, despite their actual degree-specific grids. | 720 |
| Lambda and rounded Bernoulli gamma constants | 27+64 real slots, each reserved signed139. | 1,638 |

Total reserved source arrays are 12,762 bytes. The generic source bound is
norm<2^16 for stored centers and midpoint work; signed139 covers grid122.
R and endpoint arrays have sharper bounds but no narrower reservation is used.
Exact head accumulation and the 64 Bernoulli corrections remain in the source
program. The denominator checks, exact Bernoulli definitions, elementary
initializers and raw multiplication/division witnesses are not implied by the
stored-array bound. Their temporary capacities and allocation are a remaining
implementation obligation.

At each unit a, Horner uses the fixed grids
`94,94,94,94,91,89,89,89,83,81,81,81,75,73,73,73,65,65,65,65`,
then embeds its grid94 output exactly on grid100. The raw conductor factor
`c*conj(B_c)` is formed once per height. Its signed131 coordinates occupy 34
packed bytes. A raw head is consumed immediately; no 4800-head array is needed.
The raw producer's conservative scalar capacities are signed247 for update
witnesses and signed254 for head witnesses. The head is signed111 on grid100;
polynomial delivery signed114 and exact assembly signed115. The existing
conservative p81 regrid target has signed96 coordinates, with signed116 raw
witness capacity. All these operations and witnesses remain checked. The
transform buffer reserves the wider common signed113 capacity below.

## Actual tensor buffers

Use input order `((j61*40+j41)*2+j4)`. After the first pruned axis retain j4's
single primitive output. The 40-axis retains labels 1..39; the 60-axis retains
labels 1..59. The resulting sizes are therefore
`4800 -> 2400 -> 2340 -> 2301` per height, not 2301 at every stage.

Reserve A with 4800 complex slots and B with 2400. Axis2 reads A and writes B
at `j61*40+j41`. Axis40 reads each 40-element B line and writes A at
`j61*39+(k41-1)`. Axis60 reads each strided 60-element A line and writes B at
`59*(k41-1)+(k61-1)`. These are proposed addressing equations requiring a
proved match to the actual positive-exponent DFT and CRT ordering. They are
not a replacement permutation inferred from numerical agreement.

The retained peak recurrence gives K2=4, K3=6, K5=10, K10=40, K15=60,
K20=80, K30=120, K40=160 and K60=240. Across the ordered axes,
`K=max(2*1*4,2*2*160,2*80*240)=38400`, so ceil(log2 K)=16.
With p81 and V_width=2^14 the existing bound gives signed113 stored
coordinates, signed194 ordinary exact products/combinations and signed197
three-product temporaries. Presums need signed114. These bounds retain the
old safety/peak guards and do not assign 81 bits to an entire coordinate.

A and B occupy `(4800+2400)*2*15=216000` packed bytes. For a deliberately
simple depth-first implementation, reserve an additional 340 complex slots:
60 input and 60 output slots for a line, plus
`2*(60+30+15+5)=220` recursive slots. This is 10,200 packed bytes. The
implementation must exhibit that allocation discipline, releasing a child
workspace before the next child. It is not an automatic bound on an existing
functional evaluator. A different transform implementation must publish its
own allocation; raw scalar arithmetic temporaries are additional.

## Completion, radii and the actual proof boundary

Stream the 2301 final outputs, but retain their full numerical precision until
completion and enclosure tests finish. Root-number phases can be shared across
the two heights; Gamma/parity factors can be shared within a height when the
actual completion formula proves it. No canonical phase may be replaced by an
arbitrary unit number. The saved plan has not fixed the actual completion
producer, its rounding grids, intermediate widths or HOL FE theorem.

Consequently completion storage is a named unknown, not silently zero. A
proposed cache of 2301 unit root-number centers at grid g_eps needs
`2301*2*ceil((g_eps+2)/8)` packed bytes once that enclosure contract is proved.
Two parity-dependent completion records plus a streaming output/radius record
have separately unknown widths. If phases are generated and discarded per
channel, their second-height regeneration must be charged. If they are
retained, their memory and source proofs must be charged. Uniform proved
radii may be shared; otherwise all per-channel radius arithmetic still runs.

Only the following objects need cross the external proof boundary in this
design. Crossing once is not a free theorem import.

| Object | Required external meaning; internal treatment |
|---|---|
| Program and generic library | Checked arithmetic, CV denotation, recurrence, EM remainder/shift, DFT/pruning, L-definition and completion/reality theorems. Build/import and proof memory remain measured costs. |
| Fixed specification | c, two heights, axes, all grids/orders, rounding rule, labels and success/repair policy. Prove concrete domains and retained guard inequalities. |
| Generator/CRT, exact roots, exact constants | Small witnesses or their checked producers; bind them to mathematical identities. Bernoulli/pi, log/cis, inverse-root and completion data need their actual proofs. |
| Initial numerical seeds, if supplied rather than generated internally | A concrete bound to each exact argument/grid, and complete verified enclosure witnesses. This alternative crosses once per supplied seed, not once per later arithmetic block. |
| Final statuses | The packed status data plus a theorem of the real-function sign implications in the fixed order. Do not export every internal center as a new literal merely to apply the next theorem. |
| Optional repair checkpoint | Explicitly selected numerical data, or a recomputation obligation. It is outside the minimal status-only output and must be accounted for if used. |

There is no source reason to translate a fresh arbitrary 128+64 integer
payload for each 8192 notional operations. That proxy does not identify the
actual objects above. Conversely, this schedule does not prove that CV's
internal array/list representation, proof construction or garbage collection
will realize the desired reuse.

## What memory and timing can actually be claimed

Summing the enumerated persistent and working arrays, including both tensor
buffers and the conservative scratch reservation, gives an overlapping packed
reservation of **9,075,977 bytes = 72,607,816 bits**. This deliberately sums
source work and transform scratch even though their active phases differ.
The conductor factor adds 34 bytes. This is an upper reservation for those
enumerated fields only, not a complete process or algorithm peak.

Write the complete proposed packed peak as
`9,076,011 + E + C + R + I` bytes, where E bounds elementary/EM raw working
arithmetic and witnesses, C completion/phase storage, R retained repair data,
and I scalar/index/control scratch not in the tables. These terms need an
implementation and proof of their lifetimes. No finite numeric total peak is
asserted while they are unspecified. If the source pools are released before
final export, that does not erase their earlier peak.

HOL has an additional, presently unmeasured cost for CV integer/constructor
objects, list or array nodes, aliasing and copies, persistent proof terms,
generic theory state, cache registries and evaluator stacks. Packed bytes do
not bound those quantities. An implementation should report actual live
object counts, maximal integer capacities and RSS beside the packed schedule,
and distinguish retained shared objects from reconstructed equal terms.

The next measurement must use this actual c10004 program and the same final
contract for both compared paths. Record source proof/seed generation,
one-time external-to-CV translation, internal pool updates, EM/Horner,
transform, completion/radii/signs, compact decode/export and all theorem
construction. Include whole-process CPU and peak RSS, since a sum of selected
phases misses setup and proof assembly. Compare identical source identities
and statuses, with corruption controls and a real strict-sign success gate.
Generic library construction and optional second replay are separate totals.

Compact02 establishes a useful integer-only example of avoiding large final
decoding. It does not measure this source pool, the transform, completion, or
analytic theorem construction. This note gives a concrete replacement target
for the representation proxy, not an hours refund or a new forecast.

## Source locations

Paths below are relative to the repository root. The accompanying hash ledger
is appended from the exact files read. Relevant sections are:

- `hol-platt/ANALYTIC_BLOCK_PLAN.md`, fixed real block and measurement gates.
- `forecast-audit-20261113/C10004_PARAMETER_PACKET.md`, exact selected rows,
  source, degree grids and character ordering.
- `SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md`, sections on concrete source
  grids and persistent state.
- `SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md`, head/endpoint recurrences,
  finite shifted-polynomial bound and unbounded elementary temporaries.
- `RAW_HEAD_GRID100_PRODUCER_AUDIT_2026-11-11.md`, integer pool, conductor
  factor, raw witnesses and grid100 interface.
- `MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md`, equations (2), (4), (5)
  and the whole-conductor peak formula.


| Exact source | SHA256 |
|---|---|
| `work/backend-costs-20261112/hol-platt/ANALYTIC_BLOCK_PLAN.md` | `55E63C1849DC9D9007DD8085D0FD4EEE2CD98CEBDA57E14554A5DB23A9F3AD1C` |
| `work/backend-costs-20261112/forecast-audit-20261113/C10004_PARAMETER_PACKET.md` | `2B8102E8134B8BC9DA5BD93DD2105673EE6614B2D3D721B7E701F3A38C09F8EF` |
| `work/qrh-blueprint/SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md` | `8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413` |
| `work/qrh-campaign/agents/prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md` | `251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231` |
| `work/qrh-campaign/agents/integration/RAW_HEAD_GRID100_PRODUCER_AUDIT_2026-11-11.md` | `FBBB538E0FC72865A9B4815A048992644AA0563AFC2DEA970FB9C3B4F7596EEE` |
| `work/qrh-campaign/agents/independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md` | `5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A` |
| `work/qrh-campaign/agents/major-constants/reconciled_nonprincipal_schedule_20261111.json` | `0E83C9AB65725FBD34F0D34FC462E9EC805A040717DA92B1AB262CC7A9345397` |
| `work/backend-costs-20261112/raw-state-compact/RESULT_REVIEW.md` | `54B232E4EF22A02531D10CC16EDCE468538B409B763C6D88B9EC61C494FA4333` |
