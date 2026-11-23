# Bind the audit to the completed helper

Rawaudit01 stopped while refreshing helper metadata. Rawaudit02 used private metadata overlays but its dependency record resolved RawPairRoundTheory to the preserved original failed stage, where that theorem module does not exist. It therefore exited before compiling or running the audit. The original candidate and repaired helper deliberately share a theory name, so ordinary include discovery was insufficient to select the completed helper.

The successor uses PRE_INCLUDES for ../raw-pair-round-proof and retains the library stage under INCLUDES. Holmake's compiler command combines preincludes before includes. The obsolete local dependency record was moved into the failed-run archive so it will be regenerated. The completed helper source and proof objects are unchanged and remain pinned/read-only. The dependency record must name the repaired helper before audit acceptance.
