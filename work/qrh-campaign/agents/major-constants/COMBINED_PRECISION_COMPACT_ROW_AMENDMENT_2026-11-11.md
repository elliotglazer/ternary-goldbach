# Compact combined-assignment row amendment

2026-11-11. Narrow proposed successor to the frozen combined-assignment preflight `B563B8CC28DC1F2BCF08390BCF9385AD504432940A0C22D263BC9002037158B2`, reviewed at `E1DA5A7A4101326B2419EB9367D842405AB9965DC44B8807B33CE8F345C9B2B8`. Independent review, exact revised-writer clearance and coordinator authorization are required before another execution.

The failed first run is preserved in `COMBINED_PRECISION_FIRST_RUN_STOP_2026-11-11.md`, SHA256 `11FA5B695F37C9A2A0669282CDFC4D8A351D2FBD54E4A55AB240E0FD444938DD`. Writer `D0764C6DFEB13453D4F47356EAC62A7138CEBF8F9963B6F2AC1E30C3F1D1F785` stopped at its encoded artifact cap after30371291 checks. No output file was opened. The generic diagnostic did not report filename or byte count; no actual size is inferred here. The failed writer will be preserved as `combined_conductor_precision_assignment_20261111_v2_failed.py`. Its input, mathematical and prior exact-match conditions are unchanged.

## Only the new row serialization changes

Use row schema `combined-conductor-precision-rows-2`. Store precisely

```text
[source_row_id,c,phi,primitive,S_mix,S_sharp,S_tight,S_base,
 D_local_old,p_mix,p_sharp,p_comb,rho]
```

Omit the four deterministic new slack columns from serialized rows. Still compute and check them at the exact same points in the writer. In particular, with Q=2^52, Cg=4196258524692480 and V_error=8828, define

```text
budget(p) = c*((Q-1)*Cg)^2
            - phi^2*((Q-1)*rho_p+Q*S_tight*8828)^2*2^(2*(108-p)),
D_slack(p) = 2^p-D_local_old,
peak_slack(p) = 2^p-2*S_base.
```

The selected p must have all three slacks nonnegative. If p>80 its immediate predecessor must fail; because both safety guards hold throughout80..108, the predecessor budget is negative. At p80 the predecessor is absent. The independent reviewer must reconstruct and check these quantities from every compact row, not trust an aggregate successful-check count. Reconstructing these integers is exact proof/checking work, not a numerical evaluation. No sufficient error threshold, precision search, arithmetic coefficient, source/input contract or cache rule changes.

All exact old and sharp rows/slacks remain compared with their immutable full representations. Their cache keys, ordered child references, contracts and summary totals must still match before new publication. The new cache file binds the new row artifact hash, so a schema1 hash is never substituted for schema2. All four output basenames remain the same because no first-run output exists. Their exclusive-creation requirement is unchanged.

## Static row-size bound

The new writer checks the supplied metadata ranges used in this estimate. Source row id is below125400; `1<=primitive<=phi<=c<=265800`. The phi/c inequality is a validity check on the supplied Euler-totient metadata, not a new totient or residue enumeration. Existing saved-axis products and source identities remain checked. Each of S_mix,S_sharp,S_tight is between0 and202305920, S_base is between0 and424706204, and D_local_old is between1 and29961461170177. All three precisions are between80 and108, with legacy/sharp still at least100; rho is0 or1.

The thirteen decimal integer fields use at most

```text
4*6 + 3*9 + 9 + 14 + 3*3 + 1 = 84 digits.
```

A compact JSON row has two brackets and twelve commas, so at most98 bytes. Charging one separator after every row gives at most99*125400=12,414,600 bytes. Require the encoded row metadata wrapper with `rows=[]` to occupy at most1 MiB. The complete row artifact is then at most13,463,176 bytes, safely below the existing32 MiB cap. The estimate is conservative about the last separator and empty-list brackets. It does not depend on the observed precision distribution or slack lengths.

For comparison only, the old seventeen-field representation had no corresponding32 MiB guarantee. The same global metadata bounds give a selected budget below2^227, D/peak slacks at most2^108, and a generic preceding test magnitude below2^284. These allow69,33,33 and87 signed-decimal characters respectively. With the original84 digits and seventeen-field punctuation, a conservative row-and-separator bound is325 bytes, or40,755,000 bytes for125400 rows before metadata. This is an upper bound, not an assertion about the failed artifact's actual size or identity.

## Same limits, clearer failure reporting

All ten inputs and their hashes remain unchanged. Keep the exact75,419,343-byte allowlist,96 MiB aggregate and32 MiB per-input caps,37117 nodes,13943 axes,125400 rows,29 candidate tests per row, compact masks,200000 record cap and observed1 GiB private-memory stop. The output caps remain32/8/4/1 MiB and48 MiB total. No larger cap or additional input is authorized by this amendment.

The revised writer must report the artifact name, actual encoded byte count and corresponding cap in any serialization-size failure. It must continue checking every output size and every destination before opening any output. Record each own-created path immediately after successful exclusive open, so write/close failure reports incomplete artifacts. Preexisting refused paths must not be reported as created by this run.

The source-only revision and this amendment introduce no data fold. A new exact source hash will be submitted for inspection. No rerun is allowed before the reviewer clears that source and the coordinator authorizes this schema successor. No price, source-output, guard, numerical-cache or function-value work is included.
