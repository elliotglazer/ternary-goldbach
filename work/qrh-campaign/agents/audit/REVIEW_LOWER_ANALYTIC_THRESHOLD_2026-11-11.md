# Lower-threshold source and endpoint review

2026-11-11. Independent targeted efficiency review. The source argument supports the candidate N0=989*10^24 while retaining the original analytic scales and constants. This is paper/source and exact rational/integer evidence, not a compiled refactor or a newly proved spectral fact. No Lean/Lake build, source edit, prime test or analytic evaluation was performed.

**PASS for the proposed N0 refactor at this scope, with no correction requested.** I read the final full author report `major-constants/EFFICIENCY_LOWER_ANALYTIC_THRESHOLD_2026-11-11.md`, SHA256 `99D06335D5F8AF1D9AB0916A84BB60AE2ECF060B5FDF04C0134AB9BCB860F786`, and verified all19 source-table pins. Its scalar script is `AB1BED8186C0CE937FB5CFFBA9D60A1338A3672C104F44B9845E02EDD6FF76EC` and receipt `0D6A6C0EEB89C5B4660B95EF974AFA104CA7397AE8B00400B04B97D7FE9FBE3E`; neither was modified or imported. The principal verdict concerns the original live assembly, including all threshold-dependent Chebyshev/nonprime and ladder endpoints.

## Actual large-N consumers

I read `Helfgott/Defs`, `Inputs`, `Chebyshev`, `Numerics`, `Main`, `SmallCases`, `Statement`, `MainTheorems`, `MinorArcs/NumericsFinal`, and the ladder assembly/specification and terminal data modules. A target-wide search for `10 ^ 27`, `10^27` and `1e27` separated the live Helfgott threshold uses from fixed scale-grid values in `MinorArcs/NumericsCells`. The latter are not extra lower bounds on the integer N: `numerics_M` takes every real x>=4.9e26 and dispatches the existing cells/asymptotic branch.

The scale denominator is c0=2+9/(196*sqrt(2*pi)). From pi>3.14, sqrt(2*pi)>5/2, hence

    0<c0<2+9/490=989/490,
    (989/490)*(4.9e26)=N0.

Thus N>=N0 implies x=N/c0>4.9e26, and y=x/49>1e25. Existing weak inequalities follow, including at the proposed closed threshold. This improves `Inputs.xOf_ge:57-64`; using only its old c0<=2.02 bound would not suffice. The definitions of x, kappa, r0, smoothing and all normalized phase bounds are unchanged.

`Inputs.major_arcs_input:76-91` and `minor_arcs_input:109-114` use the N cutoff to obtain this scale bound. Their actual major/minor estimates and the identity N/x=c0 therefore remain applicable. No new cell, analytic error constant or conductor height is required by this threshold change.

The nonprime chain needs genuine re-threading, not merely an improved x lemma:

- `Chebyshev.psi_sub_theta_le:115-203` uses N>=1e27 to infer N>0 and w=N^(1/32)>=6.9. The exact rational inequality (6.9)^32<N0 suffices. Its natural floors, Nat.log sum and exponent split remain valid without change.
- `Chebyshev.psi_le:207-220` also uses sqrt N>=1e13. This follows from 1e26<=N0. Its bound psi(N)<=1.387*N is retained.
- `Inputs.nonprime_input:126-148` uses these two estimates, sqrt N>=1e13, positivity and log2<=.0001*sqrt N. All remain valid, so the original 6.7e6*N^(3/2)*log N bound is unchanged.
- `Numerics.final_inequality_crude:71-149` uses N>=1e27 only to establish positivity and v=N^(1/64)>=2.64. Independently, (2.64)^64<N0. Its unchanged strict coefficient inequality

      1.589e8 * 4.0804 * 49 < .0114 * (2.64)^31

  passes exactly. Consequently its original proof gives strict final positivity for all N>=N0. No new transcendental estimate or numerical log evaluation is needed for this minimal refactor. The unused sharper `final_inequality:24-65` similarly needs only (10^6)^4<=N0, but it is not the theorem consumed by the current main proof.

Update the threshold arguments in `Helfgott.Main.repSum_lower_bound` and `ternaryGoldbachFrom` to these localized versions. Calling the old theorems with a weaker inequality is not justified. Broad finite-RH assumptions remain exactly as before, or may be localized by the separately reviewed reduced-domain blueprint; this threshold change proves neither version of the finite-RH data.

## Ladder prefix and closed range join

The current small-case proof uses i=floor((n-5)/D), where D=111616*2^45=3927138875067072512. For n<=N0 the maximum required index is

    K=floor((N0-5)/D)=251837287.

N0 is even. The top odd n is N0-1; floor((N0-6)/D) has the same value K, independently checked. Keeping the inclusive bound n<=N0 is therefore sound and needs no special parity gap convention.

The n<=4e18+3 branch still uses p=3. Above it, the same floor identity yields 1<=i<=K, and the unchanged window width satisfies `(111616+2047)*2^45 <= 4e18-4`. Thus the actual rung prime obeys n-4e18<=p<=n-4, p is odd, and the remainder is even in the inclusive binary input range [4,4e18]. The general `statement_of_upTo_of_from` joins the two new N0 bounds directly. The original public large conclusion from 1e27 is also a restriction of the stronger large theorem. The true full `Statement` and original binary premise remain unchanged.

For 4096-rung certificates starting at1, ceil(K/4096)=61484 chunks cover [1,251838465). This contains every required index, with padded rungs through251838464. The source `prime_of_runsOK:287-302` requires the padded upper endpoint, not only K: both `1+4096*61484 <= 2^28` and `111616*(1+4096*61484) <= 2^45` pass exactly.

The existing `Data.runsOK_all` has62168 chunks. The proposed slice removes684 chunks, or2801664 checked rung positions. The required-index count falls by2801021 from254638308 to251837287; these two savings count different objects.

Source file boundaries are not uniform: `L000` has486 chunks while the terminal files have485. The actual L126 start250667009 implies61198 preceding chunks; retain286 of L126's485 chunks and omit L127. A provisional message from this reviewer incorrectly used126*485 and suggested374 terminal chunks; that assumption was corrected against the actual source before this report. The totals61484 and684 were unaffected.

Actual checked-work savings require a prefix-only aggregation/import path. Merely applying the old `ladder_prime` to i<=K still imports `Data` and its complete `runsOK_all`. Importing all L126 while using only its initial chunk declarations may also retain excess clean-build work. A versioned truncated terminal module and prefix aggregation can reuse the old deterministic hints/claims without changing the fixed base-3 criterion, but this has not been generated or built. The roughly1.1% reduction is a certificate-count opportunity, not a measured reduction of total proof time or binary verification cost.

## Exact independent checks

`review_lower_threshold_exact_20261111.json` records11 independent rational/integer assertions and the endpoint counts. SHA256 `CC886CFDEA05ECAC7C5CB7366491F92C919604A64B3C466A7D045D989E6B2D12`. It checks the scale identity, the two root lower bounds, sqrt N floor, unchanged strict crude coefficient inequality, top-odd floor, fixed gap, and padded index/Proth bounds. No source or producer code was imported.

This review's positive conclusion concerns N0 and reuse of the original live assembly. It is not an assertion that substantially lower thresholds are impossible, nor that altered QRH consumers have been recompiled at N0.

As supplementary read-only scalar checks, I independently reconstructed the author's degree24 exponential lower sum at2.303, the exact reserve upper `20618162523/7784250095800 < .002648703`, and the star/sig scalar failures at5e26,2e26,1e26. The decreasing `log N/sqrt N` reduction is valid throughout N>=N0. These tests support the author's distinction between failed unchanged envelopes and actual analytic errors. They are not a complete new audit of the separately conditional QRH assembly or a proof that no better lower-threshold method exists.

## Source pins

Paths below are under `work/ternary-goldbach/TernaryGoldbach`. These bind the inspected source, not a new kernel validation.

| File | SHA256 |
|---|---|
| `Statement.lean` | `3F61837D2C3A0DDE3A1997F05AF21C20C7FE6EE13E29891125495F6947596BF8` |
| `MainTheorems.lean` | `4B2BDB187A2D9AC485239611EEE99D1C716C5BC0F57F1946DAA32CBD22FECFFF` |
| `Helfgott/Defs.lean` | `4CE6EA7FB475024DF403775F9480D7D01B6336A798E0CF254BD61B5AFEC79DC7` |
| `Helfgott/Inputs.lean` | `5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83` |
| `Helfgott/Chebyshev.lean` | `3E1809BA6681FF486C62608A42B5D5D48674D240E41D474A74B2C4A5A28E5269` |
| `Helfgott/Numerics.lean` | `059874D201ECC571583118A56BA6193D6D8B49016C227988CBC83FA0F34648DB` |
| `Helfgott/Main.lean` | `DD5E20E51EC7C699CAC00A497C34FEF687E7E5B4562D3B1D8B981ECE54F4261D` |
| `Helfgott/SmallCases.lean` | `61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359` |
| `MinorArcs/NumericsFinal.lean` | `27DB90B71D4B3ACBF7F3BB84374733A4E9601170A770C83E8006CCB2465B95A4` |
| `Ladder/Main.lean` | `A68289240152DDF2D6ADBD98A0055B45284D924F4F64820D851C01CA6FA250E9` |
| `Ladder/Spec.lean` | `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F` |
| `Ladder/Data.lean` | `A07F94E80C0AA4DC3EF9032A8CB418AB3DC6FFA1040A51DFB3DA5E874BD879F3` |
| `Ladder/Data/L000.lean` | `650B391D462C1562143D879DAB8EFFC973F917081C276369FB9201985131DC6D` |
| `Ladder/Data/L126.lean` | `8785DB5F7BE25A4C770D79CFB6F778E6BB971B5355AA45E3FF40B45FF30943C0` |
| `Ladder/Data/L127.lean` | `7F74625895FBCC23162B4F8FC683F6F1814585F5C28D01FA159997FD4BC9F33E` |
