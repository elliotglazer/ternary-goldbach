"""Reconcile frozen source/review pins; no prover or numerical evaluation."""
from pathlib import Path
from hashlib import sha256
import json
import re

HERE=Path(__file__).resolve().parent
ROOT=HERE.parent.parent
AGENTS=ROOT/'work/qrh-campaign/agents'
reports={
 'independent-feasibility/MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md':'5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A',
 'major-constants/REVIEW_MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md':'A1D0815D5B186F0E07CCCFDD4EE3035D5E74D780CC4364ED49866AC30B56EF2F',
 'audit/EFFICIENCY_MM0_STREAMING_PROOF_STATE_2026-11-11.md':'53AD15DAE3EE3F19B1ABEA27B26F4ECD593ED7F6C557001FC2BF2A5B7957FE40',
 'independent-feasibility/REVIEW_EFFICIENCY_MM0_STREAMING_PROOF_STATE_2026-11-11.md':'8BC3923014640241C3D40EDB1D8DD85C35922D8E2D18C11898D3D307C6A33886',
 'prime-estimates/EFFICIENCY_COMPLEX_KARATSUBA_2026-11-11.md':'86D8A9435A9962CFF95194642E590D65C76B334E5AD24377959006E7AB17BEFF',
 'prime-estimates/CLARIFICATION_COMPLEX_KARATSUBA_CHUNKS_2026-11-11.md':'788CB7708B95B05BB9FE12DD823CEE200E6D0468D2532A3963766A61C373278C',
 'audit/REVIEW_EFFICIENCY_COMPLEX_KARATSUBA_2026-11-11.md':'27FADB7F3BD0B49D6A29B1183F04BCAB507FAC2F5C173B3ED8EA230C413424B7',
}
checked={}
def check(path,expected):
    actual=sha256(path.read_bytes()).hexdigest().upper()
    assert actual==expected,(str(path),actual,expected)
    checked[path.relative_to(ROOT).as_posix()]=actual
for rel,h in reports.items():check(AGENTS/rel,h)
tables=[
 ('major-constants/REVIEW_MIXED_RADIX_INTERMEDIATE_WIDTH_2026-11-11.md',AGENTS,7),
 ('audit/EFFICIENCY_MM0_STREAMING_PROOF_STATE_2026-11-11.md',ROOT,9),
 ('audit/REVIEW_EFFICIENCY_COMPLEX_KARATSUBA_2026-11-11.md',AGENTS,8),
]
rows=0
for rel,base,expected_count in tables:
    count=0
    for line in (AGENTS/rel).read_text(encoding='utf-8').splitlines():
        if not line.startswith('|'):continue
        cells=[c.strip().strip('`') for c in line.split('|')[1:-1]]
        if len(cells)!=2 or not re.fullmatch('[A-F0-9]{64}',cells[1]):continue
        check(base/cells[0],cells[1]);count+=1
    assert count==expected_count,(rel,count)
    rows+=count
out={'scope':'frozen report and source hashes only; mathematical acceptance is recorded separately',
     'report_count':len(reports),'support_table_rows':rows,'unique_pins':checked,
     'builds_run':False,'numerical_values_evaluated':False}
(HERE/'reconcile_width_streaming_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'reports':len(reports),'support_rows':rows,'unique_pins':len(checked)}))
