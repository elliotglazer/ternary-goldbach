"""Bind the research blueprint to local sources, without executing proof code."""
from pathlib import Path
from hashlib import sha256
import re,json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parent.parent
AGENTS=ROOT/'work/qrh-campaign/agents'
EXPECTED={
 'zero-sum/PRIMITIVE_OUTPUT_PRUNING_EFFICIENCY_2026-11-11.md':'CB4085D00AED0BFDA9ADC1BB7306DB24EF052502C99F30D45E15AEF6EEC3F8B8',
 'major-constants/REVIEW_PRIMITIVE_OUTPUT_PRUNING_EFFICIENCY_2026-11-11.md':'A8B844581DC6E1D562B575A5973246F8C5ACBF06A47880FFA697A524AE36343D',
 'integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md':'861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895',
 'independent-feasibility/REVIEW_SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md':'F190270EC3A359A1251E24C1039826EFE13897499DE540EA9F877331804748BB',
 'audit/EFFICIENCY_MM0_PARALLEL_PROOF_STATE_2026-11-11.md':'4927B1604C4E13A001CDD3C9176F024D11A3FA8ECB0C6EB35F3C70A0B9F100FE',
 'independent-feasibility/REVIEW_EFFICIENCY_MM0_PARALLEL_PROOF_STATE_2026-11-11.md':'AA3EF5871BD12DDD6479C7A0C978F746E6EB8DAB57A04791323322552CDC7C43',
}
for rel,h in EXPECTED.items():assert sha256((AGENTS/rel).read_bytes()).hexdigest().upper()==h,rel
blueprint=HERE/'CURRENT_COMPUTE_BLUEPRINT_2026-11-11.md'
refs={}
for rel in re.findall(r'\]\(([^)]+)\)',blueprint.read_text(encoding='utf-8')):
    assert '://' not in rel,rel
    path=(HERE/rel).resolve()
    assert path.is_relative_to(ROOT),str(path)
    refs[path.relative_to(ROOT).as_posix()]=sha256(path.read_bytes()).hexdigest().upper()
out={'scope':'source identity and link existence only, not theorem validity',
     'blueprint_sha256':sha256(blueprint.read_bytes()).hexdigest().upper(),
     'explicit_expected_pins':EXPECTED,'linked_sources':refs}
(HERE/'current_compute_blueprint_inputs_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'blueprint_sha256':out['blueprint_sha256'],'explicit_pins':len(EXPECTED),'linked_sources':len(refs)}))
