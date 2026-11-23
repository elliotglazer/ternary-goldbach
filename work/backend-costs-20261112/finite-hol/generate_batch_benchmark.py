"""Retain the baseline interval/coverage protocol and replace primality input."""
from pathlib import Path
H=Path(__file__).resolve().parent
source=(H/'coverbench_balanced.sml').read_text()
source=source.replace('FiniteCoverTheory PrimeData CoverData','FiniteCoverTheory BatchPrimeTheory BatchData CoverData')
source=source.replace('new_theory "FiniteCoverResults"','new_theory "BatchCoverResults"')
source=source.replace('("FiniteCover" :: Theory.ancestry "FiniteCover")','("BatchPrime" :: Theory.ancestry "BatchPrime")')
start=source.index('val prime_results =')
end=source.index('val serial = ref 0;',start)
replacement='''val cert_serial=ref 0;
val root_definition=ref TRUTH;
fun raw_certificate_tree [] = ``CEmpty``
  | raw_certificate_tree cs =
    let val middle=length cs div 2
        val (p,a,fs)=List.nth(cs,middle)
        val left=raw_certificate_tree(List.take(cs,middle))
        val right=raw_certificate_tree(List.drop(cs,middle+1))
        val pt=numeral p val at=numeral a
        val ft=listSyntax.mk_list(map numeral fs,numSyntax.num)
    in ``CNode ^left ^pt ^at ^ft ^right`` end;
fun define_certificates cs =
  let val rhs=if length cs <= 31 then raw_certificate_tree cs
      else let val middle=length cs div 2
               val (p,a,fs)=List.nth(cs,middle)
               val left=define_certificates(List.take(cs,middle))
               val right=define_certificates(List.drop(cs,middle+1))
               val pt=numeral p val at=numeral a
               val ft=listSyntax.mk_list(map numeral fs,numSyntax.num)
           in ``CNode ^left ^pt ^at ^ft ^right`` end
      val id= !cert_serial val _=cert_serial:=id+1
      val name="certificates_"^Int.toString id
      val def=new_definition(name^"_def",mk_eq(mk_var(name,type_of rhs),rhs))
      val _=cv_transLib.cv_trans def
      val _=root_definition:=def
  in lhs(concl def) end;
val _=require(length certificates=1537 andalso length all_roots=393) "wrong fixture sizes";
val certs=timed "certificate_translation" (fn()=>define_certificates certificates);
val valid=timed "batch_primality" (fn()=>EQT_ELIM(cv_transLib.cv_eval ``tree_valid ^certs ^certs``));
val _=audit ``tree_valid ^certs ^certs`` valid;
val (tree,named_tree_proof) = timed "prime_tree" (fn()=>
  let val raw=``prime_values ^certs``
      val def=new_definition("cert_tree_def",mk_eq(mk_var("cert_tree",type_of raw),raw))
      val _=cv_transLib.cv_trans def
      val th=REWRITE_RULE[GSYM def](MATCH_MP batch_prime_sound valid)
  in (lhs(concl def),th) end);
val _=audit ``tree_primes ^tree`` named_tree_proof;
val _=save_thm("cert_tree_primes",named_tree_proof);
val _=timed "root_claims" (fn()=>List.app(fn p=>
  let val pt=numeral p
      val member=EQT_ELIM(cv_transLib.cv_eval ``tree_contains ^pt ^tree``)
      val th=MATCH_MP tree_contains_prime (CONJ named_tree_proof member)
  in audit (prime_term p) th; ignore(save_thm("prime_"^p,th));
     print("HOL4_BATCH_ROOT,"^p^"\\n") end) all_roots);
'''
source=source[:start]+replacement+source[end:]
source=source.replace('(cv_transLib.cv_trans tree_def;define_witnesses witnesses)','define_witnesses witnesses')
insert=source.index('val _=timed "export"')
controls='''val (_,root_args)=strip_comb(rhs(concl(!root_definition)));
val _=require(length root_args=5) "unexpected certificate root definition";
val [left,p,a,fs,right]=root_args;
fun reject_tree label t = reject label ``tree_valid ^t ^t``;
val _=reject_tree "certificate_bad_base" ``CNode ^left ^p 1 ^fs ^right``;
val _=reject_tree "certificate_wrong_product" ``CNode ^left ^p ^a (0::^fs) ^right``;
val _=reject_tree "certificate_missing_factor" ``CNode CEmpty ^p ^a ^fs ^right``;
val _=reject_tree "certificate_self_reference" ``CNode ^left ^p ^a (^p::^fs) ^right``;
val _=reject_tree "certificate_composite" ``CNode (CNode CEmpty 2 0 [] CEmpty) 9 2 [2;2;2] CEmpty``;
'''
source=source[:insert]+controls+source[insert:]
source=source.replace('HOL4_FINITE_COVER_BENCHMARK_DONE','HOL4_BATCH_COVER_BENCHMARK_DONE')
(H/'batchcoverbench.sml').write_text(source,encoding='utf-8',newline='\n')
print('Generated the full batch-prime and interval benchmark.')
