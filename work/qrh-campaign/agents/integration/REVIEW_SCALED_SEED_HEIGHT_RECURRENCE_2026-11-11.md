# Independent review of the scaled seed height recurrence

2026-11-11. PASS at paper and exact-metadata scope, with no correction requested. This review binds `work/qrh-blueprint/SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md`, SHA256 `8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413`.

I read the complete note, scalar script and receipt, and the referenced grid-anchor construction and its review. I independently reconstructed the error argument, cohort lifetimes, precision conversions and state-width bound. The attached independent script imports no producer code and completed1,098 exact rational and integer checks. It computes no log, root, phase or seed value. No build or frozen-file edit occurred.

## Actual recurrence and complete error

For fixed positive rational x and h=5/64, the identity B(x,t+h)=cis(-h log x)B(x,t) holds for the actual critical-line power. The true step has modulus one and the true B has modulus at most one. The stored step need not have modulus one. Therefore the correct error recurrence is

    e_(j+1) <=(1+eps)e_j+eps+u.

The report retains both occurrences of eps. For j<=J, binom(j,k)<=J^k bounds the finite binomial expansion by the geometric series with ratio J eps. Here J=128000 and eps=u=2^-140 give J eps<1/2, hence the factor is below2. This proves the stated bound uniformly over all required iterations without computing a giant rational power.

The initial p120 leaf has error below(7/16)2^-120, which is less than delta/4 for delta=2^-118. The shared log error2^-144 is stronger than its required2^-137. Its final coordinate grid2^-123 embeds exactly in the finer state grid2^-140, so no extra initialization rounding is silently omitted.

For the step, p138 in the cis-only construction gives error below2^-142 at the exact rational approximate phase. The additional conversion to grid2^-142 is separately charged. The true phase differs by at most(5/64)2^-144. Their sum is

    (517/1024)2^-140 <eps.

The initial and step polynomial term counts74 and83 follow from the reviewed variable-p rule. A pi certificate accurate enough for p138 also meets the p120 requirement. Exact signed period reduction is still needed separately for each phase. Neither sharing pi nor using a small step phase removes that witness.

After all updates, conversion of a separate copy to the EM grid costs at most2^-122. The complete bound is

    2(delta/4)+4J*2^-140+2^-122=(701/1024)delta
      <(11/16)delta<delta.

The state used in the next recurrence must remain on its finer grid. Feeding the converted EM copy back into the recurrence would violate the proof. The copied output's radius is sufficient for the previously reviewed scaled EM circuit, including at band transitions.

## Grid, first-use heights and counts

At one height the exact argument set is x=1+k/D with 0<=k<=(N+1)D. It includes every head argument and the endpoint b=N+z. At a band transition, the old index embeds by multiplication by D_new/D_old; the new N endpoint is no smaller. Thus the sets are genuinely nested, not merely sets with increasing cardinality.

Initialize a newly introduced argument at the first height of its band. An old argument gets one update at that height. This accounts for each height/argument pair exactly once and does not require new arguments to have existed at earlier heights. The height-index intervals are0..6400,6401..12800,12801..25600,25601..64000 and64001..127988. Their respective physical heights j*5/64 remain within the stated V bounds. Every argument requires fewer than128000 updates.

I independently counted by introduction cohorts: multiply the number first introduced in a band by the number of remaining heights, and by one less for its recurrence updates. This reproduces the report's distinct counts:

| Quantity | Count |
|---|---:|
| Arguments, initial leaves and step certificates | 27,754,497 each |
| Height/argument pairs and EM conversions | 2,068,812,377,589 each |
| Recurrence updates | 2,068,784,623,092 |

This calculation is independent of the report's per-band update subtraction. It also confirms that zero-height special cases have not been used to claim extra savings.

The degree21 log construction at target2^-144 is a valid instance of the accepted general block rule. Its tail2*128^-22 is below2^-147. I reconstructed the1,046 geometric blocks using integer endpoints, obtaining exactly27,754,497 covered points. The nonanchor stage count is21*(27,754,497-1,046)=582,822,471. Anchor certification, assembly and round-witness costs remain additional.

## Storage and cost boundary

The proved state magnitude is below2, and the stored step magnitude is at most1+eps<2. Signed144-bit coordinates with140 fractional bits for state and142 for step suffice. The step format has the tighter signed range, approaching2 from below, which still contains every coordinate. Initial outputs and step outputs lie on the claimed grids.

Two complex arrays need four18-byte coordinates per argument, giving1,998,323,784 raw bytes. This is a possible packed representation, not a claim that an implementation automatically uses18-byte scalar arithmetic. Alignment, decoded temporaries, full products, proofs, indices, output arrays, worker replication and I/O are excluded explicitly. In particular the width statement is not a bound on raw multiplication intermediates or proof-environment memory.

The comparison correctly retains initialization, step certification, updates, EM conversion and state costs separately. Log setup cannot simultaneously be counted as shared and hidden inside a full opaque initialization price. Amplitude certificates can be consumed at first use only after their proof obligations are discharged. Streaming or sharding may change the retained state but can add regeneration or rechecking; no constant-memory or runtime winner follows.

This establishes compatibility of the paper schedules and their exact inventories. It supplies no new numerical data, executable checker or kernel proof. Actual arithmetic, parameter binding, the analytic library, phase witnesses and the downstream spectral sign/count obligations remain necessary.

## Frozen evidence

| Artifact | SHA256 |
|---|---|
| `work/qrh-blueprint/SCALED_SEED_HEIGHT_RECURRENCE_2026-11-11.md` | `8ABDD8A1F991AF9FEACE49908E5BA865EC3FD5804311CAE73AB9D80A4456D413` |
| `work/qrh-blueprint/check_scaled_height_recurrence_20261111.py` | `F9A4A552EFAD7CE139D4E61D9378E40A9B0138CE8CB2CBB03848DAAE23D9AB3F` |
| `work/qrh-blueprint/scaled_height_recurrence_20261111.json` | `10058EA331D8FC143981F3DA1AC5BA92AEEEF03553849A2E4666CA0783462F02` |
| `integration/check_height_recurrence_review_20261111.py` | `AF99051F169BF6C2D9A7ACD84B0D5DB64F47B5FF9C1451728043919760916682` |
| `integration/check_height_recurrence_review_20261111.json` | `B6A2AF23EA08AC5AA418BE00B883B9DA83B0607E8AFAD1AEA1C37FBAE2D7ABB0` |

The independent receipt also verifies the six author-listed prerequisite hashes and records the independently counted cohorts. The producer script was read but not imported or executed in this review.
