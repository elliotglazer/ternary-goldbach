# Complete error contract after the large character transform

2026-11-11. Bounded source and paper audit, with exact selector arithmetic only. No function, root, transform, L-value, zero or prime values, new inventories, source edits or builds. This note supplies a conditional composition rule. It selects no production precision or sign tolerance.

The current joint K/grid contract bounds the WHOLE polynomial contribution after character scaling by `A_alpha<2^-82`. It already contains the target Taylor remainder, analytic finite-shift bias, numerical source error and polynomial conversion/evaluation error. Intrinsic transform error is additional. No pinned consumer provides a complete numerical sign margin from which to choose among p112, p134 and p152.

## 1. Source chain and current scope

Paths below are relative to `work/qrh-campaign/agents`; the companion receipt records full absolute paths and hashes for all 21 inspected inputs.

| Input | Relevant source contract |
|---|---|
| `major-constants/VARIABLE_DEGREE_GRID_ROUNDED_DIFFERENCES_2026-11-11.md`, SHA `79F8EA3F6F8BE2AA0EC61E335BB068EA2690A3AA84CBB4BBF39D6878FC4F1B55`, sections4–5 | `T_K+S_shift+N_source+633 E_eval<2^-82`; exact grid100 export |
| `moebius/JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md`, SHA `AEAB2BDCF2D767546A7F410CC463D17DFB6C4639BFFC94D771574C134DA36E63`, sections2,5 | Same full alpha allocation for the matched Horner alternatives |
| `integration/REVIEW_SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md`, SHA `B15D0C3B15B8005A6B3DC3CFE1A1CDE157448B83904950487CD124F87647536E`, sections1–4 | Genuine shorter Taylor theorem, finite-vector comparison and downstream radius limits |
| `zero-sum/REDUCED_NONPRINCIPAL_PLATT_COST_MODEL_2026-11-11.md`, SHA `B3718D22BE11EBE5503EB2124E0B690D49B428E0000D5CD763317367ADB60AFC`, lines19–61 and section6 | Actual Hurwitz/head/L identity, transform scaling and interpolation input errors |
| `integration/LARGE_CHARACTER_TRANSFORM_PA_COST_MODEL_2026-11-11.md`, SHA `DAEA81308B256EEDC68CDC86B20730613FD8F5EE0ECF485A9BCD772C4557F52C`, sections1–2 | Transform of stored centers, separate input uncertainty, intrinsic precision selector |
| `integration/R132900_POST_TRANSFORM_CERTIFICATE_COST_2026-11-11.md`, SHA `F718551E44C343FB874AAD919290D002F402760B5B6B44772B534C087AF2D054`, sections2–4 | Actual-L binding, strict real signs, phase radius, canonical interpolation source and count closure |
| `prime-estimates/FINITE_U_HARDY_NORMALIZATION_2026-11-11.md`, SHA `06C9D3BF785BB183339D8EC64BE0B5AAD05331184C35356F575A8C126ADB724E`, sections1–3,5 | Exact positive-cosine sign proxy; actual completion and canonical count phase |
| `zero-sum/SELECTED_SIGN_CHECKER_COST_SUPPLEMENT_2026-11-11.md`, SHA `D4507C3C7F7B513621240AC2BB4B0142B371465FC7AFD5892C2993F0404F4C41`, sections3,6 | Actual completed Y samples, dependency union and unresolved margins |

The companion also pins their relevant reviews, the current reconciled domain, the endpoint/count adapters and the actual `MajorArcs/GRH.lean:32–37` definition. Historical counts and domains in the older point/post-transform reports are not re-adopted. The current large branch has c>10000 with odd c<=132900 or 4 dividing c<=265800, its reviewed combined heights, and the four separately conditional extra-node scenarios. Principal and small-conductor computations remain separate.

The original reduced-Platt equation called `E_alpha` only the Taylor truncation allocation and then listed seed errors separately. The NEW joint inequality includes those polynomial seed and shift errors inside A_alpha. Reusing the old prose as an additional charge would double-count them. It would also be wrong to omit them from a new producer merely because an old output polynomial had a tighter radius.

## 2. From stored residue inputs to actual L

Fix an actual character label chi, conductor c, exact height t and `s=1/2+it`. Let v=phi(c), `q=c^-s`, and nu=`|q|=c^-1/2`. The exact positive, unnormalized character transform is

    T_chi(z)=sum_(a unit modulo c) chi(a) z_a,
    L(s,chi)=q T_chi(zeta(s,a/c)).

The ordering/character map and inverse conventions must be proved for that exact label. Since a is a unit, `|chi(a)|=1`. A normalized DFT would need its explicit v restoration; the current unnormalized circuit has no such extra output v factor.

Use raw centers zhat_a comprising the stored polynomial plus the finite head `(a/c)^-s`, with any NEW assembly/alignment error included. Let their error radii split into polynomial, head and new representation parts. Define their already conductor-scaled bounds

    A = nu sum_a e_poly,a,
    H = nu sum_a e_head,a,
    J = nu sum_a e_new_rep,a.

The accepted joint alpha contract supplies `A<=A_alpha<2^-82` for its bound circuit. A mixed evaluator needs its actual weighted bound or a valid common upper bound. It cannot choose error and cost independently from different circuits. J excludes errors already charged in polynomial evaluation or head production. Exact grid100 embedding into p_T>=100 and exact common-grid addition make that part of J zero.

Let Shat approximate the exact transform OF THESE STORED CENTERS with error e_T. The intrinsic transform theorem supplies `nu e_T<=epsilon_T`. Let qhat have error e_q, and let final multiplication/serialization have error e_sc. Then

    r_L = A_alpha + H + J + epsilon_T + M_S e_q + e_sc,       (L)

is sufficient when `M_S>=|Shat|` is a certified bound. The proof splits at `q Shat`:

    q(T(true)-T(zhat)) + q(T(zhat)-Shat)
      +(q-qhat)Shat + final arithmetic error.

This avoids an unnecessary e_q times input-error cross term. It does not assume qhat is exactly unit-scaled. Its amplitude and conductor-phase errors must both be included in e_q. A rational implementation uses proved upper bounds for nu and every displayed magnitude.

Do not add another seed/S/N term to (L), multiply A_alpha by633 again, or propagate the same input radius through each transform gate. If a chosen producer instead supplies one complete transformed input radius, use it in place of A+H+J. Do not add both forms.

The head may alternatively be attached after scaling through the exact identity `c^-s*(a/c)^-s=a^-s`. That circuit needs its own transformed-head radius and arithmetic accounting in place of H and the corresponding raw assembly. It cannot be charged as both a raw input and an extra final term. Likewise a fused completion/scaling circuit may prove a direct bound without materializing Lhat, but it must account for every error in its actual factorization.

The historical implementation confirms these distinct operations: pinned `int-l-func5.11.cpp:697–740` constructs the finite head plus shifted Hurwitz value; lines575–616 perform the product-group transform and subsequent conductor/root/Gamma factors. It is schedule evidence, not an arithmetic proof backend.

## 3. What the transform precision cases establish

Use p_T for transform fractional bits, distinct from the FD state grid. With the actual stored-input norm bounded by M, set V0=M+1. The accepted intrinsic bound is

    epsilon_T >= 2*(phi(c)/sqrt(c))*S(c)*V0*2^-p_T.

The current conservative envelope uses V0<=2^14 and S(c)<=202305920, yielding

    C_T = 1266*202305920*2^14 = 4196258524692480.

The preserved safety conditions are `2^p_T>=29961461170177` and `2^p_T>=2*424706204`. The exact minima of these conditions together with `C_T*2^-p_T<=2^-s` are:

| Intrinsic allowance | p_T |
|---|---:|
|2^-60|112|
|2^-82|134|
|2^-100|152|

These minima refer only to these sufficient inequalities. V0 is a magnitude bound on actual stored inputs, not their accuracy. The finite-head radius-at-most-one assumption in the magnitude bridge is not a useful sign-error budget. It must not replace H in (L).

Root/chirp enclosure errors, cached-kernel uncertainty and gate errors are already inside epsilon_T when the hypotheses of the intrinsic theorem are met. The Gauss/root-number phase epsilon_chi used after the transform is a different object and needs its own enclosure. A cache's construction cost is paid separately, but its same proved numerical uncertainty is not added again outside the transform theorem.

The proposed cached Bluestein normalization may use (L) only after proving the SAME exact unnormalized transform of the SAME stored input centers and a sufficient intrinsic bound, including cache normalization/rounding. Moving /P into a cache is not a new permission to change overall character normalization. Its new centers require new downstream checks. No pending normalized-cache result is accepted by this note.

## 4. Two distinct downstream consumers

For a direct sign, use the reviewed exact elementary proxy

    P(t)=Re(epsilon_chi cis(phi0(t)) L(s,chi)).

The root phase is fixed for the whole character. Let its center error be e_eps, let the cis center error be f, let `M_L>=|Lhat|`, and let final proxy arithmetic error be e_P. Then

    r_P = r_L + M_L*(e_eps*(1+f)+f) + e_P.                  (P)

If the real phase is first approximated, f includes its absolute error plus the numerical cis error by the real-angle Lipschitz bound. The analytic Binet discrepancy between phi0 and canonical theta is NOT an additive error in (P): the exact proxy equals unit Hardy H times a strictly positive cosine. The same proxy, exact character and fixed phase must be used at all bracket endpoints. A sign requires `abs(Phat)>r_P`.

Interpolation needs actual samples of the function Y appearing in its theorem. Write `Y_i=A_i*U_i*L_i`, with A_i positive and U_i the exact unit root/canonical-phase factor. Let an enclosed multiplier center have error e_m,i, `Abar_i>=A_i`, and let sample formation error be e_Y,i. Then

    r_Y,i = Abar_i*r_L,i + M_L,i*e_m,i + e_Y,i.             (Y)

For separately enclosed A and U, one possible bound is `e_m<=e_A+|Ahat| e_U`, plus any multiplier-formation rounding. A canonical phase approximation must include its analytic remainder. The sign-equivalent proxy P cannot be substituted for Y.

This normalization must be tagged explicitly. The reviewed tilted function is

    F_eta = pi^-alpha exp(pi*eta*t/4)|Gamma(alpha+it/2)| H,
    alpha=(2a+1)/4.

The historical large-character code's Gamma inputs at lines889–890 instead give the real sample `Y_src=exp(pi*t/4)|Gamma| H`, using its pinned root/character convention. Thus at eta=1, `Y_src=pi^alpha F_1`; a different eta changes a time-dependent positive factor. These identities preserve signs, not numerical sample values, absolute radii or Fourier-tail constants. A theorem requiring strict tilt cannot be extended to eta=1 merely from this identity. The current large-branch plan still requires a specific valid interpolation theorem and parameters for its chosen Y; no uniform numerical instantiation is supplied by the transform inventory.

For a finite interpolation candidate `Ihat=round(sum_i Khat_i Yhat_i)`, let r_K,i be kernel radii, e_I its finite arithmetic radius, and T_F,T_S the proved Fourier and omitted-sample tails for this exact Y and domain. Then

    r_I = T_F+T_S+e_I
          +sum_i[(|Khat_i|+r_K,i)*r_Y,i+|Yhat_i|*r_K,i].    (I)

This includes the input/kernel cross term once. Direct sums and a proved convolution computing the same finite sum use the same source/tail contract but their own e_I. All guard samples, low-height hypotheses, negative inverse-character adapters, endpoints and padding conditions remain. A sign of Y requires `abs(Ihat)>r_I`; no extra proxy phase overlay is needed on an already valid real Y enclosure.

Substituting (L) into (Y) and then (I) gives a complete symbolic chain. The transform portion is precisely

    sum_i (|Khat_i|+r_K,i)*Abar_i*epsilon_T,i.

Everything else forms the remaining radius. This is the allocation a normalized-kernel or local-precision proposal must consume, rather than an isolated output epsilon guessed from the alpha budget.

## 5. Fixed contracts, selectable tolerances and missing evidence

| Item | Current status |
|---|---|
|Whole polynomial A_alpha|Chosen admitted K/grid contract, strictly below2^-82; its actual rational bound is available, with source S/N already included|
|Grid100 export/alignment|Exact identities when performed as specified; new inexact conversions need a new J charge|
|Transform safety and intrinsic formula|Fixed sufficient theorem; epsilon_T and p_T are design parameters, not full-output acceptance|
|Head and conductor scaling|Actual producer radii and arithmetic must be supplied; no selected complete tiny allowance was found|
|Root phase, cis and canonical completion|Refinable enclosures with exact labels/branches; magnitude-weighted tolerances remain to be chosen and checked|
|Interpolation|Exact Y, windows, kernels, both tails, guards, arithmetic and dependency union must be instantiated|
|Signs and count closure|Actual strict real margins, disjoint evidence and orbit surplus are absent from operation metadata|

For a direct point, put all terms of (P) except epsilon_T into R_rest. A sufficient conditional choice is `C_T*2^-p_T < abs(Phat)-R_rest`, with a strictly positive right side and the safety conditions. For interpolation replace C_T by the indicated weighted sum of local coefficients and include all non-transform terms in R_rest. The centers and their magnitudes can change with precision or circuit, so an observed margin from a different circuit is not automatically reusable.

A desired total tolerance tau can similarly be budgeted only after proving `R_rest<tau`. Nothing in the current source says tau is2^-82 for a sign. In particular setting both A_alpha and epsilon_T allowances to2^-82 does not bound their sum by2^-82. If the certified non-transform radius already exhausts the available margin, improving transform arithmetic alone cannot certify that output under these bounds. This is a limitation of the sufficient enclosure, not proof that the actual error is that large or the true value is zero.

The missing evidence is therefore concrete: actual stored input/head/scaling enclosures; magnitude and phase objects; chosen interpolation parameters and tails where used; actual real centers with strict margins; and the retained bracket/auxiliary/count certificate. Without these, p112/134/152 remain valid intrinsic cost scenarios and no one of them is a justified complete-sign choice. A fixed location at a zero need never give a strict sign, and ordinary brackets need not account for arbitrary critical multiplicity.

## 6. Completeness is a separate final inequality

The endpoint adapter counts all nontrivial zeros with closed |Im rho|<=T, including real zeros and multiplicities. Nonreal inverse pairs require both positive channels; real characters double the positive contribution, not the central contribution. Principal counts are separate.

After certified main critical evidence K, auxiliary lower weight W and canonical Gamma-phase integral upper bound Abar, the elementary theorem gives

    C_chi(T) <= (Abar-W+2 Bbar)/h.

The reviewed same-character reflection adapter permits finite RH from the strict test

    h*(K+2)-Abar+W-2 Bbar > 0.

Exact-count/list consumers instead need their stronger saturation rule or separately controlled residual mass. Abar must include its canonical integral error; the elementary proxy phase cannot replace it without an integral bound. W comes from proved intervals/count objects, not approximate ordinates. These are not additive L-value tolerances. Smaller transform error proves neither enough signs nor the required surplus. The original closed `GRHUpTo` consumer is unchanged.

## Evidence and handoff

Companion `audit/large_character_complete_error_contract_20261111.py` has SHA256 `42C666E3C0F419FCE4795A21D54A22727FEBBF8D49B8EB7F8324ED550FBDE650`. Its exclusive receipt has SHA256 `86C2F5441C5E706DEEA1976AC00026E0F3E39FBB492CC31E524C4BC1636091C6`. It pins21 source artifacts and passes28 expected-hash/selector assertions. The selector checks use only integers and rational powers of two. No evaluator was imported.

Integration and independent-feasibility received equations (L), (P) and (I) for the normalized-cache proposal. This paper audit supplies their common downstream contract and identifies the missing evidence. It does not validate the pending kernel variant, choose precision, add a final mathematical premise or claim Lean/MM0 closure.
