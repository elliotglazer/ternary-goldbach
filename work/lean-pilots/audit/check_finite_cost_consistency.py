"""Independent fixed-scenario accounting; no benchmark or mathematical-value work."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json
import math

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
EST = ROOT / "work/qrh-blueprint/estimates-20261111"
BIN = ROOT / "work/lean-pilots/binary"
def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest().upper()
expected = {
 EST / "FINITE_COST_ESTIMATE.md": "F03C9E49433988ECCEF97D6A10CCA073F7BD024F1B92511285CCD7D65CA1BFCE",
 EST / "finite_cost_scenarios.py": "C842CFE3897E1A503781241DEFE0416260134E151ECF1B6CE6900DF49F13664B",
 EST / "finite_cost_scenarios.json": "48FC76488941526A4B2CA5B5198B06D6051DA67D78DFBA342C5F8B9374E9363B",
 BIN / "REPORT.md": "20FBB99BECB49FF16E19ABE17EE7CE91542B53D8D0F92929A61B3979FFA6946D",
 BIN / "results.json": "C0C0B289849E2FDC7CAB8BBD5859A40A4FAEC2FB7EC263FD44F062A32C2EF0AA",
}
checks = 0
def check(b):
    global checks
    assert b
    checks += 1
def near(actual, exact):
    check(math.isclose(actual, float(exact), rel_tol=2e-14, abs_tol=1e-9))
for p, h in expected.items():
    check(sha(p) == h)
data = json.loads((EST / "finite_cost_scenarios.json").read_text())
year = 31557600
N = 989 * 10**24
check(data["N0"] == N and data["year_seconds"] == year)
def ceildiv(a,b): return (a+b-1)//b
def rates(*args): return [F(str(x)) for x in args]
for row in data["rows"] + data["central_cutoff_sensitivity"]:
    i = ["low", "central", "high"].index(row["scenario"])
    B = row["B"]
    lean = row["backend"] == "Lean"
    stock = row["backend"] == "MM0_stock_conditional"
    targets = B//2-1
    words = ceildiv(targets,64)
    tiles = ceildiv(targets,2**18)
    anchors = 512*(B//2//2**36)
    minimum = ceildiv(N-1-B-3,B-2)
    K = ceildiv(minimum*[105,120,200][i],100)
    for field, value in [("targets",targets),("words",words),("tiles",tiles),
                         ("anchor_records",anchors),("Kmin",minimum),("assumed_K",K)]:
        check(row[field] == value)
    scale = F(B,10**16)
    search = words * F(13,10**7) * [1,2,5][i]
    anchor_gen = anchors*rates('.002','.02','.2')[i]
    exception = year*scale*rates('.05','.5','5')[i]
    fallback = rates('.00001','.001','.01')[i]
    native_rung = F(15,10**6)*[2,10,100][i]+fallback*rates('.02','.1','1')[i]
    if lean:
        cover_check = tiles*F(3399653,10**9)*[1,2,8][i]
        cover_gen = cover_check*rates('.1','.5','1.5')[i]
        anchor_check = anchors*rates('.03','.055078125','.25')[i]
        sourcegen = year*rates('.02','.1','1')[i]
        sourcecheck = year*rates('.02','.2','2')[i]
        rung = F(55,10**6)*[1,3,30][i]+fallback*rates('.1','.5','5')[i]
        laddergen = K*native_rung
        setup = year*[F(1,10),F(1),F(10)][i]
        check(row["mm0_dispatches_per_rung"] is None)
    else:
        updates = words*F(447,40)
        core = (F('8.22014460148686e-7') if stock else rates('.00000060','.000000822','.0000015')[i])
        cover_check = updates*core*rates('1.2','2','5')[i]
        cover_gen = updates*F('3.9959993084370677e-7')*(rates('1','2','5') if stock else rates('.75','1.25','3'))[i]
        anchor_check = anchors*[F(1,10),F(1),F(10)][i]
        anchor_gen += anchor_check*rates('.5','1','2')[i]
        sourcegen = year*rates('.1','1','10')[i]
        sourcecheck = year*rates('.2','2','20')[i]
        dispatches = 65560*[100,180,400][i]+3256*[80,160,320][i]+44*[100,180,400][i]
        check(row["mm0_dispatches_per_rung"] == dispatches)
        throughput = ([200,100,25] if stock else [400,160,50])[i]*10**6
        rung = F(6,5)*F(dispatches,throughput)+fallback*rates('.1','1','10')[i]
        laddergen = K*(native_rung+rung*(rates('.5','1','2') if stock else rates('.3','.6','1.5'))[i])
        setup = year*rates('.2','2','20')[i]
        # These are floating-point Fermi byte projections, not exact serialized lengths.
        near(row["schematic_binary_stream_bytes"],updates*F('150.01'))
        near(row["ladder_dispatch_bytes_sensitivity"],K*dispatches*3)
    components = {
      "binary_native_search":search,"binary_anchor_generation":anchor_gen,
      "binary_exception_generation":exception,"binary_cover_production":cover_gen,
      "binary_source_generation":sourcegen,"binary_cover_checking":cover_check,
      "binary_anchor_checking":anchor_check,"binary_exception_checking":exception,
      "binary_source_checking":sourcecheck,"ladder_generation":laddergen,
      "ladder_checking":K*rung,"cold_library_decoding_assembly_reserve":setup}
    for key, value in components.items(): near(row["seconds"][key],value)
    gen = search+anchor_gen+exception+cover_gen+sourcegen+laddergen+setup/2
    chk = cover_check+anchor_check+exception+sourcecheck+K*rung+setup/2
    near(row["core_years"]["generation"],gen/year)
    near(row["core_years"]["checking"],chk/year)
    near(row["core_years"]["total"],(gen+chk)/year)
    near(row["rung_check_seconds"],rung)

# Check that the measured standalone source contains the already audited components.
pieces = []
for i, name in enumerate(["BinarySupport.lean","PilotPrimes.lean","BinaryPilot.lean"]):
    text = (BIN/name).read_text(encoding="utf-8")
    if i: text = '\n'.join(line for line in text.splitlines() if not line.startswith('import '))+'\n'
    pieces.append(f'/- Owned component: {name} -/\n'+text)
check((BIN/"CompleteBinaryPilot.lean").read_text(encoding="utf-8") == '\n'.join(pieces))
pilot = json.loads((BIN/"results.json").read_text())
for name, entry in pilot["files"].items():
    check(sha(BIN/name) == entry["sha256"])
    check((BIN/name).stat().st_size == entry["bytes"])
for run in pilot["runs"]:
    saved = json.loads((BIN/run["receipt"]).read_text())
    for key in ["exit","wall_seconds","process_cpu_seconds","command","cwd"]:
        check(run[key] == saved[key])
receipt = {"scope":"Fixed Fermi arithmetic and measurement-source binding only; no throughput or scenario feasibility validation",
           "checks":checks,"rows":18,"pins":{str(p.relative_to(ROOT)).replace('\\','/'):h for p,h in expected.items()},
           "script_sha256":sha(Path(__file__))}
out = HERE/"finite_cost_consistency_receipt.json"
with out.open('x',encoding='utf-8') as f:
    json.dump(receipt,f,indent=2);f.write('\n')
print(json.dumps({"checks":checks,"receipt_sha256":sha(out)}))
