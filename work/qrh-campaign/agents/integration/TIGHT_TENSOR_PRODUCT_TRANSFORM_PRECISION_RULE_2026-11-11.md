# Tighter tensor-product factor for the existing transform

2026-11-11. Paper theorem and fixed rational checks. The factor 2 in the intrinsic tensor-error bound can be replaced by

    Q = 2^72,   B = Q/(Q-1).

This holds for the admitted family, the existing full ordered circuit and p>=100. It preserves the exact complete global-p108 radius when the integer selector below passes. It does not change a leaf theorem, a peak bound or a numerical producer. No inventory was read or folded, no new precision assignment or count was computed, and no values, declarations, proofs or builds were produced. Independent review is requested before adoption.

Paths in the source table are relative to `work/qrh-campaign/agents`, except the explicit blueprint path. All predecessors remain unchanged.

## 1. Actual circuit and local hypotheses

The mixed-radix precision supplement, sections 1–5, proves the local theorem for the positive unnormalized DFT D_n and exact normalized operator T_n=D_n/n:

    ||computed_D_n(x)/n - T_n(x)||_infinity <= C_n*u*(M+1),
    ||x||_infinity <= M,  u=2^-p,  0<u<=1/D_n_safe.

The exact operator T_n has sup norm at most one. Normalization in this statement is mathematical bookkeeping. The computed character transform remains unnormalized.

The local theorem includes root/chirp uncertainty, arithmetic error on stored operands, cached-kernel error and cross terms. Each complex gate and required root enclosure must meet its u contract. A coordinate rounding bound is not automatically the complex norm bound. The accepted rounded normalized Bluestein cache has its own producer and scaling round; an exact cache on grid p+k is a different representation.

Let n_i be the saved ordered outer cyclic axis lengths, repeated when the source has repeated axes. Their product is phi(c). Let C_i be either the reviewed mixed coefficient or the reviewed sharper coefficient for the actual corresponding circuit, and let S=sum_i C_i. The sharper coefficient can be used only with its accepted rounded normalized-cache implementation. In either case require

    0 <= S <= S_mix(c) <= S_g = 202305920 < 2^28.

The global cap is inherited from the reviewed mixed schedule and its admitted subfamily, not established for an arbitrary new circuit or family. The sharper source proves C_sharp<=C_mix on the same full ordered plan. An eventual tighter coefficient would need its own local error theorem and safety compatibility; this paper accepts no additional leaf improvement. Runtime occurrence counts and primitive-output counts do not enter S. Repeated outer axes do.

Retain the existing input and safety conditions:

    V=M+1 <= 2^14,
    p>=100,
    2^p>=D_local_old(c),
    2^p>=2*S_base(c).

Here D_local_old includes both saved mixed and whole-axis baseline safety denominators. S_base is the old whole-axis baseline sum. The alternative old global guards are 29961461170177 and 2*424706204. Both fit below 2^100. This retains the old semantic-output, internal-peak, normalized inverse and postchirp arguments. In particular it does not replace S_base by S or infer smaller internal capacities from the tighter tensor factor.

## 2. Reconstruct the full tensor recurrence

Start with the exact stored input centers x, bounded by M. Source uncertainty is set aside until the exact operator comparison at the end. Put N_0=1 and N_i=product of the first i axis lengths. Let zhat_i be the actual unnormalized stored intermediate after those axes and y_i the exact normalized partial transform of x. Define

    e_i = ||zhat_i/N_i-y_i||_infinity,  e_0=0.

Every exact partial normalized transform is a contraction, so ||y_i||<=M and

    ||zhat_i|| <= N_i*(M+e_i).

Apply the local theorem to every next-axis line of these actual stored inputs. The theorem is uniform in the line input, so the same bound controls their maximum. Dividing its absolute error by N_i*n_(i+1) gives at most

    C_(i+1)*u*(M+e_i+1/N_i).

The exact next normalized axis transports e_i without enlargement. Since N_i>=1,

    e_(i+1) <= e_i+C_(i+1)*u*(V+e_i).

Thus V+e_(i+1)<=(1+C_(i+1)u)(V+e_i), and induction yields

    e_final <= V*(product_i(1+C_i*u)-1).                 (1)

This proves the source product formula for the actual unnormalized computation. It does not insert runtime divisions or assume rounded normalized intermediate arrays. The same argument covers the dependency-closed primitive-output subset because each retained output has the same computation and error bound as the full circuit. Pruning does not change phi(c) into the number of primitive outputs. Identity axes with C_i=0 and the empty product cause no exception.

## 3. Finite-product inequality and fixed factor

For a finite list x_i>=0 with s=sum_i x_i<1,

    product_i(1+x_i) <= 1/(1-s).

Here is a finite induction, without an infinite series. Suppose the old sum is t and the next term is a>=0 with t+a<1. Positive denominators permit

    (1+a)/(1-t) <= 1/(1-t-a),

because

    (1-t)-(1+a)(1-t-a)=a*t+a^2>=0.

The empty list gives equality. Consequently

    product_i(1+x_i)-1 <= s/(1-s).                       (2)

Set x_i=C_i*u. The admitted global bound and p>=100 imply

    0<=s=S*2^-p <= S_g*2^-100 < 2^-72=1/Q.

Therefore 1/(1-s)<=Q/(Q-1)=B and (1)–(2) give

    e_final <= B*S*V*2^-p.                              (3)

No division by S appears. If S=0, every nonnegative C_i is zero and (1) gives exact intrinsic output. B lies strictly between 1 and 2. The replacement is uniform across all admitted heights, characters and axis lists once their source bounds and local contracts hold.

The same algebra has a general form. For any integer lower precision bound q>28, if p>=q and 0<=S<2^28, set Q_q=2^(q-28) and B_q=Q_q/(Q_q-1). Then s<1/Q_q and (3) holds with B_q. The selected q100 case is B_100=2^72/(2^72-1). The purely algebraic q80 case would use B_80=2^52/(2^52-1), which is larger than B_100. It cannot use B_100 merely because the latter is close to one. This general statement proves no sub-grid100 input representation, regridding error, stored-input bound, peak interface, cache production or downstream budget. Those would need separate accepted premises. The actual selector and source interface in this note remain p>=100; no sub-grid successor is adopted.

## 4. Conductor normalization and exact selector

Restore the full group size phi(c), then apply the exact conductor factor c^-s whose magnitude on Re(s)=1/2 is 1/sqrt(c). For c>0, a sufficient intrinsic L-error is

    epsilon_B(c,p) = B*phi(c)*S*2^14*2^-p/sqrt(c).       (4)

Approximation of c^-s remains a separately charged producer. The input/source uncertainty passes through the exact transform once. In particular the already conductor-scaled alpha radius is not multiplied by B or by phi(c) again.

Keep the old global intrinsic ceiling with

    C_g=1266*S_g*2^14=4196258524692480,
    epsilon_B(c,p)<=C_g*2^-108.                         (5)

For integer p in {100,...,108}, (5) is equivalent to the integer test

    (Q*phi(c)*S)^2 * 2^(2*(108-p))
        <= c*((Q-1)*1266*S_g)^2.                       (6)

Indeed cancellation of the positive 2^14 and multiplication by the positive Q-1 and sqrt(c) gives

    Q*phi(c)*S*2^(108-p) <= (Q-1)*1266*S_g*sqrt(c).

Both sides are nonnegative, so squaring is reversible. This includes S=0 and requires no square-root evaluation. Combine (6) with all old guards in section 1; select the least passing p only in a separately authorized metadata task. No such selection was run here.

The old factor-2 selector implies (6), since Q<2(Q-1). The same statement holds when replacing S_mix by a proved smaller S_sharp. Thus a previously passing p remains passing and p108 remains an available fallback for the admitted family. This alone does not guarantee a full bit reduction: at p_old-1, the new intrinsic allowance relative to the old factor-2 allowance at p_old is B>1. The p100 floor, actual slack and all guards still matter. No precision distribution or operation saving follows from this theorem alone.

## 5. Complete interpolation radius is unchanged

Use the actual endpoint-normalized Y and the reviewed window h=159/500, m=41, Delta=5/64, with all required samples in [-7000,7000]. The +41 guard maximum 26525/4 is in that domain. This theorem supplies no samples or guards. One p(c) still covers the conductor's whole transform and all its sample heights, including inverse-character samples used by the negative adapter.

Retain every nontransform tolerance from the lower-transform allocation. With

    T=(927193523/10^9)*2^-46,
    R_fixed=T+135*(2^-82+4*2^-63)
               +10*2^-54+93*2^-55+2^-51,

the complete sufficient radius is

    R_fixed+135*epsilon_B(c,p)
        <= R_fixed+135*C_g*2^-108.                     (7)

The right side divided by 2^-45 is exactly

    2804840254168152529/4294967296000000000
        <653052762/10^9<691/1024.

The factor 135 is the retained completion bound 27 times the exact interpolation-kernel absolute-sum bound 5. The nontransform terms keep full alpha 2^-82 once, finite head and assembly, approximate conductor factor, sample completion and formation, negative inverse-character damping and rounding, all 83 kernel errors, and finite accumulation. The exact kernel split is unchanged. The old intermediate sample radius is not silently reused; the source's rL, rDirect and rY expressions use epsilon_B in place of the old intrinsic allowance. Their magnitude prerequisites remain valid because (5) bounds it by the same global-p108 quantity.

The exact grid100 export still embeds at p>=100. Changing p changes numerical centers and may require different certified root/cache objects. Equal error ceilings do not transfer signs. Strict center tests, unresolved repairs and Turing success remain separate requirements.

## 6. Producer, representation and cost boundary

The local theorem's cache identity includes the full ordered plan, n, padded P, chirp/direction, normalized rounded-cache variant, p, rounding policy, enclosure contract and lifetime. A lower-precision cache cannot be relabeled from an old one. The proof of (3) changes only tensor error composition; it does not construct a new cache, reduce setup work, relax its enclosure, change cached sums or authorize a shared higher-precision producer.

Existing internal norm factors and their precision-dependent capacities remain in force. Any later assignment must retain the same old peak/safety fields and validate p-specific full-cache closure. Any later pricing must use the actual new assignments and cache lifetimes, with source, head, completion, negative adapters, interpolation queries, proof bindings and setup still charged. No inventory or price pass is authorized or performed by this note.

The conclusion is the conditional theorem (3)–(7). It is available for the accepted mixed or sharp coefficients under their respective local implementations. It does not certify actual transform values, kernel enclosures, sign/count closure or an end-to-end runtime improvement.

## 7. Evidence and pins

The exclusive companion `tight_tensor_product_precision_20261111.py`, SHA256 `61C0E6CA85D0A2B4902D5DE4634DFA8B53912FE7B71297C2E1A62A150D609BA9`, passed 28 fixed checks on its first execution. It checks the formal polynomial induction gap and recurrence identity, eight source hashes, fixed rational constants, safety caps and exact complete radius. It reads only the named Markdown sources and no inventory. The exclusive 3109-byte receipt `tight_tensor_product_precision_20261111.json` has SHA256 `40D68D74CBC17CF42DB189B4D9B1D8BD49669724CD0D0771F442AF47DDC9F50A`. The general tensor and product inductions are proved above, not inferred from sampled data.

|Source and consumed section|SHA256|
|---|---|
|zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md, sections 1–7|4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4|
|audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md|1268986720865E47569FC5E568546194C0A61EDC9AE80CDD78502CDC77385537|
|audit/SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md, sections 1–5|08A06A83C73DBE295DD389F96D316F52C4DEFE7EE1B2243D2B04635B38AC786F|
|prime-estimates/REVIEW_SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md|3ADEA1B5860DA35E5BBF6DF26CEC3A005300096E60CA23BFE52EA3C084C9E9A3|
|major-constants/CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md, sections 1–4|1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A|
|independent-feasibility/REVIEW_CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md|15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2|
|integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md|09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA|
|work/qrh-blueprint/LOWER_TRANSFORM_PRECISION_ALLOCATION_2026-11-11.md, intrinsic theorem and complete output sections|EEBC987DD386E2ED50CC7F56C82714FC1EF51C8A3DF22C2579FFC108C0C1BD39|
