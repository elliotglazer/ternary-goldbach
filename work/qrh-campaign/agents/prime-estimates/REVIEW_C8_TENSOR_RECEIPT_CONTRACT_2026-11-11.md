# Independent review of the conductor-eight receipt contract

2026-11-11. **PASS for the corrected paper/schema contract.** The compact representation preserves the accepted mathematical and independent-containment obligations. Two requested clarifications are incorporated: explicit shared-root labels and the scope of the independent endpoint-power P-jet method. No further correction is required.

This review used document reads, hashes and direct mathematical checks only. It ran no evaluator, scalar script, process-capability test, numerical experiment, Lean or Lake build. It prepared no evaluator code and changed no author file. Acceptance of this schema is not authorization to execute it.

## Frozen versions

Paths are relative to `work/qrh-campaign/agents`.

| Artifact | SHA256 |
|---|---|
| `integration/C8_TENSOR_RECEIPT_CONTRACT_2026-11-11.md` | `8B22F47F6C1EE461C4AB2E56A34D7DDA0A74BC1B75829C8263558B4493729EB8` |
| Governing `zero-sum/NONPRINCIPAL_TENSOR_PILOT_DESIGN_2026-11-11.md` | `3B4B21946F89CA503F03A2BBC030B73F556B31254BA643C427AFB1B39CA5A43B` |
| Its `moebius/REVIEW_NONPRINCIPAL_TENSOR_PILOT_DESIGN_2026-11-11.md` | `0046FAEEC56248F33F5AB9CD80E8C8675631FBF77679FE54CE436DD9A56FCFA3` |
| `major-constants/C8_INDEPENDENT_POLE_JET_ALLOCATION_2026-11-11.md` | `59C6448E26CDC8AD7DA944017C555B2F3B3F1A4D70E98B4B275585FA5BC46E48` |
| Its `moebius/REVIEW_C8_INDEPENDENT_POLE_JET_ALLOCATION_2026-11-11.md` | `B50F5AF842E71467E821F97070D6315F08E5921F29E16D5362561B48591D851E` |
| Conditional `audit/C8_EXTERNAL_SUPERVISION_DESIGN_2026-11-11.md` | `EF2EF80F930AA029DE7418C9759A01465A867A40DFACAA0F9FE9B67ED8FC6B19` |

These pins were checked locally. The original receipt-contract pin `717110591A5572B4895878EE2E8597B9C7BCB640E988219421FE5177CF82D79C` is superseded; this verdict binds only the corrected version. The supervision document is used as a conditional implementation requirement, not as evidence of a working supervisor or host capability.

## Complete indices and actual-function scope

The fixed parameters, three centers `1+i/8,1,1-i/8`, thirty normalized complex-s derivatives, full radius-1/16 disks, signed time increment, and all finite-U conductor factors match the governing design.

The dense positions are bijective mixed-radix encodings of the required index sets:

| Layer | Required records | Scope retained |
|---|---:|---|
| `(h,m,u,k)` moments | `30*32*4*16=61,440` | Every bin, including empty and exact-zero slots |
| `(h,m,j,r)` tensor outputs | `30*32*3*4=11,520` | All four character rows, including 2,880 principal artifacts |
| Nonprincipal coefficients | `3*3*30=270` | Only labels 01,10,11 |
| Full disk models | `3*3=9` | Actual level-eight nonprincipal L-functions |
| Endpoint incidences | `3*3*2=18` | Twelve distinct character/point pairs, shared endpoints duplicated by incidence |

The unit order `[1,5,7,3]` is the order of `(-1)^e*5^f` with f fastest. The character signs, conductors and parity match the accepted table. The principal row is retained where it is needed to check the finite tensor circuit, but cannot acquire an actual-L coefficient, disk or endpoint claim. The conductor-four row remains an actual nonprincipal character at level eight. Exact multiplication and reduction-kernel checks, rather than just row counts, are still required to identify the source characters.

The time labels are 0,15,14 and the exact contraction arguments are 0,1/3,2/3. The two normalized transforms require scale `4*16=64`. Full signed bin integers remain in the residual; only their residues index arrays. There is no extra conductor power, Gauss factor, parity half, or s-1 normalization of the full L-function.

Endpoint heights from `(1-j)/8+(1-2*side)/16` are `(3/16,1/16)`, `(1/16,-1/16)` and `(-1/16,-3/16)`. The schema does not replace these incidences with a smaller set of shared images. All jet and conjugation formulas use complex-s derivatives; no extra `(-1)^h` is appropriate at conjugate centers.

## Norm semantics and independent containment

A C record stores a closed rectangular witness with an exact midpoint and two nonnegative coordinate radii. It is not itself a Euclidean disk of either coordinate radius. The canonical moment/tensor target radius is separately fixed to epsilon=`2^-90`. The producer must prove that its own rectangle encloses the intended value and lies within epsilon/4 of its midpoint, for example using the sum of coordinate radii. Independent rectangles must fit completely in the immutable radius-epsilon target about that same producer midpoint. The specified squared-distance or L1 tests include midpoint displacement; center agreement alone cannot pass the gate.

The same distinction is retained for all 270 finite-L coefficients: independent complete enclosures, including any separately retained norm tails, must have maximum distance `D_h<=2^-75` from the exact producer center. The nine independent inequalities sum `rho^h*D_h`, add the actual EM and finite-function Taylor bounds and any evaluation arithmetic, and require a strict total below `2^-68`. This proves a full-disk polynomial tube, not a sampled comparison and not an actual-L derivative estimate inferred from a pointwise EM error.

Every one of the eighteen endpoint balls has the prescribed producer polynomial-evaluation center and radius `2^-68`. The center's evaluation error is separately bounded by `2^-75`. The independent actual-L enclosure must fit wholly inside that particular ball. It may not replace the producer center with an easier one. Shared-coordinate equality, overlap, conjugation and realness checks are explicitly auxiliary and cannot replace any containment or operation proof.

The per-order main residual and the producer's P truncation error enter the complete coefficient/correction bounds once. Neither is added twice in the disk test. Coordinate-square padding of analytic errors still pays the norm conversion. Header constants do not replace verification of the underlying source domains and inequalities.

## Shared roots and reconstruction of the circuit

The repaired table means exactly `root[t]=exp(2*pi*i*t/16)` for t=1,...,15, with root[0]=1 exact and implicit. It is a table of powers of one positive primitive root, not fifteen primitive roots and not fifteen stage-local records with duplicate zeros.

A butterfly of length d uses `root[(16/d)*b mod16]` for local `0<=b<d/2`; this is exactly `exp(2*pi*i*b/d)`. A direct transform term uses `root[k*ell mod16]`. The positive sign, bit-reversed radix-two schedule, normalization by two at each stage, and f-axis then e-axis group transforms give the same normalized finite tensor map. Negative time is represented by the selected output label, not by silently conjugating the input.

Omitting stage dumps does not omit circuit verification. The chosen method reconstructs every butterfly by deterministic exact-rational interval operations starting from exact serialized moment centers and the retained root rectangles. Its whole result must lie in the supplied own witness rectangle, itself inside epsilon/4. This is a new certificate calculation for the mathematical circuit, not a claim to reproduce unrecorded native 192-bit intermediate balls. It can fail because of interval width, output mismatch or resource limits; the schema does not promise otherwise.

The separate independent program must also check all 11,520 outputs by direct finite tensor sums with independently enclosed roots. Neither that calculation nor the reconstructed circuit substitutes for the actual-moment layer. Unused intermediate stage outputs are not advertised as independently checked function values. Reconstructible stage data and absent uncheckable data are properly distinguished.

## Producer and independent pole-jet paths

The producer retains the Q32 moment formula, all sixteen conductor-scaled Bernoulli corrections, and the complete half/P/addition error accounting. All twelve residue/center packets and 192 Bernoulli term series are represented explicitly or by deterministic reconstruction. The a=1 branch gives ninety exact zero P jets. At s=1, exact `E=1` and `phi_k(0)=1/(k+1)` are rational identities; nonreference jets retain their full log-power convolution. Rational moment values need not be dyadic and have their separate wire type.

The corrected schema now admits the independently reviewed endpoint-power route without changing the producer:

`P_h(1)=((-L_a)^(h+1)-(-L_1)^(h+1))/(8*(h+1)!)`.

Thus h=29 requires power 30 and factorial 30!, not a numerator series stopped at degree 29. Off center, `q*P_h+P_(h-1)=N_h/8` yields exactly `-i*N_h+8i*P_(h-1)` at q=i/8 and `i*N_h-8i*P_(h-1)` at q=-i/8. These are checked signed-coordinate operations, never division by an uncertain near-zero interval. They are not applied at q=0.

The full thirty-order amplification `(8^30-1)/7`, elementary bound `2^-240` and complete named-gate bound `2^-224` remain explicit. A 256-bit setting does not establish these inequalities. This independent formula has zero Q32 truncation tail; all of its elementary/arithmetic errors still have to be proved and retained. The exact method is fixed at code preflight, not switched after a failed run. Restricting s-1 operations on the full L-function no longer accidentally bans this valid internal P calculation.

## Encoding size and operational conditions

The finite wire limits are safe acceptance restrictions, not assertions that every computed result fits. Dyadic mantissas satisfy `abs(m)<2^256`, exponents `abs(e)<=4096`, with canonical odd nonzero mantissas and exact zero encoding. General rational records have positive denominators, bounded bit lengths and separate types. Over-limit records must fail without clipping values or making huge shifts before validation. Floats, booleans in integer positions, duplicate keys, malformed counts and unknown tags are rejected.

The byte bound is correct under the required compact ASCII encoding. A signed mantissa needs at most 79 characters; quotes add two, a signed exponent at most five, and pair punctuation three, totaling 89 bytes per D. Four D values plus outer brackets and three commas give 361 bytes per C, or 362 including a following comma. Therefore the 72,960 mandatory bulk entries occupy at most 26,411,520 bytes. A zero token saves storage while preserving an indexed claim whose exact-zero semantics still must be justified.

This does not bound remaining sections, temporary rational arithmetic, peak memory or runtime. The 48 MiB payload, 4 MiB companions, 4 MiB logs and 8 MiB reserve remain inside the aggregate 64 MiB allowance. Every partial, pending, checkpoint, manifest, supervisor log and seal counts. There is no permission to drop a required record to fit. The allowance is per attempted job; an independent job can read the frozen producer input in place, while any retained copy counts as its own output.

The fixed jobs remain one 192-bit producer attempt with a 180-second launch-to-exit limit and one separate 256-bit independent attempt with a 300-second limit, each with a 512 MiB lifetime peak-working-set cap. No worker subprocess, automatic retry, hidden second precision or delegated computation is allowed. External supervision covers the complete launch/setup/computation/serialization/exit interval. A worker's candidate-complete token is not a supervisor seal and does not attest to its future shutdown peak.

The retained-handle, signaled-exit, fresh final `PeakWorkingSetSize` protocol is explicitly conditional on a separately checked host/API capability. Missing, zero or inconsistent final telemetry fails closed; neither commit accounting nor the maximum of live samples is a substitute. The pinned supervision design also requires a monotonic start before native process creation, an observed-exit deadline check, and waiting after asynchronous termination. None of those capabilities was tested here. The schema requires later supervisor implementation/static review and benign capability evidence before numerical authorization.

Exclusive attempt creation, bounded streaming, no-overwrite publication and a hash-bound post-exit seal preserve the distinction between partial files and completed evidence. Exact code and platform behavior must still be reviewed; this paper state machine does not prove crash recovery or race freedom. A valid mathematical payload with missing lifecycle evidence remains incomplete, and a valid seal cannot make false numerical claims true.

## Final scope

The corrected contract preserves all required evidence and source meanings. Its repair changes neither mathematical target nor fixed resource limits. It provides no actual enclosures, code, working supervisor, successful cap measurement, spectrum, nonvanishing result or Lean theorem. The next gates are concrete implementation/static review, required capability evidence, a separately bound execution decision and complete independent validation. No execution follows merely from this PASS.
