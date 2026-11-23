"""Independent exact polynomial/scalar checks; no Lean or analytic evaluations."""
from fractions import Fraction as F
import hashlib
import json
from pathlib import Path


class P:
    def __init__(self, a=0):
        self.a = {k: F(v) for k, v in a.items() if v} if isinstance(a, dict) else ({(0, 0): F(a)} if a else {})
    def __add__(self, b):
        b = b if isinstance(b, P) else P(b)
        keys = self.a.keys() | b.a.keys()
        return P({k: self.a.get(k, 0) + b.a.get(k, 0) for k in keys})
    __radd__ = __add__
    def __neg__(self):
        return P({k: -v for k, v in self.a.items()})
    def __sub__(self, b):
        return self + -(b if isinstance(b, P) else P(b))
    def __rsub__(self, b):
        return P(b) + -self
    def __mul__(self, b):
        b = b if isinstance(b, P) else P(b)
        out = {}
        for i, x in self.a.items():
            for j, y in b.a.items():
                k = tuple(u + v for u, v in zip(i, j))
                out[k] = out.get(k, 0) + x * y
        return P(out)
    __rmul__ = __mul__
    def __pow__(self, n):
        out = P(1)
        for _ in range(n):
            out = out * self
        return out


delta = P({(1, 0): 1})
y = P({(0, 1): 1})
D = (37 + 34*y)*F(1, 18)
weight = (7 + 18*y + 8*y*y)*F(1, 9)
J = (F(5, 6)-delta)*D + delta*weight
V = 51 + 41*y
# balancedExponent*J, derived independently by expanding the cutoff.
EJ = (-F(1, 48) + F(2, 3)*delta + delta*(F(1, 2)-y)*F(1, 6)
      - F(13, 16)*delta)*J + F(13, 32)*(F(5, 6)-delta)*delta*weight
rhs = (3+5*y)*((4*V*delta-79)**2+49) + 4*y*(4*V*delta*((1+3*y)*(15+32*y)*delta+9-13*y)+265+3485*y)
residual = -10368*V*EJ-rhs
assert not residual.a
checks = {
    "endpoint_cleared_polynomial_identity": True,
    "margin_denominator": 10368*17*F(5, 2) == 440640,
    "strict_endpoint_margin": F(49, 440640) > F(1, 10000),
    "high_baseline_larger_margin": F(1, 48)+F(5, 6)/16 > F(49, 440640),
    "physical_a_coefficient": 1-F(23, 48) == F(25, 48),
    "physical_constant": F(17, 48)*F(4, 25)-F(33, 50) == -F(181, 300),
    "physical_e_coefficient": 16-F(23, 48)*6 == F(105, 8),
    "common_count_epsilon": 154+5 == 159,
    "common_count_nu": 1+6 == 7,
    "high_count_epsilon": 76+2 == 78,
    "post_normalization_saving_t": 1-F(1, 8) == F(7, 8),
    "post_dyadic_saving_t": 1-F(1, 8)-F(1, 8) == F(3, 4),
}
assert all(checks.values())
here = Path(__file__).resolve().parent
root = here.parents[3] / "work/openai-math/lean/OAI/NumberTheory/DirichletL"
sources = """Detector/FinalAssemblyNormalized.lean
PrimeRows/NonfloorNormalized.lean
Detector/FinalAssemblyIntegral.lean
Detector/FinalAssemblyArithmetic.lean
Detector/FinalAssemblyClass.lean
Detector/FinalAssemblySourceCount.lean
Detector/FinalAssemblyCountParameters.lean
PrimeRows/NonfloorCount.lean
PrimeRows/NonfloorBudget.lean
PrimeRows/NonfloorSourceCount.lean
PrimeRows/NonfloorExponent.lean
Detector/CentralDyadicWeight.lean
Detector/CentralMixedMargins.lean
Detector/CentralExponent.lean
Endpoint.lean
Hecke/DetectorFixedAmplitudeCount.lean
Hecke/DetectorHighBatchCount.lean
Hecke/DetectorCountFromMoments.lean
Hecke/DetectorHighCount.lean
Hecke/DetectorRawBranches.lean
Hecke/DetectorBranchBudget.lean
Hecke/DetectorRowCountOptimization.lean
Hecke/DetectorRowCountCrossing.lean
Hecke/DetectorRowCountEndpoint.lean
Hecke/DetectorInverseFiberCount.lean
Hecke/DetectorPlainFiberCount.lean
Hecke/DetectorNoSlotInverseCount.lean
Hecke/DetectorRowCount.lean
PrimeRows/CubeNormalizer.lean
Detector/RayPoolThresholds.lean
Detector/RayNormalization.lean
Detector/RaySlots.lean
Detector/PrincipalNormalizer.lean
RayPrimeNormalizer.lean
Hecke/RayPrimes.lean
PrimeRows/NonfloorMoments.lean
Hecke/DetectorFiberEnergy.lean
Hecke/DetectorRowwiseMarked.lean
Hecke/DetectorRowwisePlain.lean
Detector/CentralCubeNorm.lean""".splitlines()
receipt = {
    "scope": "exact algebra and source hashes only; no analytic functions or Lean execution",
    "checks": checks,
    "endpoint_residual_coefficients": len(residual.a),
    "source_sha256": {p: hashlib.sha256((root/p).read_bytes()).hexdigest().upper() for p in sources},
}
out = here / "check_normalized_cell_algebra_20261111.json"
out.write_text(json.dumps(receipt, indent=2)+"\n", encoding="utf-8")
print(json.dumps({"checks": len(checks), "source_hashes": len(sources), "status": "PASS"}))
