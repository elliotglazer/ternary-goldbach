# Platt's Turing auxiliary regions: source choices and proof obligations

2026-11-11. Source-only follow-up to `PLATT_ARTIFACT_REUSE_RESEARCH_2026-11-11.md`. Small C/header files were read, not compiled or executed. No zeros, L-values, transforms or archive samples were evaluated. The settings below are configurations in identified versions, not a proof that those settings always succeed or the exact provenance of every historical job.

## 1. Manuscript: sufficient theorem versus repairs

The retained primary text `agents/audit/platt_turing_1305_3087.txt:268-315` is the author preprint, section 3, Theorems 3.2-3.3 (PDF pages 5-6). The count identity uses an auxiliary interval [t0,t0+h], h>0, with both endpoints not zero ordinates; conjugate characters are paired. The displayed Rumely bound for the S integral is C=1.8397+0.1242 log(q(t0+h)/(2*pi)), t0>50. The text reports replacement constants 2.17618 and .0679955 from a personal communication optimized near qt0=1e8. That sentence is not a newly reconstructed uniform theorem for arbitrary parameters. [Author preprint](https://arxiv.org/pdf/1305.3087).

Section 7, text lines 917-944 (PDF pages 13-14), reports initial spacing5/64, interpolation factors8,32,128,512, and direct Euler--Maclaurin repairs, sometimes at100-bit MPFI precision. It also reports moving Turing regions or resolving missing auxiliary zeros when an integer count could not be isolated. Its approximately3.8e13 zero total expressly excludes Turing auxiliaries. Neither this section nor the theorem supplies a universal successful fixed h. The accepted manuscript renumbers these discussions as sections3 and9. [Accepted manuscript](https://research-information.bris.ac.uk/files/67056136/platt_grh3.0.pdf).

## 2. Nonprincipal code: a concrete width10 policy

Source commit: `djplatt/code` `1f19fcbefa33d2fe5949ddbcd4d3df75deca6819`.

In [`low_q/low_upsam8.cpp`](https://github.com/djplatt/code/blob/1f19fcbefa33d2fe5949ddbcd4d3df75deca6819/low_q/low_upsam8.cpp):

- Line25 fixes Delta=5/64. Lines84-86 set the initial indices i0=N0-30/Delta and i1=i0+10/Delta. Thus the initial auxiliary interval is [N0*Delta-30,N0*Delta-20], with128 grid steps. N0 is read from the input record; it is not itself an authenticated required height.
- Lines110-115 advance both indices by one while the real-character starting sign is unknown. Lines155-159 do the same until both starting signs are known for a conjugate pair. This preserves width10 but increases the upper endpoint. The source does not supply a universal bound on the number of shifts.
- Lines117-125 and160-167 recompute the Gamma integral and interpolation error at the actual shifted endpoints. Lines126-145 and168 onward save unsuccessful states when the Turing count is ambiguous or the located count disagrees. Successful output is conditional on those checks.

These are actual driver choices. A new implementation must additionally enforce its sample-array limits and interpolation halo while shifting, and fail closed if it exhausts them. The historical loops do not establish termination, nor that a planned finite height margin is sufficient.

[`includes/upsample.h`](https://github.com/djplatt/code/blob/1f19fcbefa33d2fe5949ddbcd4d3df75deca6819/includes/upsample.h):930-944 has the important distinction between the comment and arithmetic. `s_of_t` actually uses

    C_code(q,t2)=217618/100000 + (67996/1000000)*log(q*t2/(2*pi)),

so the slope is .067996, not .0679955. The interval is made symmetric using this library's negated-upper representation. Lines1297-1329 use twice this S allowance for a conjugate pair, divide by h, and require `ceil(lower)==floor(upper)` for the resulting count interval. Lines1395-1423 give the real-character version with its phase term. These formulas need their normalization theorem and arithmetic enclosure proof; neither is supplied by copying the constants.

For cost planning alone, separate the S uncertainty from the other count terms. With a valid per-character bound |integral S|<=C, a pair contributes radius2C/h and full interval width4C/h. Thus h>4C makes this contribution narrower than1. This is not a complete successful-rounding criterion: other errors, auxiliary zero brackets, the interval's position relative to integers and missed zeros still matter. A proved bound applicable to the chosen q,t2 must replace the personal-communication comment before this is an accepted quantitative design.

An older pipeline illustrates why filenames cannot define coverage. `low_q/f1.3.cpp:132-135` sets N0*Delta=10*ceil(QT/(10q))+30. But `low_q/qt.h:22-34` sets QT/q=ceil(37500000/phi(q)+50) for odd q and ceil(75000000/phi(q)+50) for even q. These are phi(q)-dependent old settings, not the published conductor-height formula. They may explain that driver's30-unit buffer, but must not be substituted into the current target or asserted to describe every historical run.

## 3. Principal code: width21 and carried counts

Source commit: `djplatt/arb_zeta` `d918aa093a304819a0f7d1c27bfaf67c8c0f0602`.

[`parameters.h`](https://github.com/djplatt/arb_zeta/blob/d918aa093a304819a0f7d1c27bfaf67c8c0f0602/parameters.h):14-25,55-65 fixes center range1e10..3.01e12, Delta=21/512, Turing width21 (512 steps), interpolation spacing1 and Ns=70. This configuration is not validated for the campaign's principal height1e8 merely because the Turing identity has wider applicability.

[`turing.c`](https://github.com/djplatt/arb_zeta/blob/d918aa093a304819a0f7d1c27bfaf67c8c0f0602/turing.c):303-325 uses C_zeta(t2)=.059 log(t2)+2.067, with the comment's domain t0>168*pi and reference to Trudgian's thesis Theorem5.2.2. Lines349-424 construct upper/lower integer count bounds. Lines432-439 use [b,b+21] for the upper count; [a-21,a] is used only when no prior successful count at a is available. A successful returned count is carried forward. Unknown endpoint signs, parity disagreement or unequal located/required counts fail the block. Stationary-point refinement seeks additional certified sign changes; it does not assume RH to accept them. See lines13-156 and432-490.

The main program `arb_zeta.c:431-435` requires a step that is an even integer multiple of Delta. Lines439-446 and517-524 also include an interpolation halo Ns*Delta=735/256 beyond the Turing sides. It prepares both sides even when the logical count can reuse the preceding block. Therefore distinguish logical auxiliary count work from actual chosen evaluator extent and cached overlap. The block call is at534.

The source's diagnostic failure path advises looking harder in the main or auxiliary regions, or shifting the endpoints. A width21 success claim requires the actual integer and sign checks, not only these macros. No historical per-block exception transcript was located in this bounded review.

## 4. Interface for the current optimizer

For each conductor/character pair record: required closed height H; chosen t0>=H; h>0; exact grid; actual endpoint nonvanishing evidence; interpolation halo; phase/Gamma normalization; the auxiliary signed-zero brackets and their weighted integrals; the count interval; integer selection; and all repaired subregions. If endpoint zeros cannot be excluded, a separately proved endpoint convention or a higher endpoint is necessary. Do not round a required H downward to fit a grid.

Charge source/seed nodes through the actual t0+h+halo, not just H, and retain every auxiliary sign evaluation. Shared conductor cohorts may share seeds at those nodes, but do not automatically share character signs. Reusing a previously proved count can remove the logical left Turing proof for later contiguous blocks; disconnected or failed blocks need a fresh anchor. It does not by itself remove a two-sided evaluator's already computed halo. Auxiliary widths10 and21 are useful initial choices for experiments, not fixed accepted production margins.

This report supplies configurations and their exact caveats to the count optimizer. It does not select a sufficient universal h, establish any new success rate, or close the historical constants' formal proof obligations.

## Saved source hashes

All copies are in sibling `platt-reuse-sources/`; upstream links above identify their roles. Earlier `arb_zeta.c` hash is retained in the predecessor report.

| Local file | SHA256 |
|---|---|
| `parameters.h` | `B2FE59CFC850297AA9E75F997B84F838707A6B388DD8A514F4F1D703DCBE4A93` |
| `turing.c` | `07305E04E85477749CED09325C9E78388DD55D6107AA526D3BECDE345A430C27` |
| `upsample.h` | `27F1D989F5BA3BA3B1AD57B789DFCDBEF893FDC43925DF25F49E6904DF81113A` |
| `low_q_low_upsam8.cpp` | `DC03F30434ADB76655C557CE46F63053424C3FE15F89BB50854E04881DE785DF` |
| `low_q_f1.3.cpp` | `20C88BB0F2F2D0CA43617428E8AA550DA4126F026F0F4A34AF60F92CD2305E47` |
| `low_q_qt.h` | `880B98DB8C38128C27F2F2661E780A2195CB430A5AAB12B8A7B4A40D2CF0BBF8` |
