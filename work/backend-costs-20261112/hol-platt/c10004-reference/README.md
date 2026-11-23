# Direct Hurwitz reference at conductor 10004

Each h0.tsv, h1.tsv and h2.tsv contains 4,800 units in tensor order. At height 5h/64, the integers in the re and im columns represent the nearest multiples of 2^-81 to the coordinates of ζ(1/2 + 5hi/64, a/10004). Every 176-bit Arb enclosure lay strictly within its rounding cell. The generator checks that the residue list covers every unit. It uses the generators and CRT coefficients from ../c10004-map/C10004MapScript.sml and the order 2(40j61+j41)+j4 from ../c10004-layout/C10004LayoutScript.sml.

The recorded timings cover the single-threaded calls to Hurwitz zeta, rounding checks and row formatting. File writes and subsequent character checks fall outside the timed region. For each height and each recorded Conrey label, the unrounded weighted sum multiplied by 10004^(-s) overlapped the value returned by FLINT's Dirichlet L function. The recorded positive Fourier frequencies are in axis order (4,41,61).

The production contract in ../../forecast-audit-20261113/C10004_PARAMETER_PACKET.md specifies a P20 finite translated polynomial, a separately produced raw head, grid100 assembly and conversion to p81. The direct evaluations supply independent numerical references. Production rounding can differ within its error allowance. These timings cover direct evaluation only. The TSV files and character checks carry no HOL proof.

Run reference.py with the campaign interval-env Python interpreter. receipt.json records the generator and TSV digests, run times, precision, thread count, software version and character checks.
