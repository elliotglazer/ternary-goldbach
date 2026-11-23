"""One-time explicit accepted-source inventory; no mathematical checks or builds."""
import hashlib
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
A=ROOT/'work/qrh-campaign/agents'

def digest(p): return hashlib.sha256(p.read_bytes()).hexdigest()

# Review pins were supplied/confirmed by the coordinator. No discovery-by-PASS scan.
specs=[
('head','Complete head counts and wider sufficient strip',
 'mellin/PSI_HEAD_COUNTS_CERTIFICATE_2026-11-11.md',
 'moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md',
 '0BD2AF981C7F8A201F15597A7EE4C7B9812053C4987231C8EB02E5A6AA8BA491',
 ['mellin/psi_head_counts_20261111.py','mellin/psi_head_counts_20261111_h1500.json','mellin/psi_head_moment_20261111.py','moebius/psi_head_review_20261111.py','moebius/psi_head_review_20261111.json','moebius/psi_head_taylor_review_20261111.py','moebius/psi_head_taylor_review_20261111.json']),
('prime-kernel','Pure-kernel finite-prime replay architecture',
 'prime-estimates/RESUME_PSI_KERNEL_REPLAY_ARCHITECTURE_2026-11-11.md',
 'independent-feasibility/REVIEW_PSI_KERNEL_ARCHITECTURE_2026-11-11.md',
 'C94A37170290EA9B789E37B6BC498E3ABB805DD52856135C5EDB8DC5CDD9AA66',
 ['prime-estimates/resume_psi_kernel_replay_sizing_20261111.py','prime-estimates/resume_psi_kernel_replay_sizing_20261111.json','independent-feasibility/review_psi_kernel_architecture_20261111.py','independent-feasibility/review_psi_kernel_architecture_20261111.json']),
('prime-logs','Exact logarithm and theta-recurrence handoff',
 'prime-estimates/RESUME_PSI_LOG_RECURRENCE_LEDGER_2026-11-11.md',
 'audit/RESUME_PSI_LOG_RECURRENCE_REVIEW_2026-11-11.md',
 '1CC401BC6F6649A1DC1B885E652C77EA16AA5982933821D900D5F6A7A9D00738',
 ['prime-estimates/resume_psi_log_recurrence_integer_audit_20261111.py','prime-estimates/resume_psi_log_recurrence_integer_audit_20261111.json','audit/resume_psi_log_recurrence_review_20261111.py','audit/resume_psi_log_recurrence_review_20261111.json','audit/resume_psi_log_recurrence_replay_20261111.json']),
('rectangle','Rectangle checker source interfaces',
 'major-constants/RECTANGLE_CHECKER_SOURCE_LEDGER_2026-11-11.md',
 'audit/RECTANGLE_CHECKER_SOURCE_REVIEW_2026-11-11.md',
 'CDC8361E28975B7669C3261D033C2A8C39D95025C85C7608C1645BEC1C8D2BFD',[]),
('polygon','Complete generic polygon crossing paper proof',
 'major-constants/POLYGON_CROSSING_PROOF_2026-11-11.md',
 'independent-feasibility/REVIEW_POLYGON_CROSSING_PROOF_2026-11-11.md',
 'F75647007C294E13132B984A0F6241B516D5113D789AECA922B4DA265A5E73F0',
 ['independent-feasibility/review_polygon_crossing_20261111.py','independent-feasibility/review_polygon_crossing_20261111.json']),
('em','Source-faithful complex Euler-Maclaurin paper proof',
 'major-constants/EM_SOURCE_PROOF_PLAN_2026-11-11.md',
 'moebius/EM_SOURCE_PROOF_REVIEW_2026-11-11.md',
 '5D261401E8D4490DCE78CF284418E840253EB47ADBF0C9654E4A794B75C87CF1',[]),
('cauchy','Production sampled-Cauchy wrapper and bounded zeta models',
 'zero-sum/PRODUCTION_SPECTRAL_EVALUATOR_2026-11-11.md',
 'moebius/PRODUCTION_SPECTRAL_EVALUATOR_REVIEW_2026-11-11.md',
 'F3F3B312E752278D1414F7D1742AC8276B8F9585B8DA66AE94ECB9056EB58A37',
 ['zero-sum/rs_panel_benchmark_20261111.py','zero-sum/rs_panel_benchmark_20261111.json','zero-sum/rs_cauchy_block_benchmark_20261111.py','zero-sum/rs_cauchy_block_benchmark_20261111.json','moebius/production_spectral_review_20261111.py','moebius/production_spectral_review_20261111.json','moebius/review_replay_rs_cauchy_block_benchmark_20261111.json','moebius/review_replay_rs_panel_benchmark_20261111.json']),
('c5','Conductor-five complete low rectangle pilot',
 'zero-sum/FAMILY_EVALUATOR_INTERFACE_2026-11-11.md',
 'moebius/FAMILY_EVALUATOR_REVIEW_2026-11-11.md',
 '27E7EA05F68E72126EE6F91A0C7BCC24BACE9758DA153813731BE2E806AF0F5C',
 ['zero-sum/c5_family_dft_certificate_20261111.py','zero-sum/c5_family_dft_certificate_20261111.json','moebius/c5_family_review_20261111.py','moebius/c5_family_review_20261111.json']),
('alpha','Conductor-101 Hurwitz alpha-grid materialization',
 'zero-sum/FAMILY_ALPHA_MATERIALIZATION_2026-11-11.md',
 'moebius/FAMILY_ALPHA_MATERIALIZATION_REVIEW_2026-11-11.md',
 '34567872FFA5DA524F265D09C6E597B4D3EEC68FBB4B568F4F5619A8D91D1D50',
 ['zero-sum/family_alpha_materialize_20261111.py','zero-sum/family_alpha_materialize_20261111.json','moebius/alpha_materialization_review_20261111.py','moebius/alpha_materialization_review_20261111.json']),
('provider','Genuine seven-eighths provider compatibility and reflection cut',
 'integration/PROVIDER_COMPATIBILITY_CUT_2026-11-11.md',
 'prime-estimates/REVIEW_PROVIDER_COMPATIBILITY_CUT_2026-11-11.md',
 '85AFD92D37CA273EF553399903F3133BFA030175CFF608A25E3DA1E146970167',[]),
('principal-route','Principal sign-plus-independent-count completeness design',
 'mellin/PRINCIPAL_COMPLETENESS_ROUTE_2026-11-11.md',
 'audit/PRINCIPAL_COMPLETENESS_ROUTE_REVIEW_2026-11-11.md',
 'FB268AD7ACE08954435194D51BF6FC3C358AE7838E8CCFAE7087B0E0F84EAA11',
 ['mellin/principal_completeness_sizes_20261111.py','audit/principal_completeness_sizes_review_20261111.log']),
]

packets=[]
for id,title,report,review,reviewhash,evidence in specs:
    assert digest(A/review)==reviewhash.lower(),review
    files=[]
    for role,src in [('report',report),('review',review)]+[('evidence',e) for e in evidence]:
        p=A/src
        dest=f'chapters/{id}-{role}.md' if role in ('report','review') else f'evidence/post131/{src}'
        files.append({'source':p.relative_to(ROOT).as_posix(),'path':dest,'role':role,'bytes':p.stat().st_size,'sha256':digest(p)})
    packets.append({'id':id,'title':title,'status':'accepted research evidence; no new Lean proof','files':files})

catalog={'kind':'coordinator-selected research evidence, not proof validation',
 'package_stage':'draft staging; not frozen or independently reviewed as a synthesis',
 'frozen131_manifest_sha256':'eaa2fdf61fbb79477242314c3269146ffd45646da030df1d111a0360ed447035',
 'accepted_packets':packets,
 'pending_slots':[
  {'id':'sign1500','title':'1070-sample principal sign certificate through1500','status':'awaiting coordinator final review pins; not accepted in this synthesis'},
  {'id':'topcount1e6','title':'Principal top horizontal count at one million','status':'awaiting coordinator final review pins; not accepted in this synthesis'},
  {'id':'c101-combined','title':'Combined conductor101 alpha/Cauchy character block','status':'awaiting coordinator final review pins; not accepted in this synthesis'}]}
path=HERE/'catalog.json'
assert not path.exists(), 'Catalog already exists; revise explicit pins, do not auto-refresh frozen inputs.'
path.write_text(json.dumps(catalog,indent=2)+'\n',encoding='utf8')
print(json.dumps({'accepted_packets':len(packets),'new_source_copies':sum(len(p['files']) for p in packets),'pending_slots':len(catalog['pending_slots'])}))
