(* Unbuilt experimental adapter. Stock kernel and cv libraries remain unchanged.
   The only varied operation is retaining versus rebuilding cv_compute's conversion.
   No final evaluation theorem is cached. *)
structure PreparedEval =
struct
open HolKernel boolLib bossLib;
exception CacheMismatch;
fun time label work =
  let val cpu = Timer.startCPUTimer ()
      val wall = Time.now ()
      val result = work ()
      val {usr,sys} = Timer.checkCPUTimer cpu
  in print ("PREPARED_PHASE," ^ label ^ "," ^
       Real.fmt (StringCvt.FIX (SOME 9)) (Time.toReal (Time.+ (usr,sys))) ^ "," ^
       Real.fmt (StringCvt.FIX (SOME 9)) (Time.toReal (Time.- (Time.now (),wall))) ^ "\n");
     result end;
fun require b s = if b then () else raise Fail s;
fun remove_T_IMP th = MP th TRUTH handle HOL_ERR _ => th;
fun discover tm =
  let
    val _ = require (null (free_vars tm)) "prepared input must be closed"
    val rep = cv_repLib.cv_rep_for [] tm
    val ft = cv_typeLib.from_to_thm_for (type_of tm)
    val cvtm = cv_miscLib.cv_rep_cv_tm (concl rep)
    val eqs = cv_transLib.cv_eqs_for cvtm
    val _ = require (List.all (fn th => null (hyp th)) eqs)
                    "code equations must be closed"
  in (rep, ft, eqs) end;
fun same_equations xs ys =
  length xs = length ys andalso
  ListPair.allEq (fn (a,b) => aconv (concl a) (concl b)) (xs,ys);
(* Audit-only registry. Exact closed equations are exported as theorems;
   printed IDs index those objects, not a hash-authorized computation cache. *)
val recorded = ref ([] : (int * thm list) list);
fun record_equations prefix eqs =
  let
    val _ = require (List.all (fn th => null (hyp th)) eqs)
                    "cannot record open equations"
    val id = case List.find (fn (_,old) => same_equations old eqs) (!recorded) of
      SOME (id,_) => id
    | NONE =>
        let val id = length (!recorded)
            fun save [] _ = ()
              | save (th::rest) index =
                  let val name = "prepared_equations_" ^ Int.toString id ^
                                 "_" ^ Int.toString index
                      val _ = save_thm (name,th)
                      val _ = print ("PREPARED_EQUATION_MEMBER," ^
                        Int.toString id ^ "," ^ Int.toString index ^ "," ^ name ^ "\n")
                  in save rest (index+1) end
            val _ = save eqs 0
            val _ = recorded := (!recorded) @ [(id,eqs)]
            val _ = print ("PREPARED_EQUATION_SET," ^ Int.toString id ^
                           "," ^ Int.toString (length eqs) ^ "\n")
        in id end
  in print ("PREPARED_EQUATION_USE," ^ prefix ^ "," ^ Int.toString id ^
            "," ^ Int.toString (length eqs) ^ "\n") end;
fun finish rep ft conversion =
  let
    val th1 = MATCH_MP cv_repTheory.cv_rep_eval rep
    val th2 = MATCH_MP th1 ft
    val th3 = UNDISCH_ALL th2
    val th4 = CONV_RULE (RAND_CONV (RAND_CONV conversion)) th3
    val th5 = remove_T_IMP (DISCH_ALL th4)
    val th6 = CONV_RULE (RAND_CONV EVAL) (UNDISCH_ALL th5)
  in remove_T_IMP (DISCH_ALL th6) end;
(* Polymorphic local timer: every callback executes once. No higher-order
   monomorphic timer is reused across differing result types. *)
fun fresh prefix tm =
  let
    val (rep,ft,eqs) = time (prefix ^ "_discover") (fn () => discover tm)
    val _ = time (prefix ^ "_equation_record") (fn () => record_equations prefix eqs)
    val conversion = time (prefix ^ "_compile") (fn () => cv_computeLib.cv_compute eqs)
  in time (prefix ^ "_evaluate_transport") (fn () => finish rep ft conversion) end;
fun prepare prefix tm =
  let
    val (_,_,eqs) = time (prefix ^ "_prebuild_discover") (fn () => discover tm)
    val _ = time (prefix ^ "_equation_record") (fn () => record_equations prefix eqs)
    val conversion = time (prefix ^ "_prebuild_compile") (fn () => cv_computeLib.cv_compute eqs)
    (* Keep the actual validated theorem list, not just hashes of printed names. *)
  in fn prefix => fn input =>
    let
      val (rep,ft,current) = time (prefix ^ "_discover") (fn () => discover input)
      val _ = time (prefix ^ "_equation_record") (fn () => record_equations prefix current)
      val _ = time (prefix ^ "_equation_identity") (fn () =>
        if same_equations eqs current then () else raise CacheMismatch)
    in time (prefix ^ "_evaluate_transport") (fn () => finish rep ft conversion) end
  end;
end;
