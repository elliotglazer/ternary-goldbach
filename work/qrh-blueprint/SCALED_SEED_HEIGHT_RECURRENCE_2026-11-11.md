# Scaled seed height recurrence and its actual costs

2026-11-11. This composes reviewed paper constructions, with exact scalar and integer metadata checks. It supplies no analytic values or kernel-checked implementation. The preceding goal turn made progress by accepting the scaled seed and spectral budget reviews and recording their status. This note addresses a remaining integration cost rather than changing the goal.

The optional height recurrence is compatible with the scaled seed interface. A sufficient concrete allocation uses log errors at most 2^-144, initial base-power errors at most 2^-120, step errors and update rounding at most 2^-140, and a final conversion into the seed grid with error at most 2^-122. All resulting base-power errors remain below the required delta=2^-118. This trades repeated cis evaluations for complex multiplications, tighter precision and persistent state. It is not a runtime measurement or proof that this schedule is cheapest.

## Exact target and error propagation

For each positive rational x, the actual value is B(x,t)=x^(-1/2) cis(-t log x). Consecutive heights differ by h=5/64 and B(x,t+h)=z(x) B(x,t), where z(x)=cis(-h log x) has modulus one. The initial value is computed at the first height at which x is needed, not assumed to start at zero.

Let eps=u=2^-140 and initialize with error at most delta/4. If the stored step has error at most eps and each complex update has norm rounding error at most u, then

    e_(j+1) <= (1+eps)e_j + eps + u.

The eps term uses the bound |B(x,t)|<=1; no assumption that the approximate step has modulus exactly one is made. For j<=J=128000, the binomial coefficient bound gives (1+eps)^j <= sum_(k>=0)(J eps)^k <2. Therefore

    e_j <= 2(delta/4)+2J(eps+u).

Keep this high-precision state for future updates. Round a separate copy to the EM grid with norm error at most 2^-122. The final bound divided by delta is exactly 701/1024, below 11/16 and hence below one. Feeding the low-precision EM copy back into the height recurrence would invalidate this calculation.

## Producing the initialization and step

Use the reviewed elementary leaf construction with p=120 for each initial B. Its complete error is below (7/16)2^-120 <delta/4. Its required log error is 2^-137, so the shared 2^-144 log certificate suffices. Its amplitude witness uses grid 2^-123. The initial output is already on a dyadic grid compatible with the finer state grid.

For the step, evaluate cis at the exact rational phase -(5/64) log_hat(x). The cis-only portion of the same construction with p=138 has complete error below 2^-142 at that approximate phase, including pi uncertainty. Then round this complex result to coordinate grid 2^-142, which has norm error below 2^-142. The total step error is bounded by

    (5/64)2^-144 + 2^-142 + 2^-142
      = (517/1024)2^-140 < eps.

The p=138 cis portion has 83 polynomial terms. The p=120 initial leaf has 74. A shared pi enclosure sufficient for p=138 also suffices for initialization. Each phase still needs its own signed reduction/rounding witnesses. The fact that the step phase is small may support a cheaper specialization, but no such saving is included here.

The reviewed grid-anchor log construction allows arbitrary target exponents. At p_L=144 its sufficient degree is 21, rather than 19 for the direct-leaf target 135. It requires 582822471 nonanchor Horner stages on the coarse grid, plus anchor certification, final assembly and all rounding witnesses. A degree or precision increase has not been hidden behind the old 135-bit count.

## Complete argument and height schedule

The band tuples (V,D,N,H) are

    (500,512,220,6401), (1000,1024,387,6400),
    (2000,2048,720,12800), (5000,4096,1720,38400),
    (10000,8192,3387,63988).

The required arguments at one height are x=1+k/D for 0<=k<=(N+1)D, including the EM endpoint. There are X=(N+1)D+1. The argument sets are nested: each new D is divisible by the preceding D and each N increases. Thus an old argument remains required at every later height. Initialize each new argument at the first height of its band and update all previously active arguments once for that height. The same rule applies at band boundaries. The largest used height index is 127988, below J.

The exact inventory is:

| Category | Count |
| --- | ---: |
| Unique arguments and initial B leaves | 27754497 |
| Step cis certificates | 27754497 |
| Total height/argument pairs | 2068812377589 |
| Recurrence complex updates | 2068784623092 |
| Conversions into the EM grid | 2068812377589 |

Each pair has one initialization or update, not both. There are at most two phase certificates per argument, including the initial leaf's phase, compared with one per pair in the direct schedule. This statement is about phase evaluations, not the number of proof instructions. Some exact zero phases permit smaller checks, but this inventory does not claim that saving. All EM head scales, accumulations, endpoint corrections and downstream transform work remain.

## State and fair comparison

One possible dense native layout stores both complex state and complex step as two signed 144-bit coordinates each. State coordinates have 140 fractional bits and step coordinates have 142. The proved magnitudes below two fit these widths. Four 18-byte coordinates per argument cost 1998323784 raw bytes, about two decimal GB, at the final band. This is only the two numerical arrays. It excludes alignment, live proof expressions, index maps, seeds, transform arrays, output buffering and worker replication. It is not a Lean or MM0 memory guarantee.

Log and amplitude certificates can be consumed when an argument is introduced, then discarded subject to the proof checker's dependency policy. Sharing their values never permits discarding an undischarged obligation. A tiled implementation can change peak storage, but any additional initializations, steps, rechecks and I/O must be charged. No constant-memory claim follows from the native array size.

Let I=27754497, T=2068812377589 and U=T-I. A comparison should retain these separate terms:

    Recurrence:
      log setup at144 bits + I initial leaves at120 bits
      + I step cis checks at138 bits + I step conversions
      + U complex updates at140-bit error
      + T EM-grid conversions + state/I/O costs.

    Direct:
      log setup at135 bits + amplitude setup at121 bits
      + T direct cis checks at118-bit contract
      + T phase/amplitude products and final rounding.

Shared setup in the first line must not also be counted inside an opaque full-leaf price. Amplitude/phase setup, exact rational argument formation, arithmetic witnesses and serialization are real costs in both schedules. The recurrence is a promising component option because it removes trillions of polynomial cis checks, but only actual arithmetic and storage models can decide its end-to-end advantage.

## Evidence and remaining work

`check_scaled_height_recurrence_20261111.py` checks six author/review pins, all band counts, nesting conditions, height ranges, precision inequalities and the degree21 log bound. Its output is `scaled_height_recurrence_20261111.json`. It performs no elementary or L-function evaluations. The six pinned inputs are the shared EM circuit, scaled-seed review, elementary leaf author/review and grid-anchor author/review. The three independent reviews certify the paper prerequisites, not an executable numerical implementation.

An independent review of this composition is still required. Generic recurrence proofs, state/argument bindings, concrete values, arithmetic implementation, high-to-low conversion, ordinary proof acceptance and the complete spectral sign/count interface remain open. The schedule only concerns the large-conductor seed calculation, not the principal or small-conductor branches, finite Goldbach coverage, or full Lean/MM0 foundation costs.
