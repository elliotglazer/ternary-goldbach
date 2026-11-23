# Composition of raw signs and variable interpolation order

2026-11-11. Bounded conditional paper construction. Both component independent reviews are now available and were read. This composition is a new author supplement, not an independently accepted composition or a change to a frozen ledger. No analytic values, transforms, signs, builds or Lean/MM0 declarations were produced.

## 1. Exact bound inputs

Paths are relative to `work/qrh-campaign/agents`.

| Input | SHA256 |
|---|---|
|audit/SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md|076030481DEB4A922356A5BC0B8CCB243DF3FBB15A0DD427A29DEB044E82D430|
|zero-sum/REVIEW_SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md|5683768E8F7B8B93FD4CD2E45CDBED40BFA9CC1BAE238CF920A22B40FEBB820A|
|prime-estimates/ADAPTIVE_SMALL_THETA_INTERPOLATION_ORDER_2026-11-11.md|6F275BC37931D5AF741AC9DFA87C8CFC5022BC61FF829B3A45AD4C288539416C|
|integration/REVIEW_ADAPTIVE_SMALL_THETA_INTERPOLATION_ORDER_2026-11-11.md|EACC35D6B7B05B808C93515665D2616FC322DD65802CB67B0BB2782A150D4948|
|prime-estimates/adaptive_small_theta_interpolation_20261111.py|83397BC9122A7D965E91503990AAF7DAFE6A3A8FEB4CF1508C92C2886FBF229A|
|prime-estimates/adaptive_small_theta_interpolation_20261111.json|3E6F184E7C7D2F13915F925C6687E3970204990035487DAC8BD41D9991C283A2|

The component reviews establish conditional source/error interfaces and exact metadata, not actual spectral evidence. Their inherited fixed-phase, coefficient, gate and finite-family hypotheses all remain. The revised minimal-theta schedule must retain its bucket-rounding clarification.

## 2. Transport of the shorter remainder to raw units

Keep one actual character, its fixed unit phase epsilon_chi, and the same exact stored Hermitian array A. The error budget is separately denoted eps. Let

    Delta=5/64, P=N*Delta, omega=2*pi/P,
    J=ceil(25N/192), B=2*Wbar^2+1, M=44B,
    U(t)=A_0+2 Re sum_(j=1)^J A_j exp(i*j*omega*t),
    C_U=(2J+1)B, L=6/P, H=44/(7P).

H here is an omega upper bound, not a spectral height. The raw-interface proof gives L<omega<H and H*C_U<M. The analytic/coefficient error is `|F_b-omega*U|<3eps/4` only at targets in [0,V]. The finite polynomial and its derivative bound are global.

Every selected row has N>=2^18. Hence its exact bandwidth satisfies

    Omega*Delta/2=pi*J/N
      <(22/7)*(25/192+1/N)
      <=q_star=160919/393216.

For the selected even order r=2m, the reviewed table proves `M*q_star^r<eps/16`. The global raw derivative bound is C_U*Omega^r. Applying the same real interpolation product inequality to U, with nodes j=-m+1,...,m, gives

    raw remainder <=C_U*q_star^r <eps/(16H).             (1)

Thus no T-sample scaling is needed to use the improved bandwidth or the shorter order. It is essential that M is still the same conductor-cohort/tilt majorant used to select r. Replacing it by a numerically guessed raw magnitude would be another proof.

All 40 even orders182 through260 occur. At every order the seven eighth-grid kernels have exact l1 norms below4. Those bounds, independently reconstructed in the component review, apply to the same Lagrange weights for U and T. No new kernel values or norm monotonicity assumption are introduced by this composition. The relevant cohort is conductor parity, not character parity; both character arrays remain distinct.

## 3. Samples, finite arithmetic and unchanged sign threshold

Require raw grid sample radius at most eps/(64H), uniformly at all consumed N-grid indices. The raw-interface radix-two argument still applies verbatim: the old sufficient time-root/gate budget divided by8 yields raw error at most eps*P/448<eps/(64H). The number of stencil points does not enter that argument. There is no return to the scaled-T factor16 allocation unless that stronger allocation is deliberately retained.

For a selected order r, a complete simple rounded implementation may use the common absolute error tolerance

    v_raw <=eps/[16*r*H*(C_U+3)].                         (2)

Quantize each exact real weight to this accuracy. Round each of the r real products and r-1 sequential additions to this accuracy and permit one final rounding at the same accuracy. The sample centers have magnitude below C_U+1. Decomposition with exact weights first gives at most

    r*(C_U+1)*v_raw + 2r*v_raw
      =r*(C_U+3)*v_raw <=eps/(16H).

This includes the weight/sample cross error and all stated roundoff. The exact weight quantizations are shared setup, not extra per-query gates. There are r products, r-1 additions and2r arithmetic rounds per query. Kernel error and roundoff are not assumed independent.

One may conservatively keep the adaptive scaled-T kernel tolerance `eps/[16*r*(M+3)]`. Indeed

    H*(C_U+3) <=(506/21)B+66/21 <=44B+3=M+3,

using B>=1. This proves sufficiency of that tolerance, not equality of raw and scaled product widths. The raw sample and product magnitudes still require their own checked widths and costs.

The exact kernel norm below4 makes sample uncertainty contribute less than eps/(16H). Together with (1), (2) and the target-only analytic comparison, the resulting center z has

    |F_b(t)/omega-z|
      <3eps/(4L)+3eps/(16H)
      =109eps*P/704.                                    (3)

This is precisely the previous raw sign threshold, independent of the selected r. A strict comparison of z to either signed threshold proves the corresponding actual F_b and Y sign because omega and exp(theta*t/V) are positive. Neither multiplier needs numerical evaluation at the output. The looser5eps*P/32 threshold also remains valid. A failed strict test stays inconclusive.

Wrapped sample indices refer only to U's period P. N>r and m_grid+1<=N hold in the reviewed row admissions. The unwrapped derivative proof, closed physical target range [0,V], exact coefficient identity and complete wrapped sample dependency union all survive. There is no assertion of periodicity of F_b or Y.

## 4. Counts and cost interpretation

Under the full-range independent-stencil schedule, the raw composition inherits the following adaptive counts. The error-unit conversion does not change the selected order, number of requests or access pattern.

| Extra nodes | New eighth-grid requests | Real products and sample accesses | Real additions | Arithmetic rounds |
|---:|---:|---:|---:|---:|
|0|12427893758063|2439308097734074|2426880203976011|4878616195468148|
|167|12449493497315|2444314618551050|2431865125053735|4888629237102100|
|320|12469282479983|2448675913538876|2436206458958893|4897351827077752|
|640|12510671201903|2457999714849406|2445489043647503|4915999429698812|

In the main scenario this removes1786175780007346 real products relative to applying the fixed340 raw stencil independently everywhere. It is not a comparison to an optimal dense convolution or FFT interpolation circuit, nor a forecast of the actual needed signs. For a selected request set, charge its actual r values and its exact union of wrapped samples.

The kernel pool remains61880 exact rational weights at40 orders, with all seven arrays charged. It is59500 more weights than the fixed340 pool. The coefficient/FFT normalization, proof of the weights, their rounded forms, sample retention and raw integer widths remain priced. A cache may need the finest tolerance of every consumer. Matching order alone is insufficient to reuse an inadequately accurate rounded table.

There is no additional output-scaling deduction in this supplement. The omega and Y scale removals were already counted in the raw-interface note. They must not be subtracted again from either the coarse-prefix ledger or the adaptive stencil savings. Likewise, the three-bit raw time allocation replaces the four-bit scaled-T sufficient allocation; it is not another removed FFT or an unpriced transform.

The joint priced comparison is therefore the actual fixed340 raw query cost minus the actual adaptive raw query cost, minus incremental kernel/setup/storage/proof costs. Common raw scaling omissions cancel between those two options. The pending separately priced arithmetic schedules and any online sparse/dense switching policy require their own normalization and width binding before use.

## 5. Boundaries and exact evidence

Both positive channels, fixed canonical phases, central handling, rational bracket geometry and canonical Turing/count inputs remain unchanged. Actual Y-value output, amplitude interpolation or general complex contour consumers do not inherit this sign-only shortcut. Actual source-bound coefficient values, FFT arithmetic, successful signs and completeness are still absent.

The owned `audit/raw_adaptive_theta_composition_20261111.py`, SHA256 `92C4A1068691A920F0C3974D6CC45B3D33271C54250BA63238AB4EC0789BED4A`, and its JSON receipt, SHA256 `B6BC867C1F48648F9012271ACF9EC37F4E771DF9D4CA374016731069A1BA563D`, passed908 exact composition checks. They verify the frozen author inputs, all130 scalar remainder choices, the280 saved rational norm inequalities, and all query-histogram cost identities. This bounded script does not independently reconstruct the weights or every conductor row; those are the explicitly cited component-review inputs. It imports no author code and evaluates no analytic values.

The two component reviews above were read and hash-verified after the bounded receipt was made. Its wording that reviews are separate gates remains accurate; it is not itself a receipt for either independent source review. This supplement makes the mathematical composition explicit and awaits its own acceptance. No final target, original binary-input condition, source file or frozen ledger has changed.
