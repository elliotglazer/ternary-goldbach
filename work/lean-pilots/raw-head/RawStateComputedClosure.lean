import RawStateComputed

/-! Same complete output contract as the explicit variant. Its dependency
closure includes every computed arithmetic module and the analytic assembly. -/

namespace RawStateComputed

theorem full_output_checked :
    (type_of% all_traces_checked) ∧
    (type_of% actual_error_1) ∧
    (type_of% actual_error_2) ∧
    (type_of% actual_error_3) ∧
    (type_of% actual_error_41) ∧
    (type_of% actual_error_61) ∧
    (type_of% actual_error_10004) ∧
    (type_of% actual_error_262144) ∧
    (type_of% actual_error_265800) :=
  ⟨all_traces_checked, actual_error_1, actual_error_2, actual_error_3,
    actual_error_41, actual_error_61, actual_error_10004, actual_error_262144,
    actual_error_265800⟩

end RawStateComputed
