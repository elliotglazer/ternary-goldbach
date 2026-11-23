(* Syntax/metadata inspection only. No closed arithmetic is evaluated. *)
open HolKernel Parse boolLib bossLib RoundSpecializationCVTheory cv_primTheory;

fun require b msg = if b then () else raise Fail msg;
fun quoted s = "\"" ^ String.toString s ^ "\"";
fun qualified tm =
  let val {Thy,Name,...} = dest_thy_const tm in Thy ^ "$" ^ Name end;

(* Lossless constructor-level term output, independent of overloaded names or
   pretty-printer elision. Types here are the imported theorem's own types. *)
fun ast tm =
  if is_var tm then
    let val (n,t) = dest_var tm
    in "(var " ^ quoted n ^ " " ^ quoted (type_to_string t) ^ ")" end
  else if is_const tm then
    "(const " ^ quoted (qualified tm) ^ " " ^
      quoted (type_to_string (type_of tm)) ^ ")"
  else if is_abs tm then
    let val (v,b) = dest_abs tm in "(abs " ^ ast v ^ " " ^ ast b ^ ")" end
  else let val (f,x) = dest_comb tm
       in "(app " ^ ast f ^ " " ^ ast x ^ ")" end;

fun count name tm =
  if is_const tm then (if qualified tm = name then 1 else 0)
  else if is_var tm then 0
  else if is_abs tm then count name (snd (dest_abs tm))
  else let val (f,x) = dest_comb tm in count name f + count name x end;

val counted = ["cv$cv_div","cv$cv_mod","cv_prim$cv_int_div",
               "cv_prim$cv_total_int_div"];
fun counts label tm = List.app (fn name =>
  print ("CV_SYNTACTIC_COUNT," ^ label ^ "," ^ name ^ "," ^
         Int.toString (count name tm) ^ "\n")) counted;

fun branch_shapes label path tm =
  let val (head,args) = strip_comb tm
      val is_if = is_const head andalso qualified head = "cv$cv_if"
  in
    if is_if andalso length args = 3 then
      let val cond = List.nth(args,0)
          val yes = List.nth(args,1)
          val no = List.nth(args,2)
          val here = label ^ ":" ^ path
      in print ("CV_IF_CONDITION_AST," ^ here ^ "," ^ ast cond ^ "\n");
         counts (here ^ ":then") yes;
         counts (here ^ ":else") no;
         branch_shapes label (path ^ ".cond") cond;
         branch_shapes label (path ^ ".then") yes;
         branch_shapes label (path ^ ".else") no
      end
    else if is_abs tm then branch_shapes label (path ^ ".body") (snd(dest_abs tm))
    else if is_comb tm then
      let val (f,x) = dest_comb tm
      in branch_shapes label (path ^ ".fun") f;
         branch_shapes label (path ^ ".arg") x end
    else ()
  end;

fun audit label th =
  let val (oracles,axioms) = Tag.dest_tag (tag th)
  in require (null (hyp th)) (label ^ ": unexpected theorem hypotheses");
     require (List.all (fn s => s = "DISK_THM") oracles)
             (label ^ ": unexpected oracle tag");
     print ("CV_IMPORTED_TAG," ^ label ^ ",oracles=" ^
       String.concatWith ";" oracles ^ ",axioms=" ^
       String.concatWith ";" axioms ^ "\n")
  end;

fun equation label th =
  let val _ = audit label th
      val specialized = SPEC_ALL th
      val (left,right) = dest_eq (concl specialized)
      val head = fst (strip_comb left)
  in print ("CV_EQUATION_HEAD," ^ label ^ "," ^ qualified head ^ "\n");
     print ("CV_EQUATION_TEXT_BEGIN," ^ label ^ "\n" ^ thm_to_string th ^
            "\nCV_EQUATION_TEXT_END," ^ label ^ "\n");
     print ("CV_EQUATION_AST," ^ label ^ "," ^ ast (concl th) ^ "\n");
     counts label right;
     branch_shapes label "rhs" right;
     (head,right)
  end;

fun inspect label def representation require_no_mod =
  let val (head,_) = equation (label ^ ":definition") def
      val _ = audit (label ^ ":representation") representation
      val _ = print ("CV_REPRESENTATION_AST," ^ label ^ "," ^
                     ast(concl representation) ^ "\n")
      (* Start at the actual imported definition head, not a guessed cv name. *)
      val closure = cv_transLib.cv_eqs_for head
      fun walk [] _ acc = rev acc
        | walk (th::rest) i acc =
            let val item = equation (label ^ ":reachable:" ^ Int.toString i) th
            in walk rest (i+1) (item::acc) end
      val items = walk closure 0 []
      val _ = require (List.exists (fn (h,_) => aconv h head) items)
                      (label ^ ": root missing from reachable closure")
      fun total name = List.foldl (fn ((_,r),n) => n + count name r) 0 items
      val _ = print ("CV_CLOSURE_EQUATIONS," ^ label ^ "," ^
                     Int.toString(length closure) ^ "\n")
      val _ = List.app (fn name => print ("CV_CLOSURE_SYNTACTIC_COUNT," ^ label ^
                "," ^ name ^ "," ^ Int.toString(total name) ^ "\n")) counted
      val _ = if require_no_mod then
        require (total "cv$cv_mod" = 0 andalso total "cv_prim$cv_int_div" = 0
                 andalso total "cv_prim$cv_total_int_div" = 0)
                (label ^ ": unexpected remainder/signed-divider dependency")
        else ()
  in print ("CV_INSPECTION_CASE_DONE," ^ label ^ "\n") end;

val _ = List.app (fn name =>
  inspect name (DB.fetch "RoundSpecializationCV" ("cv_" ^ name ^ "_def"))
    (DB.fetch "RoundSpecializationCV" ("cv_" ^ name ^ "_thm")) true)
  ["positive_den_div_one","round_scaled_one","rounded_butterfly_one"];

(* Stock contrast from the actual imported code/representation theorem. *)
val _ = inspect "stock_int_div"
  (DB.fetch "cv_prim" "cv_int_div_def")
  (DB.fetch "cv_prim" "cv_int_div") false;

val _ = print "CV_INSPECTION_SCOPE,syntactic occurrences per stored equation; not dynamic calls or timings\n";
val _ = print "HOL4_ROUND_CV_INSPECTION_DONE\n";
