# Small EM batch producer: code preparation and schema v1

2026-11-11. Code preparation complete for independent static review. Numerical execution is not authorized by this packet. The implementation is `integration/small_em_batch_candidate_20261111.py`, SHA256 `23D358590279AA810EAE764D3FEEA0756C51DF8CF0EA6F05B457A192BB82822C`. It imports no old numerical producer and imports FLINT only inside the runtime engine. Syntax/AST checking and read-only hash checks of all ten pinned inputs passed. The producer was not imported or executed; no numerical model, elementary-function call, FFT or output image was evaluated.

## Stable consumed schema

Top-level object: `schema="small-em-batch-candidate-v1"`, `status="PASS"` only after all producer/cap guards, `producer_code_sha256`, `parameters`, `pins`, `analytical_budget`, `bins`, `moments`, `transforms`, `g_jets`, `panels`, `endpoints`, and top-level `telemetry`. The four diagnostic sections `elementary`, `twiddles`, `main_jets`, and `corrections` are also REQUIRED by the frozen receipt contract. The only other allowed top-level fields are `software` and `failure`. Diagnostics retain the finite-expression inputs and error derivation; independent final-g containment does not replace them.

Scalar encodings have disjoint key sets (no extra tag field):

```
Q = {"numerator": signed canonical decimal string,
     "denominator": positive canonical decimal string}   # reduced gcd=1
D = {"mantissa": signed canonical decimal string,
     "exponent": integer}                               # m*2^e; odd m or (0,0)
RBall = {"mid": D, "rad": D}                            # rad>=0, exact internal ball
CBall = {"re": RBall, "im": RBall}
CenterD = {"re": D, "im": D}
CenterQ = {"re": Q, "im": Q}
RectQ = {"re": {"lo": Q, "hi": Q}, "im": {"lo": Q, "hi": Q}}
```

Required exact `parameters` are N1024, B1025, M16, K16, p24, J8, L32, precision_bits192; sigma=629/1250, t0=31999/16, Delta=-1/8, outer_radius=1, panel_radius=1/16, all rational parameters in Q format. `analytical_budget.EM` is `4*2003*33/(63/2)*(2034/(6*1025))^32`; `.Taylor` is `1/(15*2^33)`, both Q.

* `bins`: 1024 records ordered by n=1..1024: `{n, x:{lo:Q,hi:Q}, mid:Q, q:int, k:int, residual:RBall}`. x is the actual bin-coordinate enclosure; mid its rational midpoint; q=floor(mid+1/2); k=q mod32. Residual is real, not a complex ball.
* `moments`: 12,288 records lexicographically by (h,m,k), h0..15,m0..23,k0..31: `{h,m,k,center:CenterD,radius:D}` plus optional `computed:CBall`. Fixed norm radius is exactly 2^-110, except certified zero may use zero. The claim is about the actual bucket coefficient.
* `transforms`: 3,072 records lexicographically by (h,m,j), j0..7: `{h,m,j,index:(-j)%32,center:CenterD,radius:D}` plus optional `computed:CBall`. Fixed norm radius is exactly 2^-110, except certified zero may use zero. The claim is about the normalized positive DFT of the **exact stored moment centers**.
* `g_jets`: eight rows `{j,center:CenterQ,coefficients:[16 CBall]}`. Each real/imaginary coefficient radius is exactly 2^-52, centered at the producer's exact dyadic midpoint. These are normalized s-derivatives of finite g.
* `panels`: eight records `{index,owner:index,top:Q,bottom:Q,image:RectQ}` with top=2000-index/8, bottom=2000-(index+1)/8.
* `endpoints`: nine records `{index,owner:min(index,7),height:Q,image:RectQ}` with height=2000-index/8.
* `telemetry`: numeric `elapsed_seconds`, integer `peak_working_set_bytes`, plus scope/guard metadata. It is sampled after complete receipt serialization, before publication; further limit guards follow publication. A failed observed cap cannot retain a published PASS.

## Required diagnostic sections

The following nested names are fixed in schema v1. Every real/complex ball uses lossless internal midpoint and radius, not rounded display endpoints. All error fields are nonnegative Q values bounding complex Euclidean norm; the code may use the larger sum of coordinate radii to establish them.

* `elementary = {pi:RBall, log_B:RBall, logs:[{n,value:RBall}], base_weights:[CBall], bin_counts:[int]}`. The 1,024 log records and 1,024 weights are ordered by n=1..1024. Weights enclose `exp(-s0*log(n))`; the n=1 log and weight are exact zero and one. The 32 bin counts sum to 1,024.
* `twiddles`: 31 records `{length,r,value:CBall}` in increasing length=2,4,8,16,32 and r=0..length/2-1. These enclose the positive twiddle `exp(2*pi*i*r/length)`. Every butterfly divides both outputs by two. The experiment computes 384 full length-32 transforms internally, but serializes only the 3,072 consumed outputs; it does not claim independent checking of all 12,288 internal outputs.
* `main_jets`: 16 rows `{h,values:[eight records]}`. Each record has `{j,center:CenterD,contraction:CBall,contraction_error:Q,source_input_error:Q,transform_error:Q,residual_taylor_error:Q,total_error:Q}`. The contraction is `32*sum_m (j/8)^m*transform_center[h,m,j]`. The separate error terms are respectively final contraction rounding, `sum_m (j/8)^m sum_k epsilon[h,m,k]`, `32*sum_m (j/8)^m alpha[h,m,j]`, and `64*7^h/(h!*24!)`. `total_error` is their sum. These are finite main-sum normalized-jet units, before multiplication by s-1.
* `corrections.bernoulli`: 16 records `{k,bernoulli:Q,factor:Q}`, with exact `B_(2k)` and `B_(2k)/(2k)! * 1025^(1-2k)`. `log_B_coefficients` holds 16 RBall values `(-log(1025))^h/h!`.
* `corrections` also contains `base:CBall`, `step:CBall`, `base_center:CenterD`, `step_center:CenterD`, `base_error:Q`, `step_error:Q`, `A_B_upper:Q=1`. The first two enclose `exp(-s0*log B)` and `exp(-i*Delta*log B)`. `phases` has eight `{j,center:CenterD,error:Q,point_product:CBall-or-null,rounding_error:Q}` records. At j=0, the product is null and the rounding term is zero. Later phases multiply exact stored centers and propagate `error_next=(1+step_error)*error_old+step_error+rounding_error`.
* `corrections.rows` has eight `{j,R:[16 CBall],Q:[16 CBall],C:[16 CBall],centers:[16 CenterD],errors:[16 Q],products:[16 records],assembly:[16 records],full_g_errors:[16 Q]}`. R is the truncated normalized jet of the Bernoulli correction polynomial; Q is `(s-1+z)R+B`; C is the normalized jet of `exp(-z log B)*Q`. `products[h]={h,C_center:CenterD,C_error:Q,point_product:CBall,rounding_error:Q}` records multiplication by the phase center. The corresponding `errors[h]` bounds the COMPLETE correction `B^(-s_j)*C_h`, including the already-present factor s-1. `assembly[h]={h,point_assembly:CBall,rounding_error:Q}` records `(s_j-1)*main_h+main_(h-1)+correction_h`; the missing main_-1 term is zero. `full_g_errors[h]` includes all main, correction and assembly terms. Each must be strictly below 2^-53 before exporting the coordinate square of halfwidth 2^-52.

Independent mandatory consumed checks remain all moment disks, the 3,072 selected exact-center DFT disks, all 128 direct-g coefficient squares, and all exact images. A reviewer may additionally audit the diagnostic recurrence; these records are not a complete standalone proof trace or proofs of the FLINT transcendental calls.

## Exact image operation order

Read the fixed coefficient squares as rational rectangles. Horner runs from degree15 to0. For a whole panel use z=(0,i[-1/16,1/16]); for endpoint index r use the exact singleton offset from owner min(r,7). Real multiplication takes all four endpoint products. Complex multiplication uses the Cartesian formula. Add `EM+Taylor` to both coordinate radii once. Do not re-add coefficient errors. Reciprocal uses the correct unary square interval for each real coordinate, adds the two squares, checks a strictly positive lower endpoint, then divides the conjugate coordinates by that positive interval. Multiply this reciprocal rectangle by the padded numerator. Final endpoints are exact reduced rationals. The independent image reconstruction must match them exactly.

## Intended runtime and independent boundary

The accepted main/scalar/receipt/preflight pins will be embedded in `pins`. A separate future coordinator manifest binds this code hash, a new output name and runtime authorization; this preparation is not such a manifest. One attempt at192bits,180seconds,512MiB evaluator-process peak working set,64MiB receipt, no child/delegated evaluation, no overwrite or retuning. Exact lossless mid/rad exports avoid the old rounded-endpoint defect. FLINT exp/log/complex-exp remain externally trusted interval primitives, not rational analytic proofs or Lean operations.

Independent code must rebuild all moments at224bits using frozen bin labels, directly compute every consumed32-term DFT, directly compute all128 finite-g jets without bins/FFT, and reconstruct all8+9 images. Require full containment in fixed claimed disks/squares, not overlap. No nonvanishing, half-plane or winding success is required. The final source/telemetry/error-guard static review and separate runtime authorization remain necessary.

## Executable schedule and publication

The only numerical entry point is `main`, requiring `--manifest`. The future coordinator manifest must contain exactly `runtime_authorized:true`, `producer_code_sha256`, `parameters`, `pins`, `static_review:{path,sha256}`, `output`, and `caps:{seconds:180,peak_working_set_bytes:536870912,receipt_bytes:67108864}`. Its parameter object and pins must match the embedded values with exact types. The source and static-review hashes are checked before any FLINT import. The manifest is bounded to 1 MiB, read at most cap+1 bytes, and parsed with duplicate-key rejection. No enabled manifest is created here. This is a coordinator execution record under existing user authorization, not another user permission request.

The schedule is fixed: exact Bernoulli/scalar guards; elementary inputs and all bins; h-major moment accumulation and 384 normalized FFTs; eight phase/correction rows and all 128 g coefficients; exact rational whole-panel and endpoint images; structural/encoding validation; streaming receipt publication. No work is delegated to another process. Explicit guards run during input accumulation, each moment row and transform, contractions, corrections, image construction, payload validation and each serialization chunk of about 64 KiB. A long library call can overrun before the next guard, so there is no hard real-time promise. Any observed overshoot or unavailable required telemetry rejects complete PASS. An external coordinator watchdog may terminate the process.

The launcher reserves a new `.attempt.json` with exclusive creation. This marker is retained even after failure, forbidding restart under the same output name. It writes the result into a newly created `.pending` file, checks the 64 MiB bound while streaming, flushes and fsyncs the complete file, and checks elapsed time and Windows process peak working set. Fixed-width telemetry fields are then filled without reserializing the payload. Further guards follow that write and the no-overwrite Windows rename to the final output. Only the final output is a candidate; a `.pending` file, even if it contains a PASS token, is never accepted. An observed post-publication failure removes only a final file known to have been created by this attempt and writes a bounded `.failure.json`. Unrelated files are not deleted. An abrupt external termination can leave a pending file or attempt marker, which is an incomplete run.

Telemetry in the receipt describes the post-serialization, pre-publication snapshot. The final console record includes the post-publication sample. Both use `GetProcessMemoryInfo.PeakWorkingSetSize` for this single evaluator process. The elapsed clock starts at entry to `main`; a coordinator may separately record process startup/shutdown. Failure records preserve the current stage, indices, completed-array counts and available resource sample. They do not claim complete partial analytical outputs.

After static review and the separate coordinator run decision, the proposed command is:

```powershell
& work/qrh-campaign/interval-env/Scripts/python.exe -X utf8 work/qrh-campaign/agents/integration/small_em_batch_candidate_20261111.py --manifest work/qrh-campaign/agents/integration/coordinator_small_em_batch_run_20261111_01.json
```

That manifest does not yet exist. No retry, changed precision, changed geometry, relaxed radius, or larger cap is authorized by this prepared code. A failed fixed attempt is a failure report, not a reason to tune parameters silently.

## Static review and later acceptance

The preparation check is `small_em_batch_preparation_check_20261111.json`; it records source syntax, lazy-import location and source-pin equality without running the producer. Static review must inspect the actual code hash above, not just this description. Later producer PASS will mean that its numerical and resource guards succeeded. Independent verification must still certify all 12,288 actual-moment disks, all 3,072 consumed exact-center DFT disks, all 128 full-g squares and all eight plus nine image reconstructions. The phase and correction diagnostics have narrower verification scope unless explicitly recomputed. None of these external checks proves a standard-axioms Lean theorem or certifies new spectral coverage.
