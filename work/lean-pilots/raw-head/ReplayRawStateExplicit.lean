import RawStateExplicitClosure
import RawReplay

/-! Complete concrete trace/output/enclosure closure; shared source and generic
libraries remain imported. These are disclosed replay measurement settings. -/
set_option maxHeartbeats 0
set_option maxRecDepth 65536

#replay_raw "state_explicit" "RawStateExplicit" 1024 100 RawStateExplicit.full_output_checked
