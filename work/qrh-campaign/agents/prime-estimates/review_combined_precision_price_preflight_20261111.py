"""Preflight pins and fixed limits only. Does not parse any inventory JSON."""
from pathlib import Path
import hashlib
import json
import re

BASE=Path(__file__).resolve().parents[1]
AUTHOR=BASE/'moebius/COMBINED_PRECISION_PRICE_PREFLIGHT_2026-11-11.md'
EXPECTED='369F28970D508C5179524F9B5D5019E587BA87B39F2959515029A198F4EF379C'
checks=0
def ck(condition):
    global checks
    assert condition
    checks+=1
def digest(path):
    h=hashlib.sha256()
    with path.open('rb') as f:
        while block:=f.read(1024*1024):h.update(block)
    return h.hexdigest().upper()
ck(digest(AUTHOR)==EXPECTED)
note=AUTHOR.read_text()
pins={}
for name,size,sha in re.findall(r'^\|\s*([^|]+\.json)\s*\|\s*(\d+)\s*\|\s*([A-F0-9]{64})\s*\|$',note,re.M):
    name=name.strip()
    if '/' not in name:name='major-constants/'+name
    path=BASE/name
    size=int(size)
    ck(size<=32*1024**2 and path.stat().st_size==size)
    ck(digest(path)==sha)
    pins[name]=dict(bytes=size,sha256=sha)
ck(len(pins)==12)
total=sum(v['bytes'] for v in pins.values())
ck(total==73619701<128*1024**2)
ck(sum(v['bytes'] for k,v in pins.items() if k.startswith('major-constants/'))==12392794)
SUPPORT={
'major-constants/COMBINED_CONDUCTOR_PRECISION_ASSIGNMENT_PREFLIGHT_2026-11-11.md':'B563B8CC28DC1F2BCF08390BCF9385AD504432940A0C22D263BC9002037158B2',
'major-constants/COMBINED_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md':'EBA33B23C531312243495B9B0321597FC26D8AEBA8E1CF24626457474EA3A997',
'integration/REVIEW_COMBINED_CONDUCTOR_PRECISION_SAVED_PASS_2026-11-11.md':'8745235D810A1F06E8661961A05EF93C8DB24574121700DF6D924AE6EC2615C4',
'major-constants/combined_conductor_precision_assignment_20261111.py':'F67CF569467ED444A0BB8ED0F576166F4B289B8E5710CB769F08D3F22AF78408',
'major-constants/COMBINED_PRECISION_COMPACT_ROW_AMENDMENT_2026-11-11.md':'AACBB5CA78AA460F811FBDF90040741E9A546AC23381F9A9BF8DA9F53DC5A25B',
'integration/REVIEW_COMBINED_PRECISION_COMPACT_ROW_AMENDMENT_2026-11-11.md':'2D30DECAACF68512804F9E8106461463A6DCB1A5282471FC76C95D10F0B10172',
'independent-feasibility/SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md':'B7E781617D7E9E041CB340549A52387EC32303CFDE086B7BD5170448905BD266',
'independent-feasibility/SUBGRID100_ERROR_MAGNITUDE_COMPANION_2026-11-11.md':'39EC80DDC3388A9E470647CC4486D448108BB1FFD0D4CC58C13B61FBE3A4A761',
'audit/REVIEW_SUBGRID100_TRANSFORM_INPUT_REGRID_2026-11-11.md':'8431B9FF6B172F8ED36644413C359F5B8E2FEB58D9EBF0F88E500F152113EBAD',
'audit/REVIEW_SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md':'56B27935FF994E3F25F735825196076DF72C8DBC33D2A61D4787B61E3BBDD5F0',
'zero-sum/SUBGRID_REGRID_ARITHMETIC_COST_INTERFACE_2026-11-11.md':'E2457D3CA0E4436575DBAEA81413D91601312033AC6086233CFB7977D790225D',
'moebius/SHARPER_PRECISION_DELTA_PRICES_2026-11-11.md':'D12934F2624BD88564B6E0E19C251D2465B338E34EF08755798180F672F42BB1',
'prime-estimates/REVIEW_SHARPER_PRECISION_DELTA_PRICES_2026-11-11.md':'402537CDCA633BD94D4AA2F23FB6334FB0B317541929F30D1B6DD787DAB5F470',
}
support={}
for name,sha in SUPPORT.items():
    p=BASE/name
    ck(digest(p)==sha)
    support[name]=dict(bytes=p.stat().st_size,sha256=sha)
ck(sum(v['bytes'] for v in support.values())<1024**2)
ck(29*220108==6383132)
ck(29*133==3857)
ck(18*125400==2257200)
ck(2*37117==74234)
ck(29*37117==1076393)
ck(29*6004==174116)
ck(4*(2*((115+7)//8)+1)==124)
ck(292453624512==41*7133015232)
ck(59962061953248+292453624512==60254515577760)
ck(60254515577760+640*7133015232==64819645326240)
ck(29961461170177<2**80 and 2*424706204<2**80)
ck(8*1024**2+2*1024**2<12*1024**2)
receipt=dict(scope='Paper/schema review, streaming hashes and fixed arithmetic only; no inventory JSON parsed or folded',
    author_sha256=EXPECTED,checks=checks,input_bytes=total,input_pins=pins,support_pins=support,
    schema_fields=13,context_total=6383132,context_live_cap=220108,width_class_cap=3857,
    execution_authorized=False)
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f:json.dump(receipt,f,indent=2);f.write('\n')
print(json.dumps(dict(checks=checks,receipt_bytes=dest.stat().st_size,receipt_sha256=digest(dest))))
