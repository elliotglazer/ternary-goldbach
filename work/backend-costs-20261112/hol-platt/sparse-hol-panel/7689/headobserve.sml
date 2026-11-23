structure headobserve = struct
open HolKernel Parse boolLib bossLib meter;
open SparseHeadTheory PanelTablesTheory;
val tuple=replay.tuple
val pair=pairSyntax.mk_pair;
fun row [m,w,e,bits] = tuple[nat m,nat w,nat e,numSyntax.mk_numeral(Arbnum.fromHexString bits)]
  | row _ = raise Fail "bad head row";
fun two [x,y] = pair(nat x,nat y) | two _ = raise Fail "two numbers expected";
fun pairs name=listSyntax.mk_list(replay.lines two name,``:num#num``);
fun encoded value=EVAL(mk_comb(replay.enc_for(type_of value),value));
fun channel lab =
  let val start=cpu()
      val rows=listSyntax.mk_list(replay.lines row ("heads-"^lab^".txt"),``:num#num#num#num``)
      val jobs=pairs ("jobs-"^lab^".txt")
      val main=pairs ("main-"^lab^".txt") and aux=pairs ("aux-"^lab^".txt")
      val [[mb,ab,ea,eb,k,w,a,b]]=replay.lines (map nat) ("target-"^lab^".txt")
      val result=pair(pair(k,w),pair(a,b))
      val data=replay.named ("raw_"^lab) (tuple[rows,jobs,mb,main,ab,aux,ea,eb])
      val ready=cpu()
      val args=[tables_encoded,replay.literal data,encoded result]
      val t=cpu()
      val _=print("HEAD_INPUT "^lab^" "^Real.toString(ready-start)^" "^Real.toString(t-ready)^"\n")
      val th=replay.joined ``SparseHead$exact_observation`` args
      val eq=PURE_REWRITE_RULE [exact_observation_def] th
      val saved=save_thm("sparse_observation_"^lab,eq)
      val _=replay.req(closed saved)"sparse observation tag"
      val _=print("HEAD_CHANNEL "^lab^" "^Real.toString(cpu()-start)^"\n")
  in (lhs(concl data),saved) end;
fun certify name l r =
  let val (left,leq)=channel l
      val (right,req)=channel r
      val [[h,phase,allow]]=replay.lines (map nat) ("pair-"^name^".txt")
      val tab=rand(lhs(concl tables_encoded))
      val start=cpu()
      val goal=list_mk_comb(``SparseHead$pair_from_heads``,[tab,h,phase,allow,left,right])
      val simp=SIMP_CONV (srw_ss()) [pair_from_heads_def,tables_valid,leq,req] goal
      val th=EQT_ELIM(TRANS simp (EVAL(rhs(concl simp))))
      val _=replay.req(closed th)"sparse pair tag"
      val _=save_thm("pair_from_sparse_raw_"^name,th)
      val _=print("HEAD_PAIR_DONE "^name^" "^Real.toString(cpu()-start)^"\n")
  in () end;
end;
