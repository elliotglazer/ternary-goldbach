open HolKernel Parse boolLib bossLib H1FiniteHeadsTheory H1RawCvTheory
     SourceRawHeadBridgeTheory SourceRawHeadBoundsTheory C10004FullIntegerTheory C10004PhaseDataTheory;
fun require ok msg=if ok then () else raise Fail msg;
val std=["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val axs=List.concat(map (fn thy => map (fn (n,_) => thy^"."^n) (DB.axioms thy))
  ("H1FiniteHeads"::Theory.ancestry "H1FiniteHeads"));
val _=require (List.all (fn a=>List.exists (fn v=>a=v) std) axs) "unexpected context axiom";
fun audit (name,th,expected) =
 let val (oracle,ax)=Tag.dest_tag(tag th)
 in require(aconv (concl th) expected) (name^" wrong conclusion");
    require(null(hyp th) andalso null ax andalso List.all (fn a=>a="DISK_THM") oracle) (name^" hypotheses or oracle");
    print("HEAD_MATCH_ROOT,"^name^","^thm_to_string th^"\n") end;
val _=audit("h1_archive_rows",h1_archive_rows,
 ``LENGTH (full_heads h1_archive_blocks) = 4800 /\
     !i. i<4800 ==> 0<full_residue i /\
     EL i (full_heads h1_archive_blocks) = raw_head 10004 (srh_state 10004 1) (srh_state (full_residue i) 1)``);
val _=audit("h1_archive_analytic",h1_archive_analytic,
 ``!i:num. i<4800 ==> modu
    (source_pair_value (2**100) (EL i (full_heads h1_archive_blocks)) -
     complex_exp ((~(1/2),~(5/64))*complex_of_real (ln ((&(full_residue i):real)/10004)))) < 1/(2:real) pow 85``);
val blocks=rhs(concl h1_archive_blocks_def);
val (nums,_)=listSyntax.dest_list blocks;
val _=require(length nums=300) "wrong number of packed blocks";
fun compare_consumer (thy,name,hash,constant) =
 let val dat=TheoryReader.load_thydata {thyname=thy,hash=hash,path="../../c10004-full-integer/"^thy^"Theory.dat"}
     val th= #1(valOf(Symtab.lookup dat name))
     val (head,args)=strip_comb(lhs(concl th))
     val _=require (aconv head constant andalso aconv (rhs(concl th)) boolSyntax.T) "unexpected consumer form"
     val _=require (aconv (List.nth(args,2)) blocks) "consumer used different packed heads"
 in print("HEAD_MATCH_CONSUMER,"^thy^"."^name^"\n") end;
val _=compare_consumer("C10004FullAdmission","full_admit","e23808a7f0d1f82befad835d907192fdcc7e8caf",``full_checked``);
val _=compare_consumer("C10004FullIdentity","full_identity","049928470ddc75374b8af0eb3fb7a2a3a5c1ee7c",``C10004FullInteger$full_identity``);

(* Independently read the source TSV and check all signs, order, CRT residues,
   and packing against the actual terms recovered from the exported theorem. *)
val stream=TextIO.openIn "../../c10004-p20-source/h1-rawhead.tsv";
val _=require(String.tokens Char.isSpace (valOf(TextIO.inputLine stream))=["index","a","re","im"]) "wrong TSV header";
val bias=IntInf.pow(2,111) and radix=IntInf.pow(2,112);
fun integer s=valOf(IntInf.fromString(String.translate(fn #"-"=>"~" | c=>String.str c) s));
fun expmod b n m=if n=0 then 1 else (b*expmod b (n-1) m) mod m;
fun residue i=(2501*(1+2*(i mod 2))+4880*expmod 6 ((i div 2) mod 40) 41+2624*expmod 2 (i div 80) 61) mod 10004;
fun read_one (j,acc) = case String.tokens Char.isSpace (valOf(TextIO.inputLine stream)) of
 [si,sa,sr,st] =>
    let val _=require(valOf(Int.fromString si)=j andalso valOf(Int.fromString sa)=residue j) "TSV order/residue"
        val r=integer sr+bias and t=integer st+bias
        val _=require(0<=r andalso r<radix andalso 0<=t andalso t<radix) "TSV signed range"
    in acc + (r+radix*t)*IntInf.pow(radix*radix,j mod 16) end
 | _=>raise Fail "bad TSV row";
val _=List.app (fn (block,tm)=>
 let val packed=List.foldl read_one (0:IntInf.int) (List.tabulate(16,fn k=>block*16+k))
 in require (Arbnum.toString(numSyntax.dest_numeral tm)=IntInf.toString packed) "TSV and HOL payload differ" end)
 (ListPair.zip(List.tabulate(length nums,fn k=>k),nums));
val _=require (not(Option.isSome(TextIO.inputLine stream))) "extra TSV rows";
val _=TextIO.closeIn stream;
val _=print("HEAD_MATCH_TSV,4800,300\nHEAD_MATCH_AXIOMS,"^String.concatWith ";" axs^"\n");
val _=print "HEAD_MATCH_AUDIT_DONE\n";
