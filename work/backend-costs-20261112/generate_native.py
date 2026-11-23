"""Same Lean checker as a native runtime baseline; this produces NO proof."""
from pathlib import Path
H=Path(__file__).resolve().parent
old=H.parent/'lean-pilots/batched-transform'
core=(old/'StageCheck.lean').read_text()
core=core[core.index('namespace BatchedTransform'):core.index('def butterfly_spec')]
core=core.replace('def checkStage','@[noinline]\ndef checkStage')
data=(old/'DataP343N64.lean').read_text().splitlines()[1:]
text='import Init\n'+core+'\nend BatchedTransform\n'+'\n'.join(data)+'\n'
text+='''
open BatchedTransform DataP343N64
-- Inputs originate at runtime; the loop intentionally calls a noinline checker.
def main (args : List String) : IO UInt32 := do
  let reps := (args.headD "10000").toNat!
  let s := (args[1]!).toInt!
  let b := (args[2]!).toInt!
  let start <- IO.monoNanosNow
  let mut accepted := 0
  for _ in [:reps] do
    if checkStage s b inputs outputs then
      accepted := accepted + 1
  let stop <- IO.monoNanosNow
  IO.println s!"{reps},{accepted},{stop-start}"
  return if accepted == reps then 0 else 1
'''
(H/'NativeBaseline.lean').write_text(text)
