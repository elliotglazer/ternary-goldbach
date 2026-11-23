"""Bound integral_(5/4)^infinity log zeta(s) ds by explicit EM and convexity.

External interval evidence only. No builtin zeta, quadrature, or prime table.
The paper note supplies the analytic inequalities; this checks their scalar side.
"""
from flint import arb, ctx
from pathlib import Path
import hashlib
import json

ctx.prec = 160
N = 2048
B = 64
left = arb(5) / 4
right = arb(32)
step = (right - left) / N
logs = [arb(n).log() for n in range(1, B + 1)]
values = [(-left * x).exp() for x in logs]
ratios = [(-step * x).exp() for x in logs]
total = arb(0)
samples = []
for j in range(N + 1):
    s = left + step * j
    # |EM remainder after B2 correction| <= s/12 * B^(-s-1).
    # Adding correction and remainder gives s/6 in this upper bound.
    upper_zeta = sum(values[:-1], arb(0)) + values[-1] * (
        arb(B) / (s - 1) + arb(1) / 2 + s / (6 * B)
    )
    assert upper_zeta > 1
    f_upper = upper_zeta.log()
    total += f_upper * (1 if j in (0, N) else 2)
    samples.append(str(f_upper))
    if j < N:
        values = [v * r for v, r in zip(values, ratios)]

trapezoid = total * step / 2
# log zeta <= zeta-1 <= 2^-s + integral_2^infinity x^-s dx.
tail = (-right * arb(2).log()).exp() / arb(2).log() * (
    1 + 2 / (right - 1)
)
bound = trapezoid + tail
assert bound < arb(5918) / 5000  # 1.1836
assert bound < arb(148) / 125  # 1.184
receipt = {
    "status": "PASS_EXTERNAL_EXPLICIT_EM_TRAPEZOID",
    "precision_bits": ctx.prec,
    "panels": N,
    "B": B,
    "left": "5/4",
    "right": "32",
    "step": "123/8192",
    "trapezoid": str(trapezoid),
    "tail": str(tail),
    "bound": str(bound),
    "strict_rational_upper": "5918/5000",
    "target": "148/125",
    "log_upper_samples": samples,
    "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    "scope": "External interval arithmetic under paper EM/convexity/tail proof; no Lean theorem.",
}
out = Path(__file__).with_suffix('.json')
out.write_text(json.dumps(receipt, indent=2) + '\n', encoding='utf-8')
print(json.dumps({k: v for k, v in receipt.items() if k != 'log_upper_samples'}, indent=2))
