import Lean
open Lean Elab Tactic
elab "timedProof " n:num : tactic => do
  let path := (← IO.getEnv "TG_INTERVAL_PROBE_LOG").get!
  let writeMark (phase : String) : IO Unit := do
    let t ← IO.monoMsNow
    IO.FS.withFile path .append fun h => h.putStrLn s!"{phase} {n.getNat} {t}"
  writeMark "start"
  let stopAt := (← IO.monoMsNow) + 350
  repeat
    if (← IO.monoMsNow) >= stopAt then break
  writeMark "end"
  evalTactic (← `(tactic| rfl))
theorem sample1 : 1 = 1 := by timedProof 1
theorem sample2 : 2 = 2 := by timedProof 2
theorem sample3 : 3 = 3 := by timedProof 3
theorem sample4 : 4 = 4 := by timedProof 4
theorem sample5 : 5 = 5 := by timedProof 5
theorem sample6 : 6 = 6 := by timedProof 6
theorem sample7 : 7 = 7 := by timedProof 7
theorem sample8 : 8 = 8 := by timedProof 8
theorem sample9 : 9 = 9 := by timedProof 9
theorem sample10 : 10 = 10 := by timedProof 10
theorem sample11 : 11 = 11 := by timedProof 11
theorem sample12 : 12 = 12 := by timedProof 12
