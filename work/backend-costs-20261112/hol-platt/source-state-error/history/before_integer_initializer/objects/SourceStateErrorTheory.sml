structure SourceStateErrorTheory :> SourceStateErrorTheory =
struct
  
  val _ = if !Globals.print_thy_loads
    then TextIO.print "Loading SourceStateErrorTheory ... "
    else ()
  
  open Type Term Thm
  local open RawPairRoundTheory SourceArithmeticTheory in end;
  
  structure TDB = struct
    val path =
      OS.Path.base (#(FILE)) ^ ".dat"
    val timestamp = HOLFileSys.modTime path
    val thydata = 
      TheoryReader.load_thydata {
        thyname = "SourceStateError",
        hash = "20ab7628f18933fc05724166162562d10cd8c17b",
        path = path
      }
    fun find s = #1 (valOf (Symtab.lookup thydata s))
  end
  val () = Theory.record_metadata
    "SourceStateError" {timestamp=TDB.timestamp, path=TDB.path}
  
  fun op ss_step_norm _ = () val op ss_step_norm = TDB.find "ss_step_norm"
  fun op ss_source_update_error _ = ()
  val op ss_source_update_error = TDB.find "ss_source_update_error"
  fun op ss_source_mul_error _ = ()
  val op ss_source_mul_error = TDB.find "ss_source_mul_error"
  fun op ss_source_mul_eq _ = ()
  val op ss_source_mul_eq = TDB.find "ss_source_mul_eq"
  fun op ss_product_error _ = ()
  val op ss_product_error = TDB.find "ss_product_error"
  fun op ss_modu_triangle _ = ()
  val op ss_modu_triangle = TDB.find "ss_modu_triangle"
  fun op ss_modu_sub_triangle _ = ()
  val op ss_modu_sub_triangle = TDB.find "ss_modu_sub_triangle"
  fun op ss_modu_add_square _ = ()
  val op ss_modu_add_square = TDB.find "ss_modu_add_square"
  fun op ss_exact_state_norm _ = ()
  val op ss_exact_state_norm = TDB.find "ss_exact_state_norm"
  fun op ss_envelope_nonneg _ = ()
  val op ss_envelope_nonneg = TDB.find "ss_envelope_nonneg"
  fun op source_state_error_from_initial_and_step _ = ()
  val op source_state_error_from_initial_and_step = TDB.find
    "source_state_error_from_initial_and_step"
  fun op source_pair_value_def _ = ()
  val op source_pair_value_def = TDB.find "source_pair_value_def"
  fun op source_error_envelope_def _ = ()
  val op source_error_envelope_def = TDB.find "source_error_envelope_def"
  fun op source_error_envelope_compute _ = ()
  val op source_error_envelope_compute = TDB.find
    "source_error_envelope_compute"
  
val _ = if !Globals.print_thy_loads then TextIO.print "done\n" else ()
val _ = Theory.load_complete "SourceStateError"

end
