signature SourceArithmeticTheory =
sig
  type thm = Thm.thm
  
  (*  Definitions  *)
    val source_em_initial_def : thm
    val source_em_step_from_log_pi_def : thm
    val source_exp_horner_def : thm
    val source_exp_step_def : thm
    val source_initial_def : thm
    val source_inverse_root_def : thm
    val source_log_center_def : thm
    val source_log_checked_def : thm
    val source_log_domain_def : thm
    val source_log_from_two_def : thm
    val source_log_horner_def : thm
    val source_mul_def : thm
    val source_pool_tick_def : thm
    val source_raw_initial_def : thm
    val source_raw_log129_def : thm
    val source_raw_step_def : thm
    val source_regrid_def : thm
    val source_state_def : thm
  
  (*  Theorems  *)
    val source_exp_horner_compute : thm
    val source_log_checked_domain : thm
    val source_log_horner_compute : thm
    val source_mul_residuals : thm
    val source_pool_tick_length : thm
    val source_state_compute : thm
end
