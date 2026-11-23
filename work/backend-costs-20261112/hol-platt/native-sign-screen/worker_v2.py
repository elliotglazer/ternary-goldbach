"""Eight fixed native interval margin tests. No canonical signs or HOL proof.

Run only through run_screen_v2.py: wait for post-job-assignment GO before importing
FLINT. A failed character binding or an inconclusive point stops the experiment.
"""
from pathlib import Path
from fractions import Fraction
import hashlib
import json
import os
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
BASE_PYTHON = Path("C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe")
BASE_PIN = "4942B86A6597E5AEE0128DAA00050ED79BC21F6E709A78EB19CBFEB0C2F39AC9"
SITE = ROOT / "work/qrh-campaign/interval-env/Lib/site-packages"
PACKAGE_PINS = {
    "flint/__init__.py": "51B38D54B85E213A7AE1E801F9D6E9FEC6E31AA25D28F57732DF12DC0F1D0948",
    "flint/types/dirichlet.cp314-win_amd64.pyd": "882740ABD12444B2A90383FC52FD1F1AB03167E6F74FECE63A9F80E922D25A8A",
    "flint/types/acb.cp314-win_amd64.pyd": "34D3E382AE2A9C4BF7BCF2BAB9505964FBAA5316EEB2B289D4AF4D8B8CB0A1EB",
    "flint/types/arb.cp314-win_amd64.pyd": "D89D5A1DA29F74F2DD256DD52136319BA2799566211ADB9D9224BFB966EF4324",
}
PRECISION = 512
CAP = 256 * 1024
LABELS = (1877, 2813)
HEIGHTS = ((0, 1), (5, 64), (3290, 1), (6580, 1))
PLAN = [{"character": label, "t_numerator": n, "t_denominator": d,
         "label": f"chi{label}_t{n}_{d}"}
        for label in LABELS for n, d in HEIGHTS]


def need(condition, message):
    if not condition:
        raise RuntimeError(message)


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def rat(value):
    return {"numerator": str(value.numerator), "denominator": str(value.denominator)}


def main():
    need(len(sys.argv) == 2, "runner output-directory argument required")
    output = Path(sys.argv[1]).resolve()
    need(output.parent == (HERE / "runs").resolve() and output.is_dir(), "output path")
    need(sys.stdin.buffer.readline(80) == f"GO {os.getpid()}\n".encode("ascii"),
         "no post-assignment PID-bound GO")
    need(Path(sys.executable).resolve() == BASE_PYTHON.resolve(), "wrong Python")
    need(sys.version_info[:3] == (3, 14, 7) and sys.maxsize == 2**63 - 1
         and sys.implementation.cache_tag == "cpython-314", "wrong Python version/ABI")
    need(sys.flags.isolated == 1 and sys.flags.no_site == 1, "require -I -S")
    need(sha(BASE_PYTHON).upper() == BASE_PIN, "base Python pin")
    started, cpu_started = time.perf_counter(), time.process_time()
    completed = []
    current = None
    size = 0
    with (output / "events.jsonl").open("xb", buffering=0) as events:
        def emit(kind, **fields):
            nonlocal size
            record = {"kind": kind, "wall_seconds": time.perf_counter() - started,
                      "cpu_seconds": time.process_time() - cpu_started, **fields}
            data = (json.dumps(record, sort_keys=True, allow_nan=False) + "\n").encode("utf-8")
            need(len(data) <= 32 * 1024 and size + len(data) <= CAP, "event size cap")
            events.write(data)
            os.fsync(events.fileno())
            size += len(data)
            print(data.decode("utf-8"), end="", flush=True)

        try:
            emit("start", plan=PLAN, precision_bits=PRECISION, pid=os.getpid(),
                 worker_sha256=sha(__file__), python_sha256=sha(sys.executable),
                 canonical_signs=False, formal_proof=False,
                 meaning="Native modulus lower bounds for conditional p160 admissibility only")
            need("flint" not in sys.modules and "site" not in sys.modules, "unexpected early package/site import")
            for relative, expected in PACKAGE_PINS.items():
                need(sha(SITE / relative).upper() == expected, "package pin: " + relative)
            # No site.addsitedir(): do not process .pth files or sitecustomize.
            sys.path.insert(0, str(SITE))
            import flint
            from flint import acb, arb, fmpq, dirichlet_char, ctx
            need(Path(flint.__file__).resolve() == (SITE / "flint/__init__.py").resolve(),
                 "wrong FLINT package path")
            need(flint.__version__ == "0.9.0", "unexpected python-flint version")
            ctx.prec = PRECISION
            ctx.threads = 1
            need(ctx.prec == PRECISION and ctx.threads == 1, "FLINT context")
            module_files = [Path(flint.__file__)] + [Path(sys.modules[name].__file__) for name in
                ("flint.types.dirichlet", "flint.types.acb", "flint.types.arb")]
            need(all(p.resolve().is_relative_to(SITE.resolve()) for p in module_files),
                 "FLINT extension outside pinned site directory")
            emit("backend", python=sys.version, python_flint=flint.__version__,
                 fingerprints=[{"path": str(p), "sha256": sha(p)} for p in module_files],
                 fingerprint_scope="Python package entry and three extension modules; not full DLL closure")

            # These integer checks certify the chosen local generator orders.
            need(pow(5, 4, 16) == 1 and pow(5, 2, 16) != 1, "C4 generator")
            need(pow(2, 500, 625) == 1 and pow(2, 250, 625) != 1
                 and pow(2, 100, 625) != 1, "C500 generator")
            chars = [dirichlet_char(10000, label) for label in LABELS]
            for ch, label, expected in zip(chars, LABELS, ((0, 125, 1), (0, 375, 499))):
                need(ch.modulus() == 10000 and ch.number() == label, "Conrey identity")
                need(ch.conductor() == 10000 and ch.is_primitive() and not ch.is_principal(),
                     "primitive conductor")
                need(ch.parity() == 1 and ch.order() == 500, "parity/order")
                need(ch.group().size() == 4000 and ch.group().exponent() == 500, "group")
                got = tuple(int(ch.chi_exponent(r)) for r in (8751, 2501, 9377))
                need(got == expected, f"generator exponent mismatch for {label}: {got}")
                need(ch.chi_exponent(2) is None and ch.chi_exponent(5) is None, "nonunits")
                need(int(ch.chi_exponent(9999)) == 250, "odd character value")
                emit("character", conrey=label, conductor=10000, parity=1,
                     generators=[8751, 2501, 9377], exponents=list(got), exponent_modulus=500)
            need((chars[0] * chars[1]).number() == 1, "not inverse characters")

            eps = Fraction(1, 2**80 * 4 * 3**64)
            L0, H0 = Fraction(6, 40960), Fraction(44, 7 * 40960)
            radius = 3 * eps / (4 * L0) + Fraction(524288 * 42 * (2 * 1250000**2 + 2), 2**160)
            threshold = 2 * H0 * radius
            emit("threshold", eps=rat(eps), raw_radius=rat(radius),
                 physical_threshold=rat(threshold), strict_test="lower_abs_Q > physical_threshold")

            def dyadic(x):
                need(x.is_finite() and x.is_exact(), "nonfinite/inexact dyadic export")
                m, e = x.man_exp()
                m, e = int(m), int(e)
                need(abs(e) <= 100000 and abs(m).bit_length() <= 4096, "dyadic export cap")
                return [str(m), e]

            def ball(x):
                need(x.is_finite(), "nonfinite real ball")
                return {"mid": dyadic(x.mid()), "rad": dyadic(x.rad())}

            def complex_ball(x):
                need(x.is_finite(), "nonfinite complex ball")
                return {"real": ball(x.real), "imag": ball(x.imag)}

            pi = arb.pi()
            three_quarters = arb(fmpq(3, 4))
            b = pi / 4 - arb(fmpq(16, 1645))
            log_ratio = (arb(10000) / pi).log()
            for spec in PLAN:
                current = spec["label"]
                need(ctx.prec == PRECISION and ctx.threads == 1, "changed FLINT context")
                emit("point_start", **spec)
                tick, cpu_tick = time.perf_counter(), time.process_time()
                t = arb(fmpq(spec["t_numerator"], spec["t_denominator"]))
                s, w = acb(arb(fmpq(1, 2)), t), acb(three_quarters, t / 2)
                ch = chars[LABELS.index(spec["character"])]
                value = ch.l_function(s)
                need(value.is_finite(), "nonfinite L ball")
                exponent = acb(-three_quarters * pi.log() + b * t, t * log_ratio / 2) + w.lgamma()
                Q = exponent.exp() * value
                need(Q.is_finite(), "nonfinite completion ball")
                lower = Q.abs_lower().lower()
                mstr, e = dyadic(lower)
                m = int(mstr)
                lower_q = Fraction(m * 2**e, 1) if e >= 0 else Fraction(m, 2**(-e))
                need(lower_q >= 0, "negative modulus lower bound")
                passed = lower_q > threshold  # exact integer/rational strict comparison
                emit("point", **spec, status="pass" if passed else "inconclusive",
                     L=complex_ball(value), Q=complex_ball(Q), lower_abs_Q=[mstr, e],
                     strict_comparison=passed, point_wall_seconds=time.perf_counter() - tick,
                     point_cpu_seconds=time.process_time() - cpu_tick)
                if not passed:
                    emit("stopped", reason="inconclusive margin; no retry or relabeling",
                         completed=completed, pending=[p["label"] for p in PLAN if p["label"] not in completed])
                    return 2
                completed.append(current)
            emit("complete", completed=completed, count=len(completed),
                 actual_fft_run=False, canonical_signs=False, finite_RH=False)
            return 0
        except Exception as error:
            emit("failure", current=current, error_type=type(error).__name__, error=str(error)[:3000],
                 completed=completed, pending=[p["label"] for p in PLAN if p["label"] not in completed])
            return 3


if __name__ == "__main__":
    raise SystemExit(main())
