open HolKernel Parse boolLib bossLib;
val _ = Globals.show_types_verbosely := true;
val _ = print ("INITIAL_DEF " ^ thm_to_string SourceArithmeticTheory.source_initial_def ^ "\n");
val _ = print ("SOURCE_INITIAL_TYPE " ^ type_to_string (type_of ``source_initial``) ^ "\n");
val _ = print ("SOURCE_PAIR_VALUE_TYPE " ^ type_to_string (type_of ``source_pair_value``) ^ "\n");
val _ = OS.Process.exit OS.Process.success;
