"""Independent rational allocation checks. No function values or producer imports."""
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
SRC = HERE.parent / "prime-estimates"
PINS = {
    "FINITE_U_HARDY_NORMALIZATION_2026-11-11.md": "06C9D3BF785BB183339D8EC64BE0B5AAD05331184C35356F575A8C126ADB724E",
    "finite_u_hardy_normalization_20261111.py": "03C27E09FD35195A8765263B0C9BEF63D41FAFE25E90DF2AD2EA425B79D63272",
    "finite_u_hardy_normalization_20261111.json": "DD5C2BC8A872A3308476CF8781582FCC9FC74B6CF96BCFF9C5D1F1E9DB9D7421",
}


def main():
    checks = 0
    def check(b):
        nonlocal checks
        assert b
        checks += 1
    def decode(pair):
        return F(int(pair[0]), int(pair[1]))
    for name, digest in PINS.items():
        check(hashlib.sha256((SRC / name).read_bytes()).hexdigest().upper() == digest)
    data = json.loads((SRC / "finite_u_hardy_normalization_20261111.json").read_text())
    for row in data["phase"]:
        alpha = F(2*row["a"]+1, 4)
        e = F(1, 48)/(alpha+row["J"])**2
        check(decode(row["remainder"]) == e)
        check(decode(row["cos_lower"]) == 1-e*e/2)
        check(1-e*e/2 >= F(17,18))
    check(F(11,200)**2 < F(1,16)**2)
    check(F(3,50)**2+F(1,64)**2 < F(1,16)**2)
    check(F(173,240) < F(3,4))
    for row in data["allocations"]:
        c, V, p = row["c"], decode(row["V"]), row["p"]
        tau = F(1,2**p)
        B = 2*(c+1)*(V+1)+1
        eta = tau/(64*B)
        phase = eta*F(5*V+1,16*(V+1))+eta/2
        Lerr = 3*tau/64
        mult = eta*(1+eta)+eta+phase
        check(row["p_L"] == p+5)
        check(decode(row["B"]) == B)
        check(decode(row["eta"]) == eta)
        check(decode(row["elementary_each"]) == eta/(4*(V+1)))
        check(phase < eta and mult <= 4*eta)
        check(decode(row["proxy_total_over_tau"]) == (Lerr+B*mult+tau/16)/tau)
        check(Lerr+B*mult+tau/16 < tau/4)
        J = int(row["true_H_J_cap"])
        check(J-1 < 2*B/tau <= J)
        for alpha in (F(1,4),F(3,4)):
            check(1/(48*(alpha+J)**2) <= eta)
            for j in (0,1,7):
                # Exact sum of absolute coefficients for the shifted real phase.
                coeff = 5*V/4+abs(alpha+j-F(1,2))+j
                check(coeff <= 2*(V+j+1))
        check(decode(row["true_H_total_over_tau"]) == F(13,64) < F(1,4))
    result = {"status":"PASS_SCALAR_ONLY", "checks":checks,
              "scope":"Rational allocation and source pins; no analytic values or sign data",
              "producer_pins":PINS}
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
