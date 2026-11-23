"""Split the pinned, previously checked whole-axis harness into theory and driver."""
import hashlib
from pathlib import Path

here=Path(__file__).resolve().parent
parent=here.parent/"large-kronecker-hol-price/LargePanelScript.sml"
buf=parent.read_bytes()
assert hashlib.sha256(buf).hexdigest()=="0e49e0993a28c2f6400744f3569bcf6873b06a3756b21ea450db4b57ca5a75b8"
thy,driver=buf.decode().replace("\r","").split('val f=TextIO.openIn "cases.txt";')
(here/"SampleAxisScript.sml").write_text(thy.replace("Theory LargePanel","Theory SampleAxis"))
start='''open HolKernel Parse boolLib bossLib cv_transLib SampleAxisTheory;
val _=new_theory "SampleAxisTrial";
val _=print "AXIS_START\\n";
val f=TextIO.openIn (valOf(OS.Process.getEnv "AXIS_INPUT"));
val first=valOf(Int.fromString(valOf(OS.Process.getEnv "AXIS_FIRST")));
val last=valOf(Int.fromString(valOf(OS.Process.getEnv "AXIS_LAST")));
val count=ref 0;
'''
driver=driver.replace("in List.app trial [0,1,4,4,0] end;",
'''in List.app trial (if n<=8192 then [0,1,4,4,0] else [0,1,1,0]) end;''')
driver=driver.replace("SOME l=>(run l;loop())",
  "SOME l=>(count:=(!count)+1; if first<=(!count) andalso (!count)<=last then run l else (); loop())")
(here/"worker.sml").write_text(start+driver+'\nval _=print "AXIS_DONE\\n";\n')
