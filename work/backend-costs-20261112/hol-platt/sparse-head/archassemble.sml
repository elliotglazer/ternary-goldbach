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
        in SOME(replay.tuple[idx,m,w,p,n,ws],th) end end
 in List.mapPartial row (ListPair.zip(List.tabulate(length ths,fn i=>i),ths)) end;
val cells=List.concat(List.tabulate((wanted+15) div 16,group));
val _=require(length cells=wanted)"archive prefix";
val td=cpu();
val source=replay.named "source_3" (listSyntax.mk_list(map #1 cells,type_of(#1(hd cells))));
val dataenc=replay.literal HeadPairEvenTheory.raw_3_def;
val t1=cpu();
val renc=replay.literal source;
val t2=cpu();
val actual=replay.joined ``channel_ok`` [dataenc,renc];
val _=save_thm("channel_3_ok",actual);
val _=save_thm("channel_3_all_lookups",MATCH_MP channel_enclosures actual);
val inst=SPEC_ALL retained_from_bounds;
val specialize=Q.SPECL [`HeadPairEven$raw_3`,`source_3`,`vs`] retained_from_bounds;
val _=save_thm("channel_3_retained",SIMP_RULE (srw_ss()) [actual] specialize);
val _=print("CHANNEL_INVARIANT "^String.concatWith " " (map Real.toString[td-t0,t1-td,t2-t1,cpu()-t2,cpu()-t0])^"\n");
