# Static arithmetic review of the rational direct-g j7 code

2026-11-11. Verdict: PASS for static arithmetic fidelity to the accepted paper specification. No mathematical or rounding-schedule correction is required in the two versions below. This is not an executed acceptance result. Neither evaluator was imported or run during this review, and no elementary values, coefficients, images, or negative-control outcomes were computed. There was no Lean build.

## Exact versions and scope

All paths below are relative to `work/qrh-campaign/agents/`.

| Item | SHA256 |
| --- | --- |
| `integration/rational_direct_g_j7_producer_20261111.py` | `B633D322F0B696CDF59FEDB668CE62F4EE13E5BFAC28BC0959E9AF13E37315D7` |
| `moebius/rational_direct_g_j7_independent_20261111.py` | `4762265952B7DD4E5382BC0426205A84BB766EFA43A872DDD6E148EF15674FDC` |
| `major-constants/RATIONAL_DIRECT_G_J7_PILOT_SPECIFICATION_2026-11-11.md` | `8AE42550658C25548352161EBBB8A1FDCBC967F7E32772C9D2FF1826AAACEEC2` |
| Independent paper-specification review | `0ED13860F941BE3786D9EE780F71590581D2C658BF30B84A8CE79AF383ABE4ED` |
| `major-constants/FINITE_EM_INNER_ROUNDING_ALLOCATION_2026-11-11.md` | `60B4BC4414A75B90BF036E0CBA2CAB6F12C270CF7DE1F45C767341D872D383E9` |
| Independent inner-rounding review | `E2AFC3467382506F4D68CDB9E7AA0307C911B0F2195032E505C4EC8E69D6401B` |

Earlier draft hashes are not covered by this verdict. I reread the final arithmetic and receipt-validation sections after the authors froze these replacements and checked both final file hashes. The producer's final changes guard raw integer arithmetic and check the complete Q identity in its omitted-B control. The independent checker's final changes strengthen input, type, manifest, and evidence validation without changing its numerical recurrence. Its last change from E6EE3863 explicitly checks 0<=logn<=8 after each independent forward logarithm, before using the normalized-power bounds.

The immutable proposed output is `integration/small_em_batch_candidate_20261111_01.json`, hash `2ADDFE3FE7D77B8CC10606886CC580D5C8103B30B0E4CD3BC9507AB27B198F7E`. Only its sixteen j7 coefficient squares, one whole panel, and endpoints 7 and 8 are targets. The initial candidate's source declares schema `small-em-batch-candidate-v1`; the independent checker's matching literal is correct.

## Rounding and elementary leaves

The producer's `Gates.real` and `verify_round` implement nearest rounding with ties toward positive infinity. For rational p/q with q positive and S=2^g, the computed integer is floor((2pS+q)/(2q)). The separately tested relation `(2m-1)q <= 2pS < (2m+1)q` has the correct negative-input and tie conventions. The Euclidean remainder check is consistent with this integer. The independent `nearest`, `signed_witness`, and digest encoding use the same rule. A complex gate rounds both coordinates. On grid 2^(-1041), for example, its norm error is at most sqrt(2)*2^(-1042), below the allocated 2^(-1040).

The following implementation details match the accepted error proof:

* `log_inner` starts at zero, runs indices 511 through 0, and then multiplies by 2t. It is the 512-term atanh polynomial, not a 513-term variant. The exact reduction t=(n-2^k)/(n+2^k) lies in [0,1/3]. All 1025 labels are retained, including exact n=1.
* The log-two cache remains at the inner grid. Each other logarithm combines k times that raw cache with its reduced logarithm before its single canonical rounding. No earlier canonical log-two error is reused k times.
* Both Machin arctangent polynomials have 256 terms with alternating sign. Their weights are 16 and -4. The combined pi center is rounded once to the canonical grid.
* The exponential Horner loop starts at 1 and runs denominators 512 down through 1. Induction gives the degree-512 exponential polynomial. The real input is divided by 16, followed by exactly four rounded squarings. The complex loop evaluates at i times the reduced real angle.
* The signed period is the nearest integer to theta/(2*pi_hat), with the same half-open tie rule. The code checks its magnitude below 4096 and the reduced argument below 4. Its pi-uncertainty cost is therefore bounded by 8192 eta. The unreduced phase and nonpositive real-exponential domains are checked.
* The canonical product uses grid 2^(-1025). Actual positive-base phases carry radius 2^(-499), not the smaller error for an exponential at an already exact rational argument. This preserves the log-input perturbation.

The source loops account for the recorded gate counts: the shared raw log-two/Machin computation has 513+257+257+1=1028 coordinate gates; every nonidentity logarithm has 514; every nonidentity phase has 512+4+1024+2=1542. Sixteen head, correction, and final coefficient gates add 96 coordinate gates. The checker reconstructs these events and their exact rational inputs rather than treating their digests as numerical evidence.

The independent path does not reuse the producer's elementary algorithm. Its forward exponential starts with exact term and sum 1, updates the term before the sum, and includes all 512 term and 512 sum gates. This is the schedule bounded by 512*(exp(R)+1)*deltaI, not by the Horner error alone. The four-square contribution 81*tail+165928*deltaI matches the paper specification. Its forward log and arctangent paths round the initial power, then each term and accumulator, and omit an unused final power update. Their 23936*deltaI and (46720/3)*deltaI aggregate constants include these operations. Its raw log-two cache is also unfinalized. The grids 1081, 1057, and 545 match deltaI, etaI, and epsilonI.

## Complete normalized finite-g coefficients

Write c=629/1250+i*31985/16, B=1025, and b_m=B_(2m)/(2m)!. Both programs compute the degree-below-16 part of

```
C(c+z) = 1/2 + sum_(m=1..16) b_m * B^(-(2m-1)) * (c+z)_(2m-1),
Q(z)   = (c-1+z)*C(c+z) + B,
g(c+z) = (c-1+z)*sum_(n=1..1024) n^(-c)*exp(-z log n)
          + B^(-c)*exp(-z log B)*Q(z).
```

This is the accepted finite EM expression, including its half term, all sixteen signed Bernoulli terms, and B^(1-s). The exact B in Q is essential. There is no residual-bin approximation or p=24 tail in this direct route.

The producer's old-array affine update multiplies by c+length-1+z. Lengths 1 through 31 are formed; odd lengths select exactly m=1 through 16. Truncating at degree 15 at every multiplication is sound because all polynomial degrees are nonnegative. The independent checker forms the same products with a separate truncated polynomial convolution. Both Bernoulli recurrences use B_1=-1/2 and the binomial identity for every index through 32; these are normalized by (2m)! before entering C.

The recurrence for a log-power coefficient divides by h at step h. Thus every output is an ordinary complex-s derivative divided by h!, with no missing factorial or power of i. Head sums use n=1 through 1024, while the separate B=1025 phase supplies the full correction. The h=0 predecessor is zero. The final assembly `(c-1)*D_h+D_(h-1)+correction_h` is correct.

There are only the three named finite-g rounding locations: completed head, completed correction, and final assembled coefficient. The rising products, sums, and convolutions between them are exact Fraction arithmetic. The independent construction reverses the head order and uses its finer outer grid. Its replay construction retains ascending order and the producer grid, so regrouping exact correction products does not change the rational input to the final correction gate.

Both versions check the coefficient l1 bound on Q below 2^48 and the normalized Bernoulli coefficient bound. Their scalar predicates match the paper allocations: head below 2^70 epsilon, correction below 2^78 epsilon, and full g below 2^84 epsilon. The resulting declared producer and independent radii are respectively 2^(-420) and 2^(-450), larger than the proved bounds 2^(-428) and 2^(-460). These predicates have not been executed in this review.

## Containment and the actual-zeta images

The independent program first reconstructs the producer's deterministic leaf and outer gates. It then builds fresh forward-series leaves and fresh complete coefficients. Log, phase, and final-coefficient comparisons require containment. The use of the l1 distance between complex centers is conservative for Euclidean disk containment. In addition, both sets of final coefficient balls must fit inside the immutable old coordinate squares. No overlap test substitutes for those checks.

The panel center, top 15993/8, bottom 1999, and owners of endpoints 7 and 8 are consistent: subtracting the center height gives offsets +1/16 and -1/16. Both image routines perform rectangular Horner on the old squares, not the fresh narrower centers. They add exactly

```
4*2003*33/(63/2)*(2034/(6*1025))^32 + 1/(15*2^33)
```

to each coordinate radius. This is the EM plus finite-polynomial Taylor padding from the accepted source argument. Coefficient uncertainty already resides in the old squares and is not added twice.

The denominator is the whole s-1 rectangle. The unary interval square correctly handles a zero-crossing interval; its norm-square lower endpoint must be positive. Each implementation forms a reciprocal rectangle before multiplying the numerator rectangle. The independent inverse-scale implementation and the producer's interval-division implementation have the same four-corner extrema with a positive denominator. This preserves the old operation order; reassociating interval multiplication and division could have produced a different box. The code demands exact equality of all three reconstructed old images.

The code's semantic negative controls exercise the relevant rejection predicates, including missing n=1024, wrong center/owner, changed Bernoulli sign, omitted B, invalid signed rounding, missing Taylor padding, and changed endpoint data. Static inspection establishes what these tests attempt. It does not establish that a future complete run reaches them or that all tests pass.

## Remaining acceptance boundary

This review approves the arithmetic implementation plan for the exact two source hashes. It does not authorize execution, verify a produced receipt, prove successful containment, or certify a nonvanishing margin. A complete bounded run must still produce its prescribed evidence, pass the mandatory independent reconstruction, and obtain the separate external post-exit resource seal. Worker `CANDIDATE` or `ARITHMETIC_CANDIDATE` status alone is insufficient.

Source and paper identities are still mathematical inputs to this Python acceptance exercise. A future Lean result needs verified elementary, EM, coefficient, interval, decoding, and finite-arithmetic bridges. Compact gate digests plus deterministic reconstruction are not a standalone Lean proof trace. The earlier seven centers, every old FFT/internal-batch assertion, and full strip coverage remain outside this j7 review.
