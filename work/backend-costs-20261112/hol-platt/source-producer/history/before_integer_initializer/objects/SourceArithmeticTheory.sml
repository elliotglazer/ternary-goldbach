structure SourceArithmeticTheory :> SourceArithmeticTheory =
struct
  
  val _ = if !Globals.print_thy_loads
    then TextIO.print "Loading SourceArithmeticTheory ... "
    else ()
  
  open Type Term Thm
  local open BlockRoundTheory in end;
  
  structure TDB = struct
    val path =
      OS.Path.base (#(FILE)) ^ ".dat"
    val timestamp = HOLFileSys.modTime path
    val thydata = 
      TheoryReader.load_thydata {
        thyname = "SourceArithmetic",
        hash = "0710b702705886732af0dd5ea4999043d52be00d",
        path = path
      }
    fun find s = #1 (valOf (Symtab.lookup thydata s))
  end
  val () = Theory.record_metadata
    "SourceArithmetic" {timestamp=TDB.timestamp, path=TDB.path}
  
  fun op source_state_def _ = ()
  val op source_state_def = TDB.find "source_state_def"
  fun op source_state_compute _ = ()
  val op source_state_compute = TDB.find "source_state_compute"
  fun op source_regrid_def _ = ()
  val op source_regrid_def = TDB.find "source_regrid_def"
  fun op source_raw_step_def _ = ()
  val op source_raw_step_def = TDB.find "source_raw_step_def"
  fun op source_raw_log129_def _ = ()
  val op source_raw_log129_def = TDB.find "source_raw_log129_def"
  fun op source_raw_initial_def _ = ()
  val op source_raw_initial_def = TDB.find "source_raw_initial_def"
  fun op source_pool_tick_length _ = ()
  val op source_pool_tick_length = TDB.find "source_pool_tick_length"
  fun op source_pool_tick_def _ = ()
  val op source_pool_tick_def = TDB.find "source_pool_tick_def"
  fun op source_mul_residuals _ = ()
  val op source_mul_residuals = TDB.find "source_mul_residuals"
  fun op source_mul_def _ = ()
  val op source_mul_def = TDB.find "source_mul_def"
  fun op source_log_horner_def _ = ()
  val op source_log_horner_def = TDB.find "source_log_horner_def"
  fun op source_log_horner_compute _ = ()
  val op source_log_horner_compute = TDB.find "source_log_horner_compute"
  fun op source_log_from_two_def _ = ()
  val op source_log_from_two_def = TDB.find "source_log_from_two_def"
  fun op source_log_domain_def _ = ()
  val op source_log_domain_def = TDB.find "source_log_domain_def"
  fun op source_log_checked_domain _ = ()
  val op source_log_checked_domain = TDB.find "source_log_checked_domain"
  fun op source_log_checked_def _ = ()
  val op source_log_checked_def = TDB.find "source_log_checked_def"
  fun op source_log_center_def _ = ()
  val op source_log_center_def = TDB.find "source_log_center_def"
  fun op source_inverse_root_def _ = ()
  val op source_inverse_root_def = TDB.find "source_inverse_root_def"
  fun op source_initial_def _ = ()
  val op source_initial_def = TDB.find "source_initial_def"
  fun op source_exp_step_def _ = ()
  val op source_exp_step_def = TDB.find "source_exp_step_def"
  fun op source_exp_horner_def _ = ()
  val op source_exp_horner_def = TDB.find "source_exp_horner_def"
  fun op source_exp_horner_compute _ = ()
  val op source_exp_horner_compute = TDB.find "source_exp_horner_compute"
  fun op source_em_step_from_log_pi_def _ = ()
  val op source_em_step_from_log_pi_def = TDB.find
    "source_em_step_from_log_pi_def"
  fun op source_em_initial_def _ = ()
  val op source_em_initial_def = TDB.find "source_em_initial_def"
  
val _ = if !Globals.print_thy_loads then TextIO.print "done\n" else ()
val _ = Theory.load_complete "SourceArithmetic"

end
