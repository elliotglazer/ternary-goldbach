signature SourceInverseRootTheory =
sig
  type thm = Thm.thm
  
  (*  Theorems  *)
    val source_inverse_root_adjacent_squares : thm
    val source_inverse_root_real_error : thm
    val source_inverse_root_scaled_enclosure : thm
    val source_sqrt_bracket : thm
end
