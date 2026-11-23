# Lowering the analytic threshold without new spectral estimates

2026-11-11. Source/paper and exact rational arithmetic only. Target source HEAD is `23b2d68ca344203d4384e0aff7affa4ec034bef9`. This report preserves the earlier raised-threshold report and all Lean sources. No Lean build, prime search, spectral evaluation, or certificate generation was run.

## Result and limits

The explicit candidate

    N0 = 989 * 10^24 = 9.89e26

preserves the original proof's complete major/minor estimates with their original smoothing and spectral premises. All scale-sensitive estimates can be invoked at their existing domains: `x >= 4.9e26` and `y=x/49 >= 1e25`. The elementary nonprime proof and final strict positivity also extend to N0. These are paper adaptations of the exact source bodies, not newly compiled theorems.

The original finite-RH premise remains unchanged by this change. If the separately researched restriction of the original spectral family is eventually proved, the threshold improvement composes with it because it changes none of its conductor, height or normalized-frequency requirements. This report does not discharge finite RH, BinaryGoldbachInput, or a global QRH provider.

For a newly generated/checked ladder, the candidate removes 2,801,021 required rungs. At the existing 4096-rung checking granularity it removes 684 chunks, or 2,801,664 checked rungs, about 1.1% of this component. It does not imply a 1.1% reduction in the whole proof's cost. Keeping the old aggregate import would realize no ladder saving.

The deeper probes 5e26, 2e26 and 1e26 do not close with unchanged constants. This is more than a missing theorem binder: the fixed star-error scalar envelope and a minor-arc scalar coefficient are actually false at those probes. They are upper-bound formulas used by the proof, not lower bounds on the actual analytic errors. Thus their failure is not an impossibility result for a redesigned proof.

## The scale join

Write

    c0 = 2 + 9/(196 sqrt(2*pi)),  x=N/c0,  y=x/49.

`Helfgott/Numerics.lean:11-20` gives c0>0 and c0<=2.02. For the improved threshold use just the existing elementary pi bound pi>3.14, already consumed in `Helfgott/SupNorms.lean:40-41`. Since 2*3.14>(5/2)^2,

    sqrt(2*pi)>5/2,
    c0 < 2+9/490 = 989/490,
    (989/490)*(4.9e26) = N0.

Consequently N>=N0 gives x>4.9e26 and y>1e25, including the new endpoint. No argument substitutes a smaller x into an estimate proved only at the old x floor.

`Inputs.major_arcs_input:76-91` uses N>=1e27 only to obtain that x floor and N>0. Its identity N/x=2+9/(8 sqrt(pi/2))/49 is unchanged. `MajorTotal.major_total:974-1054` then gives 1.049*x^2/49 with exactly the old per-modulus constants and summed L2 bound. In particular all plus/star square-root errors, coprime-removal errors, upper J, singular-series bounds and convolution constants remain covered by the same `hx`.

`Inputs.minor_arcs_input:109-113` likewise calls only `minor_total hx (numerics_M hx)`. The numerical cells need no extension. `NumericsFinal:12-33` still starts at x=4.9e26, and `NumericsCells.cell0:340ff` has that same left endpoint. In `MinorTotal`, the live scale-dependent consumers include:

| Source | Bound or interface preserved |
| --- | --- |
| `MinorTotal:138-143` | prime-power coefficient energy <=8e-11*x |
| `MinorTotal:166-212` | ghatY base-level lower bound at y>=1e25 |
| `MinorTotal:216-263` | total prime-coefficient energy, including 366.91/sqrt(x) |
| `MinorTotal:277-316` | lower I0>=8.6294*x, after prime-power removal |
| `MinorTotal:323-330` | minor total 1.0376*x^2/49 and y>=1e25 |
| `ArcCharsStar:113-135,139-151` | scaled star error1.49e-6 and actual y=x/49 |
| `ArcChars:324-337` | scaled plus error4.25e-7 |

This reuse preserves the actual smoothing functions and character sums. It does not assert that one decaying term controls the complete minor or major budget.

## Nonprime terms and strict final positivity

Read the full bodies of `Chebyshev.psi_sub_theta_le:115-203` and `psi_le:207-220`. The former sets w=N^(1/32), writes sqrt(N)=w^16 and bounds the higher-prime-power contribution by

    46.2*w^13*log(4) <= .15*w^16*log(4).

Its only use of N>=1e27 beyond positivity is w>=6.9. The exact comparison

    (69/10)^32 < N0

is in the scalar receipt. Moreover 46.2<.15*(6.9)^3 and 1.15*1.3862943617<1.6. Thus every subsequent finite sum, floor, root and logarithm comparison in that proof remains valid, giving psi(N)-theta(N)<=1.6*sqrt(N).

`psi_le` additionally uses sqrt(N)>=1e13, which follows from N0>=1e26. Its inequality 1.6*sqrt(N)<=.0001*N and log(4)+.0001<1.387 are unchanged. The full `Inputs.nonprime_input:126-148` therefore retains the bound

    bad contribution <= 6.7e6 * N*sqrt(N)*log(N).

It also uses sqrt(N)>=1e13 to absorb log(2), and the unchanged exact coefficient comparison

    3*400^2*6.2*1.6001*1.387 < 6.7e6.

There are two sufficient final scalar routes. The minimal source adaptation reuses `Numerics.final_inequality_crude:71-147` in full. Its threshold dependence is v=N^(1/64)>=2.64. The receipt proves (2.64)^64<N0 and the unchanged strict comparison

    1.589e8 * 4.0804 * 49 < .0114*(2.64)^31.

Thus the exact original proof of nonprime<(.0114)*x^2/49 survives, without a new analytic inequality or numerical cell.

A sharper independent reserve calculation also helps compare routes. Define

    Cnp(N)=49*(2.02)^2*6.7e6*log(N)/sqrt(N).

For N>=N0 this is decreasing, since the derivative of log(N)/sqrt(N) has the sign of 1-log(N)/2, which is negative here. At N0 use log(N0)<27*2.303 and sqrt(N0)>=isqrt(N0). The bound log(10)<2.303 follows from a positive exponential Taylor sum of degree24 exceeding10. All remaining calculations are rational. They give

    Cnp(N) <= 20618162523/7784250095800
            < .002648703 < .00265 < .00271.

The original major/minor difference .0114 therefore has positive reserve >.008751297. Even the separately accepted conditional QRH paper major constant1.0404, if all its other premises are retained, would keep reserve >.000151297 after minor1.0376. The latter is a composition observation, not a new proof of any QRH input or a reason to adopt that route.

`Helfgott/Main:30-51,68-75` now assembles the same circle identity, major/minor estimates, nonprime removal and positive-prime-count extraction at N0. The original `10^27` wrappers must be generalized or replaced; the old theorem cannot be instantiated directly with a weaker hypothesis. `MainTheorems.lean:17` is a further public wrapper, not an extra estimate.

## Exact ladder change and cost scope

Keep BinaryGoldbachInput through B=4e18, stride D=111616*2^45=3927138875067072512 and the existing 2048-candidate windows. For odd n<=N0 use the same index

    i=floor((n-5)/D).

The proof in `SmallCases:21-42` only needs 1<=i and an upper available rung bound. The new maximum is

    I0=floor((N0-5)/D)=251837287.

Since N0 is even, the top relevant odd n is N0-1; the receipt checks that floor((N0-6)/D) has the same value. The lower branch n<=B+3 and every parity/end-window inequality remain unchanged. The exact conditions

    (111616+2047)*2^45 <= B-4,
    111616*I0 < 2^45

preserve both gap coverage and `Ladder.Spec.prime_of_cert:58-79`. This needs no new candidate existence beyond the retained old range.

| Quantity | Existing | Proposed |
| --- | ---: | ---: |
| Required rung maximum |254638308|251837287|
| Checked 4096-rung chunks |62168|61484|
| Rungs actually checked at that granularity |254640128|251838464|
| Final half-open endpoint |254640129|251838465|

Source `Ladder/Data.lean:133-138` supplies the existing aggregate. The data files are not all the same size. `Data/L126.lean:5,19` starts at250667009, so its preceding files cover61198 chunks. Retain286 of L126's485 chunks; omit its remaining199 and all485 chunks in L127. This accounts for exactly684 removed chunks. `Ladder/Main:19-26` must call a new restricted aggregate. Merely proving a smaller endpoint from the old `runsOK_all` still imports/checks the full old data and saves nothing.

No source was changed. The intended future implementation must change the data/import aggregation and final wrappers, then verify those changes. Regenerating only the retained chunks can avoid their omitted search/check/serialization work; reuse of already generated data can avoid rediscovery but does not refund previous computation. Binary checking, spectral work, analytic library compilation and the retained 90-bit candidate arithmetic are unchanged. No timings or end-to-end percentage are inferred. The added mathematical work is a small threshold lemma and elementary wrapper changes; its checking cost has not been measured.

## Why the larger reductions are not established

With unchanged x/y theorem domains, the exact threshold frontier is c0*4.9e26. Existing decimal pi bounds imply

    9.88975944468823e26 < c0*4.9e26 < 9.88976302561239e26.

These displayed bounds only localize the black-box frontier. The primary N0 proof uses the much simpler pi>3.14 argument. Lowering the threshold appreciably below this frontier requires changing some actual scalar estimates, not merely changing the final N wrapper.

For example `ArcCharsStar.err_scaled_le_star:113-135`, after division by y, asserts the explicit inequality

    sqrt(c)*(1e-17+1e-12) + 4.7e6/sqrt(y) <= 1.49e-6.

At c=300000, sqrt(c)>547. Using c0>2+9/(196*2.5067), a necessary condition for this exact scalar inequality is

    N > [2+9/(196*2.5067)]*49*
        [4.7e6/(1.49e-6-547*(1e-17+1e-12))]^2
      > 9.8475e26.

That conductor is not an empty primitive family. But the obstruction already concerns the stated scalar lemma for real c, so no character evaluation is required. Corresponding necessary thresholds for the unchanged plus envelope and minor `sig_le_lin` scalar coefficient are >9.7686e26 and >9.4017e26 respectively. The receipt records exact fractions. The minor coefficient is the inequality 366.91/sqrt(x)<=1.7e-11 used in `NumericsCore:204-212`, and is not a claim that the full minor integral itself is too large.

At each proposed deeper probe c0>2 gives x<N/2 and y<N/98. The receipt directly proves

    (4.7e6)^2 > (1.49e-6)^2*N/98,
    366.91^2 > (1.7e-11)^2*N/2.

Thus both fixed scalar estimates fail already before adding their other positive terms. The old auxiliary bound w>=6.9 also fails at all three probes. A better elementary Chebyshev estimate might readily repair the latter; that alone does not repair the major/minor estimates.

| Probe N | Conditional Cnp upper, assuming the old6.7e6 coefficient | Present conclusion |
| --- | ---: | --- |
|5e26|.003725172|Below original .0114 reserve, but fixed star/minor scalars fail|
|2e26|.005890014|Same failure|
|1e26|.008329738|Same failure|

These nonprime columns are sensitivity calculations only: this report has not extended the6.7e6 theorem to those probes. A valid larger improvement would need a new complete major error aggregation, lower/upper J and prime-power energy bounds, base-gap/star input, and new minor numerical cells. The next source target should therefore be a parameterized version of those estimates and a recomputed `Mexpr`, not a claim based on the final .0114 margin. This report establishes only the explicit N0 candidate and the failed unchanged-envelope tests.

## Scalar packet and source pins

`efficiency_lower_analytic_threshold_20261111.py` uses only Fraction, integer powers/factorials/isqrt, source hashing and JSON. Its exact replay exited0. It produces no prime or analytic-function values. Source hashes below are also recorded in the receipt. Displayed decimal values are outward rounded descriptions; exact rational fields are authoritative.

- Script SHA256 `AB1BED8186C0CE937FB5CFFBA9D60A1338A3672C104F44B9845E02EDD6FF76EC`.
- Receipt SHA256 `0D6A6C0EEB89C5B4660B95EF974AFA104CA7397AE8B00400B04B97D7FE9FBE3E`.

All source paths in the following table are relative to `work/ternary-goldbach/TernaryGoldbach`.

| Source | SHA256 |
| --- | --- |
| `Helfgott/Inputs.lean` | `5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83` |
| `Helfgott/Numerics.lean` | `059874D201ECC571583118A56BA6193D6D8B49016C227988CBC83FA0F34648DB` |
| `Helfgott/Chebyshev.lean` | `3E1809BA6681FF486C62608A42B5D5D48674D240E41D474A74B2C4A5A28E5269` |
| `Helfgott/Main.lean` | `DD5E20E51EC7C699CAC00A497C34FEF687E7E5B4562D3B1D8B981ECE54F4261D` |
| `Helfgott/SmallCases.lean` | `61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359` |
| `Helfgott/SupNorms.lean` | `2F8FD07A7845FE3D8AA1C3EF9CF0A617D099BF292BFBC45C810FFB9400A1EC33` |
| `MainTheorems.lean` | `4B2BDB187A2D9AC485239611EEE99D1C716C5BC0F57F1946DAA32CBD22FECFFF` |
| `MajorArcs/MajorTotal.lean` | `106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A` |
| `MajorArcs/ArcChars.lean` | `0A5BA0770CC02C94C0A802FF78FC297FE7B5776153516033ECC189331A6041CF` |
| `MajorArcs/ArcCharsStar.lean` | `B95DE4A83BAF37008B21FCFF90A0188AA230548C8776DE6C5F2905C19DA9DF10` |
| `MinorArcs/MinorTotal.lean` | `6319681CA96E5408071C60036AF55769EF9A63DE2453DDBD3D17008B979FA742` |
| `MinorArcs/NumericsFinal.lean` | `27DB90B71D4B3ACBF7F3BB84374733A4E9601170A770C83E8006CCB2465B95A4` |
| `MinorArcs/NumericsCore.lean` | `4E2D5351E5BFD0350FBD3B378B123CA1F7155943D467CB4788554800B657F6F8` |
| `MinorArcs/NumericsCells.lean` | `5192960AD541DCF981C630F538B35EC63FE966A61044AF31576AB83C93A41139` |
| `Ladder/Main.lean` | `A68289240152DDF2D6ADBD98A0055B45284D924F4F64820D851C01CA6FA250E9` |
| `Ladder/Spec.lean` | `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F` |
| `Ladder/Data.lean` | `A07F94E80C0AA4DC3EF9032A8CB418AB3DC6FFA1040A51DFB3DA5E874BD879F3` |
| `Ladder/Data/L126.lean` | `8785DB5F7BE25A4C770D79CFB6F778E6BB971B5355AA45E3FF40B45FF30943C0` |
| `Ladder/Data/L127.lean` | `7F74625895FBCC23162B4F8FC683F6F1814585F5C28D01FA159997FD4BC9F33E` |

The prospective padded aggregate also satisfies the source `prime_of_runsOK` conditions `1+4096*61484 <= 2^28` and `111616*(1+4096*61484) <= 2^45`; these are included in the scalar checks.
