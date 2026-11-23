# Native margin-screen worker source review

13 November 2026. PASS for the proposed bounded native experiment, conditional on the separately reviewed process runner. No blocking source defect found. This review imported no Python package, executed no worker or analytic function, and ran no build. It does not certify a numerical result, a canonical sign, or a HOL theorem.

## Fixed experiment and character binding

The worker preserves the requested two labels 1877 and 2813 and four heights 0, 5/64, 3290, 6580, in the declared order. It checks exact modulus/conductor/primitiveness, odd parity, order, group size/exponent, three generator exponents, the two nonunit values, the value at minus one, and the mutual inverse before any L call. Failure stops rather than changing labels. The generator-order checks exclude each prime divisor of the proposed orders 4 and 500. Together with the specified CRT generators, these checks bind the descriptor; they do not depend on approximate complex character values.

The installed stub signatures match the methods used. The versioned implementation constructs Conrey characters, returns integer exponents or None for nonunits, multiplies characters in their common group, and sends l_function to acb_dirichlet_l. This establishes the intended API semantics, not correctness of every binary implementation. [python-flint 0.9.0 Dirichlet implementation](https://raw.githubusercontent.com/flintlib/python-flint/0.9.0/src/flint/types/dirichlet.pyx).

## Formula and exact threshold

Every analytic input is an integer, an fmpq rational, or a native interval constant. No Python float enters t, s, w, b, pi or the logarithms. The worker uses

```
s = 1/2 + i*t
w = 3/4 + i*t/2
b = pi/4 - 16/1645
Q = exp(-3*log(pi)/4 + b*t + i*t*log(10000/pi)/2 + logGamma(w)) * L(s,chi).
```

This is the proposal's exact completion normalization. The real part of w stays positive, away from the logGamma poles/negative-real branch boundary. Computing one combined exponential implements the stated product without separately forming its large and small real factors. Dependency loss in ball arithmetic can widen the result but cannot justify shrinking it.

With eps=1/(2^80*4*3^64), P=40960, N=524288, W=1250000, the Python Fraction expression is exactly

```
R = 3*eps/(4*(6/P)) + N*42*(2*W^2+2)/2^160
threshold = 2*(44/(7*P))*R.
```

An independent symbolic simplification gives threshold = (11/7)*eps + (67584/5)*(W^2+1)/2^160, since N/P=64/5. The code retains all factors, including 42, the doubled W-square contribution, and the final factor two. Comparison is strict Fraction comparison after exact dyadic decoding, not a float comparison.

The threshold tests |Q| rather than a real or imaginary part. Under the proposal's existing unit-phase and real-normalization theorem, a pass implies the stated conditional transform-center sign margin. The worker correctly does not output that canonical sign, compute a phase, or claim that the candidate transform has run.

## Outward export and interval semantics

The versioned acb.abs_lower returns a finite-precision number rounded downward as an exact arb. Its real and imaginary components are properties, matching the worker. The worker's extra lower() cannot increase that bound. The implementation of lgamma/exp and ordinary acb arithmetic is the native interval route selected in the proposal. [python-flint 0.9.0 acb implementation](https://raw.githubusercontent.com/flintlib/python-flint/0.9.0/src/flint/types/acb.pyx).

The arb implementation converts fmpq through arb_set_fmpq at the current precision, so a nondyadic rational is enclosed rather than silently treated as an exact binary value. mid() copies the actual midpoint; rad() copies its radius exactly; lower() is downward-directed; man_exp requires a finite exact value and returns its integer mantissa and power-of-two exponent. Thus the exported midpoint/radius dyadics describe the returned ball, and the separate lower_abs_Q dyadic remains a lower bound. [python-flint 0.9.0 arb implementation](https://raw.githubusercontent.com/flintlib/python-flint/0.9.0/src/flint/types/arb.pyx).

The worker rejects nonfinite/inexact exports and unreasonable export sizes before rational comparison. Both positive and negative dyadic exponents are converted exactly. A nonnegative lower bound is required. A zero or insufficient lower bound produces an inconclusive result and stops; 512 working bits alone are never treated as an error guarantee.

## Bounded-result and trust scope

The worker verifies the selected interpreter and waits for GO before importing FLINT. Version, precision and thread checks, implementation fingerprints, fixed input identities, individual balls and the exact threshold are recorded. It documents that its fingerprints are not the complete dependent-DLL closure. The event cap and process runner remain separate protections; the small output limit does not bound native working memory.

An event-cap or I/O failure can prevent a final failure event from being written. That is a stopped attempt, never a successful result: the separate runner must continue to require its terminal status and complete eight-point sequence. Root owns review of that runner. No resource authorization is granted by this source verdict alone.

No actual character exponent or L value has been checked by this review. The runtime checks are necessary admission gates. A successful eight-point run would be native interval evidence at exactly those points under the retained source/error contract. It would not establish a full theta array, repair workload, finite RH, zero count, or ordinary-rule HOL certificate.

## Reviewed local pins

| File | SHA256 |
|---|---|
| worker.py | D2B3FF44B42DA82D4AE456344D0B2C4EED8DFB74484AC316AC6F4A1BFE2E8094 |
| ../NATIVE_SIGN_EXPERIMENT.md | 52B4442E3F44B2CC28AC37DC1043865A18DC60FC75E66A6C63694E9AFB216B70 |
| flint/types/dirichlet.pyi | 2FA0555EB5D6D10F51B807F4194F8A6CBF27654B86CCDC092F0751C964F86401 |
| flint/types/acb.pyi | 661B8C4076559FE71B5DB475DEBAAF0E1B90F2D350DAC5FC71E0508C80FF78D0 |
| flint/types/arb.pyi | 0B8F83271C2D328B49CD9D924C9CD6EC7383D6F72E59261EA754E42A2092D1F4 |
| flint/flint_base/flint_context.pyi | 72BF036F201F38270A7EDA8E66DA4DA966DAEFCF3E9AD57C9FC114062356F5DC |

The flint paths are in work/qrh-campaign/interval-env/Lib/site-packages. Upstream source was read at the explicit 0.9.0 tag linked above. No active dependent-benchmark source was edited.
