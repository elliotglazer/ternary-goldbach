signature SourceStateBoundsTheory =
sig
  type thm = Thm.thm
  
  (*  Theorems  *)
    val source_envelope_linear_prefix : thm
    val source_raw_envelope_lt_dyadic96 : thm
    val source_raw_state_error_lt_dyadic96 : thm
end
