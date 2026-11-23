# Component-mix and supplied-root break-even screen

2026-11-11. New conditional cost screen; the earlier linear screen is unchanged. This note reads the frozen principal height-scaling analysis, Q-frontier allocation and common-root acceptance contract. It performs only integer/rational composition of their cost parameters and saved scalar enclosures. No prover, primality search, analytic evaluator, FFT or benchmark ran. No runtime winner or final Fermi estimate is asserted.

## 1. Preserve the unknown component costs

Write H0=10^8, H*=3000175332800 and H(Q)=4*10^10 Q. In the **fixed-window scenario**, let s in[0,1] be the fraction of reference-prefix cost attributable to coefficient work proportional to the integral of sqrt(t); the remainder is proportional to height. Set

    l_Q=(H(Q)-H0)/(H*-H0),
    c_Q=(H(Q)^(3/2)-H0^(3/2))/(H*^(3/2)-H0^(3/2)),
    r_Q=c_Q/l_Q.

Use the previous nominal linear anchor

    P0(Q)=27000000000*(H(Q)-H0)/H* seconds.

This chooses a nominal reference-prefix allocation of the historical7.5 million core-hours. The actual prefix allocation is unreported; its discrepancy belongs in the transfer factors below. No certificate through H0 is assumed already free.

Let k_L and k_C price the **complete** linear and coefficient components relative to that nominal model, including hardware, preparation, witness/proof generation and verification. Then a useful conditional equation is

    P_s(Q)=P0(Q)*[(1-s)k_L+s*r_Q*k_C]+C_extra(Q).     (1)

The components may have different formal overheads. A single multiplier k is the special case k_L=k_C=k, not a conclusion about an implementation. If precision, window widths, truncations or repairs change outside this model, recompute the work functions; do not force their cost into an alleged universal exponent.

The height-scaling source proves why the two terms arise, but does not identify s from Platt–Trudgian's aggregate timing. Its B.1 analysis also prevents holding J/sqrt(t) fixed while freely widening the Gaussian scale: at fixed sigma the sufficient bound has an additional h^(1/(sigma-1)) factor. Thus neither H^(3/2) nor linear/H-log-H is an established total production law.

## 2. Exact threshold across the component mix

Retain the B_L=2*10^16 comparator with K=90804183483 required mixed-ladder slots. Put

    D(Q)=C_bin(B(Q))-C_bin(B_L)
         + additional analytic/head/import/assembly cost
         - eliminated fixed ladder cost + C_extra(Q).

The principal route beats this ladder candidate precisely when its complete average rung cost satisfies

    c_root > [P0(Q)/K]*[(1-s)k_L+s*r_Q*k_C]+D(Q)/K.  (2)

For fixed k_L,k_C,D, the right side is affine in s. Therefore its minimum and maximum over every component mix are the two endpoint values

    D/K + (P0/K)*min(k_L,r_Q*k_C),
    D/K + (P0/K)*max(k_L,r_Q*k_C).                  (3)

Below the minimum, the ladder is cheaper for every s in this scenario; above the maximum, the principal route is cheaper for every s; between them, the component measurement matters. These are **model-conditional** robust tests, not bounds on all possible evaluators. Without bounds on the k factors, no finite unconditional cost interval follows.

The following coefficients set k_L=k_C=1 and omit D. Entries are outward integer-microsecond intervals for P/K, with r taken from the frozen exact-height H* rows, not the rounded3*10^12 rows.

| Q | coefficient only, s=1 | equal shares, s=1/2 | linear only, s=0 |
|---:|---:|---:|---:|
|1|[457,458]|[2206,2207]|[3954,3955]|
|2|[1294,1295]|[4606,4607]|[7918,7919]|
|4|[3661,3662]|[9754,9755]|[15847,15848]|
|8|[10357,10358]|[21031,21032]|[31704,31705]|
|16|[29294,29295]|[46357,46358]|[63419,63420]|
|32|[82858,82859]|[104853,104854]|[126849,126850]|
|47|[147489,147490]|[166901,166902]|[186314,186315]|

At Q47, r is in[.791615,.791616]; varying s alone changes the nominal threshold by at most about21%. It does not supply an orders-of-magnitude saving. At Q1, r is in[.115737,.115738], so this particular uncertainty is much larger. The printed .791638/.115741 values in the scaling discussion use the rounded reference height; mixing the two references would slightly change the calculation.

For the equal-factor special case k_L=k_C=k, put c_net=c_root-D/K. If 0<r_Q<1, the crossing share is

    s_cross = [1-c_net/(k*P0/K)]/(1-r_Q).

The principal route wins when s>s_cross, provided the crossing lies in[0,1]. If k_L differs from k_C, use the slope in(2); its sign can reverse.

## 3. The binary change is part of the threshold

The fresh sufficient allocation is

    U=125539470000000000,
    B(Q)=2 max(10^16,ceil((.031+2.261/Q)*U+3)).       (4)

It is conditional on the new analytic frontier and its actual finite-RH input. Q47 reaches the floor2*10^16; larger Q does not improve this B. No certificate is inferred from these parameter values.

For B(Q)>B_L define beta_Q as the **average complete marginal cost per additional even target**:

    beta_Q=[C_bin(B(Q))-C_bin(B_L)] / [(B(Q)-B_L)/2].

This definition does not require a globally linear binary model. It includes the changed source-prime, anchor, coverage, exception and assembly costs. For a monotone cost assumption beta_Q is nonnegative; the equation itself allows any justified measured difference. A stipulated1 nanosecond per extra even target contributes the following microseconds per ladder slot:

| Q | actual B(Q) | added microseconds/rung per beta_Q=1ns |
|---:|---:|---:|
|1|575472930480000006|[3058,3059]|
|2|291628188810000006|[1495,1496]|
|4|149705817975000006|[714,715]|
|8|78744632557500006|[323,324]|
|16|43264039848750006|[128,129]|
|32|25523743494375006|[30,31]|
|47|20000000000000000|0|

The1ns is a unit slope, not a claimed checker throughput. For example, Q1's coefficient-only spectral figure457–458us does not by itself make it inexpensive: a1ns average binary increment would add about3059us. If binary Goldbach remains an allowed premise rather than a certificate being produced, this term is absent; do not then claim computational savings from reducing B. At the current unchanged final Statement, this distinction must remain explicit.

### Switching between Q rows

For Q_j>Q_i, the larger height wins if the complete binary saving exceeds the spectral and fixed-cost increase. Under the nominal common-factor1 scenario with equal fixed costs, divide the spectral difference by `(B_i-B_j)/2`. The resulting switch rate is affine in the **same reference share s**. Values below are nanoseconds per removed even target:

| pair | coefficient-only switch enclosure | linear-only switch enclosure |
|---|---:|---:|
|1 to2|[.535,.536]|[2.536,2.537]|
|2 to4|[3.029,3.030]|[10.145,10.146]|
|4 to8|[17.135,17.136]|[40.583,40.584]|
|8 to16|[96.932,96.934]|[162.332,162.333]|
|16 to32|[548.334,548.337]|[649.331,649.332]|
|32 to47|[2124.900,2124.911]|[1955.081,1955.082]|
|1 to47|[48.071,48.072]|[59.621,59.622]|

An average binary saving rate above the larger endpoint makes the higher Q cheaper for every s in this scenario; below the smaller endpoint favors the lower Q for every s. In between, the mix matters. Fixed-cost differences and k_L,k_C must be restored before applying the comparison.

The last adjacent pair illustrates why total and marginal costs must be separated: coefficient scaling reduces total cost at each height below H*, but its marginal cost from Q32 to47 is greater than the linear component's. One cannot choose every Q comparison by saying “H^(3/2) is cheaper below the reference.” Also, a winner among Q rows need not beat the best ladder.

## 4. Price the supplied-root option by its actual circuit

The accepted paper contract permits a product M of actual odd candidate integers, each greater than1 and below(2^45+1)^2, and a supplied root X satisfying

    X^(2^44) mod M = M-1.

This entails primality by the existing order/least-divisor criterion. Acceptance checks44 modular squarings plus actual product binding, reduction, final comparison, candidate size/oddness and coverage. It needs no reconstruction of the small base, offset powers, indexed progression, or separate gcd. It does **not** imply that suitable candidates/roots populate every required interval.

For a batch of q current candidates of at most90 bits each, a concrete checking model is

    V_root(q) = 44*S_s(90q) + product_s(q) + initial_reduction_s(q)
                + final_binding_s(q) + coverage_s(q) + non_gate_proof/IO_s(q),

where S_s(b) is complete checked modular-square cost at the actual b-bit modulus, including quotient/remainder witness checking or kernel reduction and the chosen proof representation. Use actual bit lengths when available. Division by q gives an ordinary-slot average; varying group sizes and direct singletons require their actual sum. The44 count alone does not price wide operands, product construction or proof events.

The untrusted producer still finds candidates and individual roots and constructs the common root, for example by CRT. Duplicate factors require a valid construction or deduplication. All failed searches count. A full root needs up to90q payload bits for these candidates, beyond offsets and framing; streaming lowers memory, not automatically generation or checking I/O. The checker does not need to replay the producer's CRT if it checks the sufficient congruence itself.

Define eta44 as the resulting complete root-checking cost per ordinary slot divided by the historical55us reference. This is an unknown circuit/implementation factor, **not44/88 as a timing theorem**. A useful conditional total is

    c_root = 15us*g_search + 55us*eta44
             + extra_root_generation + layout/IO + f*Delta_fallback. (5)

The added terms must not overlap; in particular the15us historical search did not include this new common-root production/payload architecture. An ordinary-MM0 implementation prices the same circuit in PA proof events/bytes and checking costs rather than inheriting Lean's55us.

For sensitivity only, eta44=1/2, g_search=1 and all added costs zero give42.5us per rung. This is a hypothetical operation-cost bridge, not a measured speedup. At Q47 the nominal spectral range147489–186315us is then about3470–4384 times larger. Against the unrevised70us reference it is about2107–2662 times larger. Thus reducing the rung checker without a compensating producer premium makes the high-H route harder, not easier, to justify under this model.

Conversely, expensive unsuccessful searches, CRT/witness work or fallbacks can raise c_root. Equation(2) gives their required **average** premium. At Q47, k_L=k_C=1 and D=0, the route needs c_root above186315us to win regardless of s; if c_root is below147489us it loses regardless of s. A measured value between them needs the component mix. These thresholds move with every explicit transfer/fixed-cost term and are not unconditional statements about actual compute.

## 5. Measurements that can reverse the conditional choice

The decision-driving quantities are few, but each must cover a complete accepted object:

1. **Root-ladder block:** candidate/root availability, failed search, root/CRT construction, group-size distribution, all44-square acceptance work, fallback proof cost, emitted/read bytes and import/root composition. This estimates c_root and reveals whether eta44 is small enough to matter after production.
2. **Spectral window at the intended scale:** separate coefficient construction, Gamma/elementary work, transforms, output error checks, local repairs and completeness, with both generation and formal acceptance. This determines whether common k or distinct k_L,k_C is appropriate and constrains s. A native FFT or low-height function value cannot supply these coefficients.
3. **Binary marginal block:** the actual source/anchor/coverage changes when moving between two B allocations. The average beta for that pair, not a universal bits-per-second assumption, enters the switch test. At Q1 versus47 the nominal48–60ns threshold explains why this measurement can outweigh uncertainty in the spectral component mix.
4. **Fixed proof overhead:** analytic library checking and imports, reusable head evidence, final root assembly and rechecks. Development effort is a separate planning dimension; do not silently turn it into CPU seconds or ignore the missing Logan formalization.

The robust tests concern only uncertainty in s after other parameters have been fixed. If the actual window schedule invalidates the two-term scaling, or the analytic theorem/spectral certificate fails, there is no cost verdict to apply. The full objective remains the minimum over admissible ladder cutoffs/batch policies versus the minimum over proved Q routes, with the nonprincipal family common where legitimately shared.

Ordinary MM0 includes a mechanically widened64-bit format or garbage-collected/streaming implementation retaining the exact PA inference rules. Those are implementation candidates, not arithmetic axioms. Apply implementation assurance comparable to Lean's conventionally trusted kernel; neither backend receives a free native analytic oracle. Price trusted arithmetic accelerators or changed acceptance rules only as separately labeled alternatives. This note selects no backend and authorizes no run.

## Source and arithmetic pins

All prior notes remain frozen. The new JSON `integration/mixture_root_cost_screen_20261111.json` has SHA256 `5D3AA8FD6D780A9E0D1986511557B2BCD76376A5CC0E887C5DDF88BCA3A0B14F`. It records outward integer brackets, including exact added-even counts and pairwise switch units; it consumes the source report's saved rational r enclosures rather than evaluating powers or logarithms. Its claims are model arithmetic only, with no independent review asserted.

| Source | SHA256 |
|---|---|
| `zero-sum/PRINCIPAL_WINDOW_HEIGHT_SCALING_2026-11-11.md` | `E9C8B143D82070C7329F7F4B93CBE0823771B3C95614538368F0425DD40A5EBF` |
| `zero-sum/principal_height_scaling_ratios_20261111.json` | `4752D2D6F4E46B930C86B16EF0280CC9406C3D851B342930B25CCBD197D26741` |
| `work/qrh-blueprint/COMMON_ROOT_PRIMALITY_CERTIFICATE_2026-11-11.md` | `8D4E43987A576E7B18D849E94CB613A4F16C6E15B65DFE4204D1905C3D5FDF95` |
| `moebius/EFFICIENCY_Q_FRONTIER_SELECTION_2026-11-11.md` | `9905D47D869D8E6C568C7A1EFA7E4C8D5523FE47B4F4167B9E838C363211F64B` |
| `major-constants/EFFICIENCY_JOHNSTON_FINITE_RH_FRONTIER_2026-11-11.md` | `0305EF19674FF97D13C2FA3F897E1106B5B0C4618287C9002842B87233F617DF` |
| `integration/EFFICIENCY_LADDER_ZETA_BREAK_EVEN_SCREEN_2026-11-11.md` | `A0400AF43EC88FED3756F2C05AF24EEC20308E716DC422CF2B9D9AA525266BDA` |

Except the explicit blueprint path, source paths are relative to `work/qrh-campaign/agents/`. Historical timing provenance and nontransferability are unchanged from the previous screen.
