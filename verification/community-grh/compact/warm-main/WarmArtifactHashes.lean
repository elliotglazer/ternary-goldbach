import Lake.Build.Trace

def main : IO Unit := do
  let input ← IO.getStdin
  let output ← IO.getStdout
  repeat
    let line ← input.getLine
    if line.isEmpty then break
    let path := line.trimAsciiEnd.toString
    let digest ← Lake.computeBinFileHash path
    output.putStrLn digest.toString
