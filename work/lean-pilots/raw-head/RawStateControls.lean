import RawStateFixtureData
import RawStateSources
import RawTraceCertificate

/-!
Exact controls for state_fixture.json, SHA256
01C3E9F1AF2FD8DF40C9EF770840078E02EC356737727637C58397836C5C6BF9.

Each rejection below is a theorem that a concrete equality is false or that
the checker returns false. A resource failure is not a successful control.
Imported source equalities avoid rerunning logarithm, exponential, or sqrt
producers. These are bounded controls, not a complete source/trace audit.

The trace checker accepts an arbitrary finite length. The consumer must also
bind the requested 129-row shape. The constant x=1 trace makes this distinction
visible: a valid prefix or repeated terminal row still follows the recurrence.
-/

namespace RawStateControls

open RawHead RawStateData

def changedInitial : ℤ × ℤ := (initial_1.1 + 1, initial_1.2)
def changedInterior : List (ℤ × ℤ) := trace_1.set 64 changedInitial
def changedFinal : List (ℤ × ℤ) := trace_1.set 128 changedInitial
def droppedFinal : List (ℤ × ℤ) := trace_1.take 128
def repeatedFinal : List (ℤ × ℤ) := trace_1 ++ [initial_1]

theorem baseline_constant_trace :
    traceCertificate initial_1 step_1 trace_1 = true := by decide +kernel

theorem changed_initial_rejected :
    traceCertificate changedInitial step_1 trace_1 = false := by decide +kernel

/-- Use a nonconstant row: replacing its actual step by the x=1 step fails
already on the first edge, without checking any analytic producer again. -/
theorem changed_step_rejected :
    traceCertificate initial_2 step_1 (trace_2.take 2) = false := by decide +kernel

theorem changed_initial_source_rejected : changedInitial ≠ rawStateInitial 1 := by
  change changedInitial ≠ ((inverseRootCandidate 1 (2 ^ 98) : ℤ) * 2 ^ 22, 0)
  rw [RawStateSources.initial_checked_1]
  decide +kernel

theorem changed_step_source_rejected : step_1 ≠ rawStepNumerator 1 2 := by
  rw [RawStateSources.step_checked_2]
  decide +kernel

theorem wrong_base_initial_rejected : initial_2 ≠ rawStateInitial 3 := by
  change initial_2 ≠ ((inverseRootCandidate 3 (2 ^ 98) : ℤ) * 2 ^ 22, 0)
  rw [RawStateSources.initial_checked_3]
  decide +kernel

theorem wrong_base_step_rejected : step_2 ≠ rawStepNumerator 1 3 := by
  rw [RawStateSources.step_checked_3]
  decide +kernel

theorem interior_coordinate_rejected :
    traceCertificate initial_1 step_1 changedInterior = false := by decide +kernel

theorem final_coordinate_rejected :
    traceCertificate initial_1 step_1 changedFinal = false := by decide +kernel

theorem interior_shape_preserved : changedInterior.length = 129 := by decide +kernel
theorem final_shape_preserved : changedFinal.length = 129 := by decide +kernel

theorem dropped_prefix_still_follows :
    traceCertificate initial_1 step_1 droppedFinal = true := by decide +kernel

theorem repeated_constant_row_still_follows :
    traceCertificate initial_1 step_1 repeatedFinal = true := by decide +kernel

theorem dropped_row_shape_rejected :
    (decide (droppedFinal.length = 129) &&
      traceCertificate initial_1 step_1 droppedFinal) = false := by decide +kernel

theorem repeated_row_shape_rejected :
    (decide (repeatedFinal.length = 129) &&
      traceCertificate initial_1 step_1 repeatedFinal) = false := by decide +kernel

/-- Signed nearest division uses ties toward positive infinity, including
negative half ties. These are checks of the actual integer algorithm. -/
theorem negative_half_tie : roundDiv 2 (-1) = 0 := by decide +kernel
theorem negative_three_half_tie : roundDiv 2 (-3) = -1 := by decide +kernel
theorem positive_half_tie : roundDiv 2 1 = 1 := by decide +kernel
theorem negative_below_tie : roundDiv 4 (-3) = -1 := by decide +kernel

theorem wrong_negative_half_tie_rejected :
    decide (roundDiv 2 (-1) = -1) = false := by decide +kernel

theorem wrong_positive_half_tie_rejected :
    decide (roundDiv 2 1 = 0) = false := by decide +kernel

theorem signed_product_ties : mulStep 2 (1, 1) (0, 1) = (0, 1) := by decide +kernel
theorem conjugate_signed_product_ties :
    mulStep 2 (1, 1) (0, -1) = (1, 0) := by decide +kernel

theorem wrong_signed_product_rejected :
    decide (mulStep 2 (1, 1) (0, 1) = (-1, 0)) = false := by decide +kernel

end RawStateControls
