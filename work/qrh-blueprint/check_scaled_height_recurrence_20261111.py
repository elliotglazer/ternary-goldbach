"""Exact scalar and inventory composition only; no analytic evaluations."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
AGENTS = HERE.parent / "qrh-campaign" / "agents"
PINS = {
    "integration/SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md": "1E1D5099D398EE978D635729873F4D3941BC186BD91D086198B39962DF8E564E",
    "integration/REVIEW_SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md": "043E2E1630B19EC8EED9496FAA5D9AE6AF9C20944F7F2F5589B48E5A119C4F26",
    "moebius/ELEMENTARY_HURWITZ_LEAF_BASELINE_2026-11-11.md": "0541F20C55B843683E3C496F8AEA63036A8A7AAF55A49C4F2B97ACC3FAC17C9D",
    "integration/REVIEW_ELEMENTARY_HURWITZ_LEAF_BASELINE_2026-11-11.md": "11EA2E715600A6F7E3A3646A64C21F645FB89038B915BF24A01C13D2AC4566DA",
    "zero-sum/GRID_ELEMENTARY_ANCHOR_REUSE_2026-11-11.md": "E564A8DDEC5F0AD69F5CF22DFC89147F81EA165B6E6D17B4CF0EFB0EEA3824AF",
    "independent-feasibility/REVIEW_GRID_ELEMENTARY_ANCHOR_REUSE_2026-11-11.md": "335D5B97A2071E9AFBEFF363C9FA4542CB974B8EB4D0F66B33A4E4FCECC17A29",
}
for rel, wanted in PINS.items():
    assert hashlib.sha256((AGENTS / rel).read_bytes()).hexdigest().upper() == wanted, rel

delta = Q(1, 2**118)
eps = rounding = Q(1, 2**140)
log_error = Q(1, 2**144)
step_cis_error = Q(1, 2**142)
step_storage_error = Q(1, 2**142)
conversion = Q(1, 2**122)
J = 128000
assert Q(5, 64)*log_error + step_cis_error + step_storage_error < eps
assert log_error <= Q(1, 2**137)
assert Q(7, 16)*Q(1, 2**120) < delta/4
assert J*eps < Q(1, 2)
budget = 2*(delta/4) + 2*J*(eps+rounding) + conversion
assert budget < Q(11, 16)*delta < delta

bands = [(500, 512, 220, 6401), (1000, 1024, 387, 6400),
         (2000, 2048, 720, 12800), (5000, 4096, 1720, 38400),
         (10000, 8192, 3387, 63988)]
rows = []
previous_points = previous_D = previous_N = 0
first_j = 0
for V, D, N, heights in bands:
    assert previous_D == 0 or D % previous_D == 0
    assert N >= previous_N
    points = (N+1)*D+1
    introduced = points-previous_points
    updates = heights*points-introduced
    assert Q(5, 64)*(first_j+heights-1) <= V
    rows.append(dict(V=V,D=D,N=N,heights=heights,first_j=first_j,
                     last_j=first_j+heights-1,points=points,
                     introduced= introduced,updates=updates))
    first_j += heights
    previous_points, previous_D, previous_N = points,D,N
assert first_j == 127989
active_points = rows[-1]["points"]
# The final band includes the endpoint b=N+2=3389.
overcover_points = (3389-1)*8192+1
assert active_points == overcover_points
pairs = sum(r["heights"]*r["points"] for r in rows)
updates = sum(r["updates"] for r in rows)
assert pairs == 2068812377589
assert updates == pairs-active_points
assert sum(r["introduced"] for r in rows) == active_points
assert rows[-1]["last_j"] < J
# Two complex arrays, two signed144-bit coordinates each.
raw_state_bytes = active_points*4*18
degree = max(1,(144+4+6)//7-1)
assert degree == 21
assert 2*Q(1,128)**(degree+1) <= log_error/8

out = {
    "status":"PASS_EXACT_SCALARS_AND_COUNTS_NO_FUNCTION_VALUES",
    "pins":PINS,"bands":rows,"delta_bits":118,
    "recurrence_error_bound_over_delta":str(budget/delta),
    "step_error_upper_over_eps":str((Q(5,64)*log_error+step_cis_error+step_storage_error)/eps),
    "unique_arguments":active_points,"height_argument_pairs":pairs,
    "initializations":active_points,"step_phase_certificates":active_points,
    "recurrence_updates":updates,"em_grid_conversions":pairs,
    "raw_state_and_step_bytes_at_144_signed_bits_per_coordinate":raw_state_bytes,
    "log_degree_at_144_bits":degree,
    "log_nonanchor_horner_stages":degree*(active_points-1046),
    "script_sha256":hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper(),
}
HERE.joinpath("scaled_height_recurrence_20261111.json").write_text(json.dumps(out,indent=2)+"\n",encoding="utf-8")
print(json.dumps({k:v for k,v in out.items() if k not in ("pins","bands")},indent=2))
