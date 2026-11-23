structure replay = struct
open HolKernel Parse boolLib bossLib meter;
open cv_transLib GridSignsTheory JoinTablesTheory CountReceiptTheory;
fun req b err=if b then () else raise Fail err;
fun tuple [a]=a | tuple(a::xs)=pairSyntax.mk_pair(a,tuple xs) | tuple []=raise Fail "empty tuple";
fun lines f path =
  let val ins=TextIO.openIn path
      fun go acc=case TextIO.inputLine ins of NONE=>(TextIO.closeIn ins;rev acc)
          | SOME s=>go(f(String.tokens Char.isSpace s)::acc)
  in go [] end;
fun enc_for ty=hd(#2(strip_comb(concl(cv_typeLib.from_to_thm_for ty))));
fun literal def =
  let val (a,v)=dest_eq(concl def)
      val enc=enc_for(type_of a)
  in TRANS(AP_TERM enc def)(EVAL(mk_comb(enc,v))) end;
fun named name a=new_definition(name^"_def",mk_eq(mk_var(name,type_of a),a));
fun tile (w::e::k::words) = tuple[nat w,nat e,nat k,listSyntax.mk_list(map nat words,``:num``)]
  | tile _=raise Fail "tile fields";
fun job [t,k,_,_,_,_,_]=pairSyntax.mk_pair(nat t,nat k)
  | job _=raise Fail "job fields";
(* Build the conversion with variables for the encoded inputs. This retains
   the native representation of a saved input even when the translator inlines
   or reorders arguments. All replacements are equality theorems. *)
fun joined constant encodings =
  let val args=map(rand o lhs o concl) encodings
      val vs=vars args
      val start=cpu()
      val schema=UNDISCH_ALL(REWRITE_RULE[cv_repTheory.cv_rep_def]
                             (cv_repLib.cv_rep_for [] (list_mk_comb(constant,vs))))
      val cvargs=List.tabulate(length args,fn j=>mk_var("input"^Int.toString j,``:cv``))
      val hyps=ListPair.map(fn(v,x)=>ASSUME(mk_eq(mk_comb(enc_for(type_of v),v),x)))(vs,cvargs)
      val skeleton=CONV_RULE(RAND_CONV(PURE_REWRITE_CONV hyps))schema
      val cvdo=cv_computeLib.cv_compute(cv_eqs_for(rhs(concl skeleton)))
      val concrete=INST(ListPair.map(fn(v,a)=>v |-> a)(vs,args)@
            ListPair.map(fn(v,h)=>v |-> rhs(concl h))(cvargs,encodings))skeleton
      val ready=List.foldl(fn(h,eq)=>PROVE_HYP h eq)concrete encodings
      val t=cpu()
      val raw=CONV_RULE(RAND_CONV cvdo)ready
      val u=cpu()
      val th=List.foldl(fn(a,z)=>PROVE_HYP(prove(a,SIMP_TAC(srw_ss())[])) z)raw(hyp raw)
      val truth=cv_primTheory.cv_rep_T
      val eq=TRANS th (SYM truth)
      val ft=cv_typeLib.from_to_thm_for ``:bool``
      val [_,dec]= #2(strip_comb(concl ft))
      val final=EQT_ELIM(PURE_REWRITE_RULE[REWRITE_RULE[cv_typeTheory.from_to_def]ft](AP_TERM dec eq))
      val _=req(closed final)"channel tag"
      val _=print("JOIN_EVAL "^String.concatWith " " (map Real.toString[t-start,u-t,cpu()-u])^"\n")
  in final end;
fun run label digits endcode =
  let val start=cpu()
      val tilelist=listSyntax.mk_list(lines tile ("tiles-"^label^".txt"),``:num#num#num#num list``)
      val joblist=listSyntax.mk_list(lines job ("jobs-"^label^".txt"),``:num#num``)
      val tiles=named ("tiles_"^label)tilelist
      val jobs=named ("jobs_"^label)joblist
      fun cnt suffix=DB.fetch "CountReceipt" ("runs_"^digits^suffix^"_def")
      val main=cnt "0" and aux=cnt "1"
      fun number s=let val v=nat s in EVAL(mk_comb(enc_for(type_of v),v)) end
      val t=cpu()
      val encoded=map literal[tiles,jobs]
      val u=cpu()
      val args=encoded@[JoinTablesTheory.tables_encoded]
      val [til,js,ks]=args
      val encs=[til,ks,js,number "519575974158994",literal main,literal aux,number "2",number endcode]
      val _=print("JOIN_INPUT "^String.concatWith " " (map Real.toString[t-start,u-t,cpu()-u])^"\n")
      val th=joined ``GridSigns$channel`` encs
      val _=save_thm("samples_certify_"^label,th)
      val _=print("GRID_CHANNEL_DONE "^label^"\n")
  in () end;
end;
