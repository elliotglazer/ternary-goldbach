"""Read-only frozen-input audit and independent integer metadata calculations."""
from pathlib import Path
import hashlib,json,re

AGENTS=Path(__file__).resolve().parents[1]
WORK=AGENTS.parents[1]
note=AGENTS/'prime-estimates/PRINCIPAL_RH_1E8_MINIMAL_CERTIFICATE_COST_2026-11-11.md'
assert hashlib.sha256(note.read_bytes()).hexdigest().upper()=='77403740E6BBEEBD3B85F93174DE2C9E082F42765B78163DB7CACA1650F769FC'
pins=[]
for rel,h in re.findall(r'\| `([^`]+)` \| `([A-F0-9]{64})` \|',note.read_text(encoding='utf-8')):
 p=(WORK/'ternary-goldbach'/rel) if rel.startswith('TernaryGoldbach/') else AGENTS/rel
 got=hashlib.sha256(p.read_bytes()).hexdigest().upper()
 assert got==h,(rel,got,h)
 pins.append({'path':rel,'sha256':h})
assert len(pins)==17
saved=json.loads((AGENTS/'prime-estimates/principal_rh_minimal_receipt_metadata_20261111.json').read_text())
n=250000001; H=100000001
independent=[]
for row in saved['coordinate_rows']:
 b=row['coarse_fractional_bits']; ell=row['low_bits_per_key']
 M=H*2**b
 vlen=M//2**ell+n+1
 bitbound=n*ell+vlen
 width=next(w for w in range(100) if M<2**w)
 calculated={'maximum_key':M,'high_bitvector_length_upper':vlen,
 'base_payload_bits_upper':bitbound,'base_payload_bytes_upper':(bitbound-1)//8+1,
 'fixed_coordinate_bits':width,'byte_aligned_fixed_payload_bytes':n*((width-1)//8+1)}
 for key,value in calculated.items():assert row[key]==value
 independent.append({'b':b,'ell':ell,**calculated})
assert saved['hypothetical_sample_count']==n
assert saved['conditional_top_upper']==H
assert saved['historical_13_byte_record_proxy_bytes']==13*n
assert saved['independent_K0_main_terms_total_upper']==4095*n==1023750004095
assert 6*4096**2==saved['integer_witness_six_times_4096_squared']>H
assert saved['one_eighth_grid_intervals_to_upper_height']==8*H
out={'status':'PASS_INDEPENDENT_PRINCIPAL_METADATA_SCOPE','source_pins':pins,
 'metadata_rows':independent,'scope':'Integer payload/schedule comparison only; no zero count, sign or decoder theorem'}
dest=Path(__file__).with_suffix('.json')
if dest.exists():raise SystemExit('Refusing to overwrite receipt')
dest.write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8',newline='\n')
print(out['status'])
