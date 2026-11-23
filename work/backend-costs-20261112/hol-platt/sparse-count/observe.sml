structure observe = struct
open HolKernel Parse boolLib bossLib meter;
open SparseCountTheory JoinTablesTheory;
val tuple=replay.tuple
val pair=pairSyntax.mk_pair;
fun row (m::xs) = pair(nat m,listSyntax.mk_list(map (numSyntax.mk_numeral o Arbnum.fromHexString) xs,``:num``))
  | row _ = raise Fail "empty raw row";
fun two [x,y] = pair(nat x,nat y) | two _ = raise Fail "two numbers expected";
fun pairs name=listSyntax.mk_list(replay.lines two name,``:num#num``);
fun encoded value=EVAL(mk_comb(replay.enc_for(type_of value),value));
fun channel lab =
  let val start=cpu()
      val rows=listSyntax.mk_list(replay.lines row ("raw-"^lab^".txt"),``:num#num list``)
      val jobs=pairs ("jobs-"^lab^".txt")
      val main=pairs ("main-"^lab^".txt") and aux=pairs ("aux-"^lab^".txt")
      val [[mb,ab,ea,eb,k,w,a,b]]=replay.lines (map nat) ("target-"^lab^".txt")
      val result=pair(pair(k,w),pair(a,b))
      val data=replay.named ("raw_"^lab) (tuple[rows,jobs,mb,main,ab,aux,ea,eb])
      val ready=cpu()
      val args=[tables_encoded,replay.literal data,encoded result]
      val t=cpu()
      val _=print("SPARSE_INPUT "^lab^" "^Real.toString(ready-start)^" "^Real.toString(t-ready)^"\n")
      val th=replay.joined ``SparseCount$exact_observation`` args
      val eq=PURE_REWRITE_RULE [exact_observation_def] th
      val saved=save_thm("sparse_observation_"^lab,eq)
      val _=replay.req(closed saved)"sparse observation tag"
      val _=print("SPARSE_CHANNEL "^lab^" "^Real.toString(cpu()-start)^"\n")
  in (lhs(concl data),saved) end;
fun certify name l r =
  let val (left,leq)=channel l
      val (right,req)=channel r
      val [[h,phase,allow]]=replay.lines (map nat) ("pair-"^name^".txt")
      val tab=rand(lhs(concl tables_encoded))
      val start=cpu()
      val goal=list_mk_comb(``SparseCount$pair_from_raw``,[tab,h,phase,allow,left,right])
      val simp=SIMP_CONV (srw_ss()) [pair_from_raw_def,tables_valid,leq,req] goal
      val th=EQT_ELIM(TRANS simp (EVAL(rhs(concl simp))))
      val _=replay.req(closed th)"sparse pair tag"
      val _=save_thm("pair_from_sparse_raw_"^name,th)
      val _=print("SPARSE_PAIR_DONE "^name^" "^Real.toString(cpu()-start)^"\n")
  in () end;
end;
