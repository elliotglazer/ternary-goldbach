"""Fixed dimensions and source hashes only. No prime/source/coverage data or enumeration."""
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
PINS={
 'work/qrh-blueprint/COMPACT_ASSIGNMENT_AND_MAGNITUDE_REFINEMENTS_2026-11-11.md':'93A497EEF11B914D32D1A4F8BB438B2E4DBA9A33ACAB54CDC9754413412C714E',
 'work/qrh-campaign/agents/audit/END_TO_END_COST_INVENTORY_AND_PRIORITIES_2026-11-11.md':'756DC55EF39C35597C17939339BA4C2CCC5E40A701DFB5073D4DDA31FE23E69C',
 'work/qrh-campaign/agents/audit/ERRATUM_END_TO_END_COST_PRINCIPAL_HEAD_2026-11-11.md':'3A190899E4CC87A1D50A451CD19FF55698A7FE2A0845F92C76CFBE1F9A4154F9',
 'work/qrh-campaign/agents/zero-sum/REVIEW_END_TO_END_COST_INVENTORY_AND_PRIORITIES_2026-11-11.md':'0ACA83A79F3CAA42E5E51C7CA7493A0D6028CC6B4A6345B508FFE37CF61F51C5',
 'work/qrh-campaign/agents/independent-feasibility/MISSING_END_TO_END_COMPUTE_COSTS_2026-11-11.md':'A42D1E70C1284A0A76A87D3650CF3104D4079E00BA899F6C753E4101B618437A',
 'work/qrh-campaign/agents/independent-feasibility/FINITE_COVERAGE_COST_FRONTIER_V2_2026-11-11.md':'F512044F2F5E9B55A7DFC9B5DAE8D094F4D290C41B5A9AB9202E42DD69901753',
 'work/qrh-campaign/agents/prime-estimates/REVIEW_FINITE_COVERAGE_COST_FRONTIER_V2_2026-11-11.md':'35D7DA18D6CB7941DAD798F5BC702119DF4B166578E938B57CB45BD490EC6A2C',
 'work/qrh-campaign/agents/prime-estimates/FINITE_GOLDBACH_GLOBAL_COST_FRONTIER_2026-11-11.md':'F950F36C3361A4BABB253B502168B613893DB5DCD002599A7BC261A950A16FC6',
 'work/qrh-campaign/agents/major-constants/BOUNDED_BINARY_CLAUSE_PROOF_REPRESENTATION_2026-11-11.md':'A43E9F4B180D0406BE0BC147DD793BD4DEE8F83F44BF86E57BA1479BB19279E3',
 'work/qrh-campaign/agents/zero-sum/REVIEW_BOUNDED_BINARY_CLAUSE_PROOF_REPRESENTATION_2026-11-11.md':'F4B77426B389262CD4169DC5F8E58C58A0BBA5176C44048496C5270F4E4FA777',
 'work/qrh-campaign/agents/independent-feasibility/BINARY_SOURCE_BITMAP_COST_DESIGN_2026-11-11.md':'4B877FC2377CEB81C60CE139331ED5380AB0CB78011DE500D8768B2F837B99EA',
 'work/qrh-campaign/agents/prime-estimates/PRINCIPAL_RH_1E8_MINIMAL_CERTIFICATE_COST_2026-11-11.md':'77403740E6BBEEBD3B85F93174DE2C9E082F42765B78163DB7CACA1650F769FC',
 'work/ternary-goldbach/TernaryGoldbach/Statement.lean':'3F61837D2C3A0DDE3A1997F05AF21C20C7FE6EE13E29891125495F6947596BF8',
 'work/ternary-goldbach/TernaryGoldbach/Helfgott/SmallCases.lean':'61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359',
}
checks=0
def ck(b):
 global checks
 checks+=1
 if not b:raise AssertionError(checks)
for path,h in PINS.items():
 ck(hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper()==h)
M,K,a,w=512,1024,16,64
bM=(M+w-1)//w;bK=(K+w-1)//w
ck(bM==8 and bK==16)
ck(K*bM==8192 and a*bK==256)
ck(K==1024 and bK==16)
ck(K*bM*w//8==M*bK*w//8==65536)
ck(K*M==524288)
ck(M*bK+K*bM==16384)
ck((4*10**18//2-1+63)//64==31250000000000000)
# Fixed scalar check of the setup threshold only; synthetic prices, not forecasts.
setup=1000;old=31;new=21
ck(100*old==setup+100*new)
ck(101*old>setup+101*new)
data={'scope':'fixed dimensions and source hashes; no masks, anchors, prime data, populations or runtime claims',
 'checks':checks,'pins':PINS,'synthetic_dimensions':{'M':M,'K':K,'a':a,'word_bits':w,
 'row_and':K*bM,'row_or':K*bM,'row_nonzero':K,'column_or':a*bK,'column_equal':bK,
 'transpose_bit_bindings':K*M,'row_or_column_payload_bytes':65536},
 'unpriced':'all ordinary bit proofs, signed/index/range bindings, compiler/source/anchor evidence, generation and lifetimes'}
out=HERE/'finite_binary_incidence_columns_20261111.json'
with out.open('x',encoding='utf-8',newline='\n') as f:json.dump(data,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'bytes':out.stat().st_size,'sha256':hashlib.sha256(out.read_bytes()).hexdigest().upper()}))
