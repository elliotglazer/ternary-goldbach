Theory ChannelInvariant
Ancestors RetainedTransfer SparseHeadLink HeadPairEven StreamRaw
Libs replay intLib
Definition scatter_def:
 (scatter [] xs t = t) /\
 (scatter (i::is) [] t = t) /\
 (scatter (i::is) (v::vs) t = scatter is vs (sptree$insert i v t))
End
Definition raw_map_def:
 (raw_map [] tab=tab) /\
 (raw_map ((i,m,(w:num),(p:num),n,ws)::rs) tab =
  raw_map rs (scatter (SparseHeadLink$slots 64 (64*i) m)
       (TAKE n (FLAT (MAP StreamRaw$four_raw ws))) tab))
End
Definition matches_def:
 (matches rt [] <=> T) /\
 (matches rt ((i,p)::xs) <=>
   (case sptree$lookup i rt of NONE => F | SOME v => Enclosure$encloses v p) /\ matches rt xs)
End
Definition channel_ok_def:
 channel_ok (d:((num#num#num#num)list # (num#num)list # num # (num#num)list # num # (num#num)list # num # num)) rs <=>
 case SparseHead$load_grid (FST d) 0 sptree$LN of NONE=>F | SOME tab =>
 matches (raw_map rs sptree$LN) (sptree$toAList tab)
End
Definition source_code_def:
 source_code rs i = THE (sptree$lookup i (raw_map rs sptree$LN))
End
Theorem matches_mem:
 !xs rt i p. matches rt xs /\ MEM (i,p) xs ==>
 ?v. sptree$lookup i rt=SOME v /\ Enclosure$encloses v p
Proof
 Induct >- simp[matches_def] >>
 Cases_on `h` >> rpt gen_tac >> Cases_on `sptree$lookup q rt` >>
 simp[matches_def] >> metis_tac[]
QED
Theorem channel_enclosures:
 !d rs. channel_ok d rs ==>
 ?tab. SparseHead$load_grid (FST d) 0 sptree$LN = SOME tab /\
 !i p. sptree$lookup i tab=SOME p ==> Enclosure$encloses (source_code rs i) p
Proof
 rpt gen_tac >> simp[channel_ok_def] >>
 Cases_on `SparseHead$load_grid (FST d) 0 sptree$LN` >> simp[] >>
 rpt strip_tac >> drule matches_mem >> simp[sptreeTheory.MEM_toAList,source_code_def] >>
 metis_tac[optionTheory.THE_DEF]
QED
Theorem retained_from_bounds:
 !d rs vs. channel_ok d rs /\
 (!i v. sptree$lookup i (raw_map rs sptree$LN)=SOME v ==>
    abs(vs i-real_of_int(WindowPerturbation$raw_center v))<=2) ==>
 ?tab. SparseHead$load_grid (FST d) 0 sptree$LN = SOME tab /\
 RetainedTransfer$retained tab (source_code rs) vs
Proof
 rpt gen_tac >> simp[channel_ok_def] >>
 Cases_on `SparseHead$load_grid (FST d) 0 sptree$LN` >> simp[] >>
 rpt strip_tac >> simp[RetainedTransferTheory.retained_def] >> rpt strip_tac >>
 `?v. sptree$lookup i (raw_map rs sptree$LN)=SOME v /\ Enclosure$encloses v p`
 by metis_tac[matches_mem,sptreeTheory.MEM_toAList] >>
 simp[source_code_def] >> metis_tac[]
QED
val _=cv_transLib.cv_auto_trans channel_ok_def;
open HolKernel Parse boolLib bossLib meter;
val t0=cpu();
fun require p s=if p then () else raise Fail s;
val wanted=1331;
fun group g =
 let val name="../sparse-stream/tiles/ending-"^Int.toString(16*(g+1))^".thms"
     val ths=DiskThms.read_file name
     fun row(j,(key,th))=
       let val i=16*g+j
       in if i>=wanted then NONE else
        let val (pred,args)=strip_comb(concl th)
            val [l,idx,m,w,p,n,ws]=args
            val _=require(key="raw_tile_3_"^Int.toString i andalso closed th andalso aconv pred ``StreamRaw$raw_tile`` andalso aconv l (nat "3") andalso aconv idx (nat(Int.toString i))) "archive key"
        in SOME(replay.tuple[idx,m,w,p,n,ws]) end end
 in if g mod 8=0 then print("READ_GROUP "^Int.toString g^"\n") else (); List.mapPartial row (ListPair.zip(List.tabulate(length ths,fn i=>i),ths)) end;
val cells=List.concat(List.tabulate((wanted+15) div 16,group));
val _=require(length cells=wanted)"archive prefix";
val td=cpu(); val _=print "ARCHIVED_INPUTS\n";
val source=replay.named "source_3" (listSyntax.mk_list(cells,type_of(hd cells)));
val _=print "SOURCE_DEFINED\n"; val dataenc=replay.literal HeadPairEvenTheory.raw_3_def;
val t1=cpu(); val _=print "DATA_ENCODED\n";
val sty=type_of(hd cells);
val lty=listSyntax.mk_list_type sty;
val lc=replay.enc_for lty;
val ec=replay.enc_for sty;
fun var s=mk_var(s,``:num``);
fun schema n=
 let val ms=map var ["ii","mm","ww","pp","nn"]
     val vs=List.tabulate(n,fn i=>var("raw"^Int.toString i))
     val pattern=replay.tuple(ms@[listSyntax.mk_list(vs,``:num``)])
 in (ms@vs,EVAL(mk_comb(ec,pattern))) end;
val schemes=Vector.tabulate(17,schema);
val hv=mk_var("row",sty); val tv=mk_var("tail",lty);
val consschema=PURE_REWRITE_CONV [cv_typeTheory.from_list_def] (mk_comb(lc,listSyntax.mk_cons(hv,tv)));
fun encrow cell=
 let val args=pairSyntax.strip_pair cell
     val (ws,_)=listSyntax.dest_list(List.last args)
     val (vs,eq)=Vector.sub(schemes,length ws)
 in INST(ListPair.map(fn(v,x)=>v |-> x)(vs,List.take(args,5)@ws))eq end;
fun consencode (h,(tail,tailth))=
 let val th=INST[hv |-> h,tv |-> tail] consschema
     val eh=encrow h
     val step=MK_COMB(AP_TERM ``cv$Pair`` eh,tailth)
 in (listSyntax.mk_cons(h,tail),TRANS th step) end;
val nils=listSyntax.mk_list([],sty);
val (_,rawenc)=List.foldr consencode(nils,EVAL(mk_comb(lc,nils)))cells;
val renc=TRANS(AP_TERM lc source)rawenc;
val t2=cpu(); val _=print "RAW_ENCODED\n";
val actual=replay.joined ``channel_ok`` [dataenc,renc];
val _=save_thm("channel_3_ok",actual);
val _=save_thm("channel_3_all_lookups",MATCH_MP channel_enclosures actual);
val inst=SPEC_ALL retained_from_bounds;
val specialize=Q.SPECL [`HeadPairEven$raw_3`,`source_3`,`vs`] retained_from_bounds;
val _=save_thm("channel_3_retained",SIMP_RULE (srw_ss()) [actual] specialize);
val _=print("CHANNEL_INVARIANT "^String.concatWith " " (map Real.toString[td-t0,t1-td,t2-t1,cpu()-t2,cpu()-t0])^"\n");






