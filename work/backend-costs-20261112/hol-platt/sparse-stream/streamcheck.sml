structure streamcheck = struct
open HolKernel Parse boolLib bossLib cv_transLib meter;
fun require b msg=if b then () else raise Fail msg;
fun nvar s=mk_var(s,``:num``);
fun nlist xs=listSyntax.mk_list(xs,``:num``);
val predicate=``StreamRaw$raw_tile``;
fun template count =
  let val fixed=map nvar ["l","i","m","w","p","n"]
      val ws=List.tabulate(count,fn i=>nvar("v"^Int.toString i))
      val generic=list_mk_comb(predicate,fixed@[nlist ws])
      val schema=UNDISCH_ALL(REWRITE_RULE[cv_repTheory.cv_rep_def](cv_repLib.cv_rep_for [] generic))
      val base=List.foldl(fn(h,z)=>PROVE_HYP(prove(h,SIMP_TAC(srw_ss())[])) z)schema(hyp schema)
      val step=cv_computeLib.cv_compute(cv_eqs_for(rhs(concl base)))
      val inv=REWRITE_RULE[cv_typeTheory.from_to_def] cv_typeTheory.from_to_bool
      val from_to=PURE_REWRITE_RULE[inv] o AP_TERM ``cv$c2b``
  in fn args => fn exp =>
    let val f=INST(ListPair.map(fn(v,a)=>v |-> a)(fixed@ws,args))base
        val res=CONV_RULE(RAND_CONV step) f
        val ans=if exp then cv_primTheory.cv_rep_T else cv_primTheory.cv_rep_F
        val eq=from_to(TRANS res(SYM ans))
        val th=if exp then EQT_ELIM eq else EQF_ELIM eq
        val _=require(closed th)"unclosed raw sign tile"
    in th end
  end;

fun run()=
  let val start=cpu()
      val templates=Vector.tabulate(17,template)
      val setup=cpu()-start
      val ins=TextIO.openIn "stream.txt"
      val checked=ref 0 and controls=ref 0 and inputs=ref 0
      val parseT=ref 0.0 and checkT=ref 0.0 and keepT=ref 0.0
      val archiveT=ref 0.0 and reloadT=ref 0.0
      val batch=ref ([]:(string*thm)list)
      val folder="tiles"
      val _=if OS.FileSys.isDir folder handle OS.SysErr _=>false then () else OS.FileSys.mkDir folder
      fun saveBatch()=
        let val t=cpu()
            val group=map(fn(n,th)=>(n,save_thm(n,th)))(rev(!batch))
            val path=folder^"/ending-"^Int.toString(!checked)^".thms"
            val _=DiskThms.write_file path group
            val u=cpu()
            val read=DiskThms.read_file path
            val _=ListPair.appEq(fn((n,th),(m,r))=>
                require(n=m andalso closed r andalso aconv(concl th)(concl r))"persisted raw tile") (group,read)
            val _=List.app(fn(n,_)=>Theory.delete_binding n)group
        in batch:=[]; archiveT:= !archiveT+u-t; reloadT:= !reloadT+cpu()-u end
      fun hex s=numSyntax.mk_numeral(Arbnum.fromHexString s)
      fun asint s=valOf(Int.fromString s)
      fun big s=valOf(IntInf.fromString s)
      fun step() =
        case TextIO.inputLine ins of NONE=>() | SOME line=>
        let val begin=cpu()
            val (lab::i::m::w::p::n::values)=String.tokens Char.isSpace line
            val tile=asint i
            val _=require(lab=List.nth(["3","6667","11","9091"],!checked div 1331)
                         andalso tile= !checked mod 1331)"sample order"
            val fields=map nat [lab,i,m,w,p,n]
            val raw=map hex values
            val eval=Vector.sub(templates,length raw)
            val t=cpu()
            val th=eval(fields@raw) true
            val u=cpu()
            val _=require(aconv(concl th)(list_mk_comb(predicate,fields@[nlist raw])))"raw statement"
            val _=if !controls= !checked div 1331 andalso big w>0 then
               let val wrong=IntInf.toString(IntInf.xorb(big p,IntInf.andb(big w,~(big w))))
                   val failed=eval(map nat[lab,i,m,w,wrong,n]@raw) false
                   val _=save_thm("accept_tile_"^lab,th)
                   val _=save_thm("wrong_sign_rejected_"^lab,failed)
               in controls:= !controls+1 end else ()
            val _=checked:= !checked+1
            val _=inputs:= !inputs+asint n
            val _=parseT:= !parseT+t-begin
            val _=checkT:= !checkT+u-t
            val _=keepT:= !keepT+cpu()-u
            val _=batch:=("raw_tile_"^lab^"_"^i,th):: !batch
            val _=if !checked mod 16=0 orelse !checked=5324 then saveBatch() else ()
            val _=if tile=1330 then print("STREAM_LABEL "^lab^" "^Real.toString(cpu()-start)^"\n") else ()
        in step() end
      val _=step()
      val _=TextIO.closeIn ins
      val _=require(!checked=5324 andalso !controls=4 andalso !inputs=71325)"coverage"
      val _=print("STREAM_CPU "^String.concatWith " " (map Real.toString[setup,!parseT,!checkT,!keepT,!archiveT,!reloadT,cpu()-start])^"\n")
      val _=print "SPARSE_RAW_STREAM_DONE\n"
  in () end;
end;
