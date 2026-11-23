Theory SparseAllRepairs
Ancestors HeadPairEven HeadPairOdd RepairPerturbation JoinTables
Libs replay intLib
Definition checked_job_def:
 checked_job tab ks (t,k,code,raw,ps) <=>
 case sptree$lookup k ks of NONE => F | SOME(r,off,den,err,ws) =>
 LENGTH ws = LENGTH ps /\ WindowPerturbation$reads tab (129+t DIV 4096-r DIV 2) ps /\
 LIST_REL Enclosure$encloses raw ps /\ GridSigns$at_repair tab ks t k=code /\
 (let v=StencilReceipt$dot ws (MAP WindowPerturbation$raw_center raw) in
   if code=2 then &(den*err)<v else code=1 /\ v < -&(den*err))
End
Definition jobs_ok_def:
 (jobs_ok tab ks [] [] <=> T) /\
 (jobs_ok tab ks [] (h::xs) <=> F) /\
 (jobs_ok tab ks (h::xs) [] <=> F) /\
 (jobs_ok tab ks ((t,k)::jobs) ((t',k',c,raw,ps)::rest) <=>
    t=t' /\ k=k' /\ checked_job tab ks (t,k,c,raw,ps) /\ jobs_ok tab ks jobs rest)
End
Definition all_ok_def:
 all_ok (data:((num#num#num#num)list # (num#num)list # num # (num#num)list # num # (num#num)list # num # num)) kernels records <=>
 case SparseHead$load_grid (FST data) 0 sptree$LN of NONE => F | SOME tab =>
 jobs_ok tab (sptree$fromList kernels) (FST (SND data)) records
End
val _=cv_transLib.cv_auto_trans all_ok_def;
open meter;
fun ir s = intSyntax.term_of_int(Arbint.fromString(if String.isPrefix "-" s then "~"^String.extract(s,1,NONE) else s));
fun window(t::k::c::r::xs)=let val n=valOf(Int.fromString r)
    val (raw,ps)=(List.take(xs,n),List.drop(xs,n))
    fun fields []=[] | fields(q::u::rest)=pairSyntax.mk_pair(ir q,nat u)::fields rest | fields _=raise Fail "field";
  in replay.tuple[nat t,nat k,nat c,listSyntax.mk_list(map nat raw,``:num``),listSyntax.mk_list(fields ps,``:int#num``)] end
  | window _=raise Fail "record";
fun certify lab th = let val st=cpu()
    val xs=replay.lines window ("windows-"^lab^".txt")
    val def=replay.named ("witnesses_"^lab)(listSyntax.mk_list(xs,type_of(hd xs)))
    val enc=map replay.literal [th,def]
    val ready=cpu()
    val proof=replay.joined ``all_ok`` [hd enc,JoinTablesTheory.tables_encoded,List.last enc]
    val _=if closed proof then ignore(save_thm("all_repair_margins_"^lab,proof)) else raise Fail "tag"
    val _=print("ALL_REPAIR "^lab^" "^Int.toString(length xs)^" "^Real.toString(ready-st)^" "^Real.toString(cpu()-st)^"\n")
 in () end;
val _=List.app(fn (s,t)=>certify s t) [("3",HeadPairEvenTheory.raw_3_def),("6667",HeadPairEvenTheory.raw_6667_def),("11",HeadPairOddTheory.raw_11_def),("9091",HeadPairOddTheory.raw_9091_def)];

