(* Raw-value comparison plus an unchanged stock-kernel reference. *)
structure CompiledWorkload =
struct
open HolKernel;
structure C = CompiledComputeBenchmark;
fun require b s = if b then () else raise Fail s;
fun timed label work =
  let val timer = Timer.startCPUTimer ()
      val wall = Time.now ()
      val result = work ()
      val {usr,sys} = Timer.checkCPUTimer timer
  in print ("COMPILED_TIME," ^ label ^ "," ^
       Real.fmt (StringCvt.FIX (SOME 9)) (Time.toReal (Time.+ (usr,sys))) ^ "," ^
       Real.fmt (StringCvt.FIX (SOME 9)) (Time.toReal (Time.- (Time.now (),wall))) ^ "\n");
     result end;
val mode = case OS.Process.getEnv "COMPILED_ORDER" of
    NONE => "stock-first" | SOME s => s;
val _ = require (mode = "stock-first" orelse mode = "compiled-first") "bad COMPILED_ORDER";
val _ = print ("COMPILED_ORDER," ^ mode ^ "\n");
val _ = CompiledEvalChecks.run ();
val parse_program = timed "syntax_validation" (fn () =>
  C.prepare_program CvBenchmarkConfig.config);
fun cv_size cv =
  case cv of C.Num _ => 1 | C.Pair (x,y) => 1 + cv_size x + cv_size y;
fun ast_size ce =
  case ce of
    C.Const _ => 1 | C.Var _ => 1
  | C.Monop (_,x) => 1 + ast_size x
  | C.Binop (_,x,y) => 1 + ast_size x + ast_size y
  | C.App (_,xs) => 1 + List.foldl (fn (x,a) => ast_size x + a) 0 xs
  | C.Let (x,y) => 1 + ast_size x + ast_size y
  | C.If (x,y,z) => 1 + ast_size x + ast_size y + ast_size z;
fun pair_order stock compiled =
  if mode = "stock-first" then
    let val a = stock () val b = compiled () in (a,b) end
  else let val b = compiled () val a = stock () in (a,b) end;
fun run label tm =
  let
    val _ = require (null (free_vars tm)) "open workload request"
    val (cvtm,eqs) = timed (label ^ ":discover") (fn () =>
      let val rep = cv_repLib.cv_rep_for [] tm
          val cvtm = cv_miscLib.cv_rep_cv_tm (concl rep)
          val eqs = List.map SPEC_ALL (cv_transLib.cv_eqs_for cvtm)
          val _ = require (List.all (fn th => null (hyp th)) eqs) "open code equation"
      in (cvtm,eqs) end)
    (* Save the actual ordered source equations; never synthesize a theorem
       from the candidate's raw output. *)
    fun save_eqs [] _ = ()
      | save_eqs (th::ts) i =
          (ignore (save_thm ("compiled_source_" ^ label ^ "_" ^ Int.toString i,th));
           print ("COMPILED_EQUATION," ^ label ^ "," ^ Int.toString i ^ "," ^
                  term_to_string (concl th) ^ "\n"); save_eqs ts (i+1))
    val _ = save_eqs eqs 0
    val _ = print ("COMPILED_REQUEST," ^ label ^ "," ^ term_to_string cvtm ^ "\n")
    val program = timed (label ^ ":parse_code") (fn () => parse_program (List.map concl eqs))
    val code = #code program
    val ce = timed (label ^ ":parse_request") (fn () => #parse program cvtm)
    val _ = print ("COMPILED_AST," ^ label ^ "," ^ Int.toString (Vector.length code) ^ "," ^
      Int.toString (Vector.foldl (fn (x,a) => ast_size x + a) 0 code) ^ "," ^
      Int.toString (ast_size ce) ^ "\n")
    val compile_entry = timed (label ^ ":compile_code") (fn () => C.prepare_closures code)
    val entry = timed (label ^ ":compile_request") (fn () => compile_entry ce)
    fun stock () = C.exec code [] ce
    fun compiled () = entry []
    val (a,b) = pair_order
      (fn () => timed (label ^ ":stock_first_raw") stock)
      (fn () => timed (label ^ ":compiled_first_raw") compiled)
    val _ = require (a = b) "first raw cval mismatch"
    val (ta,tb) = pair_order
      (fn () => timed (label ^ ":stock_reconstruct") (fn () => #to_term program a))
      (fn () => timed (label ^ ":compiled_reconstruct") (fn () => #to_term program b))
    val _ = require (aconv ta tb) "first reconstructed term mismatch"
    val ref_th = timed (label ^ ":stock_kernel_reference")
      (fn () => cv_computeLib.cv_compute eqs cvtm)
    val _ = require (null (hyp ref_th) andalso aconv (lhs (concl ref_th)) cvtm andalso
                     aconv (rhs (concl ref_th)) ta) "stock-kernel reference mismatch"
    val (oracles,_) = Tag.dest_tag (tag ref_th)
    val _ = require (List.all (fn s => s = "DISK_THM") oracles) "unexpected reference oracle"
    val _ = ignore (save_thm ("compiled_stock_reference_" ^ label,ref_th))
    fun verify v = require (v = a) "repeated raw cval mismatch"
    fun verify_term t = require (aconv t ta) "repeated reconstructed term mismatch"
    fun sample i =
      let val suffix = ":r" ^ Int.toString i
          val (x,y) = pair_order
            (fn () => timed (label ^ ":stock_raw" ^ suffix) stock)
            (fn () => timed (label ^ ":compiled_raw" ^ suffix) compiled)
          val _ = verify x val _ = verify y
          val (tx,ty) = pair_order
            (fn () => timed (label ^ ":stock_total" ^ suffix) (fn () => #to_term program (stock ())))
            (fn () => timed (label ^ ":compiled_total" ^ suffix) (fn () => #to_term program (compiled ())))
          val _ = verify_term tx val _ = verify_term ty
      in () end
    val _ = List.app sample [0,1,2]
    val fresh = timed (label ^ ":fresh_compile_execute") (fn () =>
      let val compile_again = C.prepare_closures code
          val run_again = compile_again ce
      in run_again [] end)
    val _ = verify fresh
  in print ("COMPILED_WORKLOAD_PASS," ^ label ^ ",cval_nodes=" ^ Int.toString (cv_size a) ^ "\n") end;
end;
