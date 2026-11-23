signature SourceStateErrorTheory =
sig
  type thm = Thm.thm
  
  (*  Definitions  *)
    val source_error_envelope_def : thm
    val source_pair_value_def : thm
  
  (*  Theorems  *)
    val source_error_envelope_compute : thm
    val source_state_error_from_initial_and_step : thm
    val ss_envelope_nonneg : thm
    val ss_exact_state_norm : thm
    val ss_modu_add_square : thm
    val ss_modu_sub_triangle : thm
    val ss_modu_triangle : thm
    val ss_product_error : thm
    val ss_source_mul_eq : thm
    val ss_source_mul_error : thm
    val ss_source_update_error : thm
    val ss_step_norm : thm
end
