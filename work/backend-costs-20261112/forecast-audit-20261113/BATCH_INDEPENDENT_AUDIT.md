# Independent audit of the batched HOL interval

Verdict: PASS for the saved HOL implementation and its stated benchmark scope. The source proof discharges all 1,537 certificate nodes, all 393 requested root-primality claims, and the exact closed interval theorem. No mathematical correction is requested. The trust and timing qualifications below are part of this verdict.

This was a read-only source, data and saved-log audit. No HOL or Lean build, evaluator run, modular-exponentiation replay, prime search or benchmark was performed. The only new file is this report. Small independent Python checks ran in memory and compared the saved literals, integer products, references, witness sums, logs, hashes and medians. The author summarizers were read, not executed.

## The exact theorem and its discharge

The exported `BatchRootsCoverResults.binary_interval` is checked by `audit expected interval` against

    !n:num. 3999999997356537860 <= n /\
            n < 3999999997356539908 /\ n MOD 2 = 0 ==>
      ?p q:num. prime p /\ prime q /\ p + q = n.

It has no undischarged theorem hypotheses. The quantified natural n, its two endpoint conditions and evenness are the intended source domain, not hidden certificate assumptions. The upper endpoint is exclusive. There are exactly 1,024 even targets, the last being 3999999997356539906.

`BatchPrimeScript.sml:20` checks each nonbase candidate p with `1 < p`, the complete expanded factor product `PROD fs = p-1`, every listed factor q strictly smaller than p and present in the certificate tree, the Fermat congruence, and every Lucas quotient-exponent residue-not-equal-to-one condition. Candidate 2 is the sole direct base case and is already prime. Its unused a/fs fields do not assert another prime.

The central proof at lines 35–54 is sound. Successful search identifies an actual node even without a sorted-tree premise. Whole-tree validity therefore supplies a valid factor certificate. Strong induction on the numerical candidate p proves all factors prime, because q<p. This prevents circular certificate justification. The existing `prime_cert_check` theorem then proves p prime. Repeated prime factors preserve their multiplicities in the complete product; repeated modular conditions are redundant but harmless. The source theorem uses the standard full-factorization Lucas criterion, not an unproved probable-prime test.

`tree_valid_primes` and `batch_prime_sound` prove that every node of the projected tree is prime. The concrete evaluator call at `batchrootscoverbench.sml:52` checks `tree_valid certs certs`, so this covers all 1,537 nodes, not merely the requested roots. It does not save 1,537 separate named prime theorems; their joint primality is contained in `cert_tree_primes`.

`BatchRootsScript.sml:10` derives `EVERY prime roots` from that prime tree and a single complete root-membership check. The projection loop at benchmark line 83 unfolds the concrete append/list definitions, applies the ordinary `EVERY` constructor equivalence, and saves each head theorem after checking its exact literal prime conclusion and empty hypothesis list. The terminal empty-list check rules out a truncated projection. All 393 saved root markers occur in the exact requested order in each of the three completed logs.

`FiniteCoverScript.sml:46` checks one explicit pair for every consecutive even target, with both prime-tree memberships and exact sum. Its list induction proves coverage at `target + 2*j` for every j below the list length. The interval adapter at line 65 proves that every even n in the half-open interval has such an index. The benchmark proves evenness, checks the witness length is 1,024 and the literal endpoint is `target + 2*1024`, applies the adapter and unfolds `binary_goldbach`. Thus no tree-validity, root-membership, coverage or endpoint premise remains in the final export.

## Concrete data and the nonminimal root fixture

Independent parsing matched every SML certificate triple to `finite-lean/fixture1024.json`, including all 7,614 expanded factor occurrences. There are 1,537 distinct candidate values. I checked every nonbase factor product and every strict-smaller/present reference with integer arithmetic, without recomputing modular powers. The ordered 393-root list also matches exactly.

Independent parsing of `CoverData.sml` matched all 1,024 pairs in `cover_fixture.json`. Every pair sums to its exact target and both values belong to the proved certificate graph and requested root set. The native flat input was independently decoded and matched these same certificates, roots, endpoints and pairs, with no trailing tokens.

The 1,024 pairs contain 231 distinct prime values. This follows by forming the set of both coordinates of every parsed pair. That set is a subset of the 393 distinct requested roots, leaving exactly 162 requested roots unused by this particular witness list. All 393 are nevertheless genuinely proved and saved. The workload deliberately preserves the original comparison fixture; it is not a minimal certificate for this isolated interval. The 231 count alone does not determine the size or cost of the corresponding recursive subgraph, and this audit claims no unmeasured saving from pruning it.

## Trust boundary and negative controls

The benchmark checks the BatchPrime/BatchRoots ancestry axiom inventory against `bool.BOOL_CASES_AX`, `bool.ETA_AX`, `bool.INFINITY_AX` and `bool.SELECT_AX`. Each accepted concrete theorem is checked for empty hypotheses and the exact expected conclusion. Its oracle-tag check permits only `DISK_THM`.

This is the standard imported-theory boundary, not an oracle-free replay of all upstream proofs. In the pinned HOL source, `Tag.read_disk_tag` adds `DISK_THM` when reading saved theorems. `cv_transLib.cv_eval` combines proved representation/translation theorems with the stock kernel computation facility and conversion back to the original type. `cv_computeLib` explicitly initializes `Thm.compute` with characteristic equations for arithmetic and the cv datatype. Consequently this is HOL4 kernel-compute acceptance, not a measurement of expansion into ordinary PA/MM0 primitive inference steps. The four-axiom inventory does not by itself describe the size of the trusted implementation.

The local source adds definitions and proved theorems, not new axioms. The saved logs contain no additional computational-oracle acceptance, and the current benchmark checks it explicitly. These conclusions assume the recorded HOL executable, loaded theory objects and ordinary saved-log provenance; this read-only audit does not independently rebuild or revalidate every imported binary. Build logs for the local soundness theories show successful exports. Context-snapshot warnings are present and are not hidden proof failures.

All nine rejection markers occur in each fresh completed HOL process: empty prime tree, wrong target origin, missing witness length, wrong endpoint, bad certificate base, wrong factor product, missing factor subtree, self-reference and a composite certificate. The missing-witness and endpoint controls check their stated length/endpoint equations; they are not attempts to reassemble the entire malformed theorem. The self-reference fixture also changes the factor product, so its rejection alone does not isolate the strict-smaller guard. That guard is justified by the source induction. These controls support the tested boundaries; they are not an exhaustive test of all malformed certificates. Native bad-base and bad-sum controls also reject, with no proof authority attached to the native result.

## Performance interpretation

All saved phase values match their logs, process CPU totals match user plus system time, and reported phase medians recompute correctly. Each HOL process exits successfully and exports the identical 2,071,826-byte artifact, SHA256 `54967A90909D342F9EF511F9E22618A829D3693C63E0BAE5D751C62A00EEF667`.

The 0.064050-second median primality phase starts after certificate definitions and cv translations have been constructed. Their 1.467315-second median translation cost remains separate. Root-list translation, root membership, 393 theorem projections, witness translation, coverage, interval assembly and export are also charged separately. The median sum of instrumented phases is 6.005743 CPU seconds and the median process is 13.09 CPU seconds. Individual phase medians need not add to the median phase sum.

The comparison `8.849970 / 0.064050 = 138.1728...` is an implementation-phase comparison. The earlier phase constructed/accepted certificates individually; the new phase benefits from prior data translation and the whole-tree checker. It is not a 138-fold complete-proof saving. The corresponding saved process comparison is `18.27 / 13.09 = 1.39572...`. These processes export different intermediate theory contents while proving the same requested claims. Neither runtime total includes the separate local theory/executable builds, prior fixture production or upstream library construction. Instrumentation, controls, startup and imports occupy the difference between phase and process totals.

The native median 0.002666905-second primality figure is an average over 500 warm iterations in each of three fresh processes, after parsing and an initial successful check. HOL's principal check occurs once per fresh process after translation. Their approximately 24.0166 ratio is a useful reference with different warmup, representation and arithmetic algorithms, not an identical-operation slowdown. Native GMP modular exponentiation produces no theorem. Its separate 0.000146110-second coverage figure cannot substitute for theorem construction/export. The source report states these limitations rather than transferring the ratio to Lean or MM0.

## Pinned evidence

Paths below are relative to `work/backend-costs-20261112/finite-hol` unless stated otherwise. Root added the 231/162 and DISK_THM qualifications during this audit; the final reviewed report pin is the updated one below. No implementation or data file changed in this audit.

| File | SHA256 |
|---|---|
| BatchPrimeScript.sml | `4ACF386084BA31791C7E37AD6ABB8E9C9E72AF97306F6AFBAFF5D057949E96D1` |
| BatchRootsScript.sml | `5A052BFF87239EEED592E243F5FF11ECB81149B4732F3FCE221AB06EE058CC24` |
| FiniteCoverScript.sml | `3F9C714EFD887255F5ABABD628E9675BCA5805EC91DCFA61F5378CF4D5C27B14` |
| batchrootscoverbench.sml | `3DCE1E0A13D27AF291355D716014E41A9262F20D89C59EB596BD745D5C3BF79E` |
| BatchData.sml | `57B45411407BCE9AB6EE9DF0E885272E5DF9435CA50EBBB49905BDDE1E89C63A` |
| CoverData.sml | `3A869771E07E14AFF3E09A70567A0EBA04B15DFB21502D09A7F8744927E2DE78` |
| cover_fixture.json | `D50884A96A7A080DA7D2D9D9308229DCE1DC80FFD470A7DA4D7FFC4512A482D4` |
| ../finite-lean/fixture1024.json | `E1B890823B25AC231C461EA023DDE88076214E3C8B58EC42F6E9155C8E7D9D07` |
| BATCH_REPORT.md | `FAC52C0F64281D135D4984F216BC5DF9CED9A70C912E021CA075E66417F3755E` |
| BATCH_RESULTS.json | `D59E4C1E38CA8455B12C2EF806708B3079C714DDD985410020A7ED1C231BF2E6` |
| NATIVE_BATCH_RESULTS.json | `E76322EDC3C4362DF6B94AEB6552A1C963F6203AD064B8D17A2AA670853FCFE2` |
| native_batch.cpp | `8F1D5518F76F11BA4972C75278A2A8F7A943D7078D080D2207FC2A8AFC48BB4B` |
| batch_cover_runr1.log | `EAA9FD76C36D678E0EDEA68A41F51552C341780583C2DDB1C3F56CFC5D6DEED9` |
| batch_cover_runr2.log | `38155B7E7984D63A48EC77F36E9A4E0685955D915497054E23BFBD908787EC06` |
| batch_cover_runr3.log | `D3FC3B4C87FA031EF87CB2520EE9B90F8DA33350751B08558EA78860709A5D1C` |

The inspected HOL tree is `hol4-setup/HOL-1de64f8521b4758508bd875fbaf11d1768261b92`. Additional decisive source pins are `examples/algebra/primality/primeCertificateScript.sml` = `CEFF709E0CD8D26BD51AFD39F2797BBFC47F81294C826D6D6DA0906A0F828107`; `src/num/theories/cv_compute/automation/cv_transLib.sml` = `182DABE3CDFD677E1EC8ED4DDD0E8EA3F6D6584D801CAE7F13EE01A203C5647F`; `src/num/theories/cv_compute/cv_computeLib.sml` = `B66D57885CB0D2DCF49F5D5FEC665CB5FDCA4EDB9F726A2CED0AD579CDD08B6C`; and `src/prekernel/Tag.sml` = `E5A6E2E22B7EF855D6BDE7BEB5B6F96A20FDDCEF8F457E3BD1884485F630CECC`.

This is a complete bounded HOL theorem and a measured implementation improvement at the stated boundaries. It supplies no whole-range, prime-ladder or spectral certificate, and no cross-backend or production-scale runtime extrapolation.
