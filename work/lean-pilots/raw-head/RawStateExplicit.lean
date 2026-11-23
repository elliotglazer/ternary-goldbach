import RawStateExplicit1
import RawStateExplicit2
import RawStateExplicit3
import RawStateExplicit41
import RawStateExplicit61
import RawStateExplicit10004
import RawStateExplicit262144
import RawStateExplicit265800

/-! Fixed explicit operation-certificate proposal. No build was run by the emitter.
Fixture SHA256: 01C3E9F1AF2FD8DF40C9EF770840078E02EC356737727637C58397836C5C6BF9
Generator SHA256: 3916A10461D6032739AE5276DEFCDA962DE2CC5A243C824DC6541501DA00D517
Every literal multiplication equality is checked separately by ordinary kernel decide.
All explicit arithmetic declarations and composition helpers share the replay prefix.
-/

namespace RawStateExplicit
open RawHead RawStateData

theorem all_traces_checked :
    [rawCachedTrace 0 1 128, rawCachedTrace 1 2 128, rawCachedTrace 1 3 128, rawCachedTrace 5 41 128, rawCachedTrace 5 61 128, rawCachedTrace 13 10004 128, rawCachedTrace 18 262144 128, rawCachedTrace 18 265800 128] =
      allTraces := by
  rw [actual_trace_1, actual_trace_2, actual_trace_3, actual_trace_41, actual_trace_61, actual_trace_10004, actual_trace_262144, actual_trace_265800]
  rfl

end RawStateExplicit
