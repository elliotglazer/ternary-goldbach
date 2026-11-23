"""Time a fixed packed-kernel sum across distinct synthetic height inputs."""
from pathlib import Path
from random import Random
from statistics import median
from time import perf_counter_ns


def ordinary(xs, u, v):
    out = []
    for x, y in xs:
        a, b = x * u, y * v
        out.append((a - b, (x + y) * (u + v) - a - b))
    return out


def reused(xs, u, v):
    s = u + v
    out = []
    for x, y in xs:
        a, b = x * u, y * v
        out.append((a - b, (x + y) * s - a - b))
    return out


for row in Path(__file__).with_name("panel.txt").read_text().splitlines()[:4]:
    n, _, _, width = map(int, row.split()[:4])
    rng = Random(n)
    bits = 8 * n * width
    u, v = (rng.getrandbits(bits) for _ in range(2))
    xs = [(rng.getrandbits(bits), -rng.getrandbits(bits)) for _ in range(16)]
    assert ordinary(xs, u, v) == reused(xs, u, v)
    ratios = []
    for trial in range(8):
        times = {}
        for f in ((ordinary, reused) if trial % 2 == 0 else (reused, ordinary)):
            start = perf_counter_ns()
            f(xs, u, v)
            times[f] = perf_counter_ns() - start
        ratios.append(times[reused] / times[ordinary])
    print(n, bits, "median paired elapsed ratio", round(median(ratios), 4),
          "range", round(min(ratios), 4), round(max(ratios), 4))
