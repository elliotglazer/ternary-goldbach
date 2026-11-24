import Lake

open Lake DSL

package ternaryGoldbach where
  srcDir := "proof"
  leanLibDir := "replay"

lean_lib CompletedGoldbach

private def runReplay (pkg : NPackage n) (mode : String) : FetchM (Job Unit) :=
  Job.async do
    proc { cmd := "python3", args := #["-B", "proof/lake_build.py", mode], cwd := some pkg.dir }

/-- Check the saved theorem's type, proof application and exported axiom list. -/
target inspect pkg : Unit := runReplay pkg "inspect"

/-- Unpack the checked sources for inspection. -/
target sources pkg : Unit := runReplay pkg "sources"

/-- Rebuild the Goldbach modules and kernel-check the final specialization. -/
@[default_target]
target goldbach pkg : Unit := runReplay pkg "build"
