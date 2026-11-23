import RawStateSources
import RawTraceCertificate

/-! Fixed explicit operation-certificate proposal. No build was run by the emitter.
Fixture SHA256: 01C3E9F1AF2FD8DF40C9EF770840078E02EC356737727637C58397836C5C6BF9
Generator SHA256: 3916A10461D6032739AE5276DEFCDA962DE2CC5A243C824DC6541501DA00D517
Every literal multiplication equality is checked separately by ordinary kernel decide.
All explicit arithmetic declarations and composition helpers share the replay prefix.
-/

namespace RawStateExplicit
open RawHead RawStateData

lemma follows_cons {step previous next : ℤ × ℤ} {rest : List (ℤ × ℤ)}
    (hstep : mulStep (2 ^ 122) previous step = next)
    (hrest : traceFollows step next rest = true) :
    traceFollows step previous (next :: rest) = true := by
  simpa only [traceFollows, hstep, decide_true, Bool.true_and] using hrest

end RawStateExplicit
