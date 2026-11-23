import RawStateFixtureData
import RawCachedLoop

/-! Computed full-trace arithmetic for the single matched fixture.
Shared literal data SHA256: BB0388FFA768A4F4CAF9154534C7F7D40CC5F4177F91513A301610FEA1B72CFB
No source producer or hidden concrete arithmetic theorem is imported here. -/

namespace RawStateComputed
open RawHead RawStateData

theorem trace_checked_3 :
    cachedTrace initial_3 step_3 128 = trace_3 := by
  decide +kernel

end RawStateComputed
