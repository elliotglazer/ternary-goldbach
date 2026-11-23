# Independent review of signed Horner schedules and break-even costs

2026-11-11. **PASS at conditional paper and exact-metadata scope; no correction requested.** The ordinary signed witness interface is sound, the stage counts and differential reserves match, and unknown proof, conversion, cache and generation prices remain explicit. This is a proposed complete symbolic schedule, not an implemented verifier, total-cost measurement or new profile optimum.

Author: moebius/SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md, SHA256 `531DD23307CED3ED958198C750393D933287809B9E42EF738888370AA4DE4474`. I read the full note, script and receipt. It consumes the previously reviewed fixed-profile repricing96734A7E/review57D7DEDB, whose stored finite-polynomial source acceptance remains separate. I executed only my owned rational-metadata checker. No coefficient, function, transform, prime or zero values, builds, profile search or frozen edits occurred.

## Acceptance and signed arithmetic

For one coordinate, the checked products are P=rM and V=Lv', where X=P2^(delta-t) and v'=v/2^t. The schedule proves R=X-V, S=2R+v', S+C+1=2v', and the exact new accumulator L+n_j. Natural S,C imply0<=S<2v', hence -v'<=2R<v'. This is exactly the nearest-integer condition for X/v', with the lower half tie included and the upper half tie excluded. It works for negative as well as positive inputs. Conversely a correct nearest witness defines such S and C, so the interface is not strengthened by an unsupported numerical requirement.

When t=min(delta,1), the actual v=2c identity proves the cancellation. Multiplying the reduced nearest inequality by2^t gives the original quotient condition. The same L and inherited error proof apply. No additional gcd or numerator-divisibility assumption is introduced.

The independent encoding caps S,C<2^(21-t) are sound completeness-preserving rejection limits: a valid witness has each below2v'<2^(21-t). They are not inferred from an unchecked equality. Even before acceptance, integer caps give S+C+1<=2^(22-t)-1. The guard therefore fits its three-byte natural adder. Canonical signs and zero conventions remain mandatory.

The signed-add bridge has the required case distinction. Equal signs reduce to addition of magnitudes; opposite signs reduce to smaller magnitude plus result magnitude equals larger magnitude, with the result sign selecting the branch. Canonical zero and branch facts prevent an incorrect sign from being accepted merely because a natural equality holds. The equality implies the appropriate order, or an implementation may separately certify it and pay that cost. Each such bridge can use one natural addition template, but the bridge itself is not free.

Carry/result matching must be checked in those templates. In an opposite-sign branch a malformed supplied result must not be accepted by discarding a high carry. The author's explicit overflow/result requirement and separately priced range/sign interfaces preserve this obligation. These are library implementation requirements, not extra trusted signed-arithmetic axioms.

## Widths and count reconstruction

I reconstructed all raw capacities from the accepted profile-specific A/T/C fractions. The rM multiplication precedes the exact alignment shift. The Lv' multiplication uses the output-grid nearest numerator. The residual bound is the sum of their magnitude caps; the range-add bound is twice that sum plus the divisor cap. These are obtained before using the accepted narrow residual. The coefficient addition has its own C_j+T_j cap; degree zero affects only that final addition/output width.

Each real stage has two natural product templates and four natural addition templates: residual, range reconstruction, natural slack guard with carry-in1, and exact coefficient addition. The first, second and fourth additions require signed bridges. Across nineteen complex stages this gives76 products,152 natural additions,114 signed-add bridges,76 signed-product bridges,38 nearest-range implications and38 residual doublings. Divisor doubling, alignment, optional cancellation and all binding/representation work remain separate prices with actual reuse conditions.

The independent check matches every stage in both modes, including raw shift lengths and the supplied slack caps. The six uncancelled product/addition pairs are:

|Band|Uniform100|Root linear|Fixed former15442|
|---|---:|---:|---:|
|First four|12562 /3204|11272 /2964|10702 /2860|
|Final|11872 /3068|10552 /2824|9970 /2716|

Optional one-bit cancellation leaves all product subtotals unchanged under the global three-byte factor cap. Its addition savings are0/28/4 and0/20/0 for the respective bands. These small reserves must pay its extra divisor/cancellation proofs after any actual shift/representation savings; automatic adoption would not follow. Complex alignment counts and distances are0/36/14 and0/38/58 without cancellation, and0/2/14 and0/2/44 afterward. Their actual prices depend on widths and proof representation.

## Direct conversion, reuse and comparisons

The direct conversion interface for original dyadic a2^e is correct. At destination grid b, e+b>=0 permits an exact shift. Otherwise nearest rounding divides a by2^(-e-b) with the same signed half-tie condition. This conversion must read the actual original numerator/exponent and pay their widths. Small final center norms do not bound an arbitrarily fine original encoding.

Each distinct admitted source-array/profile object has forty coordinate conversions, with source/height/anchor/grid identity bound. Reusing a checked object may amortize its body and conversion cost only over its actual retained lifetime. A variable grid is not automatically a read of a b100 cache. The theorem/reference/import and data association costs remain even when one proof body is shared; a prior digest alone is not an ordinary proof import.

The full price alpha*P+beta*A+R is an explicit declared model. R retains signed and range bridges, shifts, nearest implication, source conversions, geometry and coverage, library construction, numeral/DAG and reference costs, serialization, storage and traffic. The independent producer bill G retains quotient discovery and witness/proof production. No unknown category is numerically assigned zero in a claimed full result.

All twelve mode/band profile-difference rows match direct subtraction of the reconstructed counts. For example, first-four uniform to fixed gives1860alpha+344beta before cancellation, and final linear to fixed gives582alpha+108beta. The strict comparison is R_new-R_old below the relevant reserve, plus any declared lambda*(G_new-G_old) for an end-to-end objective. If those prices are merely bounds, a difference of unrelated upper bounds is not a demonstrated implementation advantage.

The reuse condition DeltaC+q*DeltaR_local<q*(DeltaP*alpha+DeltaA*beta) has the correct signs. For positive DeltaC and positive net per-output reserve D, it gives q>DeltaC/D; when D<=0, additional reuse cannot pay a positive setup difference. Negative differences and q-dependent cache traffic remain in the general inequality. Per-object sums, not a single immortal array, determine a cohort cost. No FD comparison or new grid optimization is claimed.

## Frozen evidence and open implementation work

Owned checker: independent-feasibility/review_signed_horner_schedule_20261111.py, SHA256 `A79811C7137B77B2AA2DE25C7F7F156D8FE3124F3A984ECEC9583EED272E3643`. Owned receipt: same stem JSON, SHA256 `0F8F6219EE19B27E370DEA92805DE5AFD0750F42906AA66E9E803823F382387F`. It passes4712 exact checks, binds eight inputs, and reconstructs all228 mode-specific stage records, totals, shift counts and comparison reserves. It reads but neither imports nor runs the author programs.

Author script and receipt are respectively `82BDFCBDA7A905808EF404EFD4FE36BBDC688E14C23E194CE2B1DF89C04A5602` and `0DF6FF38D7F14A9C3596423BE109E5EEC6CAF18E031F4329B907E43F5A60FF37`.

Acceptance covers the paper witness semantics, sufficient raw capacities and conditional cost interface. Actual ordinary-rule library proofs, emitted arithmetic records, complete source/output coverage, cache implementation and measured generation/checking prices remain open. The event counts are neither native instructions nor verified MM0/Lean performance figures.
