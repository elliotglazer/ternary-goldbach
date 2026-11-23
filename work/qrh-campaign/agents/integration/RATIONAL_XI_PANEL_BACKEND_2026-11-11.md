# Exact rational backend for the fixed xi panel

2026-11-11. Implementation prepared for independent inspection. **No numerical node, weight, or panel run has been performed with this backend.** Python syntax validation and a read-only replay of the already accepted scalar planning receipt passed. This is an external rational producer/replayer, not a Lean checker, proof, or accepted panel certificate.

## Fixed target and accepted ingredients

The new file is `rational_xi_panel_backend_20261111.py`. It imports definitions from the immutable, hash-checked rational helpers `r1over8_p_node_exact_20261111.py` and `lossless_modular_two_step_20261111.py`. It never calls their old fixed-node producers. Neither helper introduces a numerical oracle on import; all evaluation here uses integers and `Fraction`.

The target is the exact specification `prime-estimates/NEXT_RATIONAL_XI_PANEL_SPEC_2026-11-11.md`, SHA256 `92E778B5D9C767D18461CD0B239F94FD38B15023B13576FFBBC2EFFE8D00E957`. Its review is `zero-sum/REVIEW_NEXT_RATIONAL_XI_PANEL_SPEC_2026-11-11.md`, SHA256 `2F05928D57B1E76F513095FE5CCA4D5930EF314EB658EE748016E52FBE84CC97`.

The general closed-domain theta tail is separately reviewed in `mellin/REVIEW_THETA_JET_TAIL_TWO_FIFTHS_2026-11-11.md`, SHA256 `8C81655B87AA6855AEE4A28D34A8713FFEC95CABEEE8F538E82888A0409304CD`. The backend uses the specification's **separately accepted sharper sixteen-mode bound**, not an incorrect application of the general bound with sixteen modes. Each terminal ordinary derivative of order zero, one or two receives coordinate padding `2^-277`. This is conservative rectangular padding of an analytic norm error, subsequently propagated by interval arithmetic. No analytic tail is omitted merely because its finite terms are tiny.

`T_input=32` fixes `b=pi/4-1/33`. Independently, `T_work=14` is the coefficient-center imaginary part. The function is `F_b(s)=exp(-i*b*(s-1/2))*xiF(s)`, centered at `3/5+14i`, radius `1/64`. The grid is `h=1/256`, `K=928`, and the polynomial degree is six. None is a command-line variable.

## Arithmetic and modular semantics

Working precision is 320 bits, with one permitted retry at 512 bits. Every arithmetic operation inherited from the rational helper rounds outward. Square-root endpoints use integer `isqrt` and exact squared comparisons. Complex reciprocal bounds use the exact rectangle coordinate extrema, including the appropriate edge stationary points; they do not rely on overlap with another box. Root reconstruction uses the full input rectangle and the positive-real-part principal square root of `-i*t`.

For node `r=k/256`, the seed is newly evaluated as `exp(2*r)*(-cos(2/33)+i*sin(2/33))`. The only analytic elementary inputs are the reviewed Machin, exponential-series, and complex-exponential Taylor bounds used by the pinned helper. No old T=10^6 box or Arb value is accepted.

Each T stage records integer `n` and **subtracts it**: `t=current-n`. For classical theta2, reconstruction multiplies the translated jet by `exp(+pi*i*n/4)`. Theta3 and theta4 swap for odd n and have no scalar phase. The eight possible theta2 phases are formed from exact axes and a certified `sqrt(1/2)` interval. The initial type is theta3, unconditionally.

Stopping has priority whenever the translated box satisfies `lower(Im)>=2/5`. Otherwise S requires `upper(Im)<1/2`, a positive lower imaginary part, and fewer than four earlier S steps. A failure to certify stopping after the fourth S rejects the attempt and permits only the higher-precision retry; it never takes a fifth S. The T nearest-integer proposal comes from the rational midpoint, but its whole-box translation guard is checked.

S maps to `v=-1/t`, records `A=1/sqrt(-i*t)`, and maps types `2<->4`, `3->3`. Reverse transport uses all three ordinary derivative formulas:

```
f0 = A*g0
f1 = A*(-g0/(2t) + g1/t^2)
f2 = A*(3g0/(4t^2) - 3g1/t^3 + g2/t^4).
```

The preceding T phase multiplies all three components after each reverse S transport. Terminal theta3/4 retain their exact constant term only at derivative order zero; theta2 has no constant term. Integer theta4 modes have their alternating signs. Sixteen paired modes and the full common tail are used for all three types.

The final expression is the source-normalized unhalved kernel

`P(r+ib)=exp((r+ib)/2)*(6*tau*theta3'(tau)+4*tau^2*theta3''(tau))`.

In particular the final complex phase is `cis(pi/8-1/66)` and the real factor is `exp(r/2)`; neither is dropped. The returned center lies on `2^-32 Z[i]`. Its L1 distance to the entire computed rectangle must be at most `2^-24`, which implies the required Euclidean bound. The center norm is also checked against `2^27` by an integer squared-norm comparison.

## Small exponentials and domain boundaries

For each real exponential **endpoint separately**, if its argument is at most `-384`, the backend returns an outward-rounded `[0,2^-384]` using `exp(1)>2`. Other endpoints use the reviewed Taylor method. Consequently an interval straddling `-384` retains the correctly computed upper value from its larger endpoint. The small-term bound is propagated through every subsequent multiplication and derivative; it is never an exact-zero replacement. At 320 bits its upper endpoint rounds to `2^-320`, intentionally widening it.

All remaining exponentials have bounded arguments in this fixed specification. The inherited finite series use 96 exponential terms and 160 complex Taylor terms; the Machin pi enclosure uses 128 alternating terms. These finite choices might fail an output radius test. Such a failure is recorded; the implementation makes no generic termination or success claim from the old single-node examples.

## Signed weights and whole-panel decision

Negative P centers are conjugates of positive centers, with the same radius. The zero node occurs once. For each signed grid index, the weight is recomputed as

`h*v^j/j!*exp((1/10+14i)*v)`, `j=0,...,6`.

The sign of odd powers for negative v and the different real exponential are retained. The weight center lies on `2^-64 Z[i]`; its rectangle-to-center L1 radius must be at most `2^-48`. The six exact zero weights at v=0 are handled explicitly. Multiplying the integer centers and summing gives coefficients on `2^-96 Z[i]` without another rounding operation.

The backend hash-checks the exact scalar planning script and receipt, calls its `run()` without invoking its file-writing main, and compares every returned field with the receipt. It stores the actual selected rounded analytic-plus-arithmetic error bound, strictly below `1/10`; it does not replace this evidence with a copied decimal threshold. The target also binds a, kappa, V, both rectangle intervals and all five CCW vertices. Exact rational corner distances and orientation checks establish the rectangle's closed-disk containment. It computes the rational L1 bound `U=sum_(j=1)^6 (|Re c_j|+|Im c_j|)*(1/64)^j`. A full packet reports `POSITIVE_REAL_DISK` only if `Re c_0-U>1/10`; otherwise it reports `INCONCLUSIVE`. On success it records the constant five-vertex image polygon 1, four zero crossings and winding zero. This is the new rational polynomial's test, not a comparison to any earlier Arb result. Its mathematical interpretation still depends on the reviewed analytic identities and their future formal proofs.

## Run gate, proposed cap, and replay contract

The implementation rejects Python `-O`, changed helper/spec/review pins, incomplete authorization, changed target metadata, and output overwrite without an explicit resume. An authorization JSON must copy the exact `TARGET` dictionary, name and hash the two accepted reviews, set `sixteen_mode_bound_accepted=true`, and set `coordinator_authorized=true`. The last field is an operational authorization, not mathematical evidence. No such enabled file accompanies this implementation.

After coordinator approval and code inspection, the proposed first full command is:

```
work/qrh-campaign/interval-env/Scripts/python.exe -X utf8 \
  work/qrh-campaign/agents/integration/rational_xi_panel_backend_20261111.py \
  --authorize <approved-new-authorization.json> \
  --output <new-fixed-panel-candidate.json> --max-nodes 929 --seconds 1800
```

The 1800-second cap is a limit, not a timing prediction. The code checks it during rounded arithmetic and between nodes. Completed prefixes are checkpointed every sixteen nodes, at the requested end, and on handled failure, through a temporary file. A handled failure preserves the entire completed in-memory prefix, reason, and next index. An external process termination may lose at most the current checkpoint batch. A resume recomputes and compares the saved prefix before extending it. It does not trust prior success flags. Stored full elementary events and word operands may make the packet large; no compact-receipt or production-cost claim is made.

The same command with `--check` recomputes every node, including its precision-selection path, then all signed weights and sums. It compares exact rational records, source and backend hashes, target metadata, authorization, assembly, and final status. Partial-prefix replay is labeled `PARTIAL` and is not panel acceptance. A timeout or assertion exits unsuccessfully; a completed but inconclusive mathematical comparison is explicitly labeled `INCONCLUSIVE`.

Independent review must use a separately written arithmetic path for at least the dynamic type/phase word, all terminal types, the underflow-straddling case, negative-grid weights, the zero node, and exact coefficient assembly. It must also test rejection of altered target metadata, missing/duplicated nodes, wrong T phase or sign, missing tails, narrowed boxes, false center radii, and changed coefficient data. A same-code exact replay is useful reproducibility evidence but is not independent verification or a substitute for a Lean soundness theorem.

## Present boundary

This packet contains implementation and a proposed run contract only. No actual node or panel success is reported. Remaining tasks are independent code review, an explicitly authorized capped run, independent mathematical/arithmetic replay of the resulting packet, and ultimately formal soundness and kernel acceptance. The accepted paper tail and specification do not themselves discharge those tasks.

The saved preflight record is `rational_xi_panel_backend_preflight_20261111.json`. It binds backend SHA256 `DEE8AC9AA39F25023C77003BC2AAA5970388A016207AD5A8EE0DF8F6D912F84A`, records zero node/weight evaluations, and reproduces the exact rounded disk-error bound `91500568239/1000000000000`. The rectangle orientation and all five rational corner-distance checks passed in the same read-only scalar run. No numerical pilot authorization was enabled or consumed.
