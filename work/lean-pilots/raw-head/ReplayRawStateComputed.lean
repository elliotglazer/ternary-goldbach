import RawStateComputedPacked
import RawReplay

/-! Same complete output contract and replay boundary as the explicit variant.
All eight computed arithmetic proofs are inside the renamed closure. -/
set_option maxHeartbeats 0
set_option maxRecDepth 65536

#replay_raw "state_computed" "RawStateComputedPacked" 1024 100 RawStateComputedPacked.full_output_checked
