# Short finite psi gap: source-level design and one external pilot

Date: 2026-11-11. No Lean builds, canonical edits, or full5e9 sieve run. Status: complete interpolation design, one externally checked count/log checkpoint, and identified proof-producing integration steps. The remaining6,438 windows have not been externally counted; none of the new window counts has been checked by Lean.

## Conditional boundary and exact target

Mellin's current proposed refined spectral route would give abs(psiR(x)-x)<.00981*x/log x for x>=5e9, using the shared finite .555 strip through60343058, global7/8, and additional finite zeta RH through1e6 plus the both-sign multiplicity-weighted reciprocal moment at most24. That route remains conditional on independent review and validation of its spectral inputs. Nothing in this note proves or substitutes for those inputs.

If that endpoint is established, the finite task is to prove E for integers in [1e9,5e9), where

    E(v): abs(psiN(v)-v)<=.01*v/log v.

The finite design below includes5e9, deliberately overlapping the proposed analytic domain. Its exact public consumer is the integer envelope used by `PRIME_ENVELOPE_ASSEMBLY.md` for P1/P4/P5/P7 and by integration's separate Mobius-envelope reduction. It does not change any final Goldbach range or BinaryGoldbachInput.

The earlier long-gap note and corrected precision rules remain valid. Here we exploit the smaller logarithm: exp(1)>2.7 and2.7^23>5e9 prove log v<23 throughout the finite interval.

## Rational grid and sufficient checkpoint condition

Set A=1e9, B=5e9 and

    a_0=A, a_(i+1)=min(B,a_i+floor(a_i/4000)).

Exact integer replay gives6,439 windows and6,440 endpoints. At each endpoint certify

    a-a/24000 <= theta(a) <= a+a/24000.                 (C)

Retain the reviewed P6 estimate, which implies for all t>=A

    0<=psi(t)-theta(t)<1.4262sqrt(t)<=17*t/360000.

For a<=v<=b with b-a<=a/4000, monotonicity then yields

    v-psi(v)<=a/4000+a/24000=7*a/24000,
    psi(v)-v<=a/4000+(1/24000+17/360000)*b
             <=(15251/45000000)*a.

Both coefficients are below1/2300. Since a<=v and log v<23, these imply the strict bound abs(psi(v)-v)<.01*v/log v. In particular all required integer endpoints are covered. These arguments use real step functions directly, so they also work between the integers. The short grid therefore requires no extra integer-to-real error allowance.

The existing source `SieveTab.stg2813`, `Prelim/PsiSieveMain.lean:28149`, supplies the exact first checkpoint at A. Its `InvT` bracket is

    999967635.190289132 <= theta(A) <=999970323.068320645.

It is already inside A+/-A/24000. The strict upper endpoint of the public `sieve_table3` does not invalidate this separately present terminal invariant.

## One authorized external pilot: (1000000000,1000250000]

The owned script `resume_psi_short_gap_20261111.py` computes only this first250000-integer window, plus the small base-prime list through70710 and the rational grid arithmetic. It does not sieve the rest of the gap.

The pilot obtained12,008 primes. It generated base primes by trial division, parsed the actual `PS3b0` through `PS3b7` source lists and checked equality with all generated primes<=31622, marked composites by a segmented sieve with factor witnesses, checked every rejected integer's recorded divisibility, then trial-divided every survivor using the complete independently generated base list up to its exact integer square root. Integer arithmetic handles all divisibility and counts. This is an externally reproducible check, not a Lean theorem or a trusted theorem-provider declaration.

For future kernel replay it records these eight source-sized subwindows:

| lower endpoint n | W | count in(n,n+W] |
|---:|---:|---:|
|1000000000|32768|1566|
|1000032768|32768|1591|
|1000065536|32768|1597|
|1000098304|32768|1565|
|1000131072|32768|1554|
|1000163840|32768|1567|
|1000196608|32768|1581|
|1000229376|20624|987|

The total is12008. The surviving prime list's newline-separated ASCII SHA256 is96779ee05e044581c24f67da29904872a6777c2f4f9f654b70deab285d1fbb9f. This hash identifies an external result; it is not a primality or completeness proof.

For endpoint P=1000250000, the script replayed the actual `Small.chkLow` and `Small.chkStep` rational formulas to certify the log enclosure

    20723515795/1e9 <= log P <20723515815/1e9.

Its width is2e-8, within the corrected1e-7 width allowance. Decimal logarithms were used only to choose candidate numerators; acceptance used the source rational Taylor formulas. The script also checked the source seed log interval [20723265833/1e9,20723265841/1e9].

Updating theta using count times the lower log at A and upper log at P gives exact rational bounds

    L =250054120041602949/250000000,
    U =200043834209245433/200000000.

Thus theta(P) would lie between approximately1000216480.1664 and1000219171.0463 after formal validation of the count. Both pass(C). The rational margins are

    L-(P-P/24000)=6117937308847/750000000>0,
    (P+P/24000)-U=43503622263701/600000000>0.

The script exits0. This confirms that the first checkpoint condition is actually satisfiable by the computed data, not only that an abstract interpolation implication has spare constants.

## The pilot can reuse the existing PS3 masks

The actual source `PsiSieve3.lean:106` proves `mem_PS3`: membership iff prime and<=31622. Its `prime_iff_PS3:113` currently assumes m<31623^2=1000014129. Its proof uses `Nat.minFac_prime`, `Nat.minFac_sq_le_self`, and `Nat.minFac_dvd`.

For the pilot, that height can be increased to31627^2=1000267129 without adding a single base prime. If a composite m lies below this square, its least prime factor is<31627. The four integers31623,31624,31625,31626 are composite, by factors3,2,5,2 respectively. Thus its least prime factor is still<=31622. This is a small finite logical extension of the same proof; no new prime enumeration is required. The pilot endpoint1000250000 is strictly below1000267129.

The definitions `pats3`, `orP`, `cnt3`, and `pcL 7` can therefore remain exactly as they are for the pilot. `orP_spec3:133` depends on the modulus bound31622, pattern length66000, and index bound; it does not depend on the height n of the window. The count proof `cnt3_spec:166` needs only the strengthened primality lemma at its last step. All eight W are<=32768, so the original popcount theorem is sufficient.

A proof-producing pilot would therefore need:

1. Prove the stronger-height prime characterization, keeping the original source lemma intact or deriving it as a restriction.
2. Copy or generalize the count-specification proof with that height, without changing `cnt3`.
3. Kernel-check the eight concrete `cnt3 n W=count` equalities in independent bounded declarations.
4. Compose the eight interval cards into the250000-wide count.
5. Kernel-check the displayed log-box formulas and combine them with stg2813 and the rational theta update.
6. Apply the interpolation theorem and reviewed P6 for the first interval.

No external hash or Python result is allowed to replace step3. The eight counts are concrete candidate certificate data for that later proof-producing task. No heartbeat override, native evaluation axiom, or unproved count premise is proposed.

## Full short-gap cost and generic source changes

The full interval has4,000,000,000 integer positions, compared with about1.6e15 in the long-gap design: a span reduction of about400000. A conceptual one-bit-per-integer representation is500000000 bytes; segmentation keeps only one local block resident. This is a span measure, not a total memory/runtime bound.

All composites up to5e9 have a prime factor<=70710 because70711^2>5e9. The external trial-division enumeration finds7004 primes<=70710, versus3401 existing PS3 primes. That new base list would need its own kernel-checked completeness theorem, using the source `isPrimeSlow3_iff`/`PS3_eq` pattern or a generalized small sieve. It is small relative to the main gap but is not already proved by the PS3 theorem.

With W<=32768, the continuous span takes122071 blocks. Splitting also at every grid checkpoint takes125271 blocks, as exactly counted by the script. This is far below48,828,094,483 blocks for the long gap. A naive visit to all7004 prime masks in every grid-aligned block nevertheless means877398084 mask visits. These figures show why the short gap is a substantially smaller task but do not guarantee cheap Lean checking.

A direct generic extension can use the same `maskP` and `orP` definitions, parameterizing the proven completeness bound Pmax=70710 and pattern length L=131072. The required mask condition is W+Pmax<=L;32768+70710<131072. A precomputed131072-bit pattern for each of7004 primes occupies about114753536 raw bytes, before Lean expression/object overhead. The source66000-bit patterns are too short for the larger base bound and cannot simply be reused for the full interval.

The exact source interfaces to generalize are:

- `maskP_spec`, `PsiSieve.lean:72`: already generic in prime, residue, and width; reusable.
- `pcL_spec`, `PsiSieve.lean:221`: already generic k; `pcL k` counts2^(k+8) bits.
- `orP_spec3`, `PsiSieve3.lean:133`: generalize31622 and66000 to Pmax,L with the explicit index-length inequality.
- `prime_iff_PS3`: replace the fixed list by a proved complete base-prime list and upper height below(Pmax+1)^2, or a proved next-prime boundary.
- `cnt3_spec`: combine those generic lemmas with the correct popcount size and exact open-left/closed-right interval card.
- `outerT3_spec:233`: the existing loop checks sqrt-shaped `RtT` windows. For this task, use a separate rational theta-bracket recurrence and test(C); do not pretend the old square-root predicate is the new relative predicate.

Larger blocks can reduce mask-visit and declaration counts. For instance W<=2^18 uses `pcL 10` and can use patterns of length2^19; W<=2^20 uses `pcL 12` and patterns of length2^21. But precomputing every pattern then grows to roughly459MB or1.84GB raw, respectively. Streaming/chunking the base list or generating masks within independently checked blocks may lower residency. These are engineering choices needing measured focused tests later; no timing extrapolation from the Python pilot to Lean is justified. The original general `pcL_spec` does not itself require a new proof for each width.

For each checkpoint, use certified log boxes of width<=1e-7, retaining the seed scale1e9. With h<=a/4000, cumulative log-bucket uncertainty is bounded by

    initial_width + [1.387/80000+2e-7]*x.

At x>=A this is at most (2687.878031513/1e9+1.387/80000+2e-7)*x<x/12000. The scalar script checks this exactly. As in the corrected long-gap design, this is only an uncertainty ceiling: it does not prove that future theta brackets satisfy(C), nor that their proposed log boxes have already passed the rational checker. Both require actual data and checks.

## Prime powers and current scope

P6 is enough for the chosen interpolation, so the short computation need not enumerate prime powers. If a direct psi checker is preferred, the exact identity is

    psiN(N)=theta(N)+sum_{k=2}^{32}theta(floor(N^(1/k))), N<=5e9,

because2^32<=5e9<2^33. Every root is<=70710, so all root arguments are below1e6 and fall within the existing small finite machinery. Integer roots must be certified by r^k<=N<(r+1)^k. This offers a small finite alternative to relying on the P6 repair for this one certificate.

The authorized pilot is complete as an external calculation only. The remaining6,438 grid windows have no counts from this task, and the full spectral route remains conditional. The next bounded proof-producing step would be the eight existing-definition `cnt3` equalities for the pilot, with the simple extended-height lemma. No full5e9 run should be confused with the completed pilot or assumed from its success.
