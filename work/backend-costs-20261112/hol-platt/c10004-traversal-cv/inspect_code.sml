open HolKernel Parse boolLib bossLib cv_transLib C10004TraversalCVTheory;
fun require b s = if b then () else raise Fail s;
fun audit name th =
 let val (oracles,axs) = Tag.dest_tag (tag th)
 in require (null (hyp th)) (name ^ ": open hypotheses");
    require (List.all (fn s => s="DISK_THM") oracles) (name ^ ": oracle");
    require (null axs) (name ^ ": axiom tags");
    print ("CV_TRANSLATION," ^ name ^ "," ^ thm_to_string th ^ "\n")
 end;
val translations = [
 ("ft_pairs",cv_ft_pairs_thm),("ft_take",cv_ft_take_thm),
 ("ft_chunks",cv_ft_chunks_thm),("ft_heads_tails",cv_ft_heads_tails_thm),
 ("ft_transpose",cv_ft_transpose_thm),("ft_rows40",cv_ft_rows40_thm),
 ("ft_rows60",cv_ft_rows60_thm),("ft_concat",cv_ft_concat_thm),
 ("ft_tensor",cv_ft_tensor_thm),("ft_checked",cv_ft_checked_thm),
 ("cvfast_public_success",cv_cvfast_public_success_thm),
 ("cvfast_output_matches",cv_cvfast_output_matches_thm),
 ("cvfast_wrong_output",cv_cvfast_wrong_output_thm)];
val _ = List.app (fn (name,th) => audit name th) translations;
fun inspect name tm required forbidden =
 let val rep = cv_repLib.cv_rep_for [] tm
     val cvtm = cv_miscLib.cv_rep_cv_tm (concl rep)
     val eqs = cv_eqs_for cvtm
     fun head th = fst (strip_comb (lhs (concl (SPEC_ALL th))))
     val names = map (fn th => #Name (dest_thy_const (head th))) eqs
     fun present s = List.exists (fn n => n=s) names
     val _ = require (List.all present required) (name ^ ": missing code")
     val _ = require (List.all (fn s => not (present s)) forbidden)
       (name ^ ": unexpected alternative code")
     val _ = List.app (fn th => audit (name ^ "_equation") th) eqs
 in print ("CV_REACHABLE," ^ name ^ "," ^ String.concatWith ";" names ^ "\n");
    print ("CV_REPRESENTED_TERM," ^ name ^ "," ^ term_to_string cvtm ^ "\n")
 end;
val sequential = ["cv_ft_pairs","cv_ft_take","cv_ft_chunks",
                  "cv_ft_heads_tails","cv_ft_transpose","cv_ft_concat",
                  "cv_ft_tensor","cv_ft_checked"];
val reference = ["cv_tx_tensor_selected","cv_tx_checked"];
val _ = inspect "sequential" ``cvfast_public_success 1`` sequential reference;
val _ = inspect "reference" ``test_public_success 1`` reference sequential;
val _ = inspect "both_outputs" ``cvfast_output_matches 1``
  (sequential @ reference) [];
val _ = print "C10004_TRAVERSAL_CV_CODE_INSPECTION_DONE\n";
