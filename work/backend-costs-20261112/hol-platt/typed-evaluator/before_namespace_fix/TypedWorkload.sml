(* Diagnostic adapter. Only stock HOL conversions may create reference theorems. *)
structure TypedWorkload =
struct
open HolKernel Parse TypedBlock TypedStockCompute TypedCvConfig;
structure C = TypedStockCompute;
structure T = TypedBlock;
fun require b s = if b then () else raise Fail s;
fun timed label f =
  let val cpu = Timer.startCPUTimer () val wall = Time.now ()
      val x = f () val {usr,sys} = Timer.checkCPUTimer cpu
  in print ("TYPED_TIME," ^ label ^ "," ^
     Real.fmt (StringCvt.FIX (SOME 9)) (Time.toReal (Time.+ (usr,sys))) ^ "," ^
     Real.fmt (StringCvt.FIX (SOME 9)) (Time.toReal (Time.- (Time.now (),wall))) ^ "\n"); x end;
val mode = case OS.Process.getEnv "TYPED_ORDER" of NONE => "stock-first" | SOME x => x;
val _ = require (mode = "stock-first" orelse mode = "typed-first") "invalid order";
val _ = print ("TYPED_ORDER," ^ mode ^ "\n");
fun paired f g = if mode = "stock-first" then
  let val a = f () val b = g () in (a,b) end
  else let val b = g () val a = f () in (a,b) end;
fun destZ tm =
  let val z = intSyntax.int_of_term tm
      val _ = require (aconv tm (intSyntax.term_of_int z)) "noncanonical integer term"
  in Arbint.toLargeInt z end;
fun resolve tm = if is_const tm then
  let val {Thy,Name,...} = dest_thy_const tm
      val allowed = ["block_scale","block_inputs","block_coefficients",
                     "block_changed_inputs","block_changed_coefficients"]
  in if Thy = "TypedDependentResults" andalso List.exists (fn n => n = Name) allowed then
       let val th = DB.fetch Thy (Name ^ "_def")
           val _ = require (null (hyp th) andalso aconv (lhs (concl th)) tm) "definition binding"
       in rhs (concl th) end
     else tm end else tm;
fun destRows tm =
  let val (rows,ty) = listSyntax.dest_list (resolve tm)
      val _ = require (ty = pairSyntax.mk_prod (intSyntax.int_ty,intSyntax.int_ty)) "row type"
  in Vector.fromList (List.map (fn row =>
       let val (x,y) = pairSyntax.dest_pair row in (destZ x,destZ y) end) rows) end;
fun cvZ (C.Num n) = Arbnum.toLargeInt n
  | cvZ (C.Pair (C.Num n,C.Num z)) =
      (require (z = Arbnum.zero andalso n <> Arbnum.zero) "noncanonical negative CV";
       ~(Arbnum.toLargeInt n))
  | cvZ _ = raise Fail "invalid integer CV";
fun cvRows cv =
  let fun go (C.Num n) acc =
            (require (n = Arbnum.zero) "noncanonical list nil"; Vector.fromList (List.rev acc))
        | go (C.Pair (C.Pair (x,y),tail)) acc = go tail ((cvZ x,cvZ y)::acc)
        | go _ _ = raise Fail "invalid row/list CV"
  in go cv [] end;
fun cvBool (C.Num n) =
      if n = Arbnum.zero then false else if n = Arbnum.one then true
      else raise Fail "noncanonical Boolean CV"
  | cvBool _ = raise Fail "invalid Boolean CV";
val parse_program = C.prepare_program TypedCvConfig.config;
fun prepare label tm =
  let val _ = require (null (free_vars tm)) "open request"
      val (cvtm,eqs) = timed (label ^ ":discover") (fn () =>
        let val rep = cv_repLib.cv_rep_for [] tm
            val cvtm = cv_miscLib.cv_rep_cv_tm (concl rep)
            val eqs = List.map SPEC_ALL (cv_transLib.cv_eqs_for cvtm)
            val _ = require (List.all (fn th => null (hyp th)) eqs) "open equation"
        in (cvtm,eqs) end)
      fun record [] _ = ()
        | record (th::ts) i =
            (ignore (save_thm ("typed_source_" ^ label ^ "_" ^ Int.toString i,th));
             print ("TYPED_EQUATION," ^ label ^ "," ^ Int.toString i ^ "," ^
                    term_to_string (concl th) ^ "\n"); record ts (i+1))
      val _ = record eqs 0
      val _ = print ("TYPED_REQUEST," ^ label ^ "," ^ term_to_string cvtm ^ "\n")
      val (program,ce) = timed (label ^ ":parse") (fn () =>
        let val p = parse_program (List.map concl eqs) in (p,#parse p cvtm) end)
      fun raw () = C.exec (#code program) [] ce
      fun reference value =
        let val th = timed (label ^ ":stock_kernel_reference")
              (fn () => cv_computeLib.cv_compute eqs cvtm)
            val (oracles,_) = Tag.dest_tag (tag th)
            val _ = require (null (hyp th) andalso aconv (lhs (concl th)) cvtm andalso
              aconv (rhs (concl th)) (#to_term program value)) "stock reference mismatch"
            val _ = require (List.all (fn x => x = "DISK_THM") oracles) "reference oracle"
        in ignore (save_thm ("typed_stock_" ^ label,th)) end
  in {raw=raw,reference=reference} end;
fun run label tm expectedBool =
  let val (head,args) = strip_comb tm
      val _ = require (aconv head ``DependentBlock$block_accept``) "unsupported entry"
      val (s,w,n,x,b,e) = case args of [s,w,n,x,b,e] => (s,w,n,x,b,e)
                          | _ => raise Fail "entry arity"
      val (sz,wv,ni,xv,bz,ez) = timed (label ^ ":decode_validate") (fn () =>
        let val sz = destZ (resolve s) val wv = destRows w
            val ni = numSyntax.int_of_term n val xv = destRows x
            val bz = destZ b val ez = destZ e
            val _ = T.validate sz wv ni xv
        in (sz,wv,ni,xv,bz,ez) end)
      val outputTerm = list_mk_comb (``DependentBlock$block_run``,[s,w,n,x])
      val output = prepare (label ^ "_array") outputTerm
      val predicate = prepare (label ^ "_accept") tm
      fun typedArray () = T.run sz wv ni xv
      fun typedAccept () = T.accept sz wv ni xv bz ez
      fun sample i =
        let val tag = label ^ ":r" ^ Int.toString i
            val (stockArray,typed) = paired
              (fn () => timed (tag ^ ":stock_array") (#raw output))
              (fn () => timed (tag ^ ":typed_array") typedArray)
            val _ = require (cvRows stockArray = typed) "complete array mismatch"
            val (stockBool,typedBool) = paired
              (fn () => timed (tag ^ ":stock_accept") (#raw predicate))
              (fn () => timed (tag ^ ":typed_accept") typedAccept)
            val _ = require (cvBool stockBool = typedBool andalso typedBool = expectedBool)
                            "acceptance mismatch"
            val _ = if i = 0 then (#reference output stockArray; #reference predicate stockBool)
                    else ()
        in () end
      val _ = List.app sample [0,1,2]
  in print ("TYPED_WORKLOAD_PASS," ^ label ^ ",points=" ^
            Int.toString (Vector.length xv) ^ ",depth=" ^ Int.toString ni ^ "\n") end;
fun intTerm z = intSyntax.term_of_int (Arbint.fromLargeInt z);
fun rowsTerm xs = listSyntax.mk_list
  (List.map (fn (x,y) => pairSyntax.mk_pair (intTerm x,intTerm y)) xs,
   pairSyntax.mk_prod (intSyntax.int_ty,intSyntax.int_ty));
fun selftests () =
  let val checks = ref 0
      fun check b = (require b "edge check"; checks := !checks+1)
      fun roundCase (i,(r,q)) =
        let val tm = list_mk_comb (``BlockRound$round_scaled``,[intTerm 2,intTerm r])
            val p = prepare ("edge_round" ^ Int.toString i) tm
            val v = #raw p ()
            val _ = #reference p v
        in check (T.round 2 r = q andalso cvZ v = q) end
      val _ = List.app roundCase (ListPair.zip ([0,1,2,3,4,5,6,7],
                     [(~5,~2),(~3,~1),(~1,0),(1,1),(3,2),(5,3),(~4,~2),(0,0)]))
      fun runCase (i,(n,ws,xs)) =
        let val tm = list_mk_comb (``DependentBlock$block_run``,
                   [intTerm 2,rowsTerm ws,numSyntax.term_of_int n,rowsTerm xs])
            val p = prepare ("edge_array" ^ Int.toString i) tm
            val v = #raw p () val _ = #reference p v
        in check (cvRows v = T.run 2 (Vector.fromList ws) n (Vector.fromList xs)) end
      val w : T.point list = [(1,~1)]
      val x : T.point list = [(~3,1),(2,~4)]
      val _ = List.app runCase (ListPair.zip ([0,1,2,3,4,5],
        [(0,w,x),(3,[],[]),(1,w,x),(2,w,x),(3,w,x),
         (3,[(1,~1),(~2,3)],[(~3,1),(2,~4),(5,~6),(~7,8)])]))
      fun rejects f = check ((f (); false) handle T.Invalid _ => true)
      val wv = Vector.fromList w val xv = Vector.fromList x
      val _ = rejects (fn () => ignore (T.run 0 wv 1 xv))
      val _ = rejects (fn () => ignore (T.run (~1) wv 1 xv))
      val _ = rejects (fn () => ignore (T.run 2 wv (~1) xv))
      val _ = rejects (fn () => ignore (T.run 2 (Vector.fromList []) 1 xv))
      val _ = rejects (fn () => ignore (T.run 2 wv 1 (Vector.fromList [(0,0)])))
      (* Fail is deliberately caught only in these known decoder-rejection tests. *)
      fun bad f = check ((f (); false) handle Fail _ => true)
      val _ = bad (fn () => ignore (cvZ (C.Pair (C.Num Arbnum.zero,C.Num Arbnum.zero))))
      val _ = bad (fn () => ignore (cvRows (C.Num Arbnum.one)))
      val _ = bad (fn () => ignore (cvRows (C.Pair (C.Num Arbnum.one,C.Num Arbnum.zero))))
      val _ = require (!checks = 22) "edge count"
  in print ("TYPED_EDGES_PASS,22\n") end;
end;
