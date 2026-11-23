# Reusing Platt computation artifacts

Source and availability research, 2026-11-11. No spectral values, transforms, prime computations or builds were run. Only small public source files and repository metadata were retrieved. No published numerical theorem is imported as a formal premise.

## Finding and exact target

There is a concrete principal-zero discovery corpus, public numerical source code, and a much smaller public Dirichlet collection. These can supply candidate ordinates, labels, subdivision choices and algorithm parameters. I did not locate a public full-family interval/sign/Turing transcript that can simply be replayed by the proposed ordinary-rule checker. This is a bounded search result, not a claim that such archives do not exist.

The current compute blueprint requires principal RH through 100000000 and, at R=132900, every primitive nonprincipal character of odd conductor c<=132900 or conductor divisible by 4 with c<=265800. Its closed heights are respectively 100000000/c and max(100000000/c,200+75000000/c). There are 4,351,723,951 nonprincipal labels; this is neither a zero count nor an operation count. See `work/qrh-blueprint/CURRENT_COMPUTE_BLUEPRINT_2026-11-11.md:9-11` and the source-level `independent-feasibility/ORIGINAL_RH_CONSUMER_DOMAIN_RESEARCH_2026-11-11.md`.

Platt's accepted manuscript Theorem 9.1 covers primitive moduli c<=400000, with height max(100000000/c,200+75000000/c) for even c, and max(100000000/c,200+37500000/c) for odd c. The parity is that of the modulus. Thus the current nonprincipal target is contained in the published domain; for its odd conductors the first term dominates. This does not provide a formal certificate, and does not repair the different old shared-Hp profile, whose height exceptions were correctly recorded in the earlier campaign comparison. [Accepted manuscript](https://research-information.bris.ac.uk/files/67056136/platt_grh3.0.pdf).

## Available artifacts and what they can save

| Artifact | Observed availability and coverage | Possible reuse; remaining acceptance |
|---|---|---|
| Platt principal ordinates in LMFDB | LMFDB reports 103,800,788,359 positive ordinates through 30,610,046,000, with precision +/-2^-102 and Turing completeness. It advertises raw binary data and publishes a decoder. | Candidate brackets and inter-zero sample planning cover the required principal height 1e8. Exact parsing does not prove the zeros or completeness; actual function signs and a count/completeness proof remain. |
| LMFDB Dirichlet L-functions | The collection reports 7,655,469 primitive Dirichlet L-functions, including all 1,448,484 through conductor 2800, with zeta included. No uniform production-height coverage follows from that count. | Useful partial label/zero hints and bounded test cases. It is not the several-billion-label selected family and cannot replace its full coverage inventory. |
| `djplatt/code` interval pipeline | Public C/C++ source includes Hurwitz-lattice consumption, character transforms, interval sample output and special low-conductor programs. Inspected directory listings did not reveal a full output archive. | Reuse numerical formulas, layout documentation and exceptional-case scheduling. A surviving lattice/sample archive could save generation, but it must first be obtained and bound to actual characters, normalizations, intervals and grids. |
| `djplatt/arb_zeta` | Public code identified by its README as used for RH through 3e12. Its main source explicitly distinguishes checking/isolation from storing the 102-bit ordinates. | Reuse algorithm and parameter choices. It is not evidence that the earlier LMFDB corpus reaches 3e12, nor a supplied arithmetic proof transcript. |

The principal database statements and download/decoder links are on the [completeness page](https://www.lmfdb.org/zeros/zeta/Completeness) and [data-source page](https://www.lmfdb.org/zeros/zeta/Source). The raw archive index returned an access challenge in this session; no binary zero file was downloaded or inspected. Accordingly its availability here is an advertised public resource, not a verified complete download. The [Dirichlet collection summary](https://www.lmfdb.org/L/1/109/109.80/r0/0/0/Completeness), [reliability statement](https://www.lmfdb.org/L/1/109/109.80/r0/0/0/Reliability) and [source statement](https://www.lmfdb.org/L/1/109/109.80/r0/0/0/Source) describe numerical data, not Lean or MM0 proof terms.

The [Platt code repository](https://github.com/djplatt/code) and [principal verification repository](https://github.com/djplatt/arb_zeta) were inspected as primary-author sources. Current repository revisions are provenance pins for this inspection; they are not asserted to be the exact revisions used in the historical computation.

## Concrete source contracts found

The pinned LMFDB decoder has a block count, `ddQQ` headers, and 13-byte `QIB` delta records. It reconstructs an ordinate from an IEEE-double block origin plus an integer multiple of 2^-101. Its comments interpret header counts using strict `<t`, and warn about trailing garbage in at least one file. A new reader should use exact dyadic reconstruction, fixed endian/layout rules, explicit block counts, checked index continuity and bounded reads. Decimal printing through mpmath is not the acceptance representation. Neither a header count nor the advertised half-grid precision becomes a theorem merely by parsing it. [Pinned decoder](https://github.com/LMFDB/lmfdb/blob/f753c9a4ea20944cb2ef2fe68e2294abf55a5a11/lmfdb/zeros/zeta/platt_zeros.py#L62-L145).

In `int-l-func5.11.cpp`, the input description identifies a Hurwitz lattice with Gamma data. Lines 480-482 write a character index, a root-phase interval and a parity flag; the following computation combines the transform, conductor factor, phase and parity-dependent Gamma factor, and line 528 writes the real interval sample. A second branch has corresponding output. Lines 854-861 write run/header dimensions. This is evidence of a saved-sample interface in source, not evidence that its output is currently published. The `int_double` binary representation and sign conventions require their own audit before interpreting any recovered file. [Pinned source](https://github.com/djplatt/code/blob/1f19fcbefa33d2fe5949ddbcd4d3df75deca6819/l-func/int-l-func5.11.cpp#L463-L533).

The `arb_zeta.c` introductory comment says this program moves on after isolation instead of resolving stored ordinates to 102 bits. Its main loop computes samples, errors, interpolation and Turing verification, then prints diagnostics. It therefore supplies a generator/checking algorithm, not a discovered library of ordinary-rule certificates. [Pinned source](https://github.com/djplatt/arb_zeta/blob/d918aa093a304819a0f7d1c27bfaf67c8c0f0602/arb_zeta.c).

Platt's paper also records substantial adaptive handling: upsampling, Euler--Maclaurin evaluation for difficult central signs or missed close zeros, and changes to auxiliary Turing regions. A uniform sample file without those exceptional records would not reproduce the claimed complete result. These details motivate asking for the exception manifest as well as nominal samples. [Accepted manuscript, section 9](https://research-information.bris.ac.uk/files/67056136/platt_grh3.0.pdf).

## An additional small corpus, not a substitute

Bennett--Martin--O'Bryant--Rechnitzer's primary paper describes a separate data collection for primitive conductors 1<c<935 and log(c(T+2)/(2*pi))<=6. Section 6 reports 403,272 explicitly computed zeros under its conjugation/sign storage convention, and advertises C generation plus Mathematica processing code. This is much smaller in conductor and height than the present requirement. Its advertised project URL did not resolve to a usable archive in this session. It could be useful for bounded interface tests if recovered; no current download or formal proof is claimed. [Paper, section 6](https://personal.math.ubc.ca/~bennett/BeMaObRe-MathComp-2021.pdf), [advertised project URL](http://www.nt.math.ubc.ca/BeMaObRe2/).

## Acceptance architecture: reuse discovery without trusting history

There are three different savings, and they should have separate cost parameters.

1. **Candidate reuse.** Decode old ordinates as untrusted rational hints. Choose sign-test points between candidate zeros, rather than demanding extremely accurate evaluations at tiny alleged root brackets. Independently certify actual normalized-L signs and a complete zero count through a height strictly beyond the required closed endpoint. Close pairs, ambiguous signs and endpoint zeros require explicit fallback. This saves searching and selecting points; it does not remove sign evaluation or count certification.
2. **Numerical witness reuse.** Recovered sample intervals, seed arrays, Gamma phases or FFT states can be proposed witnesses. A new checker must establish their actual-function enclosures from accepted analytic tails and checked arithmetic. It need not reproduce the old machine's execution history if it instead proves those same enclosure statements directly. This may save witness generation, but does not make checking their arithmetic free.
3. **Proof reuse.** An already checked theorem may be reused within the target proof system. None of the located historical binary records, published reliability claims or C source alone has this status. Hashes bind bytes; they do not prove interval bounds or completeness.

For all routes, the finite coverage manifest must bind primitive labels to the actual character definition, conductor, parity and inverse/conjugate labels. Positive zeros of a complex character alone do not cover both signs for that same character. The proof must handle multiplicities, possible real zeros, auxiliary count regions and the closed final height. A sufficiently high certified count combined with enough distinct certified critical-line zeros can establish completeness; a list length by itself cannot. The actual zeta/L normalization and root-phase branch must be proved, not inferred from a file name.

For principal data, the near-term reusable artifact is therefore an exact ordinate/index reader plus a plan for certified signs and count bounds, not a fresh zero search. For the large nonprincipal family, the best unresolved availability question is whether the historical lattice/sample and exceptional-case archives survive. Merely downloading the public low-conductor pages will not answer it.

## Narrow next intake and missing evidence

A future bounded intake should first obtain an archive manifest/schema, not the whole archive: exact conductor and primitive-label ranges, ordinate grids and auxiliary heights, interval ABI/precision, normalization/phase conventions, hashes, and treatment of exceptions. Then inspect a small principal block and a few nonprincipal records covering real/complex and cyclic/noncyclic cases. This report authorizes no such numerical replay and no communication to authors.

The decisive missing artifacts are (a) the full nonprincipal output inventory; (b) actual sign/enclosure and auxiliary-count witnesses, including difficult cases; (c) a target-system proof of their arithmetic and analytic interpretation. No runtime or end-to-end cost reduction is established. Even perfect discovery reuse leaves the ordinary-rule analytic foundation and checked spectral computation costs in the current blueprint.

## Reproduction and scope ledger

Read first: campaign `COMPUTE_FIRST_SPECTRAL_RESEARCH`, `ORIGINAL_RH_CONSUMER_DOMAIN_RESEARCH`, `RESUME_SPECTRAL_CERTIFICATE_STRATEGY`, `PLATT_DOMAIN_COMPARISON`, and the current compute blueprint. Then primary web pages, repository directory metadata, and the following small source files were inspected. No repository-wide archive absence claim is made. The following copies are under this note's sibling `platt-reuse-sources/`; they were never imported or executed.

| File | Upstream revision | SHA256 of saved bytes |
|---|---|---|
| `platt_zeros.py` | LMFDB/lmfdb `f753c9a4ea20944cb2ef2fe68e2294abf55a5a11` | `FE44DA14F1012476E6FBA7FCFF92500A99ED9BD3697EF9352DCE2B5935CACDC3` |
| `int-l-func5.11.cpp` | djplatt/code `1f19fcbefa33d2fe5949ddbcd4d3df75deca6819` | `3D9B2B23B35129899048C23806AA42A4F2B08BE10304611AC9E1C913300FE852` |
| `arb_zeta.c` | djplatt/arb_zeta `d918aa093a304819a0f7d1c27bfaf67c8c0f0602` | `8E7CDB6075AF12B4C3053A0ADA6687DFD50FD9807429ACDEA7389C5FA4522A68` |

The decoder retrieval used the repository's actual `main` branch after an obsolete `master` commit lookup failed. No failed lookup output was adopted as a revision pin. Web availability and database totals are observations on the research date; the saved source pins are immutable review targets.
