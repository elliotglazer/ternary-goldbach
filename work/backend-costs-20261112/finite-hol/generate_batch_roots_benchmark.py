"""Batch root membership; preserve the exact root list and interval theorem."""
from pathlib import Path
H=Path(__file__).resolve().parent
source=(H/'batchcoverbench.sml').read_text()
source=source.replace('BatchPrimeTheory BatchData','BatchPrimeTheory BatchRootsTheory BatchData')
source=source.replace('new_theory "BatchCoverResults"','new_theory "BatchRootsCoverResults"')
source=source.replace('("BatchPrime" :: Theory.ancestry "BatchPrime")',
                      '("BatchPrime" :: "BatchRoots" :: Theory.ancestry "BatchPrime" @ Theory.ancestry "BatchRoots")')
start=source.index('val _=timed "root_claims"')
end=source.index('val serial = ref 0;',start)
replacement='''val roots_serial=ref 0;
val root_definitions=ref ([]:thm list);
fun define_roots ps =
  let val rhs=if length ps <= 32 then listSyntax.mk_list(map numeral ps,numSyntax.num)
      else let val middle=length ps div 2
               val left=define_roots(List.take(ps,middle))
               val right=define_roots(List.drop(ps,middle))
           in ``^left ++ ^right`` end
      val id= !roots_serial val _=roots_serial:=id+1
      val name="requested_roots_"^Int.toString id
      val def=new_definition(name^"_def",mk_eq(mk_var(name,type_of rhs),rhs))
      val _=cv_transLib.cv_trans def
      val _=root_definitions:=def:: !root_definitions
  in lhs(concl def) end;
val roots=timed "root_translation" (fn()=>define_roots all_roots);
val roots_th=timed "root_claims" (fn()=>
  let val member=EQT_ELIM(cv_transLib.cv_eval ``roots_known ^tree ^roots``)
  in MATCH_MP roots_known_sound (CONJ named_tree_proof member) end);
val _=audit ``EVERY prime ^roots`` roots_th;
val _=save_thm("all_requested_roots_prime",roots_th);
(* Projection uses ordinary kernel inference, without rerunning membership. *)
val _=timed "root_projection" (fn()=>
  let val raw=REWRITE_RULE (!root_definitions @ [listTheory.APPEND]) roots_th
      fun project [] th = require(aconv(concl th) ``EVERY prime ([]:num list)``) "wrong root tail"
        | project (p::ps) th =
          let val split=CONV_RULE (REWR_CONV (CONJUNCT2 listTheory.EVERY_DEF)) th
              val head=CONJUNCT1 split val tail=CONJUNCT2 split
          in audit (prime_term p) head;ignore(save_thm("prime_"^p,head));
             print("HOL4_BATCH_ROOT,"^p^"\\n");project ps tail end
  in project all_roots raw end);
'''
source=source[:start]+replacement+source[end:]
(H/'batchrootscoverbench.sml').write_text(source,encoding='utf-8',newline='\n')
print('Generated batched root membership and individual theorem projections.')
