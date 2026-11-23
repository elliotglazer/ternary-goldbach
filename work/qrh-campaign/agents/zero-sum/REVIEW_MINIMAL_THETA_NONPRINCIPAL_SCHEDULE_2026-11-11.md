# Review of the conductor-specific theta schedule join

2026-11-11. PASS at bounded coarse-value schedule-composition scope. No correction requested. The explicit conductor choices, preserved operation counts, revised local precision ranges and mandatory rounding correction are joined consistently. No values, transforms, builds or successful spectral certificates are supplied by this review.

The frozen root author is `work/qrh-blueprint/MINIMAL_THETA_NONPRINCIPAL_SCHEDULE_2026-11-11.md`, SHA256 `654484AF0793EA0D5A2D51A2842E06753F4D8CEC0BF75A96953EF017D9B3173F`. Its script is `6174F5C37C0C9D54C566427CD9BBA7E7CF4EBE4A897FA0B491AA29FE5057AFBA` and receipt is `96483C8A5E47888AC9208A8B95CA1BD8261CBC9D42AFBCBAEE1A1ABF10AC9265`.

## Component scope and exact mapping

I read the full join, script, original minimal-theta report, its correction and independent review. The corrected selector is accepted by `audit/REVIEW_MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md`, SHA256 `58215EA3A0D697D229AD746F6FCE340DE913165D63599DC197798E705392308B`. That review, rather than this join check, supplies the independent reconstruction of all130 parameter selectors, minimality, equal time lengths and local tolerance inequalities.

The join enumerates precisely the union of odd c from3 through9999 and multiples of4 from4 through10000, in increasing order. There are7499 conductors. I independently constructed that union and compared every explicit `(conductor,theta)` pair against the selector's ordered list in each of the four scenarios. All29996 pairs agree, all theta are in[64,128], and the recomputed histograms agree. This prevents an unlabeled permutation from preserving totals while assigning the wrong theta to a conductor.

The exact extra-node keys0,167,320,640 agree with both components. These are separate conditional guard scenarios on the already rounded main grids. No choice changes the target height or drops the endpoint, real/central case, required parity or inverse-character channel. The selector's output remains the same normalized Hardy Y; changing theta changes intermediate coefficient values and rescaling factors. No old numerical enclosure is reused merely because dimensions agree.

The large-family object, five seed bands, m159 final construction, setup, family partition and safe output sums match the reconciled predecessor exactly. This includes the final retirement of901120 states, no new final-band initialization, and update counts already verified in that predecessor review. The setup aliases for initial B, step-cis and step-grid calls are explicitly retained as aliases, not new work to add.

## Why all theta128 counts can be copied

The corrected selector proves N(selected)=N128 for each conductor and scenario, with the same X=10, n0=8192, conductor axes, primitive labels and present parities. Thus the retained frequency count, Gaussian term envelope, time-transform dimensions and requested output count are unchanged. Every loop-count category of the inherited schedule is a function of those dimensions and the conductor data. This justifies copying more than the six aggregate fields directly compared in the root builder.

I checked equality of the complete `totals`, `by_conductor_parity` and `time_length_conductors` objects, not only the six named aggregates. All parity subdivisions sum to their totals. In particular the main schedule still charges7969016316193 rounded bucket additions,128941391789290 main character butterflies and89858217607168 time butterflies. The1775431871117 small requested outputs combine with the unchanged large outputs to give38066330390620 in the main scenario.

These remain counts of different operation types. Equal counts do not imply equal numerical operands, elementary-function costs, raw widths or proof sizes. The theta64 and uniform theta128 predecessor schedules are alternatives, not additional summands. The unadmitted point-EM comparator fields remain absent from selected small totals.

## Precision and the mandatory correction

The author correctly replaces the old uniform-theta128 range object with the first two entries of each reviewed selected/old range record. I verified all eight local ranges in all four scenarios. The main selected ranges include seed302–404, character279–411 and time238–340 fractional bits. These are descriptive ranges across local requests, not a single precision to apply everywhere or a complete intermediate-width certificate.

The immutable original minimal-theta note contains an incorrect claim of exact bucket accumulation. The join binds and explicitly follows `prime-estimates/CLARIFICATION_MINIMAL_THETA_BUCKET_ROUNDING_2026-11-11.md`, SHA256 `4ACF800D0F7C773FA5A2DF013BD5F1341ED3CC98C0F9D257D81A2EE63B480D41`. Each parity/frequency bucket retains at most n0 additions at norm-error tolerance

`epsilon(theta)/(32*C*Bpref*n0)`.

The resulting input l1 rounding error is at most epsilon/(32*C*Bpref), with the Gaussian-term error charged separately. The unit-modulus character matrix contributes no further dimension factor to this l1-to-single-output estimate. Intrinsic transform, prefactor and final coefficient errors still have their separate allowances. As C,Bpref,n0 are fixed, the new bucket tolerance is the old one multiplied by `3^(128-theta)>=1`. It is a retained ninth allocation, not one of the eight recorded range fields.

The corrected review also retains prefactor, coefficient, omega and final-Y rounding. The root join explicitly names them instead of treating the eight displayed ranges as exhaustive. I found no deletion of their count or budget. Some individual auxiliary allowances need their full formulas, not just the monotonicity of epsilon; the accepted correction/review covers those formulas. This join does not re-prove them.

Shared roots or cached nonunit kernels must satisfy all their consumers. Local relaxation does not automatically lower the worst-case cache precision. The baseline here is the per-conductor setup count; any common cache is a separately bound replacement. The JSON is a schedule description, not a produced table of valid roots, coefficients or prime/zero facts.

## Coarse-only boundary and remaining work

The new note and JSON explicitly exclude interpolation and off-grid sign work. A future interpolation adapter may require smaller coarse output errors, tighter time/omega arithmetic and extra operations. Nothing in this review transfers the current coarse tolerances to that adapter. Equality of requested values and transform lengths likewise does not prove strict signs, zero separation or Turing closure.

All eleven predecessor required-unpriced records are unchanged, including principal certification, normalization, elementary/EM proof expansion, interpolation and repairs, central/closed count completeness, failed work, data/proof representation, finite binary coverage, the ladder and final analytic theorem assembly. The document contains no arithmetic grand total or measured efficiency ratio. The main histogram's3876 theta64,3613 intermediate and10 theta128 choices therefore describe a precision opportunity, not a realized speedup.

## Independent evidence

`zero-sum/review_minimal_theta_schedule_20261111.py`, SHA256 `BFAEAF854C2A3B9C2ABC3691409DF1EF8EED4F2EC8F95190972916105F43F5A0`, passed30281 exact join checks. Its receipt SHA256 is `A77897C11043F3B0F763BA1B82D879CFB064B5DBE814BF13D599B7BDB39B7385`. The checker verifies the author pins and five frozen dependency pins, every conductor choice, all histograms/ranges, complete copied count objects, parity sums, unchanged large/setup/unpriced objects and output sums. It imports no author generator and reruns no analytic selector or evaluator.

The underlying independent selector and reconciled-schedule reviews remain the mathematical/count foundations. This bounded review closes only their coarse-schedule composition. No frozen source was changed, no build was attempted and no successful numerical or standard-axiom proof execution is claimed.
