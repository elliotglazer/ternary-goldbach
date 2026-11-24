import Lean
open Lean

/-- Read compiler metadata directly. This utility does not replay proof terms. -/
unsafe def main (args : List String) : IO Unit := do
  for path in args do
    let (m, _region) ← readModuleData path
    IO.println s!"module {path}"
    for i in m.imports do IO.println s!"import {i.module}"
    if path == "CompletedGoldbach.olean" then
      let name := `CompletedGoldbach.ternary_goldbach
      let some (.thmInfo thm) := m.constants.find? (fun c => c.name == name)
        | throw <| IO.userError s!"Missing saved theorem {name}"
      unless thm.type == mkConst `TernaryGoldbach.Statement do
        throw <| IO.userError s!"Unexpected saved statement {thm.type}"
      let proof := mkApp2 (mkConst `GoldbachFinite.completed_of_release)
        (mkConst `riemannHypothesis) (mkConst `LFunction_eq_zero_re_of_isPrimitive)
      unless thm.value == proof do throw <| IO.userError s!"Unexpected saved proof for {name}"
      IO.println s!"saved type {thm.type}"
    for (n, xs) in m.entries do
      if n.toString.endsWith "exportedAxiomsExt" then
        for x in xs do
          let (decl, axs) : Name × Array Name := unsafeCast x
          if m.constNames.contains decl then IO.println s!"{decl} {axs}"
