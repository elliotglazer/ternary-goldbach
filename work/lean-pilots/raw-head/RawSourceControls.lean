import RawLogCases

namespace RawSourceControls
open RawHead RawLogData

theorem negative_round : roundDiv 2 (-5) = -2 := by decide +kernel
theorem negative_round_below : roundDiv 4 (-11) = -3 := by decide +kernel
theorem wrong_log_output : (log129WithLogTwo logTwo137 13 10004 == (6268505015309936937964319995554191813487 + 8 : ℤ)) = false := by decide +kernel
theorem wrong_log_input : (log129WithLogTwo logTwo137 13 (10004 + 1) == (6268505015309936937964319995554191813487 : ℤ)) = false := by decide +kernel
theorem wrong_log_cache : (log129WithLogTwo (logTwo137 + 2 ^ 16) 13 10004 == (6268505015309936937964319995554191813487 : ℤ)) = false := by decide +kernel
theorem excessive_inverse_root : decide ((3168492865354689069166240814 + 1 : ℤ) * (3168492865354689069166240814 + 1) * 10004 ≤ (2 ^ 98 : ℤ) * 2 ^ 98) = false := by decide +kernel
theorem deficient_inverse_root : decide ((2 ^ 98 : ℤ) * 2 ^ 98 < (3168492865354689069166240814 : ℤ) * 3168492865354689069166240814 * 10004) = false := by decide +kernel
end RawSourceControls
