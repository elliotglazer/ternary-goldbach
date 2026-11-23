structure fusedworker=struct
open HolKernel Parse boolLib bossLib meter FusedCountTheory;
fun enc term=EVAL(mk_comb(replay.enc_for(type_of term),term));
fun record on lab data =
 let val start=cpu()
     val [[mb,ab,ea,eb,k,w,a,b]]=replay.lines (map nat) ("target-"^lab^".txt")
     val (word,ew)=if on then
       let val nums=replay.lines(fn [s]=>numSyntax.mk_numeral(Arbnum.fromHexString s) | _=>raise Fail "raw word") ("rawpacked-"^lab^".hex")
           val lit=optionSyntax.mk_some(listSyntax.mk_list(nums,``:num``))
           val named=replay.named ("raw_words_"^lab) lit
       in (lhs(concl named),replay.literal named) end
       else let val n=``NONE:num list option`` in (n,enc n) end
     val rawtime=cpu()-start
     val result=pairSyntax.mk_pair(pairSyntax.mk_pair(k,w),pairSyntax.mk_pair(a,b))
     val d=replay.literal data
     val ready=cpu()
     val proof=replay.joined ``outcome`` [ew,JoinTablesTheory.tables_encoded,d,enc result]
     val _=save_thm("outcome_"^lab,proof)
     val plain=MATCH_MP implies_observation proof
     val _=print("FUSED_CHANNEL "^lab^" "^String.concatWith " " (map Real.toString [rawtime,ready-start,cpu()-start])^"\n")
 in (lhs(concl data),plain) end;
fun pp tag (l,leq) (r,req)=
 let val start=cpu()
     val [[h,phase,allow]]=replay.lines(map nat)("pair-"^tag^".txt")
     val tab=rand(lhs(concl JoinTablesTheory.tables_encoded))
     val goal=list_mk_comb(``SparseHead$pair_from_heads``,[tab,h,phase,allow,l,r])
     val eq=SIMP_CONV(srw_ss())[SparseHeadTheory.pair_from_heads_def, JoinTablesTheory.tables_valid,leq,req]goal
     val th=EQT_ELIM(TRANS eq(EVAL(rhs(concl eq))))
     val _=if closed th then ignore(save_thm("pair_"^tag,th)) else raise Fail "pair"
 in print("FUSED_PAIR "^tag^" "^Real.toString(cpu()-start)^"\n") end;
fun run on=let val st=cpu() in pp "even" (record on "3" HeadPairEvenTheory.raw_3_def) (record on "6667" HeadPairEvenTheory.raw_6667_def);
 pp "odd" (record on "11" HeadPairOddTheory.raw_11_def) (record on "9091" HeadPairOddTheory.raw_9091_def);
 print("FUSED_WORKER "^Real.toString(cpu()-st)^"\n") end;
end;
