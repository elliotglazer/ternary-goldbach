"""Text-only preparation of the matched driver. No arithmetic evaluation."""
from pathlib import Path
import hashlib, json, re
home=Path(__file__).resolve().parent
root=home.parents[2]
prepared=root/'hol-platt/prepared-eval/prepared_dependent.sml'
original=root/'hol4-setup/dependent.sml'
adapter=root/'hol-platt/prepared-eval/PreparedEval.sml'
expected={prepared:'50077F647A0BC91B892FC6DBB3ABAC95D4B0B5084872A8BAAC2C0D6E35EDEEA4',original:'ECB62C8C7B1F1AAAA8DF9617DAF4145D7FCADBEEDD9CF8579D3F57962C5E1AB1',adapter:'13A8941A49FA2CB238370008B10D13FC106C42B95353E18EB145683776D27807'}
for path,pin in expected.items():
    assert hashlib.sha256(path.read_bytes()).hexdigest().upper()==pin,(path,'pin')
s=prepared.read_text()
def replace_once(a,b):
    global s
    assert s.count(a)==1,(a,s.count(a))
    s=s.replace(a,b)
replace_once('StageCheckTheory DependentBlockTheory cv_transLib;','StageCheckTheory DependentBlockTheory RoundDependentTheory cv_transLib;')
s=s.replace('PreparedDependentResults','RoundDependentResults')
replace_once('("DependentBlock" :: Theory.ancestry "DependentBlock")','("RoundDependent" :: Theory.ancestry "RoundDependent")')
replace_once('val mode = case', '''val implementation = case OS.Process.getEnv "ROUND_IMPL" of
  SOME s => s | NONE => raise Fail "ROUND_IMPL required";
val _ = require (List.exists (fn s => s = implementation) ["old","one"])
                "bad ROUND_IMPL";
val _ = print ("ROUND_IMPL," ^ implementation ^ "\\n");
val accept_constant = if implementation = "old" then ``block_accept``
                      else ``round_block_accept``;
val mode = case''')
replace_once('val _ = preconditions := [positive_scale,\n  GEN_ALL (MATCH_MP block_accept_pre_ok positive_scale)];','''val _ = preconditions := positive_scale ::
  (if implementation = "old" then
     [GEN_ALL (MATCH_MP block_accept_pre_ok positive_scale)]
   else []);
(* The new CV path is total; no vacuous replacement predicate is introduced. *)
(* This transport is outside evaluation timing. The final theorem has the
   original block_contract, bound and checksum, for either implementation. *)
fun derive_original checked =
  let val accepted = SIMP_RULE bool_ss
        [positive_scale,round_block_accept_correct] (EQT_ELIM checked)
      val _ = require (aconv (#1 (strip_comb (concl accepted))) ``block_accept``)
                      "transport did not reach original acceptance"
  in MATCH_MP block_accept_sound accepted end;''')
replace_once('(``block_accept``,[scale,coeff,numSyntax.term_of_int n,input,int_term bound,int_term expected]);','(accept_constant,[scale,coeff,numSyntax.term_of_int n,input,int_term bound,int_term expected]);')
for depth in (1,8,32,128):
    replace_once(f'MATCH_MP block_accept_sound (EQT_ELIM checked_{depth}_0)',f'derive_original checked_{depth}_0')
replace_once('HOL4_PREPARED_DEPENDENT_BENCHMARK_DONE','HOL4_ROUND_DEPENDENT_BENCHMARK_DONE')
# This checks the ordered entire decimal-string sequence, including controls.
nums=lambda t: re.findall(r'"~?[0-9]+"',t)
assert nums(s)==nums(original.read_text())
assert len(re.findall(r'val fixture_(?:1|8|32|128) =',s))==4
assert len(re.findall(r'check_false "(?:checksum|bound|depth|input|coefficient)"',s))==5
out=home/'round_dependent.sml'
with out.open('x',encoding='utf-8',newline='\n') as f: f.write(s)
binding={'status':'source only; no HOL execution','inputs':{str(p.relative_to(root)):v for p,v in expected.items()},'decimal_string_count':len(nums(s)),'decimal_string_sequence_sha256':hashlib.sha256('\n'.join(nums(s)).encode()).hexdigest().upper(),'output_sha256':hashlib.sha256(out.read_bytes()).hexdigest().upper(),'depths':[1,8,32,128],'controls':['checksum','bound','depth','input','coefficient'],'implementations':['old','one'],'default_modes':['stock','retained'],'optional_mode':'fresh','fixture_arithmetic_evaluated':False}
binding['local_sources']={str(path.relative_to(home.parent)):hashlib.sha256(path.read_bytes()).hexdigest().upper() for path in [home.parent/'RoundSpecializationScript.sml',home.parent/'RoundSpecializationCVScript.sml',home/'RoundDependentScript.sml',home/'prepare_driver.py']}
binding['translation_preconditions']={'old':'positive scale closes original block_accept_pre','one':'scalar helper unconditional; generated layer/run preconditions proved universally with cv_pre; acceptance translated without residual precondition; mathematical positivity retained'}
with (home/'source_binding.json').open('x',encoding='utf-8',newline='\n') as f: json.dump(binding,f,indent=2);f.write('\n')
print(json.dumps(binding,indent=2))
